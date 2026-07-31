--=============================================
-- SQLBOLT PRACTICE
--=============================================


=============================================
-- Lesson 0: Introduction
-- ============================================

-- SQL = Structured Query Language 
-- Purpose: query, manipulate, transform data in relational databases.
-- Popular DBs: SQLite, MySQL, Postgres, Oracle, SQL Server.
-- Relational DB: collection of tables 
-- (like Excel: columns = attributes, rows = data)
-- Example: Vehicles table (Id, Make/Model, Wheels, Doors, Type)
-- Goal: Answer real questions from data.

-- Thoughts on SQL legacy quirks:
-- Using function keywords as object names (table names etc.) requires quoting, and is prone to errors.
-- =============================================
-- Lesson 1: SELECT queries
-- =============================================
-- Notes: 
-- Think of it like a Pandas DataFrame in ML Zoomcamp notebooks:
-- Table = DataFrame (e.g. movies table)
-- Row = One record / one example (e.g. one movie: Toy Story)
-- Column = Feature / variable (e.g. title, director, year)
-- Use SELECT to choose which columns (features x) you want to see:
-- SELECT column FROM table; → Pick specific column(s)
-- SELECT * FROM table; → Pick everything
-- ===============================================
-- Exercise 1
-- 1. Find the title of each film
SELECT title FROM movies;

-- 2. Find the director of each film
SELECT director FROM movies;

-- 3. Find the title and director of each film
SELECT title, director FROM movies;

-- 4. Find the title and year of each film
SELECT title, year FROM movies;

-- 5. Find all the information about each film
SELECT * FROM movies;



-- =============================================
-- Lesson 2: Queries with constraints (Pt. 1)
-- =============================================
-- Note: WHERE = filter rows (like pandas df[df['year'] == 2000]). 
-- Constraints help select only the data you need.
-- Operators: arithmetics, (NOT) BETWEEN...AND, (NOT) IN()
-- =============================================
-- Exercise 2
-- 1. Find the movie with a row id of 6
SELECT * FROM movies WHERE id = 6;
-- Note: = for exact match on id (primary key)

-- 2. Find the movies released in the years between 2000 and 2010
SELECT * FROM movies WHERE year BETWEEN 2000 AND 2010;
-- Note: BETWEEN is inclusive (2000 and 2010 included)

-- 3. Find the movies NOT released in the years between 2000 and 2010
SELECT * FROM movies WHERE year NOT BETWEEN 2000 AND 2010;
-- Note: NOT inverts the condition

-- 4. Find the first 5 Pixar movies and their release year
SELECT title, year FROM movies
WHERE id <= 5;
-- Note: id 1-5 are the first 5 movies



-- =============================================
-- Lesson 3: Queries with constraints (Pt. 2)
-- =============================================
-- Note: This lesson focuses on text/string filtering. 
-- LIKE + % = pattern matching (like regex or pandas str.contains)
-- Operators: arithmetic case sensitive comparisons, (NOT) Like (insensitive case), 
-- LIKE  + % or _ (% by characters, _ character limits)
-- Quote all 'str'
-- =============================================
-- Exercise 3
SELECT * FROM movies 
WHERE title LIKE "Toy Story%";
-- Note: % matches anything after "Toy Story"

-- 2. Find all the movies directed by John Lasseter
SELECT * FROM movies 
WHERE director = "John Lasseter";
-- Note: Exact string match (case sensitive)

-- 3. Find all the movies (and director) not directed by John Lasseter
SELECT title, director FROM movies 
WHERE director != "John Lasseter";
-- Note: != or <> for "not equal"

-- 4. Find all the WALL-* movies
SELECT * FROM movies 
WHERE title LIKE "WALL%";
-- Note: % wildcard for anything after WALL



-- =============================================
-- Lesson 4: Filtering and sorting Query results
-- =============================================
-- Note: DISTINCT = unique values (like pandas drop_duplicates). 
-- ORDER BY (ASC/DESC) = sort (like df.sort_values). 
-- LIMIT = take first N rows, OFFSET specify count from.
-- =============================================
-- Exercise 4
-- 1. List all directors of Pixar movies (alphabetically), without duplicates
SELECT DISTINCT director FROM movies 
ORDER BY director ASC;

