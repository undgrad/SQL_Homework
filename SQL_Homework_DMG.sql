#1a 
SELECT first_name, last_name FROM sakila.actor;
------------------------------------------------------

#1b
select  concat (first_name, + ' ', + last_name) 
FROM sakila.actor;
------------------------------------------------------

#2a
select actor_id, first_name, last_name
FROM sakila.actor
where first_name like '%Joe%';
------------------------------------------------------

#2b 
select * from sakila.actor
where last_name like '%gen%';
------------------------------------------------------

#2c
select * from sakila.actor
where last_name like '%LI%'
order by last_name, first_name;
------------------------------------------------------

#2d
select country_id, country 
from sakila.country
where country in ( 'Afghanistan', 'Bangladesh', 'China');
------------------------------------------------------

#3a
alter table sakila.actor
add (description blob);
------------------------------------------------------

#3b
alter table sakila.actor
drop description;
------------------------------------------------------

#4a
select last_name, count(*)
from sakila.actor
group by last_name;
------------------------------------------------------

#4b
select last_name, count(*)
from sakila.actor
group by last_name
having count(*) > 1;
------------------------------------------------------

#4c
update sakila.actor
set first_name = 'HARPO'
where first_name = 'GROUCHO'
and last_name = 'WILLIAMS';

select * from sakila.actor
where  last_name = 'WILLIAMS';
------------------------------------------------------

#4d
update sakila.actor
set first_name =  'GROUCHO'
where first_name = 'HARPO'
and last_name = 'WILLIAMS';
------------------------------------------------------

select * from sakila.actor
where  last_name = 'WILLIAMS';
------------------------------------------------------

#5a
SHOW CREATE TABLE sakila.address;
------------------------------------------------------

#6a
select staff.first_name, staff.last_name, address.address 
from staff join address on staff.address_id = address.address_id;
------------------------------------------------------

#6b
select staff.first_name, staff.last_name, sum(payment.amount)
from staff join payment on staff.staff_id = payment.staff_id
where payment.payment_date between 20050801 and 20050831
group by staff.first_name, staff.last_name;
------------------------------------------------------

#6c
select film.Title, count(film_actor.actor_id) as 'Number of Actors'
from film
inner join film_actor on film.film_id = film_actor.film_id
group by film.title;
------------------------------------------------------

#6d
select film.title, count(inventory.film_id)
from film
inner join inventory on film.film_id = inventory.film_id
where film.title like "%Hunchback Impossible%"
group by film.title;
------------------------------------------------------

#6e
select customer.first_name as "First Name", 
customer.last_name as "Last Name", 
sum(payment.amount) as "Total Amount Paid"
from customer join payment on customer.customer_id = payment.customer_id
group by first_name, last_name;
------------------------------------------------------

#7a
select film.Title from film
where language_id in (
	select language_id from language
    where name in ('English'))
    and film.title  like ('K%')
or film.title like ('Q%');
------------------------------------------------------

#7b
select concat(first_name, + ' ', + last_name) as 'Alone Trip Actors'
FROM actor
where actor_id in (
	select actor_id from film_actor
	where film_id in (
			select film_id from film
            where title = 'Alone Trip'));
------------------------------------------------------

#7c
select c.customer_id, c.First_name, c.Last_name, c.email
from customer as c
inner join address as a on c.address_id = a.address_id
inner join city on city.city_id = a.city_id
inner join country on city.country_id = country.country_id
where country.country = 'Canada';
------------------------------------------------------

#7d
select * from film_list
where category = 'Family';
------------------------------------------------------

#7e
select distinct film.title, count(r.inventory_id) as Rented from film
inner join inventory as i on film.film_id = i.film_id
inner join rental as r on i.inventory_id = r.inventory_id
group by film.title
order by count(r.inventory_id) desc;
------------------------------------------------------

#7f 
select Store, concat('$', substring(total_sales, -8,2),',',substring(total_sales, 3)) as 'Sales'
from sales_by_store;

select * from sales_by_store;
------------------------------------------------------

#7g
select s.store_id, c.city, co.country
from store as s
inner join address as a on s.address_id = a.address_id
inner join city as c on a.city_id = c.city_id
inner join country as co on c.country_id = co.country_id;
------------------------------------------------------

#7h top 5 genres in gross revenue
select c.Name as Genre, sum(p.amount) as 'Gross Revenue'
from category as c 
inner join film_category as fc on c.category_id = fc.category_id
inner join film as f on fc.film_id = f.film_id
inner join inventory as i on f.film_id = i.film_id
inner join rental as r on i.inventory_id = r.inventory_id
inner join payment as p on r. rental_id = p.rental_id
group by c.name
having sum(p.amount) > 4380
order by sum(p.amount) desc;

SELECT * FROM sakila.sales_by_film_category
where total_sales > 4380;
------------------------------------------------------
#8a
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `top_five_genres` AS

select c.Name as Genre, sum(p.amount) as 'Gross Revenue'
from category as c 
inner join film_category as fc on c.category_id = fc.category_id
inner join film as f on fc.film_id = f.film_id
inner join inventory as i on f.film_id = i.film_id
inner join rental as r on i.inventory_id = r.inventory_id
inner join payment as p on r. rental_id = p.rental_id
group by c.name
having sum(p.amount) > 4380
order by sum(p.amount) desc;
------------------------------------------------------

#8b
select * from top_five_genres;
------------------------------------------------------
#8c
drop view top_five_genres;

