# Theoretical Framework — Perspectives

The scientific foundation for prediction market research at Berg Lab. This document connects cognitive science, social psychology, computational modeling, and behavioral science to the specific problem of forecasting well in prediction markets.

## The Central Thesis

Prediction markets are cognitive-social systems. Every price is a compressed representation of distributed human (and increasingly machine) judgment. Understanding what makes these representations accurate or inaccurate requires understanding the machinery that produces them — at the level of individual cognition, social interaction, and emergent system dynamics.

This framework is organized around four interlocking perspectives: social psychology, learning and memory, cognitive neuroscience of information processing, and the emergent mathematical properties of knowledge systems.

---

## Social Psychology as Mediating Prism

Social psychology is not one variable among many — it is the mediating and moderating prism through which all interaction between agents (organic or synthetic) is filtered. In prediction markets, this means:

**Every trade is a social act.** When you take a position, you're not just expressing a probability estimate — you're positioning yourself relative to the crowd. The decision to disagree with the market at $0.65 is psychologically different from agreeing with it, even if the informational content is the same. Social identity, conformity pressures, and status dynamics affect willingness to take contrarian positions.

**Markets have cultures.** Different prediction market platforms develop different norms about what constitutes a good reason, how contrarian one can be, and how epistemic vs. tribal the discourse is. These cultural dynamics affect information aggregation quality.

**Stereotypes as compressed social knowledge.** Markets about social and political events are shaped by participants' stereotypic associations — compressed, often implicit knowledge structures about groups, institutions, and patterns. These stereotypes propagate through market behavior via the same symbolic systems that propagate them through society: language, categories, and conceptual associations.

**Separate-but-equal association structures.** The tripartite model of attitudes (affective, behavioral, cognitive) implies that a forecaster's relationship to a proposition has three semi-independent channels:

1. **Affective-emotional** — How you *feel* about the outcome. Do you want it to happen? Are you afraid of it? Affect biases probability estimates in predictable ways: desired outcomes are overestimated (wishful thinking), and feared outcomes are overestimated by vigilant copers (anxious overweighting of threat) but underestimated by avoidant copers (defensive denial of threat).

2. **Behavioral-instrumental** — What you're *willing to do*. Position sizing, timing of entry and exit, and willingness to average into a losing position all express the behavioral component of the attitude, which may diverge from the stated cognitive estimate.

3. **Cognitive-associative** — What you *know and believe*. The evidence you've processed, the base rates you've internalized, the causal models you hold. This is what forecasters think they're trading on — but the other two channels are always present.

The structure of alignment or conflict among these three channels — attitude consistency, ambivalence, and conflict — predicts forecasting behavior more reliably than any single channel alone.

---

## Learning and Memory as Intelligence Systems

Learning and memory are fundamental intelligence systems — not metaphorically, but formally. The same mathematical frameworks describe human memory consolidation and machine learning optimization. In prediction markets, this means:

**Forecasting is memory retrieval under uncertainty.** When you estimate a probability, you're retrieving relevant patterns, base rates, and causal models from memory. The quality of the estimate depends on:
- What was encoded (what evidence did you encounter and attend to?)
- How it was stored (was it chunked with the right category? tagged with the right context?)
- What cues trigger retrieval (does the current contract activate the most relevant stored knowledge, or the most salient?)
- What interferes (do vivid but irrelevant memories compete with relevant but pallid ones?)

**Repeated interaction is reinforcement.** Each market resolution is a learning event. The structure of this learning — whether it produces better calibration or entrenched biases — depends on the same factors that determine learning quality in any reinforcement paradigm:
- **Feedback quality** — Prediction markets provide excellent feedback: unambiguous outcomes with precise timing. This is why markets can be better calibration environments than most real-world forecasting contexts.
- **Feedback delay** — Long-horizon contracts delay the learning signal. Short-horizon markets provide faster feedback loops and should produce faster calibration improvement.
- **Credit assignment** — When a forecast is wrong, what went wrong? Was it the signal analysis, the bias assessment, the probability estimation, or the position sizing? Proper credit assignment requires the kind of systematic logging that the analytics system provides.

**Knowledge compression, dynamics, and expansion.** Expertise in forecasting is a form of knowledge compression: the expert has compressed thousands of past observations into retrievable patterns, heuristics, and intuitions that allow rapid probability estimation for novel situations. This compression process has the same formal structure as:
- Neural network training (compressing training data into weight matrices)
- Statistical summarization (compressing data into sufficient statistics)
- Cultural knowledge transmission (compressing collective experience into stereotypes, norms, and heuristics)

The question is always: what is preserved and what is lost in the compression? In forecasting, the risk is that compression preserves salient patterns (dramatic market crashes, surprising election outcomes) at the expense of base rates (the vast majority of the time, markets are approximately correct).