-- 2. List the last four Pixar movies released (ordered from most recent to least)
SELECT title, year FROM movies 
ORDER BY year DESC 
LIMIT 4;

-- 3. List the first five Pixar movies sorted alphabetically
SELECT title FROM movies 
ORDER BY title ASC 
LIMIT 5;

-- 4. List the five Pixar movies sorted alphabetically
SELECT title FROM movies 
ORDER BY title ASC 
LIMIT 5;



-- =============================================
-- Lesson 5 (Review 1): SQL Review: Simple SELECT Queries
-- =============================================

-- Note: Review of all basic SELECT + WHERE + ORDER BY + LIMIT. 
-- New table: north_american_cities (like a dataset with city data).
-- =============================================
-- Exercise 5 (Review)
-- 1. List all the Canadian cities and their populations
SELECT city, population FROM north_american_cities 
WHERE country = "Canada";

-- 2. Order all the cities in the United States by their latitude from north to south
SELECT city, latitude FROM north_american_cities 
WHERE country = "United States" 
ORDER BY latitude DESC;

-- 3. List all the cities west of Chicago, ordered from west to east
SELECT city, longitude FROM north_american_cities 
WHERE longitude < -87.6298 
ORDER BY longitude ASC;

-- 4. List the two largest cities in Mexico (by population)
SELECT city, population FROM north_american_cities 
WHERE country = "Mexico" 
ORDER BY population DESC 
LIMIT 2;

-- 5. List the third and fourth largest cities (by population) in the United States and their population
SELECT city, population FROM north_american_cities 
WHERE country = "United States" 
ORDER BY population DESC 
LIMIT 2 OFFSET 2;




-- =============================================
-- Lesson 6: Multi-table queries with JOINs
-- =============================================

-- Note: JOIN combines data from multiple tables (like pd.merge in pandas). 
-- Very important for real ML data pipelines where features are split across tables.
-- "FROM movies INNER JOIN 2nd-tabl-name ON tbl-1-name.CommonFeature = tbl-2-name.CommonFeature
-- =============================================
-- Exercise 6
-- 1. Find the domestic and international sales for each movie
SELECT title, domestic_sales, international_sales 
FROM movies 
INNER JOIN boxoffice ON movies.id = boxoffice.movie_id;

-- 2. Show the sales numbers for each movie that did better internationally rather than domestically
SELECT title, domestic_sales, international_sales 
FROM movies 
INNER JOIN boxoffice ON movies.id = boxoffice.movie_id
WHERE international_sales > domestic_sales;

-- 3. List all the movies by their ratings in descending order
SELECT title, rating 
FROM movies 
INNER JOIN boxoffice ON movies.id = boxoffice.movie_id
ORDER BY rating DESC;




-- =============================================
-- Lesson 7: OUTER JOINs
-- =============================================

-- Join Type     | Keeps from Left | Keeps from Right | Non-matches become NULL
-- --------------|-----------------|------------------|-------------------------
-- INNER JOIN ON | ONLY matches    | ONLY matches     | No
-- LEFT JOIN  ON | All             | Matches only     | Yes (right side)
-- RIGHT JOIN ON | Matches only    | All              | Yes (left side)
-- FULL JOIN  ON | All             | All              | Yes (both sides)




-- Note: LEFT JOIN keeps all rows from left table (like left merge in pandas). 
-- Useful when data is incomplete (common in real ML datasets)
-- Use INNER JOIN when only matching rows are wanted
-- Use LEFT JOIN when all rows from the left table must be kept, even if no match exists
-- NULL holds all datatypes/unknown marker



-- NULLS constraints
-- Exercise focuses on DISTINCT with JOINs

--SELECT column, another_column, …
-- FROM mytable
-- INNER/LEFT/RIGHT/FULL JOIN another_table 
--    ON mytable.id = another_table.matching_id
-- WHERE condition(s)
-- ORDER BY column, … ASC/DESC
-- LIMIT num_limit OFFSET num_offset;



