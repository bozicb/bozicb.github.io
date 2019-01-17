// Databricks notebook source
val rawData = sc.textFile("/FileStore/tables/u.data")
rawData.first()
val rawRatings = rawData.map(_.split("\t").take(3))
rawRatings.first()

// COMMAND ----------

import org.apache.spark.mllib.recommendation.ALS
import org.apache.spark.mllib.recommendation.Rating

// COMMAND ----------

val ratings = rawRatings.map({case Array(user,movie,rating)=>Rating(user.toInt,
movie.toInt, rating.toDouble)})
ratings.first()

// COMMAND ----------

val model = ALS.train(ratings,50,10,0.01)
model.userFeatures.count

// COMMAND ----------

model.productFeatures.count

// COMMAND ----------

val predictedRating = model.predict(789,123)

// COMMAND ----------

val userId = 789
val K = 10
val topKRecs = model.recommendProducts(userId,K)
println(topKRecs.mkString("\n"))

// COMMAND ----------

val K = 2
(Array(269,286,257,117,268)).foreach(id => {
  val topKRecs = model.recommendProducts(id,K)
  println("\nuser "+id+":\n"+topKRecs.mkString("\n"))
})

// COMMAND ----------

val df = sqlContext.sql("SELECT * from students_csv")
df.first
