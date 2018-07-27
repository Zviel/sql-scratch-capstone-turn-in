-- The First Query

SELECT *
FROM Survey
LIMIT 10;

-- The Second Query

SELECT Question AS 'Question', COUNT(*) AS 'Responses'
FROM Survey
GROUP BY 1;

-- The Third Query

SELECT * FROM Quiz LIMIT 5;

SELECT * FROM Home_Try_On LIMIT 5;

SELECT * FROM Purchase LIMIT 5;

-- The Fourth Query

SELECT DISTINCT Quiz.User_ID,
Home_Try_On.User_ID IS NOT NULL AS 'Is_Home_Try_On',
Number_of_Pairs, Purchase.User_ID IS NOT NULL AS 'Is_Purchase'
FROM Quiz 
	LEFT JOIN
Home_Try_On ON Quiz.User_ID = Home_Try_On.User_ID
	LEFT JOIN 
Purchase ON Home_Try_On.User_ID = Purchase.User_ID LIMIT 10;

-- Conversions Comparison

WITH Funnels AS (
  
SELECT DISTINCT Quiz.User_ID,
Home_Try_On.User_ID IS NOT NULL AS 'Is_Home_Try_On',
Number_of_Pairs, Purchase.User_ID IS NOT NULL AS 'Is_Purchase'
FROM Quiz 
	LEFT JOIN 
Home_Try_On ON Quiz.User_ID = Home_Try_On.User_ID
	LEFT JOIN
Purchase ON Home_Try_On.User_ID = Purchase.User_ID

)

SELECT COUNT(*) AS 'Users Answering The Quiz',
SUM(Is_Home_Try_On) AS 'Users Trying Pairs',
SUM(Is_Purchase) AS 'Purchasers',
1.0 * SUM(Is_Home_Try_On) / COUNT(User_ID) AS 'Percentage of Users From Quiz To Home Try-On',
1.0 * SUM(Is_Purchase) / SUM(Is_Home_Try_On) AS 'Percentage of Users From Home Try-On To Purchase'
FROM Funnels;

-- Difference In Purchase Rates

SELECT ROUND(1.0 * 
	(SELECT COUNT(*) FROM Funnels WHERE Number_of_Pairs = '3 pairs' AND Is_Purchase = 1) / (SELECT COUNT(*) FROM Funnels WHERE Is_Purchase = 1), 2) AS 'Purchase Rate of Users Who Tried 3 Pairs',
ROUND(1.0 * 
	(SELECT COUNT(*) FROM Funnels WHERE Number_of_Pairs = '5 pairs' AND Is_Purchase = 1) / (SELECT COUNT(*) FROM Funnels WHERE Is_Purchase = 1), 2) AS 'Purchase Rate of Users Who Tried 5 Pairs';

-- Most Common Results of The Style Quiz

SELECT Style, COUNT(*) AS 'Appearances'
FROM Quiz
GROUP BY 1 ORDER BY 2 DESC LIMIT 2;

SELECT Fit, COUNT(*) AS 'Appearances'
FROM Quiz
GROUP BY 1 ORDER BY 2 DESC LIMIT 2;

SELECT Shape, COUNT(*) AS 'Appearances'
FROM Quiz
GROUP BY 1 ORDER BY 2 DESC LIMIT 2;

SELECT Color, COUNT(*) AS 'Appearances'
FROM Quiz
GROUP BY 1 ORDER BY 2 DESC LIMIT 2;

-- Most Common Types of Purchase Made

SELECT Product_ID AS 'Product ID', COUNT(*) AS 'Appearances'
FROM Purchase GROUP BY 1 ORDER BY 2 DESC LIMIT 5;

SELECT DISTINCT Product_ID, Style, Model_Name, Color, Price
FROM Purchase WHERE Product_ID IN (3, 10, 9, 1, 6) ORDER BY 5 DESC;
