use sakila;

SELECT title, description, release_year FROM film;

SELECT title, description, release_year FROM film where title = 'ACE GOLDFINGER';

SELECT * from film;

SELECT title, description, release_year FROM film where film_id = 10;

SELECT * FROM film_actor;

SELECT title, description, actor_id, release_year FROM film f
inner join film_actor fa on (f.film_id = fa.film_id);