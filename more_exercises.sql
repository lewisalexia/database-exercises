use sakila;
select database();

show tables
from sakila;

select *
from actor;

select last_name
from actor;

select film_id, release_year
from film;

select distinct last_name
from actor;

select distinct postal_code
from address;

select distinct rating
from film;

select title, description, rating, length
from film
where length > 180
;

select payment_id, amount, payment_date
from payment
where payment_date > '2005-05-27'
;

-- 3c
show create table payment;
select *
from payment; 
select payment_id, amount, payment_date
from payment
where payment_date = '2005-05-27'
;