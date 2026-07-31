-- =============================================
-- Intermediate SQL Topics (Overview)
-- =============================================

-- Note: These topics cover more advanced SELECT techniques.
-- Help answer questions outside basic JOINs and aggregates alone.
-- Main topics:
-- 1. Subqueries
-- 2. Unions, Intersections & Exceptions (Set Operations)




-- =============================================
-- SQL Intermediate Topic 1: Subqueries
-- =============================================

-- Note: A subquery is a query nested inside another query.
-- It can appear in WHERE, FROM, SELECT, or HAVING.
--
-- Types:
-- 1. Simple (non-correlated) subquery – runs once
-- 2. Correlated subquery – runs once per outer row
--
-- Common uses:
-- - Compare against an aggregate (AVG, MAX, etc.)
-- - Test existence with IN / NOT IN / EXISTS
--
-- Syntax examples:
-- WHERE column > (SELECT AVG(column) FROM table)
-- WHERE column IN (SELECT id FROM other_table)
-- =============================================
-- Practice Exercises – Subqueries
-- (Using the familiar movies + boxoffice tables)

-- 1. Find all movies with a rating higher than the average rating
SELECT title, rating
FROM movies
INNER JOIN boxoffice ON movies.id = boxoffice.movie_id
WHERE rating > (SELECT AVG(rating) FROM boxoffice);

-- 2. Find movies that have higher domestic sales than the average domestic sales
SELECT title, domestic_sales
FROM movies
INNER JOIN boxoffice ON movies.id = boxoffice.movie_id
WHERE domestic_sales > (SELECT AVG(domestic_sales) FROM boxoffice);

-- 3. List directors who have directed more than one movie
SELECT DISTINCT director
FROM movies
WHERE director IN (
    SELECT director
    FROM movies
    GROUP BY director
    HAVING COUNT(*) > 1
);




-- =============================================
-- SQL Intermediate Topic 2: Unions, Intersections & Exceptions
-- =============================================

-- Note: Set operations combine results from two SELECT queries.
-- Both queries must have the same number of columns and compatible data types.
--
-- Operators:
-- UNION        → combine results and remove duplicates
-- UNION ALL    → combine results and keep duplicates
-- INTERSECT    → only rows that appear in both results
-- EXCEPT       → rows in the first result that are not in the second
--
-- Syntax:
-- SELECT ... FROM table1
-- UNION / UNION ALL / INTERSECT / EXCEPT
-- SELECT ... FROM table2;

-- Note: CAST() converts a value from one data type to another.
-- =============================================
-- Practice Exercises – Set Operations
-- (Conceptual – using movies table)

-- 1. List all unique directors and all unique years (as one column of values)
SELECT director AS value FROM movies
UNION
SELECT CAST(year AS TEXT) FROM movies;

-- 2. Find movies that appear in both a "high rating" list and a "high sales" list
--    (Example of INTERSECT thinking)
SELECT title FROM movies
INNER JOIN boxoffice ON movies.id = boxoffice.movie_id
WHERE rating > 8
INTERSECT
SELECT title FROM movies
INNER JOIN boxoffice ON movies.id = boxoffice.movie_id
WHERE domestic_sales > 200000000;

-- 3. Find years that have movies but are not 2010 or later (EXCEPT example)
SELECT DISTINCT year FROM movies
EXCEPT
SELECT DISTINCT year FROM movies WHERE year >= 2010;