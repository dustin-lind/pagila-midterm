/*
 * You want to watch a movie tonight.
 * But you're superstitious,
 * and don't want anything to do with the letter 'F'.
 * List the titles of all movies that:
 * 1) do not have the letter 'F' in their title,
 * 2) have no actors with the letter 'F' in their names (first or last),
 * 3) have never been rented by a customer with the letter 'F' in their names (first or last).
 *
 * NOTE:
 * Your results should not contain any duplicate titles.
 */
SELECT DISTINCT
    f.title
FROM film f
JOIN film_actor fa ON(f.film_id = fa.film_id)
JOIN ( 
    SELECT
        *,
        first_name || ' ' || last_name as "actor_name"
    FROM actor
) a ON(fa.actor_id = a.actor_id) 
JOIN inventory i ON(f.film_id = i.film_id)
JOIN rental r ON(i.inventory_id = r.inventory_id)
JOIN (
    SELECT
        *,
        first_name || ' ' || last_name as "customer_name"
    FROM customer
) c ON(r.customer_id = c.customer_id)
WHERE
    (f.title NOT LIKE '%F%') AND
    (a.actor_name NOT LIKE '%F%') AND
    (c.customer_name NOT LIKE '%F%')
ORDER BY f.title;
    
