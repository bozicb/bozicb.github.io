// Databricks notebook source
val data = Array(2,4,6,8,10,12,14,15,13,11,9,7,5,3,1,22)
val distData = sc.parallelize(data)

// COMMAND ----------

val add1 = distData.map(x => x+1)
add1.collect()

// COMMAND ----------

val sub2 = add1.map(x => x-2)
sub2.collect()

// COMMAND ----------

val sum = sub2.reduce(_+_)

// COMMAND ----------

val sumGt10 = sub2.filter(_>=10).reduce(_+_)

// COMMAND ----------

val a1 = Array("Spark", "Apache", "Stream", "Batch", "Programming", "Spark", "Apache")
val a2 = Array("Bread", "Batch", "Sodastream", "Bread", "Bread", "Butter")
val rdd1 = sc.parallelize(a1)
val rdd2 = sc.parallelize(a2)

// COMMAND ----------

var distinct1 = rdd1.subtract(rdd2)
var distinct2 = rdd2.subtract(rdd1)
var distinct = distinct1.union(distinct2)
distinct.collect()

// COMMAND ----------

var common = rdd1.intersection(rdd2)
common.collect()

// COMMAND ----------

var absent = rdd1.subtract(rdd2)
absent.collect()

// COMMAND ----------

var kvrdd = sc.parallelize(Seq(("john", 20), ("joe", 22), ("tom", 77), ("bob", 90), ("bill", 99), ("Ador", 98), ("john", 22), ("joe", 1), ("tom",2)))

// COMMAND ----------

kvrdd.map(_._2+10).collect()

// COMMAND ----------

kvrdd.keys.collect()

// COMMAND ----------

kvrdd.values.collect()

// COMMAND ----------

kvrdd.values.reduce(_+_)

// COMMAND ----------

kvrdd.sortByKey().collect()

// COMMAND ----------

var rdd1 = sc.parallelize(Array(("joe", 22), ("tom", 77), ("bob", 910), ("bill", 99), ("Ador", 981), ("john", 22), ("joe", 1), ("tom",2)))
var rdd2 = sc.parallelize(Array(("john", 20), ("joe", 122), ("bob", 77), ("bob", 920), ("bill", 99), ("john", 212), ("joe", 1), ("Ador",1)))

// COMMAND ----------

rdd1 = rdd1.reduceByKey((x,y)=>x+y)
var line1 = rdd1.collect()
rdd2 = rdd2.reduceByKey((x,y)=>x+y)
var line2 = rdd2.collect()
print(line1)
print(line2)

// COMMAND ----------

sc.union(rdd1,rdd2).reduceByKey((x,y)=>x+y).collect()
