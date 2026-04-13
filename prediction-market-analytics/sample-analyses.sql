-- Sample Analyses — Prediction Market Analytics
--
-- These queries run against the normalized market database schema.
-- SQL views handle multi-table JOINs, so analytical queries are
-- clean single-table SELECTs against views.


-- ============================================================
-- 1. CALIBRATION CURVE — Am I well-calibrated?
-- ============================================================
-- Bin predicted probabilities into deciles and compare against
-- actual resolution rates. Perfect calibration: the 70% bin
-- resolves "yes" 70% of the time.

SELECT
    CAST(ROUND(cr.predicted_probability * 10) AS INTEGER) * 10
        AS probability_bin,
    COUNT(*) AS forecast_count,
    AVG(cr.actual_outcome) AS actual_resolution_rate,
    AVG(cr.predicted_probability) AS mean_predicted,
    AVG(cr.brier_score) AS mean_brier,
    AVG(cr.actual_outcome) - AVG(cr.predicted_probability)
        AS calibration_gap
FROM calibration_results cr
GROUP BY probability_bin
ORDER BY probability_bin;


-- ============================================================
-- 2. DOMAIN PERFORMANCE — Where am I calibrated, where am I not?
-- ============================================================
-- Break down forecasting accuracy by category.
-- Reveals domain-specific biases.

SELECT
    cr.category,
    COUNT(*) AS positions,
    AVG(cr.brier_score) AS mean_brier,
    AVG(cr.log_score) AS mean_log_score,
    AVG(cr.actual_outcome) AS base_rate,
    SUM(CASE WHEN cr.actual_outcome = 1 THEN 1 ELSE 0 END)
        AS resolved_yes,
    SUM(CASE WHEN cr.actual_outcome = 0 THEN 1 ELSE 0 END)
        AS resolved_no
FROM calibration_results cr
GROUP BY cr.category
ORDER BY mean_brier ASC;


-- ============================================================
-- 3. TIME HORIZON ANALYSIS — Short vs long forecasts
-- ============================================================
-- Are short-horizon forecasts better calibrated than long ones?
-- Groups by time-to-resolution bucket.

SELECT
    cr.time_horizon_bucket,
    COUNT(*) AS positions,
    AVG(cr.brier_score) AS mean_brier,
    AVG(ABS(cr.predicted_probability - cr.actual_outcome))
        AS mean_absolute_error,
    AVG(cr.predicted_probability) AS mean_confidence
FROM calibration_results cr
GROUP BY cr.time_horizon_bucket
ORDER BY
    CASE cr.time_horizon_bucket
        WHEN '<1 week' THEN 1
        WHEN '1-4 weeks' THEN 2
        WHEN '1-3 months' THEN 3
        WHEN '3+ months' THEN 4
    END;


-- ============================================================
-- 4. PLATFORM ARBITRAGE — Cross-platform price divergence
-- ============================================================
-- Find contracts on the same underlying event where prices
-- differ across platforms. Requires contract linking.

SELECT
    c1.question,
    p1_latest.name AS platform_1,
    pr1.yes_price AS price_1,
    p2_latest.name AS platform_2,
    pr2.yes_price AS price_2,
    ABS(pr1.yes_price - pr2.yes_price) AS price_gap,
    c1.closes_at
FROM contracts c1
JOIN contracts c2
    ON c1.id < c2.id
    AND c1.question = c2.question
    AND c1.platform_id != c2.platform_id
JOIN platforms p1_latest ON p1_latest.id = c1.platform_id
JOIN platforms p2_latest ON p2_latest.id = c2.platform_id
JOIN prices pr1 ON pr1.contract_id = c1.id
    AND pr1.timestamp = (
        SELECT MAX(timestamp) FROM prices WHERE contract_id = c1.id
    )
JOIN prices pr2 ON pr2.contract_id = c2.id
    AND pr2.timestamp = (
        SELECT MAX(timestamp) FROM prices WHERE contract_id = c2.id
    )
