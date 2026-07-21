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

-- Note: LEFT JOIN keeps all rows from left table (like left merge in pandas). 
-- Useful when data is incomplete (common in real ML datasets).
-- Parameters: LEFT JOIN (logical join), RIGHT JOIN (reversed), FULL JOIN (exact format)
-- NULLS constraints
-- Exercise focuses on DISTINCT with JOINs

--SELECT column, another_column, …
-- FROM mytable
-- INNER/LEFT/RIGHT/FULL JOIN another_table 
--    ON mytable.id = another_table.matching_id
-- WHERE condition(s)
-- ORDER BY column, … ASC/DESC
-- LIMIT num_limit OFFSET num_offset;
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




