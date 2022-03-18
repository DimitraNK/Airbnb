/* Number of movies per year
 Diagram: q1.png 
*/
SELECT EXTRACT(YEAR FROM release_date) AS YEAR, count(*)
FROM Movies_Metadata
GROUP BY YEAR
ORDER BY YEAR ASC;

/* Number of movies per genre
 Diagram: q2.png 
*/
UPDATE Movies_Metadata
SET genres = REPLACE(genres,'[','{');
UPDATE Movies_Metadata
SET genres = REPLACE(genres,']','}');

create table genres1 as 
(SELECT unnest(genres::text[]) AS genre_details, id AS movie
FROM Movies_Metadata);
create table genres2 as 
(SELECT genre_details, movie 
FROM genres1 
WHERE genre_details LIKE '%name%');

UPDATE genres2
SET genre_details = REPLACE(genre_details, E'\'', '');
UPDATE genres2
SET genre_details = REPLACE(genre_details, 'name:', '');

SELECT genre_details, count(*)
FROM genres2
GROUP BY genre_details
ORDER BY genre_details ASC;

/* Number of movies per genre and per year
 Diagram: q3.png 
*/
SELECT genres2.genre_details, EXTRACT(YEAR FROM Movies_Metadata.release_date) AS YEAR, count(*)
FROM genres2, Movies_Metadata
WHERE genres2.movie = Movies_Metadata.id
GROUP BY genre_details, YEAR;

/* Average rating per genre 
 Diagram: q4.png 
*/
SELECT genres2.genre_details, AVG(Ratings_Small.rating)
FROM genres2
INNER JOIN Links
ON genres2.movie=Links.tmdbid
INNER JOIN Ratings_Small
ON Links.movieId=Ratings_Small.movieId
GROUP BY genres2.genre_details;

/* Number of ratings per user 
 Diagram: q5.png 
*/
SELECT userId, count(*)
FROM Ratings_Small
GROUP BY userId
ORDER BY userId ASC;

/* Average rating per user 
 Diagram: q6.png 
*/
SELECT userId, AVG(rating)
FROM Ratings_Small
GROUP BY userId
ORDER BY userId ASC;

/* View table 
 The results we get from this query help us identify which users are active (which users rate a lot of movies) and whether the majority of 
 their ratings are good or bad, therefore whether or not they are mild or harsh critics.
 Diagram: View_table.png 
*/
CREATE VIEW View_Table AS
(SELECT userId, AVG(rating), count(*)
FROM Ratings_Small
GROUP BY userId
ORDER BY userId ASC);