WHERE ABS(pr1.yes_price - pr2.yes_price) > 0.03
ORDER BY price_gap DESC
LIMIT 20;


-- ============================================================
-- 5. PORTFOLIO SUMMARY — Current positions and P&L
-- ============================================================
-- Overview of all open and resolved positions with performance.

SELECT
    CASE WHEN pos.exit_time IS NULL THEN 'Open' ELSE 'Closed' END
        AS status,
    c.category,
    COUNT(*) AS position_count,
    SUM(pos.shares * pos.entry_price) AS total_cost_basis,
    SUM(pos.realized_pnl) AS total_realized_pnl,
    SUM(CASE
        WHEN pos.exit_time IS NULL THEN
            pos.shares * (
                (SELECT yes_price FROM prices
                 WHERE contract_id = c.id
                 ORDER BY timestamp DESC LIMIT 1)
                - pos.entry_price
            )
        ELSE 0
    END) AS total_unrealized_pnl
FROM positions pos
JOIN contracts c ON c.id = pos.contract_id
GROUP BY status, c.category
ORDER BY status, total_realized_pnl DESC;


-- ============================================================
-- 6. SIGNAL VALUE — Which signals actually predict outcomes?
-- ============================================================
-- Correlate external signal types with position outcomes.
-- High-value signals improve forecasting accuracy.

SELECT
    s.signal_type,
    s.source,
    COUNT(DISTINCT pos.id) AS positions_using_signal,
    AVG(cr.brier_score) AS mean_brier_with_signal,
    (SELECT AVG(cr2.brier_score) FROM calibration_results cr2)
        AS overall_mean_brier,
    AVG(cr.brier_score) - (
        SELECT AVG(cr2.brier_score) FROM calibration_results cr2
    ) AS brier_improvement
FROM signals s
JOIN contract_signals cs ON cs.signal_id = s.id
JOIN positions pos ON pos.contract_id = cs.contract_id
JOIN calibration_results cr ON cr.position_id = pos.id
GROUP BY s.signal_type, s.source
HAVING positions_using_signal >= 5
ORDER BY brier_improvement ASC;


-- ============================================================
-- 7. MARKET EFFICIENCY — How fast do markets price information?
-- ============================================================
-- For resolved contracts, compare price at various time horizons
-- before resolution against the final outcome. Efficient markets
-- should converge to 0 or 1 well before resolution.

SELECT
    CASE
        WHEN hours_before <= 1 THEN '<1 hour'
        WHEN hours_before <= 24 THEN '1-24 hours'
        WHEN hours_before <= 168 THEN '1-7 days'
        WHEN hours_before <= 720 THEN '7-30 days'
        ELSE '30+ days'
    END AS time_bucket,
    COUNT(*) AS observations,
    AVG(ABS(yes_price - resolution_value)) AS mean_abs_error,
    AVG((yes_price - resolution_value) * (yes_price - resolution_value))
        AS mean_squared_error
FROM (
    SELECT
        p.yes_price,
        c.resolution_value,
        (JULIANDAY(c.resolution_date) - JULIANDAY(p.timestamp)) * 24
            AS hours_before
    FROM prices p
    JOIN contracts c ON c.id = p.contract_id
    WHERE c.resolution_outcome IS NOT NULL
) sub
GROUP BY time_bucket
ORDER BY
    CASE time_bucket
        WHEN '<1 hour' THEN 1
        WHEN '1-24 hours' THEN 2
        WHEN '1-7 days' THEN 3
        WHEN '7-30 days' THEN 4
        WHEN '30+ days' THEN 5
    END;


-- ============================================================
-- 8. BASE RATE COMPARISON — Market vs historical rates
-- ============================================================
-- Compare current market prices against base rates for
-- structurally similar historical contracts.

