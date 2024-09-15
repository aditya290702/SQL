-- Creating Tables

CREATE DATABASE CINEMA;
USE CINEMA;

CREATE TABLE Movie (
    mov_id INT PRIMARY KEY, 
    mov_title VARCHAR(50) NOT NULL, 
    mov_year INT, 
    mov_time INT, 
    mov_lang VARCHAR(25), 
    mov_dt_rel DATE,
    mov_rel_country VARCHAR(40)
);

CREATE TABLE Actor (
    act_id INT PRIMARY KEY,
    act_fname VARCHAR(50) NOT NULL,
    act_lname VARCHAR(50),
    act_gender CHAR(1)
);

CREATE TABLE Director (
    dir_id INT PRIMARY KEY ,
    dir_fname VARCHAR(50) NOT NULL,
    dir_lname VARCHAR(50)
);

CREATE TABLE Movie_Direction (
    dir_id INT,
    mov_id INT (10),
    PRIMARY KEY (dir_id, mov_id)
);

CREATE TABLE Movie_Cast (
    act_id INT,
    mov_id INT(10),
    role VARCHAR(155),
    PRIMARY KEY (act_id, mov_id)
);

CREATE TABLE Reviewer (
    rev_id INT PRIMARY KEY,
    rev_name VARCHAR(255) NOT NULL
);

CREATE TABLE Rating (
    mov_id INT,
    rev_id INT,
    rev_stars FLOAT,
    num_o_ratings INT,
    PRIMARY KEY (mov_id, rev_id)
);

-- Adding Foreign Keys

