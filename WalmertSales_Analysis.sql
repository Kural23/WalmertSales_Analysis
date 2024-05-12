 -- KURALOVIYA K ( WALMERT SALES ANALYSIS )
 SELECT * FROM walmertsales.salesdata;
 
 DESCRIBE TABLE walmertsales.salesdata;
 -- Total sales count 
 SELECT count(Invoice_ID) as Overall_Sales_Count FROM walmertsales.salesdata;
 
 -- How many  MALE & FEMALE does the data have?
 SELECT distinct Gender , count(Gender) as Sales_Count FROM walmertsales.salesdata group by Gender;
 
 -- How many unique cities does the data have?
SELECT  DISTINCT city FROM walmertsales.salesdata;

 -- How many unique cities & Branch does the data have?
SELECT  DISTINCT city , Branch FROM walmertsales.salesdata;

-- How many unique product lines does the data have?
SELECT DISTINCT product_line FROM walmertsales.salesdata;

-- What is the most selling product line
SELECT SUM(quantity) as quantity, product_line
FROM walmertsales.salesdata
GROUP BY product_line
ORDER BY quantity DESC;

-- Add the time_of_day column

ALTER TABLE walmertsales.salesdata ADD COLUMN time_of_day VARCHAR(20);

UPDATE walmertsales.salesdata
SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);
SELECT time_of_day from walmertsales.salesdata;
-- SELECT Date, year(Date) as year from walmertsales.salesdata;

-- What product line had the largest revenue?
SELECT
	product_line,
	SUM(total) as total_revenue
FROM walmertsales.salesdata
GROUP BY product_line
ORDER BY total_revenue DESC;

-- What is the city with the largest revenue?
SELECT branch,city,SUM(total) AS total_revenue
FROM walmertsales.salesdata
GROUP BY city, branch 
ORDER BY total_revenue;

SELECT 
	AVG(quantity) AS avg_qnty
FROM walmertsales.salesdata;

SELECT product_line,
	CASE
		WHEN AVG(quantity) > 6 THEN "Good"
        ELSE "Bad"
    END AS remark
FROM walmertsales.salesdata
GROUP BY product_line;

-- Which branch sold more products than average product sold?
SELECT 
	branch, 
    SUM(quantity) AS quantity
FROM walmertsales.salesdata
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM walmertsales.salesdata);

-- What is the most common product line by gender
SELECT
	gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM walmertsales.salesdata
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

-- What is the average rating of each product line
SELECT
	ROUND(AVG(rating), 2) as avg_rating,
    product_line
FROM walmertsales.salesdata
GROUP BY product_line
ORDER BY avg_rating DESC;

-- How many unique customer types does the data have?
SELECT
	DISTINCT customer_type
FROM walmertsales.salesdata;

-- How many unique payment methods does the data have?
SELECT
	DISTINCT payment
FROM walmertsales.salesdata;


-- What is the most common customer type?
SELECT
	customer_type,
	count(*) as count
FROM walmertsales.salesdata
GROUP BY customer_type
ORDER BY count DESC;

-- Which customer type buys the most?
SELECT
	customer_type,
    COUNT(*)
FROM walmertsales.salesdata
GROUP BY customer_type;


-- What is the gender of most of the customers?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM walmertsales.salesdata
GROUP BY gender
ORDER BY gender_cnt DESC;

-- What is the gender distribution per branch?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM walmertsales.salesdata
WHERE branch = "C"
GROUP BY gender
ORDER BY gender_cnt DESC;

-- Which of the customer types brings the most revenue? **
SELECT
	customer_type,
	SUM(total) AS total_revenue
FROM walmertsales.salesdata
GROUP BY customer_type
ORDER BY total_revenue;