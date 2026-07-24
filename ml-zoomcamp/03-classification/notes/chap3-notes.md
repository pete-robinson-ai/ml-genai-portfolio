# ML Zoomcamp: Classification Chapter Summary 

# Project (Churn Prediction):
Binary classification for telco customer churn (predict who will leave). Use Kaggle Telco dataset. Score customers 0-1 probability; target high-risk with promos. Positive (1): churned.

# Data Prep:
    • Load CSV, uniform columns/values (lowercase, replace spaces).
    • Fix types: totalcharges to numeric (coerce errors, fill 0).
    • Churn: "yes"/"no" → 1/0.

# Validation Split: 
60% train, 20% val, 20% test (sklearn train_test_split, reset_index, separate X/y).

# EDA & Feature Importance:
    • Global churn ~27%.
    • Group churn rates & risk ratio (group mean / global).
    • Mutual info for categoricals (contract highest).
    • Correlation for numericals (tenure strongest negative).

# One-Hot Encoding:
DictVectorizer on dicts of categorical + numerical features.

# Logistic Regression:
    • Sigmoid on linear score → probability [0,1].
    • Train: LogisticRegression().fit(X_train, y_train).
    • Predict: predict_proba for soft probs; threshold 0.5 for hard.
    • Accuracy ~80% on val.

# Interpretation: 
Weights show impact (e.g., month-to-month contract + churn risk; longer tenure - risk). Small model demo confirms.

# Applications: 
Retention campaigns, risk-based marketing, customer lifetime value optimization. Great foundation for real-world binary classifiers.