ALTER TABLE Movie_Direction
ADD FOREIGN KEY(dir_id) REFERENCES Director(dir_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Movie_Direction
ADD FOREIGN KEY(mov_id) REFERENCES Movie(mov_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Movie_Cast
ADD FOREIGN KEY(act_id) REFERENCES Actor(act_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Movie_Cast
ADD FOREIGN KEY(mov_id) REFERENCES Movie(mov_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Rating
ADD FOREIGN KEY(mov_id) REFERENCES Movie(mov_id) ON DELETE CASCADE ON UPDATE CASCADE;

-- Inserting Values

INSERT INTO Movie (mov_id, mov_title, mov_year, mov_time, mov_lang, mov_dt_rel, mov_rel_country) VALUES
(901, 'Vertigo', 1958, 128, 'English', '1958-08-24', 'UK'),
(902, 'The Innocents', 1961, 100, 'English', '1962-02-19', 'SW'),
(908, 'The Usual Suspects', 1995, 106, 'English', '1995-08-25', 'UK'),
(909, 'Chinatown', 1974, 130, 'English', '1974-08-09', 'UK'),
(910, 'Boogie Nights', 1997, 155, 'English', '1998-02-16', 'UK'),
(911, 'Annie Hall', 1977, 93, 'English', '1977-04-20', 'USA'),
(912, 'Princess Mononoke', 1997, 134, 'Japanese', '2001-10-19', 'UK'),
(913, 'The Shawshank Redemption', 1994, 142, 'English', '1995-02-17', 'UK'),
(915, 'Titanic', 1997, 194, 'English', '1998-01-23', 'UK'),
(919, 'The Prestige', 2006, 130, 'English', '2006-11-10', 'UK'),
(921, 'Slumdog Millionaire', 2008, 120, 'English', '2009-01-09', 'UK'),
(922, 'Aliens', 1986, 137, 'English', '1986-08-29', 'UK'),
(923, 'Beyond the Sea', 2004, 118, 'English', '2004-11-26', 'UK'),
(924, 'Avatar', 2009, 162, 'English', '2009-12-17', 'UK'),
(926, 'Seven Samurai', 1954, 207, 'Japanese', '1954-04-26', 'JP'),
(927, 'Spirited Away', 2001, 125, 'Japanese', '2003-09-12', 'UK');

INSERT INTO Actor (act_id, act_fname, act_lname, act_gender) VALUES
(101, 'James', 'Stewart', 'M'),
(102, 'Deborah', 'Kerr', 'F'),
(108, 'Stephen', 'Baldwin', 'M'),
(109, 'Jack', 'Nicholson', 'M'),
(110, 'Mark', 'Wahlberg', 'M'),
(111, 'Woody', 'Allen', 'M'),
(112, 'Claire', 'Danes', 'F'),
(113, 'Tim', 'Robbins', 'M'),
(115, 'Kate', 'Winslet', 'F'),
(117, 'Jon', 'Voight', 'M'),
(118, 'Ewan', 'McGregor', 'M'),
(119, 'Christian', 'Bale', 'M'),
(120, 'Stephen', 'Lang', 'M'),
(121, 'Dev', 'Patel', 'M'),
(122, 'Sigourney', 'Weaver', 'F'),
(123, 'Zoe', 'Saldana', 'F'),
(124, 'Sam', 'Worthington', 'M');

INSERT INTO Director (dir_id, dir_fname, dir_lname) VALUES
(201, 'Alfred', 'Hitchcock'),
(202, 'Jack', 'Clayton'),
(208, 'Bryan', 'Singer'),
(209, 'Roman', 'Polanski'),
(210, 'Paul', 'Thomas Anderson'),
(211, 'Woody', 'Allen'),
(212, 'Hayao', 'Miyazaki'),
(213, 'Frank', 'Darabont'),
(215, 'James', 'Cameron'),
(217, 'John', 'Boorman'),
(218, 'Danny', 'Boyle'),
(219, 'Christopher', 'Nolan'),
(220, 'Richard', 'Kelly'),
(221, 'Kevin', 'Spacey'),
(222, 'Andrei', 'Tarkovsky'),
(223, 'Peter', 'Jackson');

INSERT INTO Movie_Direction (dir_id, mov_id) VALUES
(201, 901),
(202, 902),
(208, 908),
(209, 909),
(210, 910),
(211, 911),
(212, 912),
(213, 913),
(215, 915),
(219, 919),
(218, 921),
(215, 922),
(221, 923);

INSERT INTO Movie_Cast (act_id, mov_id, role) VALUES
(101, 901, 'John Scottie Ferguson'),
(102, 902, 'Miss Giddens'),
(108, 908, 'McManus'),
(110, 910, 'Eddie Adams'),
(111, 911, 'Alvy Singer'),
(112, 912, 'San'),
(113, 913, 'Andy Dufresne'),
(115, 915, 'Rose DeWitt Bukater'),
(121, 921, 'Older Jamal'),
(122, 922, 'Ripley'),
(109, 909, 'J.J. Gittes'),
(119, 919, 'Alfred Borden'),
(124, 924, 'Corporal Jake Sully'),
(123, 924, 'Neytiri'),
(120, 924, 'Miles Quaritch');

INSERT INTO Rating (mov_id, rev_id, rev_stars, num_o_ratings) VALUES
(901, 9001, 8.4, 263575),
(902, 9002, 7.9, 20207),
(924, 9006, 7.3, NULL),
(908, 9007, 8.6, 779489),
(909, 9008, NULL, 227235),
(910, 9009, 3.0, 195961),
(911, 9010, 8.1, 203875),
(915, 9001, 7.7, 830095),
(921, 9018, 8.0, 667758),
(922, 9019, 8.4, 511613),
(923, 9020, 6.7, 13091);

insert into Rating(mov_id, rev_id, rev_stars, num_o_ratings)
values
(901, 9001, 8.4, 263575),
(902, 9002, 7.9, 20207),
(924, 9006, 7.3, NULL),
(908, 9007, 8.6, 779489),
(909, 9008, NULL, 227235),
(910, 9009, 3.0, 195961),
(911, 9010, 8.1, 203875),
(915, 9001, 7.7, 830095),
(921, 9018, 8.0, 667758),
(922, 9019, 8.4, 511613),
(923, 9020, 6.7, 13091);

-- Queries

-- 1) Find movie titles and the movie year where titles begin with T
SELECT mov_title, mov_year
FROM Movie
WHERE mov_title LIKE 'T%';


-- 2) Find all movie details where movie language is not English
SELECT *
FROM Movie
WHERE mov_lang NOT LIKE 'English';


-- 3) Find the oldest movie in the database using limit function
SELECT mov_title
FROM Movie 
ORDER BY mov_year LIMIT 1;


-- 4) Display movie title, year, director’s name, actor’s name of the movie with shortest duration.
SELECT M.mov_title, M.mov_year, D.dir_fname, D.dir_lname, A.act_fname, A.act_lname 
FROM Movie M
JOIN Movie_Direction MD ON MD.mov_id = M.mov_id
JOIN Director D ON D.dir_id = MD.dir_id
JOIN Movie_Cast MC ON MC.mov_id = M.mov_id
JOIN Actor A ON A.act_id = MC.act_id
ORDER BY mov_time LIMIT 1;

-- 5) Find the movies titles and years that received a rating 3 or 4, in the increasing order of movie year.
SELECT M.mov_title, M.mov_year 
FROM Movie M
JOIN Rating R ON R.mov_id = M.mov_id
WHERE R.rev_stars = 3 OR R.rev_stars = 4
ORDER BY M.mov_year;


-- 6) Find the movie titles that did not receive any rating
SELECT M.mov_title
FROM Movie M
LEFT JOIN Rating R ON R.mov_id = M.mov_id
WHERE R.rev_stars IS NULL;


-- 7) Find the movie title, actor’s name of movies that have more than one actor acted in them
SELECT M.mov_title, A.act_fname, A.act_lname
FROM Movie M
JOIN Movie_Cast MC ON MC.mov_id = M.mov_id
JOIN Actor A ON A.act_id = MC.act_id
WHERE M.mov_id IN (SELECT mov_id FROM Movie_Cast GROUP BY mov_id HAVING COUNT(mov_id) > 1);



