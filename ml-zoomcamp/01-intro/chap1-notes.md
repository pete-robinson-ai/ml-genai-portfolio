# 1. Introduction to ML
ML learns patterns from data (features like year/mileage + target like price) to predict unseen examples.

# 2. ML vs Rule-Based Systems
Rule-based (e.g., spam filters) uses fixed rules, hard to maintain as data changes. ML trains on features/targets, outputs probabilities; apply threshold for decisions.

# 3. Supervised ML
Uses labeled data (features X, targets y). Model learns function g(X) ≈ y.
Types: Regression (numeric), Classification (binary/multiclass categories), Ranking (scores for recommenders).

# 4. CRISP-DM Process
    1. Business understanding (measurable goal, ML need).
    2. Data understanding.
    3. Data preparation (clean, tabular).
    4. Modeling (train/select best).
    5. Evaluation.
    6. Deployment (with online eval). Iterative; focus on maintainability.

# 5. Model Selection
Split data: train/validation/test. Train on train, tune on validation. Use test to avoid multiple comparisons problem and confirm final performance.