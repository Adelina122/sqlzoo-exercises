/*
Table:
hadcet(yr, dy, m1, m2, m3, m4, m5, m6, m7, m8, m9, m11, m12)
*/

--#1
/*
The units are 10th of a degree Celcius. The columns are yr and dy for year and day of month. 
The next twelve columns are for January through to December.
Show the average daily temperature for August 10th 1964
*/
SELECT m8/10 AS temp 
FROM hadcet
WHERE yr=1964 AND dy=10

--#2
/*
Charles Dickens is said to be responsible for the tradition of expecting snow at Christmas Daily Telegraph. Show the temperature on Christmas day (25th December) for each year of his childhood. 
He was born in February 1812 - so he was 1 (more or less) in December 1812.
Show the twelve temperatures.
*/
SELECT yr-1811 AS age, m12/10 AS temp
FROM hadcet
WHERE yr BETWEEN 1812 and 1812+11 AND dy=25

--#3
/*
We declare a White Christmas if there was a day with an average temperature below zero between 21st and 25th of December.
For each age 1-12 show which years were a White Christmas. Show 'White Christmas' or 'No snow' for each age.
*/
SELECT yr-1811 as age,
  CASE WHEN MIN(m12/10) < 0 THEN 'White Christmas'
  ELSE 'No Snow' END AS snow
FROM hadcet
WHERE yr BETWEEN 1812 and 1812+11 
  AND dy BETWEEN 21 AND 25
GROUP BY age

--#4
/*
A person's White Christmas Count (wcc) is the number of White Christmases they were exposed to as a child 
(between 3 and 12 inclusive assuming they were born at the beginning of the year and were about 1 year old on their first Christmas).
Charles Dickens's wcc was 8.
List all the years and the wcc for children born in each year of the data set. Only show years where the wcc was at least 7.
*/
SELECT yob, COUNT(snow) AS wcc
FROM 
  (SELECT yob, yr+1-yob as age,
    CASE WHEN MIN(m12/10) < 0 THEN 'White Christmas'
    ELSE NULL END AS snow
  FROM hadcet 
  JOIN (SELECT DISTINCT yr AS yob FROM hadcet) tab2
  WHERE yr BETWEEN yob+2 and yob+11 
    AND dy BETWEEN 21 AND 25
  GROUP BY age, yob) tab1
GROUP BY 1
HAVING wcc >= 7

--#5
/*
Here are the average temperatures for August by decade. You decide.
*/
SELECT ROUND(yr,-1) AS decade, ROUND(AVG(NULLIF(m8,-999))/10,1) AS avg_temp
FROM hadcet
GROUP BY ROUND(yr,-1)

    


