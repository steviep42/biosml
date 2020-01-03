library(h2o)
h2o.init()

docker_data_path <- "/Users/esteban/Downloads/pima.csv"
df <- h2o.importFile(docker_data_path)
h2o.describe(df)

y <- "diabetes"
splits <- h2o.splitFrame(df, ratios=0.8,seed=1)
train <- splits[[1]]
test  <- splits[[2]]

summary(df$diabetes,exact_quantiles=TRUE)

aml <- h2o.automl(y = y,
                  training_frame = train,
                  leaderboard_frame = test,
                  max_runtime_secs = 60,
                  seed = 1,
                  project_name = "pima")

#

docker_data_path <- "/Users/esteban/Downloads/mtcars.csv"
mt <- h2o.importFile(docker_data_path)
h2o.describe(mt)

y <- "mpg"

splits <- h2o.splitFrame(mt, ratios=0.8,seed=1)
train <- splits[[1]]
test  <- splits[[2]]

mtm <- h2o.automl(y = y,
                  training_frame = train,
                  leaderboard_frame = test,
                  max_runtime_secs = 60,
                  seed = 1,
                  project_name = "mtcars")

# Convert R object to H2O frame
pima_df <- as.h2o(PimaIndiansDiabetes)

y <- "mpg"
x <- setdiff(colnames(mtcars_df),y)