**Memory systems model.** The distinction between explicit (declarative) and implicit (non-declarative) memory systems maps directly onto forecasting behavior:
- **Explicit forecasting** — Deliberate probability estimation based on consciously retrieved evidence. Slow, effortful, and sensitive to cognitive load.
- **Implicit forecasting** — Gut-level probability sense based on pattern matching against accumulated experience. Fast, automatic, and resistant to verbal justification.

Good forecasting requires both systems, and — critically — the metacognitive ability to know when each system is more reliable for a given type of question.

---

## Cognitive Neuroscience of Information Processing

The cognitive neuroscience perspective provides the mechanistic account: how does the brain (or any information processing system) encode, store, retrieve, and sometimes dysregulate the information that underlies probability estimates?

### Information Encoding

Not all evidence is encoded equally. Attention is the primary gate:
- **Attentional capture** — Vivid, emotionally charged, or surprising information captures attention automatically. In prediction markets, this means dramatic events (a candidate's gaffe, a surprise economic report) are reliably encoded, while slow-moving trends (gradual polling shifts, base rate statistics) may be under-encoded.
- **Encoding depth** — Evidence that is actively processed (compared against existing models, related to other known facts) is encoded more durably than evidence that is passively observed. This is why active analysis produces better calibration than passive market-watching.
- **Working memory constraints** — The number of signals that can be simultaneously evaluated is limited by working memory capacity. Complex multi-signal analyses require external scaffolding (the analytics system) to overcome these constraints.

### Information Storage

Stored knowledge is not a static archive — it is a dynamic system subject to reorganization:
- **Consolidation** — New evidence is integrated with existing knowledge during consolidation. The quality of this integration determines whether new evidence updates existing models (good) or creates isolated, disconnected memory traces (bad).
- **Reconsolidation** — Retrieving a memory makes it temporarily labile and subject to modification. This is why revisiting past forecasts with new information can either improve or distort the memory of what you originally believed.
- **Interference** — New learning can interfere with old learning (retroactive interference) and vice versa (proactive interference). In forecasting, this manifests as: learning about Domain B may temporarily impair performance in Domain A, and strong priors in Domain A may resist updating when Domain A evidence changes.

### Information Retrieval

Probability estimation at the moment of decision is a retrieval process:
- **Cue-dependent retrieval** — The contract question and market context serve as retrieval cues. The quality of the forecast depends on whether these cues activate the most diagnostic stored knowledge or the most available.
- **Retrieval fluency** — Evidence that comes to mind easily is judged as more probable (the availability heuristic). This is a feature, not just a bug: frequently encountered patterns *are* more probable, on average. But it becomes a bias when salience diverges from frequency.
- **Motivated retrieval** — Directional goals (wanting an outcome, having a position) bias retrieval toward confirming evidence. This is the cognitive mechanism underlying confirmation bias in markets.

### Information Dysregulation

When information processing goes systematically wrong:
- **Encoding failures** — Important evidence that was never attended to or properly encoded. You can't retrieve what you never stored. Systematic encoding failures (e.g., consistently ignoring base rate information) produce systematic forecasting biases.
- **Storage distortion** — Evidence that was encoded accurately but distorted during storage or reconsolidation. The "I knew it all along" phenomenon (hindsight bias) is a storage distortion that impairs learning from past forecasting errors.
- **Retrieval failures** — Evidence that was encoded and stored but is not retrieved at the moment of decision. Tip-of-the-tongue states in everyday life; "I should have thought of that" in forecasting.
- **Integration failures** — Evidence that is individually retrieved but not properly integrated into a coherent probability estimate. This is the computational bottleneck: combining multiple signals with different reliabilities, directions, and magnitudes into a single number.

---

## Emergent Properties of Knowledge Systems

The most speculative — and potentially most powerful — perspective concerns the emergent mathematical, computational, and statistical properties that arise when knowledge is compressed, propagated, and expanded through networks. These properties appear across scales and substrates:

### Compression and Expansion

Knowledge systems — human and artificial — operate through cycles of compression and expansion:
- **Compression:** Distilling many observations into compact representations (stereotypes, heuristics, weight matrices, sufficient statistics)
- **Expansion:** Generating novel inferences and predictions from compressed representations (generalization, analogy, interpolation)

The quality of a knowledge system is determined by what is preserved and what is lost in compression, and how faithfully the expansion recovers the original information structure.

In prediction markets, this manifests at multiple levels:
- **Individual:** A forecaster's expertise is compressed experience. The quality of forecasts depends on the compression algorithm (what was attended to, how it was organized, what retrieval cues were created).
- **Market:** A market price is compressed crowd knowledge. The quality of the price depends on the aggregation mechanism (order book dynamics, AMM design) and the diversity and independence of contributing beliefs.
- **Cultural:** Categories like "political uncertainty" or "recession risk" are culturally compressed knowledge. These compressions propagate through prediction market discourse and affect how participants frame and estimate probabilities.

### Network Structure and Traversal

Knowledge propagation through markets follows graph-theoretical principles:
- **Hub structure** — Some participants are information hubs; their trades carry disproportionate signal. Identifying hub behavior in order flow is an information-extraction problem.
- **Clustering** — Markets develop information clusters where participants share common information sources. Within-cluster prices converge quickly; between-cluster disagreements persist longer and may represent genuine uncertainty rather than noise.
- **Cascade dynamics** — Information cascades occur when participants infer from others' trades rather than private information. Cascades produce consensus without wisdom — prices that look confident but are informationally hollow.

### Gain and Loss via Iteration

Repeated interaction with a system produces both gains (learning, calibration improvement, expertise development) and losses (overspecialization, overfit to recent patterns, erosion of base rate sensitivity). The trajectory — whether iteration produces net gain or net loss — depends on:
- **Feedback structure** — Clear, timely, unambiguous feedback (as in prediction markets) favors gain.
- **Environmental stability** — Stable domains (weather, sports with fixed rules) favor gain through pattern accumulation. Shifting domains (geopolitics, technology) penalize pattern accumulation and reward adaptability.
- **Metacognitive monitoring** — The ability to notice when past patterns are no longer predictive. This is the key human advantage over simple pattern-matching systems: the capacity to doubt one's own compressed knowledge.

### Quantum Probabilistic Framing

Quantum probability theory provides a mathematical framework for modeling cognitive phenomena that violate classical probability axioms — phenomena that are common in prediction markets:
- **Order effects** — Evaluating evidence A before B produces a different probability estimate than B before A. Classical probability says this shouldn't happen; quantum probability models it naturally as non-commutative operators on a belief state.
- **Conjunction effects** — Judging P(A and B) > P(A) or P(B), violating classical conjunction rules. This occurs when the conjunction creates a more coherent narrative than either component alone.
- **Interference effects** — The act of evaluating a proposition changes the belief state, so that subsequent evaluations are no longer independent. In markets, this means the order in which you analyze contracts can change your probability estimates for each.

These are not quantum physics — they are formal mathematical tools from quantum theory applied to cognitive modeling. The relevance to prediction markets is that participants' belief states may be better modeled as quantum-probabilistic vectors than as classical probability distributions, with implications for how we understand market aggregation and information processing.

---

## Synthesis: Attitudes as the Unifying Construct

The four perspectives converge on a single construct: **attitude** — defined globally and inclusively as all affective-emotive activations, behavioral-instrumental affordances, and cognitive-associative knowledge that contribute to the relationship between a person and a proposition.

In prediction markets, every position is an attitude. The comprehensive attitude profile includes:

| Attitude Dimension | Definition | Market Manifestation |
|-----------|-----------|---------------------|
| Activity | Degree of active engagement | Trading frequency, market monitoring |
| Ambivalence | Coexistence of positive and negative evaluations | Hedged positions, frequent position changes |
| Awareness | Conscious access to the attitude | Ability to articulate rationale |
| Certainty | Subjective confidence in the attitude | Position sizing relative to edge estimate |
| Conflict | Disagreement among affective, behavioral, cognitive channels | Saying one probability but trading at another |
| Consistency | Agreement among attitude components | Alignment of stated belief, position, and emotional response |
| Construal level | Abstract vs. concrete representation | "Will inflation rise?" vs. "Will CPI exceed 3.2% in March?" |
| Correspondence with behavior | Whether stated belief matches trading behavior | Stated probability vs. revealed probability from trades |
| Durability | Persistence over time | How long a position is held despite market movement |
| Explicitness | Consciously accessible and reportable | Can the forecaster articulate the evidence? |
| Extremity | Distance from the midpoint (0.50) | Positions at 0.90 vs. 0.55 |
| Implicitness | Operative but not consciously accessible | Gut feelings about outcomes that resist verbal justification |
| Intensity | Strength of emotional engagement | Emotional response to P&L changes |
| Polarity | Direction of evaluation | Bullish vs. bearish on the proposition |
| Stability | Resistance to change given new information | Update rate in response to evidence |
| Strength | Combination of extremity, certainty, and durability | Overall conviction level |
| Valence | Positive vs. negative evaluation | Whether the forecaster wants the outcome to occur |

This comprehensive attitude framework provides the measurement apparatus for prediction market research. Each dimension can be operationalized, measured (through trading behavior, self-report, or both), and correlated with forecasting accuracy. The result is a multi-dimensional map of the forecaster's relationship to each proposition — far richer than a single probability number, and far more diagnostic when things go wrong.

The framework also applies to the market itself as a collective attitude: the market's activity, ambivalence, certainty, stability, and strength toward a proposition can be measured through aggregate trading patterns and price dynamics, providing a complementary view of collective belief that goes beyond the headline price.
