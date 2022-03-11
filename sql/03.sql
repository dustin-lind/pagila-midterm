/*
 * List the titles of all films in the 'Children' category that have a rating of 'R' or 'NC-17'.
 *
 * NOTE:
 * Your results should not contain any duplicate titles.
 */
SELECT DISTINCT
    f.title,
    c.name,
    f.rating
FROM film f
JOIN film_category fc ON(f.film_id = fc.film_id)
JOIN category c ON(fc.category_id = c.category_id)
WHERE
    (c.name = 'Children') AND
    (f.rating = 'R' OR f.rating = 'NC-17')
ORDER BY f.title;
