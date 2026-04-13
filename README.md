# Berg Lab — Portfolio

Prediction market research and analytics at the intersection of computational social science, cognitive science, and behavioral science. Active forecaster and researcher on Kalshi and Polymarket.

## Scientific Perspectives

- **Computational social science** — modeling market dynamics, crowd belief propagation, and social information processing as computational systems
- **Data science** — signal extraction, calibration analytics, and statistical inference across prediction market data
- **Cognitive science** — the information processing, memory, and decision-making architectures that underlie probabilistic judgment
- **Behavioral science** — systematic biases in forecasting, belief updating, and risk assessment under uncertainty

## What's Here

### `prediction-market-analytics/`

**A market intelligence system for systematic forecasting across prediction platforms.**

Before this system, evaluating a prediction market contract meant manually checking polling aggregators, economic data releases, and historical resolution patterns across multiple platforms. Identifying where crowd beliefs diverge from observable evidence — where there's actual edge — required juggling browser tabs, spreadsheets, and intuition.

Now it's a pipeline.

#### What it does

The system consolidates market data from prediction platforms (Kalshi, Polymarket), cross-references with external signals — polling aggregates, economic indicators, event calendars, historical resolution patterns — and surfaces analytical views designed to distinguish informed belief from noise.

A forecaster can:
- Track contract prices across platforms in real time, identifying arbitrage and divergence
- Cross-reference market-implied probabilities against external base rates and signal data
- Analyze personal forecasting calibration — Brier scores, log scores, calibration curves segmented by domain, horizon, and confidence
- Model crowd belief dynamics over a contract's lifecycle — how and when markets incorporate new information
- Identify systematic patterns in over-reaction, under-reaction, and the timescale of price discovery

#### Why it's built this way

The core analytical problem: prediction markets aggregate beliefs, but beliefs are not uniformly informed. A contract trading at $0.65 might reflect a well-calibrated crowd, or it might reflect a crowd anchored on a salient-but-misleading signal. Distinguishing these cases requires bringing external evidence into contact with market prices — and doing so systematically, not ad hoc.

The data pipeline is **source-agnostic**. Adding a new platform or signal source requires configuration — API endpoint, field mappings, update frequency — not code changes. The same analytical framework processes Kalshi order book data and Polymarket AMM prices, normalizing platform-specific structures into a common schema.

On top of the raw market data, **analytical layers** provide the working model: Calibration tracking computes proper scoring rules against realized outcomes. Signal analysis measures the predictive value of external indicators against market movements. Belief dynamics modeling traces how contract prices respond to information events — overreaction, underreaction, and the timescale of incorporation.

#### Architecture highlights

- **Platform-agnostic ingestion** — Config-driven ETL normalizes market data from different platform types (central limit order book, AMM, hybrid) into a unified analytical schema
- **Multi-source signal fusion** — External data (polls, economic releases, event outcomes) temporally aligned with market prices for cross-referencing and edge detection
- **Proper scoring rules** — Brier scores, logarithmic scores, and calibration curves computed against resolved outcomes, segmented by domain, time horizon, and confidence level
- **Belief dynamics analysis** — Tracking how market-implied probabilities evolve in response to information events, measuring incorporation speed and over/under-reaction patterns
- **Base rate engine** — Historical resolution rates for structurally similar contracts, providing an empirical prior against which current prices can be evaluated

**Stack:** Python 3.12, SQLite, Pandas, NumPy, SciPy, Plotly, Jupyter, REST APIs (Kalshi, Polymarket)

Detailed documentation:
- [`architecture.md`](prediction-market-analytics/architecture.md) — System design, data model, and analytical pipeline
- [`methodology.md`](prediction-market-analytics/methodology.md) — Signal extraction framework and calibration methodology
- [`sample-analyses.sql`](prediction-market-analytics/sample-analyses.sql) — Analytical queries against the market database

### `theoretical-framework/`

**The scientific foundation underlying prediction market research.**

Prediction markets are social-computational systems. They aggregate beliefs, but beliefs are cognitive products — shaped by information processing, memory, attention, affect, and social context. Understanding market behavior requires understanding the cognitive and social machinery that produces it.

