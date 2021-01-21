USE sakila;
SHOW tables;
SELECT title from film
ORDER BY title ASC;

#Get unique list of film languages under the alias `language`.
SELECT DISTINCT(name) AS language_name FROM language
ORDER BY language_name ASC;

#Using the `select` statements and reviewing how many records are returned, 
#can you find out how many stores and staff does the company have? 
#Can you return a list of employee first names only?
SELECT COUNT(return_date) from rental;
SELECT COUNT(staff_id) from staff;
SELECT COUNT(*) from store; #because of ACID
SELECT first_name from staff;

#How many unique days did customers rent movies in this dataset?
SELECT DISTINCT(DATE(rental_date)) AS rental_day from rental;

# Lab | SQL Queries - Lesson 2.5
### Instructions

#1. Select all the actors with the first name ‘Scarlett’.
SELECT* from sakila.actor
WHERE first_name='Scarlett';

#2. How many films (movies) are available for rent and how many films have been rented?
SELECT count(rental_id) from sakila.rental; #16044 are available
SELECT count(rental_date) as films_rented from sakila.rental;  #16044 are available
SELECT count(distinct inventory_id) from sakila.inventory;#4580 films are available 
SELECT count(distinct inventory_id) from sakila.rental;

#3. What are the shortest and longest movie duration? Name the values `max_duration` and `min_duration`.
SELECT min(length) as min_duration from sakila.film;
SELECT max(length) as max_duration from sakila.film;

#4. What's the average movie duration expressed in format (hours, minutes)?
SELECT * from sakila.film;
SELECT avg(length) as avg_duration from sakila.film;

#5. How many distinct (different) actors' last names are there?
SELECT count(distinct last_name)from sakila.actor; #200 different actors last name

#6. Since how many days has the company been operating (check DATEDIFF() function)?
SELECT*from sakila.rental;
SELECT DATEDIFF(max(rental_date),min(rental_date)) as operating_days from sakila.rental;
SELECT DATEDIFF(max(last_update),min(rental_date)) as operating_days from sakila.rental;

#7. Show rental info with additional columns month and weekday. Get 20 results.
SELECT *, weekday(rental_date) as day_of_rental, month(rental_date) as month_of_rental from sakila.rental
Limit 20;

#8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT *, weekday(rental_date) as day_of_rental, month(rental_date) as month_of_rental, 
case
when weekday(rental_date)<3 then "workday"
else "weekend"
end as workday_weekend
from sakila.rental;

#9. How many rentals were in the last month of activity?
#DATE_ADD(date,INTERVAL expr type)
SELECT max(rental_date) from sakila.rental;

select date(max(rental_date))- INTERVAL 30 DAY, date(max(rental_date)) #getting the days
from rental;

select count(rental_id) from sakila.rental
where date(rental_date) between date("2006-01-15") and date("2006-02-14"); #182

#different approach
SELECT COUNT(rental_date)
FROM sakila.rental
WHERE MONTH(rental_date) = (SELECT MONTH(MIN(rental_date)) FROM rental);