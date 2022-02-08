/* SQL Exercise
====================================================================
We will be working with database imdb.db
You can download it here: https://drive.google.com/file/d/1E3KQDdGJs4a0i1RoYb8DEq0PFxCgI6cN/view?usp=sharing
*/


-- MAKE YOURSELF FAMILIAR WITH THE DATABASE AND TABLES HERE

SELECT name, sql FROM sqlite_master
    WHERE type='table'
    ORDER BY name;

--==================================================================
/* TASK I
 Find the id's of movies that have been distributed by “Universal Pictures”.
*/

SELECT movie_id FROM movie_distributors
    JOIN distributors ON (movie_distributors.distributor_id = distributors.distributor_id)
    WHERE name = 'Universal Pictures';

/* TASK II
 Find the name of the companies that distributed movies released in 2006.
*/

SELECT distributors.name FROM movie_distributors
    JOIN distributors ON (movie_distributors.distributor_id = distributors.distributor_id)
    JOIN movies ON (movies.movie_id = movie_distributors.movie_id)
    WHERE year = 2006;

/* TASK III
Find all pairs of movie titles released in the same year, after 2010.
hint: use self join on table movies.
*/

SELECT A.title AS movie1, B.title AS movie2, A.year FROM movies A, movies B
    WHERE A.year > 2010 AND A.year = B.year AND A.title <> B.title;

/* TASK IV
 Find the names and movie titles of directors that also acted in their movies.
*/

SELECT people.name, movies.title FROM roles
    JOIN people ON roles.person_id = people.person_id
    JOIN movies ON movies.movie_id = roles.movie_id
    JOIN directors ON directors.movie_id = movies.movie_id
    WHERE directors.person_id = roles.person_id

/* TASK V
Find ALL movies realeased in 2011 and their aka titles.
hint: left join
*/

SELECT movies.title, aka_titles.title AS aka_titles FROM movies
    LEFT JOIN aka_titles ON movies.movie_id = aka_titles.movie_id
    WHERE year = 2011;


/* TASK VI
Find ALL movies realeased in 1976 OR 1977 and their composer's name.
*/

SELECT title, name, year FROM movies
    LEFT JOIN composers ON movies.movie_id = composers.movie_id
    LEFT JOIN people ON composers.person_id = people.person_id
    WHERE movies.year = 1976 OR movies.year = 1977;


/* TASK VII
Find the most popular movie genres.
*/

SELECT label FROM genres
    JOIN movie_genres ON movie_genres.genre_id = genres.genre_id
    JOIN movies ON movie_genres.movie_id = movies.movie_id
    GROUP BY label
    ORDER BY rating DESC
    LIMIT 5;

/* TASK VIII
Find the people that achieved the 10 highest average ratings for the movies 
they cinematographed.
*/

SELECT name FROM people
    JOIN cinematographers ON cinematographers.person_id = people.person_id
    JOIN movies ON movies.movie_id = cinematographers.movie_id
    GROUP BY people.name
    ORDER BY AVG(movies.rating) DESC
    LIMIT 10;

/* TASK IX
Find all countries which have produced at least one movie with a rating higher than
8.5.
hint: subquery
*/

SELECT name FROM countries
    JOIN movie_countries ON countries.country_id = movie_countries.country_id
    WHERE movie_countries.movie_id IN (SELECT movie_id FROM movies
        WHERE rating > 8.5)

/* TASK X
Find the highest-rated movie, and report its title, year, rating, and country. There
can be ties; if so, you should report for each of them.
*/

SELECT title, year, MAX(rating), countries.name FROM movies
    JOIN movie_countries ON movies.movie_id = movie_countries.movie_id
    JOIN countries ON countries.country_id = movie_countries.country_id
    

/* STRETCH BONUS
Find the pairs of people that have directed at least 5 movies and whose 
carees do not overlap (i.e. The release year of a director's last movie is 
lower than the release year of another director's first movie).
*/
