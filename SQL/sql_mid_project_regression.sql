/*-----------------------*/
/*     Question 1        */
/*-----------------------*/

# Create a database called house_price_regression.

CREATE DATABASE house_price_regression;

/*-----------------------*/
/*     Question 2        */
/*-----------------------*/

# Create a table house_price_data with the same columns as given in the csv file. Please make sure you use the correct data types for the columns.

USE house_price_regression; 
-- We have used the table data import wizard therefore we didnt need to create the columns manually.
SELECT* FROM house_price_data LIMIT 5;

/*-----------------------*/
/*     Question 3        */
/*-----------------------*/

# Import the data from the csv file into the table. Before you import the data into the empty table, make sure that you have deleted the headers from the csv file. 4
# To not modify the original data, if you want you can create a copy of the csv file as well.Note you might have to use the following queries to give permission to SQL to import data from csv files in bulk:

-- We have skipped the 3rd step as we have imported the data in a different way.

/*-----------------------*/
/*     Question 4        */
/*-----------------------*/

# Select all the data from table house_price_data to check if the data was imported correctly

ALTER TABLE regression_data RENAME house_price_data;
SELECT* FROM house_price_data;

/*-----------------------*/
/*     Question 5        */
/*-----------------------*/

# Use the alter table command to drop the column date from the database, as we would not use it in the analysis with SQL. 
#Select all the data from the table to verify if the command worked. Limit your returned results to 10.

ALTER TABLE house_price_data DROP COLUMN date;
SELECT* FROM house_price_data
LIMIT 10;

/*-----------------------*/
/*     Question 6        */
/*-----------------------*/

# Use sql query to find how many rows of data you have.

SELECT* FROM house_price_data; 
-- We have 21597 rows.

/*-----------------------*/
/*     Question 7        */
/*-----------------------*/

# Now we will try to find the unique values in some of the categorical columns:

	# 7.1 What are the unique values in the column bedrooms?
SELECT DISTINCT bedrooms from house_price_data; 
-- We can see that there are 12 unique values in the 'bedrooms' column. 

	# 7.2 What are the unique values in the column bathrooms?
SELECT DISTINCT bathrooms from house_price_data; 
-- We can see that there are 29 unique values in the 'bathrooms' column.

	# 7.3 What are the unique values in the column floors?
SELECT DISTINCT floors from house_price_data; 
-- We can see that there are 4 unique values in the 'floors' column.

	# 7.4 What are the unique values in the column condition?
SELECT DISTINCT house_price_data.condition from house_price_data; 
-- We can see that there are 5 unique values in the 'condition' column.

    # 7.5 What are the unique values in the column grade?
SELECT DISTINCT grade from house_price_data; 
-- We can see that there are 11 unique values in the 'grade' column.

/*-----------------------*/
/*     Question 8        */
/*-----------------------*/

# Arrange the data in a decreasing order by the price of the house. Return only the IDs of the top 10 most expensive houses in your data.

SELECT id,price FROM house_price_data ORDER BY price DESC LIMIT 10;

/*-----------------------*/
/*     Question 9        */
/*-----------------------*/
# What is the average price of all the properties in your data?

SELECT ROUND(AVG(price),2) from house_price_data;

/*-----------------------*/
/*     Question 10       */
/*-----------------------*/
# In this exercise we will use simple group by to check the properties of some of the categorical variables in our data:
	
	# 10.1 What is the average price of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the prices. 
    # Use an alias to change the name of the second column.
SELECT bedrooms, ROUND(AVG(price),2) as Average_Price FROM house_price_data GROUP BY bedrooms;

	# 10.2 What is the average sqft_living of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the sqft_living. 
    # Use an alias to change the name of the second column.
SELECT bedrooms , AVG(sqft_living) as Average_Living_Space_SQF FROM house_price_data GROUP BY bedrooms;

	# 10.3 What is the average price of the houses with a waterfront and without a waterfront? 
    #The returned result should have only two columns, waterfront and Average of the prices. Use an alias to change the name of the second column.
SELECT waterfront, ROUND(AVG(price),2) as Average_Price FROM house_price_data GROUP BY waterfront;

	# 10.4 Is there any correlation between the columns condition and grade? You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. 
    # Visually check if there is a positive correlation or negative correlation or no correlation between the variables.
SELECT DISTINCT house_price_data.condition, ROUND(AVG(grade),2) AS Average_Grade FROM house_price_data GROUP BY house_price_data.condition ORDER BY house_price_data.condition ASC; 
-- We can see that there is a non-linear correlation between 'grade' and 'condition'.

/*-----------------------*/
/*     Question 11       */
/*-----------------------*/

# One of the customers is only interested in the following houses:
	# Number of bedrooms either 3 or 4
	# Bathrooms more than 3
	# One Floor
	# No waterfront
	# Condition should be 3 at least
	# Grade should be 5 at least
	# Price less than 300000
	# For the rest of the things, they are not too concerned. Write a simple query to find what are the options available for them?

SELECT* FROM house_price_data
WHERE bedrooms= 3 or bedrooms=4 AND floors=1 AND waterfront=0 AND house_price_data.condition >= 3 AND grade >= 5 AND price < 300000
ORDER BY price DESC; 

/*-----------------------*/
/*     Question 12       */
/*-----------------------*/

# Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties in the database.
# Write a query to show them the list of such properties.You might need to use a sub query for this problem.

SELECT* FROM house_price_data WHERE price > (SELECT 2*ROUND(AVG(price),2) FROM house_price_data) ORDER BY price DESC;

/*-----------------------*/
/*     Question 13       */
/*-----------------------*/

# Since this is something that the senior management is regularly interested in, create a view of the same query.

CREATE VIEW price_twice_above_average AS
SELECT* FROM house_price_data WHERE price > (SELECT 2*ROUND(AVG(price),2) FROM house_price_data) ORDER BY price DESC;

/*-----------------------*/
/*     Question 14       */
/*-----------------------*/

# Most customers are interested in properties with three or four bedrooms. What is the difference in average prices of the properties with three and four bedrooms?

SELECT bedrooms , ROUND(AVG(price),2) AS Average_Price FROM house_price_data
WHERE bedrooms=3 or bedrooms=4
GROUP BY bedrooms;

SELECT (SELECT ROUND(AVG(price),2) AS average FROM house_price_data WHERE bedrooms=4) as four_bedroom_average,
(SELECT ROUND(AVG(price),2) AS average FROM house_price_data WHERE bedrooms=3) as three_bedroom_average,
((SELECT ROUND(AVG(price),2) AS average FROM house_price_data WHERE bedrooms=4) - (SELECT ROUND(AVG(price),2) AS average FROM house_price_data WHERE bedrooms=3)) as difference
FROM house_price_data GROUP BY four_bedroom_average,three_bedroom_average,difference;

/*-----------------------*/
/*     Question 15       */
/*-----------------------*/

# What are the different locations where properties are available in your database? (distinct zip codes)

SELECT DISTINCT zipcode FROM house_price_data;

/*-----------------------*/
/*     Question 16       */
/*-----------------------*/

# Show the list of all the properties that were renovated.

SELECT* FROM house_price_data WHERE yr_renovated != 0;

/*-----------------------*/
/*     Question 17       */
/*-----------------------*/

# Provide the details of the property that is the 11th most expensive property in your database.

SELECT* FROM house_price_data ORDER BY price DESC LIMIT 10,1;
