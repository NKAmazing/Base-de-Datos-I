show databases;

use sakila;

select c.city, co.country from city c
inner join country co on (c.country_id = co.country_id);

SELECT * FROM city;