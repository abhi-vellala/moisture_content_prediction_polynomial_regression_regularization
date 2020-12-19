# Moisture Content Prediction Polynomial Regression and Regularization(LASSO and Ridge)


*This is a part of LiU's Machine Learning(732A99) curriculum (Lab1 Block1, Assignment 4)*

Problem Statements are as follows:

The Excel file tecator.xlsx contains the results of study aimed to investigate whether a
near infrared absorbance spectrum can be used to predict the fat content of samples of
meat. For each meat sample the data consists of a 100 channel spectrum of absorbance
records and the levels of moisture (water), fat and protein. The absorbance is -log10 of
the transmittance measured by the spectrometer. The moisture, fat and protein are
determined by analytic chemistry.

1. Import data to R and create a plot of Moisture versus Protein. Do you think
that these data are described well by a linear model?

2. Consider model 𝑀𝑀𝑖𝑖 in which Moisture is normally distributed, and the
expected Moisture is a polynomial function of Protein including the
polynomial terms up to power 𝑖𝑖 (i.e M1 is a linear model, M2 is a quadratic
model and so on). Report a probabilistic model that describes 𝑀𝑀𝑖𝑖. Why is it
appropriate to use MSE criterion when fitting this model to a training data?

3. Divide the data into training and validation sets( 50%/50%) and fit models
𝑀𝑖, 𝑖 = 1, … ,6. For each model, record the training and the validation MSE and
present a plot showing how training and validation MSE depend on i (write
some R code to make this plot). Which model is best according to the plot?
How do the MSE values change and why? Interpret this picture in terms of
bias-variance tradeoff.

Use the entire data set in the following computations:

4. Perform variable selection of a linear model in which Fat is response and
Channel1-Channel100 are predictors by using stepAIC. Comment on how
many variables were selected.

5. Fit a Ridge regression model with the same predictor and response variables.
Present a plot showing how model coefficients depend on the log of the
penalty factor 𝜆 and report how the coefficients change with 𝜆.

6. Repeat step 5 but fit LASSO instead of the Ridge regression and compare the
plots from steps 5 and 6. Conclusions?

7. Use cross-validation to find the optimal LASSO model (make sure that case
𝜆 = 0 is also considered by the procedure) , report the optimal 𝜆 and how
many variables were chosen by the model and make conclusions. Present
also a plot showing the dependence of the CV score and comment how the CV
score changes with 𝜆.

8. Compare the results from steps 4 and 7.

