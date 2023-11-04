-- LAB "SQL Data transformation and aggregation"

-- CHALLENGE 1

-- Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT max(length) FROM sakila.film as max_duration;
SELECT min(length) FROM sakila.film as min_duration;

-- Express the average movie duration in hours and minutes. Don't use decimals. Hint: look for floor and round functions.
SELECT round(AVG(length),0) FROM sakila.film;

-- Calculate the number of days that the company has been operating. 
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT DATEDIFF(max(rental_date),min(rental_date)) FROM sakila.rental;

-- Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *,month(rental_date) as month,year(rental_date) as year FROM sakila.rental;

-- Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week. 
-- Hint: use a conditional expression.
SELECT *, IF(DAYOFWEEK(rental_date)<=5,"workday","weekend") AS day_type FROM sakila.rental;

-- We need to ensure that our customers can easily access information about our movie collection. 
-- To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results by the film title in ascending order. Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future. 
-- Hint: look for the IFNULL() function.
SELECT title, IFNULL(rental_duration,"not available") AS rental_duration FROM sakila.film ORDER BY title ASC;

-- As a marketing team for a movie rental company, we need to create a personalized email campaign for our customers. 
-- To achieve this, we want to retrieve the concatenated first and last names of our customers, along with the first 3 characters of their email address, so that we can address them by their first name and use their email address to send personalized recommendations. 
-- The results should be ordered by last name in ascending order to make it easier for us to use the data.
SELECT CONCAT(first_name," ",last_name," ",LEFT(email,3)) AS mail_list FROM sakila.customer;


-- CHALLENGE 2

-- We need to analyze the films in our collection to gain insights into our business operations. 
-- Using the film table:
-- 1.1 determine the total number of films that have been released.
   SELECT COUNT(*) FROM sakila.film;

-- 1.2 The number of films for each rating.
SELECT rating, COUNT(*) AS film_count FROM sakila.film
GROUP BY rating;


-- 1.3 Determine the number of films for each rating, and sort the results in descending order of the number of films. 
SELECT rating, COUNT(*) AS film_count FROM sakila.film
GROUP BY rating
ORDER BY film_count DESC;

-- 2. We need to track the performance of our employees. 
-- Using the rental table, determine the number of rentals processed by each employee. 
SELECT staff_id, COUNT(*) FROM sakila.rental
GROUP BY staff_id;

-- 3. Using the film table, determine:
-- 3.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. 
SELECT rating, ROUND(AVG(length), 2) AS mean_duration FROM sakila.film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 3.2 Identify which ratings have a mean duration of over two hours, to help us select films for customers who prefer longer movies.
SELECT rating, ROUND(AVG(length), 2) AS mean_duration FROM sakila.film
GROUP BY rating
HAVING mean_duration > 120;

-- Determine which last names are not repeated in the table actor.
SELECT last_name FROM sakila.actor
GROUP BY last_name
HAVING COUNT(*) = 1;