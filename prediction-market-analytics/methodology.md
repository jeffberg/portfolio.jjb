# Prediction Market Analytics — Methodology

How signals are identified, evaluated, and integrated into a forecasting workflow. The methodology connects the theoretical framework (cognitive science, behavioral science, computational social science) to practical prediction market research.

## The Forecasting Problem

A prediction market contract asks: will event X happen? The market price reflects the crowd's aggregated belief. The forecasting problem is: given everything I can observe, is the crowd's belief well-calibrated — or is there an identifiable, systematic reason it's wrong?

This is not the same as "do I know something the market doesn't." It's closer to: "can I identify a process by which the market's belief formation is biased, and is that bias large enough to exploit given transaction costs and uncertainty?"

The methodology is organized around three questions:
1. **What does the evidence say?** (Signal extraction)
2. **What does the market believe?** (Market state analysis)
3. **Where and why do they diverge?** (Edge identification)

## Signal Extraction

### Signal Taxonomy

Not all information is equally useful. Signals are categorized by their relationship to the forecasted event:

| Signal Type | Description | Example |
|------------|-------------|---------|
| **Structural** | Properties of the contract itself | Time to expiration, category, historical base rate for similar contracts |
| **Fundamental** | Direct evidence about the underlying event | Polling data for elections, economic indicators for macro contracts |
| **Market-derived** | Information from the market's own behavior | Volume spikes, price momentum, order book imbalance |
| **Cross-market** | Prices of related contracts on the same or other platforms | Correlated contracts, conditional markets, arbitrage signals |
| **Sentiment** | Qualitative indicators of crowd disposition | News volume, social media intensity, expert commentary |

### Signal Evaluation

Each signal type is evaluated on two dimensions:

- **Predictive value** — Does the signal actually predict the resolution outcome better than the base rate? Measured by the change in log-likelihood when the signal is included in a simple model.
- **Incorporation speed** — How quickly does the market price reflect the signal? Signals that are slowly incorporated represent opportunities; signals that are instantly priced offer no edge.

```
Predictive value = Δ log-likelihood when signal is included
Edge opportunity = Predictive value × (1 - Incorporation speed)
```

A signal with high predictive value but low incorporation speed is the most valuable: it tells you something the market hasn't yet priced in. A signal with high predictive value and high incorporation speed tells you something the market already knows.

### Base Rate Construction

For any contract, the first analytical step is establishing a base rate: historically, how often have structurally similar contracts resolved "yes"?

Structural similarity is defined along several dimensions:
- **Category match** — Same domain (politics, economics, weather)
- **Time horizon match** — Similar time to resolution
- **Price range match** — Similar market-implied probability at the same relative time before resolution
- **Structural pattern match** — e.g., "Will X exceed Y by date Z?" contracts share structural patterns regardless of domain

The base rate engine computes resolution frequencies for each similarity cluster and provides them as empirical priors. A contract priced at $0.70 in a category where the base rate for similar contracts is $0.55 invites investigation: what does the market know that the base rate doesn't, or is the market overweighting a salient signal?

## Market State Analysis

### Price Dynamics

Raw price is the starting point, but several derived features are more informative:

- **Price trajectory** — The path by which the current price was reached. A contract at $0.65 that has been slowly climbing from $0.50 over two weeks tells a different story than one that dropped from $0.80 yesterday.
- **Volatility regime** — Is the price stable (low information arrival rate) or volatile (high information arrival rate)? Stable prices near resolution suggest the market has converged; volatile prices suggest unresolved uncertainty.
- **Volume profile** — Trading volume relative to the contract's historical norm. Volume spikes often precede or accompany information events.
- **Order book depth** (CLOB platforms) — Bid-ask spread, depth at various levels, imbalance. Thin books near important prices suggest fragile consensus.

### Crowd Belief Decomposition

A market price is an aggregate, but aggregates can mask disagreement. Two markets at $0.65 might differ fundamentally:

1. **Consensus $0.65** — Most participants believe ~65%. The price reflects genuine agreement.
2. **Bimodal $0.65** — Half believe ~90%, half believe ~30%. The price is an artifact of averaging, not a belief anyone holds.

