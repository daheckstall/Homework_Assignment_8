Use	sakila;

Select first_name, last_name
From actor;

Select upper(Concat(first_name, " ", last_name)) as "Actor Name"
From actor;

Select actor_ID, first_name, last_name
from	actor where first_name = "Joe";

Select actor_ID, first_name, last_name
from	actor where last_name like "%GEN%";

Select actor_ID, first_name, last_name
from	actor 
where last_name like "%LI%"
order by last_name, first_name;

Select country_id, country
from country
where country in ("Afghanistan","Bangladesh","China");

alter table actor
add column middle_name blob;

alter table actor
modify column middle_name blob after first_name;

select * from actor;

alter table actor
drop middle_name;

select * from actor;

select last_name, count(last_name)
from actor
group by last_name having count(last_name);

select last_name, count(last_name)
from actor
group by last_name having count(last_name) >= 2;

update actor
set first_name = "HARPO"
where first_name = "GROUCHO"
and	last_name = "WILLIAMS";

select * from actor where last_name = "WILLIAMS"; 


update actor
set first_name = 
case when first_name = "HARPO"
then "GROUCHO" 
else "MUCHO GROUCHO"
end
where actor_id = 172;
 
select * from actor where last_name = "WILLIAMS";


Show Create table sakila.address;

Select first_name, last_name, address
from staff s
inner join address a
on s.address_id = a.address_id;

select first_name, last_name, sum(amount)
from staff s
inner join payment p
on s.staff_id = p.staff_id
group by p.staff_id
order by last_name ASC;


select title, count(actor_id)
from film f
inner join film_actor fa
on f.film_id = fa.film_id
group by title;

select title, count(inventory_id)
from film f
inner join inventory i 
on f.film_id = i.film_id
where title = "Hunchback Impossible";

select last_name, first_name, sum(amount)
from payment p
inner join customer c
on p.customer_id = c.customer_id
group by p.customer_id
order by last_name asc;

use sakila;

select title from film
where language_id in
	(select language_id 
	from language
	where name = "English" )
and (title like "K%") or (title like "Q%");

use sakila;

select last_name, first_name
from actor
where actor_id in
	(select actor_id from film_actor
	where film_id in 
		(select film_id from film
		where title = "Alone Trip"));
        
use sakila;

select country, last_name, first_name, email
from country c
left join customer cu
on c.country_id = cu.customer_id
where country = 'Canada';        


use sakila;

select title, category
from film_list
where category = 'Family';


use sakila;

select i.film_id, f.title, count(r.inventory_id)
from inventory i
inner join rental r
on i.inventory_id = r.inventory_id
inner join film_text f 
on i.film_id = f.film_id
group by r.inventory_id
order by count(r.inventory_id) desc;

select store.store_id, sum(amount)
from store
inner join staff
on store.store_id = staff.store_id
inner join payment p 
on p.staff_id = staff.staff_id
group by store.store_id
order by sum(amount);

use sakila;

select s.store_id, city, country
from store s
inner join customer cu
on s.store_id = cu.store_id
inner join staff st
on s.store_id = st.store_id
inner join address a
on cu.address_id = a.address_id
inner join city ci
on a.city_id = ci.city_id
inner join country coun
on ci.country_id = coun.country_id
where country = 'CHINA' and country = 'INDIA';

use sakila;

select c.name as "Genre", sum(p.amount)
from category c 
inner join film_category fc on c.category_id = fc.category_id
inner join film f on fc.film_id = f.film_id
inner join inventory i on f.film_id = i.film_id
inner join rental r on i.inventory_id = r.inventory_id
inner join payment p on r.rental_id = p.rental_id
group by 1
order by 2 desc
limit 5;

use sakila;

create view top_five_grossing_by_genres as

select name, sum(p.amount)
from category c
inner join film_category fc
inner join inventory i
on i.film_id = fc.film_id
inner join rental r
on r.inventory_id = i.inventory_id
inner join payment p
group by name
limit 5;

select * 
from top_five_grossing_by_genres;

drop view top_five_grossing_by_genres;
