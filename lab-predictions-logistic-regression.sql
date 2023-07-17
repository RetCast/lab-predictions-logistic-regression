USE sakila;

SELECT * FROM film;
SELECT * FROM inventory;
SELECT * FROM rental;

/* Create a query or queries to extract the information you think may be relevant for building the 
prediction model. It should include some film features and some rental features*/
SELECT f.film_id, f.rental_duration, f.rental_rate, f.length, 
f.replacement_cost, f.rating, f.special_features, 
i.inventory_id, 
r.rental_id, r.rental_date 
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id=r.inventory_id;

/* Create a query to get the list of films and a boolean indicating if it was rented last month. 
This would be our target variable.*/
SELECT rental_date FROM rental
ORDER BY rental_date DESC;
#2006-02-15  to 2006-01-15




SELECT f.film_id, MAX(IF(r.rental_date BETWEEN '2006-01-15' AND '2006-02-15', 1, 0)) as rented_last_month 
FROM film f
LEFT JOIN inventory i USING (film_id)
LEFT JOIN rental r USING (inventory_id)
GROUP BY F.film_id
ORDER BY f.film_id;

SELECT DISTINCT f.film_id
FROM film f
LEFT JOIN inventory i USING (film_id)
LEFT JOIN rental r USING (inventory_id)
WHERE r.rental_date > '2006-01-15'
order by f.film_id;
