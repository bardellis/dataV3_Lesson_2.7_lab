-- Lab | SQL Join (Part I)
USE sakila;

-- 1. How many films are there for each of the categories in the category table. Use appropriate join to write this query.
	SELECT film_category.category_id,count(distinct(film.film_id)) as films
	FROM film
	join film_category on film.film_id=film_category.film_id
	group by film_category.category_id
	order by films desc;
	    
-- 2. Display the total amount rung up by each staff member in August of 2005.
	select rental.staff_id,round(sum(payment.amount)) as 'amount'
    from rental
    join payment on rental.rental_id=payment.rental_id
    where date_format(convert(left(rental_date,10),date),'%M-%Y')='August-2005'
    group by rental.staff_id;
	
-- 3. Which actor has appeared in the most films?
	select actor.actor_id, concat(actor.first_name,', ',actor.last_name) as 'actors', count(film.film_id) as 'films' from film
	join film_actor on film.film_id=film_actor.film_id
	join actor on film_actor.actor_id=actor.actor_id
	-- where 'films'=max(count(distinct(film.film_id)))
	group by actor.actor_id,'actors'
	order by films desc
	limit 1;

-- 4. Most active customer (the customer that has rented the most number of films)
	select r.customer_id as customer_id,c.last_name as last_name,count(r.rental_id) as rentals 
    from rental as r
    join customer as c on r.customer_id=c.customer_id
    group by customer_id,last_name
    order by rentals desc
    limit 1;

-- 5. Display the first and last names, as well as the address, of each staff member.
	select s.staff_id, s.first_name, s.last_name, s.address_id, a.address
	from staff as s
	join address as a on s.address_id = a.address_id;

-- 6. List each film and the number of actors who are listed for that film.
	SELECT f.film_id,f.title, count(fa.actor_id) as actors from film as f
    JOIN film_actor as fa on f.film_id = fa.film_id
    GROUP BY f.film_id,f.title
    ORDER BY actors desc;

-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
	SELECT c.customer_id, c.last_name, c.first_name, SUM(p.amount) AS total_paid
	FROM customer AS c
	JOIN payment AS p ON c.customer_id = p.customer_id
	GROUP BY c.customer_id, c.last_name, c.first_name
	ORDER BY c.last_name, c.first_name;

-- 8. List the titles of films per category.
	select fc.category_id as category, f.film_id as film_id, f.title as title
	from film as f
	join film_category as fc on f.film_id = fc.film_id;