-- INNER JOIN SYNTAX:
-- FROM table_a
-- INNER JOIN table_b ON table_a.id = table_b.id


-- LEFT/RIGHT/FULL SYNTAX: 
-- FROM table_a
-- LEFT/RIGHT/FULL JOIN table_b ON table_a.id = table_b.id;
-- =============================================
-- Exercise 7
-- 1. Find the list of all buildings that have employees
SELECT DISTINCT building FROM employees;

-- 2. Find the list of all buildings and their capacity
SELECT building_name, capacity FROM buildings

-- 3. List all buildings and the distinct employee roles in each building (including empty buildings)
SELECT DISTINCT building_name, role 
FROM buildings 
LEFT JOIN employees ON buildings.building_name = employees.building;



-- =============================================
-- Lesson 8: A short note on NULLs
-- =============================================

-- Note: NULL = missing/unknown value (not the same as 0 or empty string).
-- Use IS NULL / IS NOT NULL to check for them (never use = NULL).
-- Common after LEFT JOIN when there is no match.
-- "WHERE column IS/IS NOT NULL"
-- "AND/OR another_condition"
-- =============================================
-- Exercise 8
SELECT name, role 
FROM employees 
WHERE building IS NULL;

-- 2. Find the names of the buildings that hold no employees
SELECT building_name 
FROM buildings 
LEFT JOIN employees ON buildings.building_name = employees.building
WHERE employees.building IS NULL;




-- =============================================
-- Lesson 9: Queries with expressions
-- =============================================

-- Note: Expression = calculation that creates a new value.
-- Syntax example:
-- SELECT column1 + column2 AS new_name
-- FROM table;
--
-- Use math operators (+ - * / %), string functions, etc.
-- AS gives the result a clean name (alias).
-- Useful for creating new features (like in pandas).
--
-- Note: "%" means Modulo - returns the remainder after division.
-- 10 % 2 = 0 (10 ÷ 2 = 5 remainder 0)
-- 11 % 2 = 1 (11 ÷ 2 = 5 remainder 1)
-- =============================================
-- Exercise 9
-- 1. List all movies and their combined sales in millions of dollars
SELECT title, (domestic_sales + international_sales) / 1000000 AS combined_sales_millions
FROM movies
INNER JOIN boxoffice ON movies.id = boxoffice.movie_id;

-- 2. List all movies and their ratings in percent
SELECT title, rating * 10 AS rating_percent
FROM movies
INNER JOIN boxoffice ON movies.id = boxoffice.movie_id;

-- 3. List all movies that were released on even number years
SELECT title, year
FROM movies
WHERE year % 2 = 0;





-- =============================================
-- Lesson 10: Queries with aggregates (Pt. 1)
-- =============================================

-- Note: Aggregate functions summarize many rows into one value.
-- Common functions: COUNT(), SUM(), AVG(), MIN(), MAX()
--
-- Syntax (all rows):
-- SELECT AVG(column) AS avg_value
-- FROM table;
--
-- Syntax (per group):
-- SELECT column, AVG(other_column) AS avg_value
-- FROM table
-- GROUP BY column;

-- COUNT(*) → counts all rows (including rows with NULL values)
-- COUNT(column) → counts only rows where that column is NOT NULL

-- DISTINCT = “give me unique values / unique combinations”
-- GROUP BY = “group the data so I can calculate something per group”
-- =============================================
-- Exercise 10
-- 1. Find the longest time that an employee has been at the studio
SELECT name, MAX(years_employed) AS max_years 
FROM employees;

-- 2. For each role, find the average number of years employed by employees in that role
SELECT role, AVG(years_employed) AS avg_years
FROM employees
GROUP BY role;

-- 3. Find the total number of employee years worked in each building
SELECT building, SUM(years_employed) AS total_years
FROM employees
GROUP BY building;





-- =============================================
-- Lesson 11: Queries with aggregates (Pt. 2)
-- =============================================

-- Note: WHERE filters individual rows first.
-- GROUP BY creates groups.
-- HAVING then filters those groups.

