-- Databricks notebook source
select guardian, count(*) as amount from students_csv group by guardian;

-- COMMAND ----------

select guardian, studytime from students_csv;

-- COMMAND ----------

select guardian, count(failures) as failures from students_csv group by guardian;

-- COMMAND ----------

select sex, age, count(failures) as failures from students_csv group by sex, age;

-- COMMAND ----------

select Mjob, Fjob, count(absences) as absences from students_csv group by Mjob, Fjob;

-- COMMAND ----------

select sum(failures) as failures, activities from students_csv group by activities;

-- COMMAND ----------

select sex, avg(age) as average_age from students_csv group by sex;

-- COMMAND ----------

select internet, avg(G3) as final_grade from students_csv group by internet;
