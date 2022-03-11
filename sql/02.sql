/*
 * Count the number of distinct customers who have rented a movie that 'RUSSELL BACALL' has acted in.
 *
 * NOTE:
 * You cannot hard-code Russell Bacall's actor_id.
 * You're where clause must include a condition using the "first_name" and "last_name" fields of the "actor" table.
 */

SELECT
    COUNT(DISTINCT c.customer_id)
FROM customer c
JOIN rental r ON(c.customer_id = r.customer_id)
JOIN inventory i ON(r.inventory_id = i.inventory_id)
JOIN film f ON(i.film_id = f.film_id)
JOIN film_actor fa ON(f.film_id = fa.film_id)
JOIN actor a ON(fa.actor_id = a.actor_id)
WHERE a.actor_id IN (
    SELECT
        actor_id
    FROM actor
    WHERE
        first_name = 'RUSSELL' AND
        last_name = 'BACALL'
);
