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

### `grant-management-system/`

**A grant intelligence platform for a five-person team managing $16M+ in funding.**

Originally developed by [David Williams](https://www.linkedin.com/in/williamsbdavid/). Included here as a reference implementation of config-driven ETL, multi-source data consolidation, and analytical SQL architecture — patterns that directly informed the prediction market analytics platform above.

The system consolidates grant data from four sources — Google Sheets task tracking, a Bloomerang CRM, 23,000+ documents on a shared drive, and IRS 990 filings — into a single SQLite database with full-text search, geospatial queries, and analytical views.

#### Architecture highlights

- **Two-tier fact table pattern** — A header row links to child tables (titles, statuses, dates, amounts, programs, notes), so different source shapes coexist without nullable columns or schema changes per source
- **SQL views as structural contracts** — All multi-table reads go through views. A Python `ViewTable` class fuses the typed dataclass and SQL metadata into one declaration, catching column mismatches at construction time
- **Config-driven ETL** — `FetchDispatcher` resolves route keys to API calls via database config. `SnapshotHasher` deduplicates via SHA-256 content hashing. `TransformCoordinator` decomposes JSON snapshots into normalized facts in a single transaction
- **SpatiaLite geospatial queries** — Service site addresses geocoded and matched against funder territory boundaries
- **FTS5 full-text search** — Porter stemming across 23,000+ extracted documents

**Stack:** Python 3.12, Flask, SQLite (WAL mode), SpatiaLite, Jinja2, Alpine.js, Plotly, Leaflet

Detailed documentation:
- [`architecture.md`](grant-management-system/architecture.md) — System design, data model, query DSL, and design decisions
- [`etl-pipeline-overview.md`](grant-management-system/etl-pipeline-overview.md) — How data flows from raw sources to structured, searchable records
- [`sample-queries.sql`](grant-management-system/sample-queries.sql) — Analytical queries against the database

### Happy to Have Lived

**A goal-planning app that starts with what matters, not what's due.**

Originally developed by [David Williams](https://www.linkedin.com/in/williamsbdavid/). A values-first goal-tracking system built in Swift — the user begins with what they value, then defines goals, sets time-boxed terms, and records actions (including Apple Health imports). The Reflect tab shows whether what you're doing aligns with what you care about.

#### Screenshots

| Facilitated Start | Now | Plan | Reflect |
|:-:|:-:|:-:|:-:|
| ![Onboarding](happy-to-have-lived/screenshots/01-facilitated-start.png) | ![Daily view](happy-to-have-lived/screenshots/02-now.png) | ![Planning](happy-to-have-lived/screenshots/03-plan.png) | ![Reflection](happy-to-have-lived/screenshots/04-reflect.png) |

| Values | Record |
|:-:|:-:|
| ![Values entry](happy-to-have-lived/screenshots/05-values.png) | ![Actions + Health](happy-to-have-lived/screenshots/06-record.png) |

Three-layer Swift Package Manager structure with normalized SQLite models (via GRDB), a centralized `@Observable` DataStore, and on-device language generation via Apple Intelligence.

**Stack:** Swift 6.2, SwiftUI, GRDB, SQLite, HealthKit, Apple Intelligence (Foundation Models), AppIntents

TestFlight: https://testflight.apple.com/join/rrpQRxYJ

### RunningBehind

**A departure calculator for people who lose track of time.**

Originally developed by [David Williams](https://www.linkedin.com/in/williamsbdavid/). The app continuously recalculates the pace needed to arrive on time, translating a countdown into something concrete and embodied — when the required pace shifts from "easy stroll" to "brisk walk" to "you'd better run," that's legible in a way a ticking number isn't.

#### Screenshots

| Departure | Destination | Modes | Modality Editor |
|:-:|:-:|:-:|:-:|
| ![Departure screen](running-behind/screenshots/01-departure.png) | ![Destination detail](running-behind/screenshots/04-destination-detail.png) | ![Travel modes](running-behind/screenshots/02-modes.png) | ![Custom modality](running-behind/screenshots/03-modality-editor.png) |

| Relaxed | Time passing | Running late | Journey in progress |
|:-:|:-:|:-:|:-:|
| ![Relaxed](running-behind/screenshots/05-relaxed-calculation.png) | ![Urgency rising](running-behind/screenshots/06-urgency-rising.png) | ![Running late](running-behind/screenshots/07-running-late.png) | ![Journey tracking](running-behind/screenshots/08-journey-in-progress.png) |

Built primarily through AI-assisted development — Claude Code writing Swift while the developer focused on product decisions, scope discipline, and shipping.

**Stack:** Swift 6.2, SwiftUI, GRDB, SQLite, MapKit, CoreLocation, EventKit, ActivityKit

Read more: [`building-with-ai.md`](running-behind/building-with-ai.md) — prompting strategy, lessons learned, and the user story

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

- **Languages:** Python, SQL, Swift
- **Data:** SQLite, SpatiaLite, Pandas, NumPy, SciPy, ETL pipelines
- **Frameworks:** Flask, SwiftUI, GRDB
- **Visualization:** Plotly, matplotlib, seaborn, Jupyter
- **APIs:** Kalshi, Polymarket, polling aggregators, economic data feeds
- **AI/ML:** Claude Code (daily use), prompt engineering, probabilistic modeling
- **Modeling:** Bayesian inference, proper scoring rules, calibration analysis, information-theoretic measures
- **Tools:** Jupyter, VS Code

## About

Berg Lab. Prediction market research grounded in computational social science, cognitive science, and behavioral science.

The work rests on a simple observation: markets are made of minds. Every price is a belief, every trade is a decision, and every resolution is a learning event. Understanding the computational, cognitive, and social processes that produce beliefs — and the systematic ways they go wrong — is the foundation for forecasting well.

The research perspective draws from social psychology, learning and memory, cognitive neuroscience, and the emergent mathematical properties of knowledge systems both human and artificial. The applied domain is prediction markets: Kalshi, Polymarket, and the broader forecasting ecosystem where these perspectives meet real stakes and measurable outcomes.

## Acknowledgments

The grant management system, Happy to Have Lived, and RunningBehind were originally developed by [David Williams](https://www.linkedin.com/in/williamsbdavid/). His portfolio architecture and documentation structure provided the foundation for this repository.
