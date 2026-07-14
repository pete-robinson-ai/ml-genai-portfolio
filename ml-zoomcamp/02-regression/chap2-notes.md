# 2.1 Car Price Prediction Project
Build model to predict car prices.
Plan: Prepare/EDA data, linear regression, internals, RMSE eval, feature engineering, regularization, usage.

# 2.2 Data Preparation
Pandas: pd.read_csv(), df.head(), df.columns, str.lower(), str.replace(), dtypes, index.

# 2.3 Exploratory Data Analysis
Pandas: unique(), nunique(), isnull().sum().
Seaborn: histplot().
Numpy: log1p().
Fix long-tail: log-transform target.

# 2.4 Validation Framework
Split into train/val/test. Shuffle, create X/y.
Pandas: iloc[], reset_index(), del.
Numpy: arange(), random.shuffle(), seed().

# 2.5 Linear Regression
Fits line to data. Predicts y from X (bias w0 + features*weights). Use untransformed scale.

# 2.6 Linear Regression: Vector Form
Dot product of features (bias=1) and weights. Matrix form for all records.

# 2.7 Training Linear Regression: Normal Equation
Solve weights via Gram matrix (X^T X) for closest solution.