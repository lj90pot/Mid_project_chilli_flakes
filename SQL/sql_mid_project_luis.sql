#1.Create a database called house_price_regression.

#CREATE DATABASE house_price_regression;

#2.Create a table house_price_data with the same columns as given in the csv file. Please make sure you use the correct data types for the columns.

USE house_price_regression;

DROP TABLE IF EXISTS house_price_data;
CREATE TABLE house_price_data
(
`id`				BIGINT UNIQUE NOT NULL,
`date`				DATE NOT NULL,
`bedrooms`			INT NOT NULL,
`bathrooms`			INT NOT NULL,
`sqft_living`		INT NOT NULL,
`sqft_lot`			INT NOT NULL,
`floors`			FLOAT NOT NULL,
`waterfront`		INT NOT NULL,
`view`				INT NOT NULL,
`condition`			INT NOT NULL,
`grade`				INT NOT NULL,
`sqft_above`		INT NOT NULL,
`sqft_basement`		INT NOT NULL,
`yr_built`			INT NOT NULL,
`yr_renovated`		INT NOT NULL,
`zipcode`			INT NOT NULL,
`lat`				FLOAT NOT NULL,
`long`				FLOAT NOT NULL,
`sqft_living15`		INT NOT NULL,
`sqft_lot15`		INT NOT NULL,
`price`				INT NOT NULL
);

# 4.Select all the data from table house_price_data to check if the data was imported correctly

ALTER TABLE regression_data RENAME house_price_data;
SELECT* FROM house_price_data;

#5. Use the alter table command to drop the column date from the database, as we would not use it in the analysis with SQL. 
#Select all the data from the table to verify if the command worked. Limit your returned results to 10.

ALTER TABLE house_price_data DROP COLUMN date;
SELECT* FROM house_price_data
LIMIT 10;

# 6.Use sql query to find how many rows of data you have.

SELECT* FROM house_price_data; # We have 21597 rows.

# 7. Now we will try to find the unique values in some of the categorical columns:

	# 7.1 What are the unique values in the column bedrooms?
SELECT DISTINCT bedrooms from house_price_data; # We can see that there are 12 unique values in the 'bedrooms' column. 

	# 7.2 What are the unique values in the column bathrooms?
SELECT DISTINCT bathrooms from house_price_data; # We can see that there are 29 unique values in the 'bathrooms' column.

	# 7.3 What are the unique values in the column floors?
SELECT DISTINCT floors from house_price_data; # We can see that there are 4 unique values in the 'floors' column.

	# 7.4 What are the unique values in the column condition?
SELECT DISTINCT house_price_data.condition from house_price_data; # We can see that there are 5 unique values in the 'condition' column.

    # 7.5 What are the unique values in the column grade?
SELECT DISTINCT grade from house_price_data; # We can see that there are 11 unique values in the 'grade' column.

# 8. Arrange the data in a decreasing order by the price of the house. Return only the IDs of the top 10 most expensive houses in your data.

SELECT id,price FROM house_price_data ORDER BY price DESC LIMIT 10;

# 9. What is the average price of all the properties in your data?

SELECT ROUND(AVG(price),2) from house_price_data;

# 10. In this exercise we will use simple group by to check the properties of some of the categorical variables in our data:
	




