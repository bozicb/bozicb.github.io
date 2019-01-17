// Databricks notebook source
val data = 1 to 50
val sparkSample = sc.parallelize(data)
sparkSample.filter(_<10).collect()

// COMMAND ----------

val lines = sc.textFile("/FileStore/tables/BramStokersDracula.txt")
lines.cache
val linesLengths = lines.map(s=>s.length)
val totalLength = linesLengths.reduce((a,b)=>a+b)

// COMMAND ----------

val tokenized = lines.flatMap(_.split(" "))
val wordCounts = tokenized.map((_, 1)).reduceByKey(_ + _)
val filtered = wordCounts.filter(_._2 >= 150)
filtered.takeOrdered(10)(Ordering[Int].reverse.on(x=>x._2))

// COMMAND ----------

val stopWords = sc.textFile("/FileStore/tables/stopwords_en.txt")
val cleaned = tokenized.subtract(stopWords)
val cleanedWordCounts = cleaned.map((_, 1)).reduceByKey(_ + _)
val cleanedFiltered = cleanedWordCounts.filter(_._2 >= 150)
cleanedFiltered.takeOrdered(10)(Ordering[Int].reverse.on(x=>x._2))

// COMMAND ----------

cleanedFiltered.takeOrdered(10)(Ordering[Int].on(x=>x._2))

// COMMAND ----------

val dfr = sqlContext.read.format("com.databricks.spark.csv").option("header", "true")
val df = dfr.load("/FileStore/tables/auctions.csv")

// COMMAND ----------

df.filter(df("bidderrate") > 21).show()

// COMMAND ----------

df.select("bidder").distinct.count

// COMMAND ----------

df.createOrReplaceTempView("df")
sqlContext.sql("select * from df").collect.foreach(println)

// COMMAND ----------

sqlContext.sql("select bidder, count(*) as cnt from df group by bidder order by cnt desc limit 2").collect().foreach(println)

// COMMAND ----------


