
/* We use an inner join command to combine "Listings" with "Neighbourhoods" 
and select all the apartments that have 2 to 5 beds and are in Goudi.
Output: 104 rows
*/

set client_encoding to 'utf8';
SELECT "Listings".id, "Listings".name, "Listings".beds, "Listings".price, "Neighbourhoods".neighbourhood
FROM "Listings"
INNER JOIN "Neighbourhoods"
ON "Neighbourhoods".neighbourhood = "Listings".neighbourhood_cleansed
WHERE "Neighbourhoods".neighbourhood = 'ΓΟΥΔΙ' AND "Listings".beds BETWEEN 2 AND 5;

/*