BEGIN;

--Deleting duplicate rows from table Keywords
create table C_Keywords(
   id int,
   keywords text
);

INSERT INTO C_Keywords(id)
(SELECT DISTINCT id 
FROM Keywords);

UPDATE C_Keywords
   SET keywords=(SELECT keywords 
				FROM Keywords
				WHERE C_Keywords.id=Keywords.id
				LIMIT 1);

DROP TABLE Keywords;

ALTER TABLE C_Keywords
RENAME TO Keywords;

--Deleting duplicate rows from table Credits
create table C_Credits(
   movie_cast text,
   crew text,
   id int
);

INSERT INTO C_Credits(id)
(SELECT DISTINCT id 
FROM Credits);

UPDATE C_Credits
    SET movie_cast=(SELECT movie_cast 
				FROM Credits 
				WHERE C_Credits.id=Credits.id
				LIMIT 1);
UPDATE C_Credits	
	SET crew=(SELECT crew 
				FROM Credits 
				WHERE C_Credits.id=Credits.id
				LIMIT 1);

DROP TABLE Credits;

ALTER TABLE C_Credits
RENAME TO Credits;

--Deleting duplicate rows from table Links
create table C_Links(
   movieId int,
   imdbId int,
   tmdbId int
);

INSERT INTO C_Links(movieId)
(SELECT DISTINCT movieId 
FROM Links);

UPDATE C_Links
    SET imdbId=(SELECT imdbId 
				FROM Links 
				WHERE C_Links.movieId=Links.movieId
				LIMIT 1);
UPDATE C_Links
	SET tmdbId=(SELECT tmdbId 
				FROM Links 
				WHERE C_Links.movieId=Links.movieId
				LIMIT 1);
				
DROP TABLE Links;

ALTER TABLE C_Links
RENAME TO Links;

--Deleting duplicate rows from table Movies_Metadata
create table C_Movies_Metadata(
   adult boolean,
   belongs_to_collection text,
   budget int,
   genres text,
   homepage varchar(250),
   id int,
   imdb_id varchar(10),
   original_language varchar(10),
   original_title varchar(110),
   overview varchar(1000),
   popularity float,
   poster_path varchar(40),
   production_companies text,
   production_countries text,
   release_date date,
   revenue bigint,
   runtime float,
   spoken_languages text,
   status varchar(20),
   tagline varchar(300),
   title varchar(110),
   video boolean,
   vote_average float,
   vote_count int
);

INSERT INTO C_Movies_Metadata(id)
(SELECT DISTINCT id 
FROM Movies_Metadata);

UPDATE C_Movies_Metadata
    SET adult=(SELECT adult 
				FROM Movies_Metadata 
				WHERE C_Movies_Metadata.id=Movies_Metadata.id
				LIMIT 1);
UPDATE C_Movies_Metadata
	SET belongs_to_collection=(SELECT belongs_to_collection 
				FROM Movies_Metadata 
				WHERE C_Movies_Metadata.id=Movies_Metadata.id
				LIMIT 1);
UPDATE C_Movies_Metadata
	SET budget=(SELECT budget 
				FROM Movies_Metadata 
				WHERE C_Movies_Metadata.id=Movies_Metadata.id
				LIMIT 1);
UPDATE C_Movies_Metadata
	SET genres=(SELECT genres 
				FROM Movies_Metadata 
				WHERE C_Movies_Metadata.id=Movies_Metadata.id
				LIMIT 1);
UPDATE C_Movies_Metadata
	SET homepage=(SELECT homepage 
				FROM Movies_Metadata 
				WHERE C_Movies_Metadata.id=Movies_Metadata.id
				LIMIT 1);
UPDATE C_Movies_Metadata
	SET imdb_id=(SELECT imdb_id 
				FROM Movies_Metadata 
				WHERE C_Movies_Metadata.id=Movies_Metadata.id
				LIMIT 1);
UPDATE C_Movies_Metadata
	SET original_language=(SELECT original_language 
				FROM Movies_Metadata 
				WHERE C_Movies_Metadata.id=Movies_Metadata.id
				LIMIT 1);
UPDATE C_Movies_Metadata
	SET original_title=(SELECT original_title 
				FROM Movies_Metadata 
				WHERE C_Movies_Metadata.id=Movies_Metadata.id
				LIMIT 1);
UPDATE C_Movies_Metadata
	SET overview=(SELECT overview 
				FROM Movies_Metadata 
				WHERE C_Movies_Metadata.id=Movies_Metadata.id
				LIMIT 1);
UPDATE C_Movies_Metadata
	SET popularity=(SELECT popularity 
				FROM Movies_Metadata 
				WHERE C_Movies_Metadata.id=Movies_Metadata.id
				LIMIT 1);
UPDATE C_Movies_Metadata
	SET poster_path=(SELECT poster_path 
				FROM Movies_Metadata 
				WHERE C_Movies_Metadata.id=Movies_Metadata.id
				LIMIT 1);