-- 8) Find the actors whose films have been directed by them. Return the actor’s names, movie title, and role
SELECT M.mov_title, A.act_fname, A.act_lname, MC.role
FROM Movie M
JOIN Movie_Cast MC ON MC.mov_id = M.mov_id
JOIN Actor A ON A.act_id = MC.act_id
JOIN Director D ON D.dir_fname = A.act_fname AND D.dir_lname = A.act_lname;



-- 9) Find the highest-rated movie title, their actors and director’s details.
SELECT M.mov_title, A.act_fname, A.act_lname, D.dir_fname, D.dir_lname, R.rev_stars
FROM Movie M
JOIN Rating R ON R.mov_id = M.mov_id
JOIN Actor A ON A.act_id = M.mov_id
JOIN Director D ON D.dir_id = M.mov_id
ORDER BY R.rev_stars DESC
LIMIT 1;


-- 10) For each country where the movie was released, find the average movie time and the first released movie year.
SELECT AVG(mov_time), MIN(mov_year), mov_rel_country
FROM Movie
GROUP BY mov_rel_country
ORDER BY MIN(mov_year);

-- FEB10

-- 1. write a SQL query to find the actors who played a role in the movie 'Annie Hall'. Return all the fields of actor table.

SELECT Actor.* FROM Actor JOIN Movie_Cast ON Actor.act_id = Movie_Cast.act_id JOIN Movie ON Movie_Cast.mov_id = Movie.mov_id WHERE Movie.mov_title = 'Annie Hall';

-- 2. write a SQL query to find those movies that have been released in countries other  than the United Kingdom. Return movie title, movie year, movie time, and date of release,releasing country.

select mov_title,year(mov_dt_rel),mov_time,date(mov_dt_rel),mov_rel_country from Movie where mov_rel_country!='UK' ;

-- 3. write a SQL query to find those movies directed by the director whose first name is  Woddy and last name is Allen. Return movie title.

SELECT Movie.mov_title FROM Movie JOIN Movie_Direction ON Movie.mov_id = Movie_Direction.mov_id  JOIN Director ON Movie_Direction.dir_id = Director.dir_id WHERE Director.dir_fname = 'Woody';

-- 4. write a SQL query to determine those years in which there was at least one movie that received a rating of at least three stars. Sort the result-set in ascending order by movieyear.Return movie year.

SELECT (mov_dt_rel)year FROM Movie JOIN Rating ON Movie.mov_id = Rating.mov_id WHERE Rating.rev_stars >= 3.0 Order by Rating.rev_stars ASC ;


-- 5. Write a SQL query to find those reviewers who have not given a rating to certain films. Return reviewer name.

SELECT rev_name FROM Reviewer JOIN Rating ON Reviewer.rev_id = Rating.rev_id WHERE Rating.rev_stars IS NULL;

-- 6.write a SQL query to find movies that have been reviewed by a reviewer and received a rating. Sort the result-set in ascending order by reviewer name, movie title, review Stars.Return reviewer name, movie title, review Stars.

SELECT Reviewer.rev_name, Movie.mov_title, Rating.rev_stars FROM Reviewer JOIN Rating ON Reviewer.rev_id = Rating.rev_id JOIN Movie ON Rating.mov_id = Movie.mov_id ORDER BY Reviewer.rev_name, Movie.mov_title, Rating.rev_stars ASC;


-- 7.write a SQL query to find those movies, which have received highest number of stars. Group the result set on movie title and sorts the result-set in ascending order

SELECT Movie.mov_title, MAX(Rating.rev_stars) FROM Movie JOIN Rating ON Movie.mov_id = Rating.mov_id GROUP BY Movie.mov_title ORDER BY MAX(Rating.rev_stars) DESC, Movie.mov_title ASC;


-- 8.write a SQL query to find all reviewers who rated the movie 'American Beauty'.Return reviewer name.

SELECT Reviewer.rev_name FROM Reviewer JOIN Rating ON Reviewer.rev_id = Rating.rev_id JOIN Movie ON Rating.mov_id = Movie.mov_id WHERE Movie.mov_title = 'Avatar';


SELECT rev_name, movie_title, rev_stars FROM Reviewer JOIN Ratings ON Reviewers.rev_id = Ratings.rev_id JOIN Movies ON Ratings.movie_id = Movies.movie_id WHERE Ratings.rev_stars IS NOT NULL ORDER BY rev_name, movie_title, rev_stars ASC;

-- 9. Find the movie title, actor’s name of movies that have more than one actor acted in them using correlated subquery

SELECT m.mov_title, a.act_fname FROM Movie m JOIN Movie_Cast mc ON m.mov_id = mc.mov_id JOIN Actor a ON mc.act_id = a.act_id WHERE (SELECT COUNT(act_id) FROM Movie_Cast WHERE mov_id = m.mov_id) > 1;

-- 10.Find the actors whose films have been directed by them. Return the actor’s names, movie title and role using join clause

SELECT Actor.act_fname, Movie.mov_title, Movie_Cast.role FROM Actor JOIN Movie_Cast ON Actor.act_id = Movie_Cast.act_id JOIN Movie ON Movie_Cast.mov_id = Movie.mov_id where Movie_Cast.mov_id = Movie.mov_id;