SELECT
    c.question,
    c.category,
    latest_price.yes_price AS current_market_price,
    br.historical_rate AS base_rate,
    latest_price.yes_price - br.historical_rate AS deviation,
    br.total_contracts AS base_rate_sample_size,
    c.closes_at,
    ROUND(
        (JULIANDAY(c.closes_at) - JULIANDAY('now')) / 7.0, 1
    ) AS weeks_to_close
FROM contracts c
JOIN (
    SELECT contract_id, yes_price,
        ROW_NUMBER() OVER (
            PARTITION BY contract_id ORDER BY timestamp DESC
        ) AS rn
    FROM prices
) latest_price
    ON latest_price.contract_id = c.id AND latest_price.rn = 1
JOIN base_rates br
    ON br.category = c.category
    AND br.structural_pattern = c.subcategory
WHERE c.resolution_outcome IS NULL
  AND ABS(latest_price.yes_price - br.historical_rate) > 0.10
ORDER BY ABS(deviation) DESC
LIMIT 20;


-- ============================================================
-- 9. BELIEF DYNAMICS — Price trajectory around information events
-- ============================================================
-- Track how contract prices move in a window around signal events.
-- Measures incorporation speed and overreaction.

SELECT
    s.signal_type,
    AVG(p_before.yes_price) AS mean_price_before,
    AVG(p_after_1h.yes_price) AS mean_price_1h_after,
    AVG(p_after_24h.yes_price) AS mean_price_24h_after,
    AVG(p_after_7d.yes_price) AS mean_price_7d_after,
    AVG(ABS(p_after_1h.yes_price - p_before.yes_price))
        AS mean_initial_reaction,
    AVG(ABS(p_after_24h.yes_price - p_after_1h.yes_price))
        AS mean_24h_adjustment,
    COUNT(*) AS event_count
FROM signals s
JOIN contract_signals cs ON cs.signal_id = s.id
JOIN prices p_before ON p_before.contract_id = cs.contract_id
    AND p_before.timestamp = (
        SELECT MAX(timestamp) FROM prices
        WHERE contract_id = cs.contract_id
          AND timestamp < s.timestamp
    )
JOIN prices p_after_1h ON p_after_1h.contract_id = cs.contract_id
    AND p_after_1h.timestamp = (
        SELECT MIN(timestamp) FROM prices
        WHERE contract_id = cs.contract_id
          AND timestamp >= DATETIME(s.timestamp, '+1 hour')
    )
JOIN prices p_after_24h ON p_after_24h.contract_id = cs.contract_id
    AND p_after_24h.timestamp = (
        SELECT MIN(timestamp) FROM prices
        WHERE contract_id = cs.contract_id
          AND timestamp >= DATETIME(s.timestamp, '+1 day')
    )
JOIN prices p_after_7d ON p_after_7d.contract_id = cs.contract_id
    AND p_after_7d.timestamp = (
        SELECT MIN(timestamp) FROM prices
        WHERE contract_id = cs.contract_id
          AND timestamp >= DATETIME(s.timestamp, '+7 days')
    )
GROUP BY s.signal_type
HAVING event_count >= 3
ORDER BY mean_initial_reaction DESC;


-- ============================================================
-- 10. OVERCONFIDENCE DETECTOR — When high confidence fails
-- ============================================================
-- Examine positions where predicted probability was extreme
-- (>0.85 or <0.15) but the outcome was wrong. These are the
-- most expensive forecasting errors and the most instructive.

SELECT
    pos.id AS position_id,
    c.question,
    c.category,
    pos.direction,
    pos.entry_price,
    cr.predicted_probability,
    cr.actual_outcome,
    cr.brier_score,
    pos.rationale,
    c.resolution_date
FROM positions pos
JOIN contracts c ON c.id = pos.contract_id
JOIN calibration_results cr ON cr.position_id = pos.id
WHERE (cr.predicted_probability > 0.85 AND cr.actual_outcome = 0)
   OR (cr.predicted_probability < 0.15 AND cr.actual_outcome = 1)
ORDER BY cr.brier_score DESC
LIMIT 20;