These cases have different forecasting implications. Consensus markets are harder to beat (the crowd is agreeing on the evidence). Bimodal markets are opportunities (the crowd is disagreeing about which evidence matters, and you might be able to determine who's right).

On CLOB platforms, order book shape provides some signal about belief distribution. On AMM platforms, trade pattern analysis can approximate it.

## Edge Identification

### Cognitive Bias Framework

The methodology's distinctive contribution is using cognitive science to identify *why* a market might be mispriced, not just *that* it appears mispriced. Common biases with prediction market manifestations:

**Anchoring and insufficient adjustment.** Markets anchor on salient reference points and adjust insufficiently. An election contract might anchor on the last major poll rather than integrating the full polling distribution. Manifestation: prices that track individual data releases rather than the underlying trend.

**Availability bias.** Events that are vivid, recent, or emotionally salient are overweighted. A dramatic event (cyberattack, natural disaster) may cause markets to overestimate the probability of similar events, even when base rates are low. Manifestation: price spikes after salient events that mean-revert as salience fades.

**Base rate neglect.** The tendency to ignore prior probabilities in favor of case-specific evidence. A contract about a specific company might be priced based entirely on recent news, ignoring the base rate for similar companies in similar situations. Manifestation: prices that diverge from structural base rates without proportional evidence.

**Recency bias.** Overweighting recent information relative to the full information set. Markets may extrapolate short-term trends into long-term forecasts. Manifestation: momentum in contract prices that isn't justified by the information arrival rate.

**Disposition effect.** The tendency to hold losing positions too long (hoping for recovery) and exit winning positions too early (locking in gains). In prediction markets, this manifests as price stickiness — markets that are slow to move even when evidence is clear.

**Narrative bias.** Constructing coherent stories around partial evidence. A plausible narrative for why an event will occur can inflate the perceived probability beyond what the evidence supports. Manifestation: prices elevated by compelling narratives rather than statistical reasoning.

### Edge Sizing

Identifying a potential bias is necessary but not sufficient. The edge must be sized:

1. **Magnitude** — How far is the market price from the evidence-implied probability? Small deviations (1–3 cents) rarely survive transaction costs.
2. **Confidence** — How confident are you in the bias identification? This is itself a calibration question — meta-forecasting about your own analytical process.
3. **Time horizon** — When will the bias correct? A mispricing that corrects at resolution is different from one that corrects when the next data release arrives.
4. **Liquidity** — Can you actually trade at the identified price? Thin markets may show apparent mispricings that disappear when you try to fill a meaningful position.

## Calibration Methodology

### Tracking Framework

Every position is logged with:
- **Predicted probability** — Your estimate at entry time
- **Market price** — The contract price at entry time
- **Rationale** — Why you believe the market is wrong (which bias, which evidence)
- **Category tags** — Domain, time horizon, confidence level
- **Outcome** — Resolution result when known

### Scoring

**Brier score** decomposes into three components:

```
Brier = Reliability - Resolution + Uncertainty

Reliability = (1/N) Σ nk(fk - ōk)²     [calibration error — lower is better]
Resolution = (1/N) Σ nk(ōk - ō)²        [discrimination — higher is better]
Uncertainty = ō(1 - ō)                    [irreducible — property of the base rate]
```

Where `nk` is the number of forecasts in probability bin `k`, `fk` is the mean forecast in that bin, `ōk` is the actual resolution rate in that bin, and `ō` is the overall resolution rate.

This decomposition tells you *why* your score is what it is:
- **High reliability (bad)** — Your probability bins don't match actual resolution rates. You're miscalibrated.
- **Low resolution (bad)** — Your forecasts don't discriminate between events that resolve yes and those that resolve no. You're not adding information.
- **Good score, poor calibration** — You're discriminating well but assigning wrong probabilities. Calibration training would help.
- **Good calibration, poor score** — You're well-calibrated but not discriminating. Better signal analysis would help.

### Feedback Loops

The calibration system feeds back into the forecasting process:

1. **Domain-specific calibration curves** reveal where you're systematically biased. If you're overconfident in politics, apply a shrinkage adjustment to political forecasts.
2. **Bias pattern recognition** — If positions motivated by "narrative bias" identification consistently underperform, the cognitive bias framework needs refinement for that domain.
3. **Time horizon analysis** — If short-horizon forecasts are well-calibrated but long-horizon forecasts are overconfident, the signal evaluation framework is overweighting short-term evidence.

## Integration with Theoretical Framework

This methodology is the applied surface of the theoretical framework described in [`perspectives.md`](../theoretical-framework/perspectives.md).

**Cognitive science → Signal processing.** The signal taxonomy and evaluation framework are grounded in information processing research: how evidence is encoded, weighted, and integrated in probabilistic judgment. The bias framework identifies specific failure modes in this process.

**Learning and memory → Calibration improvement.** The feedback loop from calibration scoring to forecasting adjustment mirrors the reinforcement learning paradigm: outcomes update belief-formation processes through experience. The segmented calibration analysis provides the error signal; the forecaster's adaptation provides the weight update.

**Social psychology → Market dynamics.** Crowd belief decomposition and incorporation speed analysis are grounded in social influence research: when do groups converge on truth, and when do social dynamics distort the aggregation process?

**Attitude theory → Position analysis.** Every trade decision has affective, behavioral, and cognitive components. Logging rationale and tracking which cognitive-bias justifications succeed or fail is a form of attitude measurement — mapping the structure of the forecaster's relationship to each proposition.