UPDATE C_Movies_Metadata
	SET production_companies=(SELECT production_companies 
				FROM Movies_Metadata 
				WHERE C_Movies_Metadata.id=Movies_Metadata.id
				LIMIT 1);
UPDATE C_Movies_Metadata
	SET production_countries=(SELECT production_countries 
				FROM Movies_Metadata 
				WHERE C_Movies_Metadata.id=Movies_Metadata.id
				LIMIT 1);
UPDATE C_Movies_Metadata
	SET release_date=(SELECT release_date 
				FROM Movies_Metadata 
				WHERE C_Movies_Metadata.id=Movies_Metadata.id
				LIMIT 1);
UPDATE C_Movies_Metadata
	SET revenue=(SELECT revenue 
				FROM Movies_Metadata 
				WHERE C_Movies_Metadata.id=Movies_Metadata.id
				LIMIT 1);
UPDATE C_Movies_Metadata
	SET runtime=(SELECT	runtime 
				FROM Movies_Metadata 
				WHERE C_Movies_Metadata.id=Movies_Metadata.id
				LIMIT 1);
UPDATE C_Movies_Metadata
	SET spoken_languages=(SELECT spoken_languages 
				FROM Movies_Metadata 
				WHERE C_Movies_Metadata.id=Movies_Metadata.id
				LIMIT 1);
UPDATE C_Movies_Metadata
	SET status=(SELECT status 
				FROM Movies_Metadata 
				WHERE C_Movies_Metadata.id=Movies_Metadata.id
				LIMIT 1);
UPDATE C_Movies_Metadata
	SET tagline=(SELECT tagline 
				FROM Movies_Metadata 
				WHERE C_Movies_Metadata.id=Movies_Metadata.id
				LIMIT 1);
UPDATE C_Movies_Metadata
	SET title=(SELECT title 
				FROM Movies_Metadata 
				WHERE C_Movies_Metadata.id=Movies_Metadata.id
				LIMIT 1);
UPDATE C_Movies_Metadata
	SET video=(SELECT video 
				FROM Movies_Metadata 
				WHERE C_Movies_Metadata.id=Movies_Metadata.id
				LIMIT 1);
UPDATE C_Movies_Metadata
	SET vote_average=(SELECT vote_average 
				FROM Movies_Metadata 
				WHERE C_Movies_Metadata.id=Movies_Metadata.id
				LIMIT 1);
UPDATE C_Movies_Metadata
	SET vote_count=(SELECT vote_count 
				FROM Movies_Metadata 
				WHERE C_Movies_Metadata.id=Movies_Metadata.id
				LIMIT 1);

DROP TABLE Movies_Metadata;

ALTER TABLE C_Movies_Metadata
RENAME TO Movies_Metadata;

-- Deleting movies from Keywords that are not in Movies_Metadata
CREATE TABLE Keywords2 AS
(SELECT Keywords.* 
FROM Keywords
INNER JOIN Movies_Metadata
ON Keywords.id=Movies_Metadata.id);

DROP TABLE Keywords;

ALTER TABLE Keywords2
RENAME TO Keywords;

-- Deleting movies from Credits that are not in Movies_Metadata
CREATE TABLE Credits2 AS
(SELECT Credits.* 
FROM Credits
INNER JOIN Movies_Metadata
ON Credits.id=Movies_Metadata.id);

DROP TABLE Credits;

ALTER TABLE Credits2
RENAME TO Credits;

-- Deleting movies from Links that are not in Movies_Metadata
CREATE TABLE Links2 AS
(SELECT Links.* 
FROM Links
INNER JOIN Movies_Metadata
ON Links.tmdbId=Movies_Metadata.id);

DROP TABLE Links;

ALTER TABLE Links2
RENAME TO Links;

-- Deleting movies from Ratings_Small that are not in Movies_Metadata
CREATE TABLE Ratings_Small2 AS
(SELECT Ratings_Small.* 
FROM Ratings_Small
INNER JOIN Links
ON Ratings_Small.movieId=Links.movieId);

DROP TABLE Ratings_Small;

ALTER TABLE Ratings_Small2
RENAME TO Ratings_Small;

-- Adding primary keys to all tables
ALTER TABLE Keywords
ADD PRIMARY KEY (id);

ALTER TABLE Links
ADD PRIMARY KEY (movieId);

ALTER TABLE Credits
ADD PRIMARY KEY (id);

ALTER TABLE Ratings_Small
ADD PRIMARY KEY (userId, movieId);

ALTER TABLE Movies_Metadata
ADD PRIMARY KEY (id);

-- Adding foreign keys to all tables
ALTER TABLE Credits 
ADD FOREIGN KEY (id) REFERENCES Movies_Metadata(id);

ALTER TABLE Keywords
ADD FOREIGN KEY (id) REFERENCES Movies_Metadata(id);

ALTER TABLE Links
ADD FOREIGN KEY (tmdbId) REFERENCES Movies_Metadata(id);

ALTER TABLE Ratings_Small
ADD FOREIGN KEY (movieId) REFERENCES Links(movieId);

COMMIT;