-- Syntax:
-- SELECT column, AGG_FUNC(other_column)
-- FROM table
-- WHERE row_condition
-- GROUP BY column
-- HAVING group_condition;
-- =============================================
-- Exercise 11
-- 1. Find the number of Artists in the studio (without a HAVING clause)
SELECT Count(name) AS num_artists 
FROM employees 
where role = "Artist";

-- 2. Find the number of Employees of each role in the studio
SELECT role, COUNT(*) AS num_employees
FROM employees
GROUP BY role;

-- 3. Find the total number of years employed by all Engineers
SELECT SUM(years_employed) AS total_years
FROM employees
WHERE role = "Engineer";




-- =============================================
-- Lesson 12: Order of execution of a Query
-- =============================================

-- Note: SQL clauses run in a fixed order (not the order they are written).
-- Understanding this order helps write correct queries and debug errors.
--
-- Order of execution:
-- 1. FROM + JOIN
-- 2. WHERE
-- 3. GROUP BY
-- 4. HAVING
-- 5. SELECT
-- 6. DISTINCT
-- 7. ORDER BY
-- 8. LIMIT / OFFSET
--
-- Full SELECT syntax:
-- SELECT DISTINCT column, AGG_FUNC(...)
-- FROM table
-- JOIN other_table ON ...
-- WHERE condition
-- GROUP BY column
-- HAVING group_condition
-- ORDER BY column ASC/DESC
-- LIMIT count OFFSET count;
-- =============================================
-- Exercise 12
-- 1. Find the number of movies each director has directed
SELECT director, COUNT(*) AS num_movies
FROM movies
GROUP BY director;

-- 2. Find the total domestic and international sales that can be attributed to each director
SELECT director, 
SUM(domestic_sales + international_sales) AS total_sales
FROM movies
INNER JOIN boxoffice ON movies.id = boxoffice.movie_id
GROUP BY director;




-- =============================================
-- Lesson 13: Inserting rows
-- =============================================

-- Note: INSERT adds new rows into a table.
-- First column id is an auto-incrementing primary key → database fills it automatically
-- Columns are identified by name, not by number (no column 0 or column 1)



-- Syntax (all columns):
-- INSERT INTO table_name
-- VALUES (NULL, value2, ...);
-- WORKS In PostgreSQL, MySQL, SQLite, SQLBOLT

-- Use this version (preferred):
-- Syntax (specific columns):
-- INSERT INTO table_name (col1, col2, ...)
-- VALUES (value1, value2, ...);
--
-- Multiple rows can be inserted in one statement by listing extra (value...) groups.
-- =============================================
-- Exercise 13
-- 1. Add the studio's new production, Toy Story 4 to the list of movies
INSERT INTO movies (title, director, year, length_minutes)
VALUES ("Toy Story 4", "Josh Cooley", 2019, 100);

-- 2. Toy Story 4 has a rating of 8.7, and made 340 million domestically and 270 million internationally
INSERT INTO boxoffice (movie_id, rating, domestic_sales, international_sales)
VALUES (15, 8.7, 340000000, 270000000);




-- =============================================
-- Lesson 14: Updating rows
-- =============================================

-- Note: UPDATE changes existing data in a table.
-- Always include a WHERE clause (otherwise every row is changed).
--
-- Syntax:
-- UPDATE table_name
-- SET column1 = value1,
--     column2 = value2
-- WHERE condition;
-- =============================================
-- Exercise 14
-- 1. The director for A Bug's Life is incorrect, it was actually directed by John Lasseter
UPDATE movies
SET director = "John Lasseter"
WHERE title = "A Bug's Life";

-- 2. The year that Toy Story 2 was released is incorrect, it was actually released in 1999
UPDATE movies
SET year = 1999
WHERE title = "Toy Story 2";

-- 3. Both the title and director for Toy Story 8 is incorrect!
--    Title should be "Toy Story 3" and directed by Lee Unkrich
UPDATE movies
SET title = "Toy Story 3",
    director = "Lee Unkrich"
WHERE title = "Toy Story 8";



