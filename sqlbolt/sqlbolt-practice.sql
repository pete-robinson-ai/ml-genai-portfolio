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