This framework connects four levels of analysis:

1. **Information processing** — How individual forecasters encode, store, retrieve, and update probabilistic beliefs. The computational constraints — attention, working memory, cognitive load — that shape how evidence is weighted. How information dysregulation (retrieval interference, encoding failures, motivated reasoning) introduces systematic error into probability estimates.

2. **Learning and memory** — How repeated interaction with markets changes forecasting behavior. The structure of learned associations between signal types and outcome patterns. How reinforcement and iteration shape the compression, dynamics, and expansion of knowledge across time — the same principles that govern both human memory consolidation and machine learning optimization.

3. **Social dynamics** — How beliefs propagate through prediction markets and the broader information ecosystem. When markets exhibit wisdom-of-crowds aggregation versus herding, cascading, or polarization. What social-psychological factors mediate the transition — and how stereotypes, symbolic systems, and conceptual-semantic associations act as propagation vehicles for beliefs through social networks.

4. **Attitudes as prediction** — Every prediction market position is an attitude: a relationship between a person and a proposition. The tripartite model decomposes this into affective (how you feel about the outcome), behavioral (what you're willing to stake), and cognitive (what evidence you've processed) components. These three channels can be consistent, ambivalent, or in outright conflict — and the structure of that alignment predicts forecasting accuracy, position sizing, and response to new information.

Read more: [`perspectives.md`](theoretical-framework/perspectives.md) — Full theoretical framework connecting cognitive science, social psychology, and computational modeling to prediction market behavior

## Fields, Theories, and Field Theories

**Social psychology** as a mediating and moderating cultural, computational, and cognitive prism affecting any interaction between organic or synthetic agents. Markets don't operate in a social vacuum — every price is a social act, and every trade occurs within a web of identity, group membership, and cultural meaning-making.

**Learning and memory** as fundamental human and machine intelligence systems. Forecasting is memory retrieval under uncertainty: the quality of a prediction depends on what was encoded, how it was stored, what cues trigger retrieval, and what interferes. The same formal framework describes a neural network updating weights and a human updating beliefs after a surprise resolution.

**Cognitive neuroscience of information processing** — the mechanisms of information storage, retrieval, and dysregulation. How attention gates what evidence enters the forecasting process. How working memory limits constrain the number of signals that can be simultaneously evaluated. How affective states bias retrieval toward confirming or disconfirming evidence. How expertise reshapes these processes through chunking, automaticity, and pattern recognition.

**Emergent properties of knowledge systems** — the computational, mathematical, quantum probabilistic, and statistical properties that emerge when knowledge is compressed, propagated, and expanded through networks. These properties appear in human social systems (stereotypes as compressed social knowledge, attitudes as compressed evaluative knowledge) and in artificial systems (neural network weight matrices as compressed training knowledge, residual connections as knowledge propagation shortcuts). The formal parallels are not metaphors — they are structural isomorphisms that can be exploited analytically.

## Technical Stack

- **Languages:** Python, SQL
- **Data:** SQLite, Pandas, NumPy, SciPy, ETL pipelines
- **Visualization:** Plotly, matplotlib, seaborn, Jupyter
- **APIs:** Kalshi, Polymarket, polling aggregators, economic data feeds
- **AI/ML:** Claude Code (daily use), prompt engineering, probabilistic modeling
- **Modeling:** Bayesian inference, proper scoring rules, calibration analysis, information-theoretic measures
- **Tools:** Jupyter, VS Code

## About

Berg Lab. Prediction market research grounded in computational social science, cognitive science, and behavioral science.

The work rests on a simple observation: markets are made of minds. Every price is a belief, every trade is a decision, and every resolution is a learning event. Understanding the computational, cognitive, and social processes that produce beliefs — and the systematic ways they go wrong — is the foundation for forecasting well.

The research perspective draws from social psychology, learning and memory, cognitive neuroscience, and the emergent mathematical properties of knowledge systems both human and artificial. The applied domain is prediction markets: Kalshi, Polymarket, and the broader forecasting ecosystem where these perspectives meet real stakes and measurable outcomes.
