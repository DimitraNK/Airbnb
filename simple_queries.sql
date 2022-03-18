/* We use an inner join command to combine "Listings" with "Neighbourhoods" 
 and select all the apartments that have 2 to 5 beds and are in Goudi. 
 This could accommodate traveling families or bigger groups of travelers in Goudi.
 Output: 104 rows
*/

SELECT "Listings".id, "Listings".name, "Listings".beds, "Listings".price, "Neighbourhoods".neighbourhood
FROM "Listings"
INNER JOIN "Neighbourhoods"
ON "Neighbourhoods".neighbourhood = "Listings".neighbourhood_cleansed
WHERE "Neighbourhoods".neighbourhood = 'ΓΟΥΔΙ' AND "Listings".beds BETWEEN 2 AND 5;

/* We use an inner join command to combine "Listings" with "Geolocation". Our goal this time is to find apartments that
 are available for 365 days and we present the results in ascending order based on their price. 
 Output: 765 rows
*/

SELECT "Listings".id,  "Listings".name, "Geolocation".properties_neighbourhood, 
"Listings".price::MONEY::NUMERIC::FLOAT AS price
FROM "Listings"
INNER JOIN "Geolocation"
ON "Geolocation".properties_neighbourhood = "Listings".neighbourhood_cleansed
WHERE "Listings".availability_365 = 365
ORDER BY price ASC;

/* We use a left outer join command to combine "Listings" with "Reviews". 
 We show the first 100 results including reviewer's comments, where there are geusts included. 
 Output: 100 rows 
*/

SELECT "Listings".id,  "Listings".name, "Reviews".reviewer_id, "Reviews".comments
FROM "Listings"
LEFT OUTER JOIN "Reviews"
ON "Listings".id = "Reviews".listing_id
WHERE "Listings".guests_included <> 0
LIMIT 100;

/* We use an inner join command to combine "Listings" with "Calendar". We find maximum_nights' maximum value, and show the listings
 which take place in April and are available.
 Output: 30 rows
*/

SELECT "Listings".id,  "Listings".name,"Calendar".maximum_nights, "Calendar".date
FROM "Listings"
INNER JOIN "Calendar"
ON "Listings".id = "Calendar".listing_id
WHERE ("Calendar".date BETWEEN '2020-04-01' AND '2020-04-30') AND ("Calendar".available = 't')
	  AND "Calendar".maximum_nights IN(
	SELECT MAX("Calendar".maximum_nights) 
	FROM "Calendar"
	WHERE ("Calendar".date BETWEEN '2020-04-01' AND '2020-04-30') AND ("Calendar".available = 't')); 	

/* We use an inner join command to combine "Listings" with "Reviews". 
 We show the results in which reviewer's comments include the words clean or comfortable. 
 Output: 119896 rows
*/

SELECT "Listings".id,  "Listings".name, "Reviews".reviewer_name, "Reviews".comments
FROM "Listings"
INNER JOIN "Reviews"
ON "Listings".id = "Reviews".listing_id
WHERE "Reviews".comments LIKE '%clean%' OR "Reviews".comments LIKE '%comfortable%';

/* We use an inner join command to combine "Listings" with "Calendar". We present the listings that take place in August,
 have a good rating (above 95) and their price is bellow $100. These are the best and most economic options for travelers in August.
 Output: 1000 rows
*/

SELECT "Listings".review_scores_rating, "Listings".id, "Listings".name,"Calendar".date,"Listings".price
FROM "Listings"
INNER JOIN "Calendar"
ON "Listings".id = "Calendar".listing_id
WHERE "Listings".review_scores_rating::NUMERIC>95 AND "Calendar".date BETWEEN '2020-08-01' AND '2020-08-31' 
	  AND "Listings".price::MONEY::NUMERIC::FLOAT < 100
LIMIT 1000;

/* In this query we use an inner join command to combine "Listings" with "Calendar". This time we calculate the average price
 on Christmas season in apartments where pets are allowed.
 Output: 1 rows
*/

SELECT AVG("Listings".price::MONEY::NUMERIC::FLOAT)
FROM "Listings"
INNER JOIN "Calendar"
ON "Listings".id = "Calendar".listing_id
WHERE ("Calendar".date BETWEEN '2020-12-23' AND '2021-01-07') AND "Listings".amenities LIKE '%Pets allowed%';

/* This time we also use an inner join command to combine "Listings" with "Neighbourhoods". We find the apartments with the
 minimum cleaning_fee ($0.00).
 Output: 42 rows
*/

SELECT DISTINCT "Neighbourhoods".neighbourhood, "Listings".cleaning_fee
FROM "Listings"
INNER JOIN "Neighbourhoods"
ON "Neighbourhoods".neighbourhood = "Listings".neighbourhood_cleansed
WHERE "Listings".cleaning_fee::MONEY::NUMERIC::FLOAT IN(
	SELECT MIN("Listings".cleaning_fee::MONEY::NUMERIC::FLOAT) 
	FROM "Listings");

/* We use a left outer join command to combine "Listings" with "Geolocation". This query calculates the total number 
 of reviews for every neighbourhood. There are no null values, because there is a review 
 for at least one apartment in every neighbourhood.
 Output: 45 rows
*/ 

SELECT "Geolocation".properties_neighbourhood,COUNT("Listings".number_of_reviews)
FROM "Geolocation"
LEFT OUTER JOIN "Listings" 
ON "Geolocation".properties_neighbourhood = "Listings".neighbourhood_cleansed
GROUP BY "Geolocation".properties_neighbourhood

/* In this query we use an inner join command and the DISTINCT clause to find the family/kid friendly hotels 
 that are helpful to visiting families. We do this by searching the key words Family/kid friendly in the listings amenities
 and the word helpful in the reviewers' comments.
 Output: 2531 rows
*/

SELECT DISTINCT "Listings".id,  "Listings".name
FROM "Reviews"
INNER JOIN "Listings"
ON "Listings".id = "Reviews".listing_id
WHERE "Listings".amenities LIKE '%Family/kid friendly%' AND "Reviews".comments LIKE '%helpful%';

/* This time we present the ids, names, prices and bedrooms of apartments that are nearby a metro station and have exactly 4 bedrooms,
 which accommodate large groups of people that might need means of transportation. The results are presented from the most economic to 
 the least economic.
 Output: 33 rows
*/

SELECT "Listings".id,  "Listings".name, "Listings".price::MONEY::NUMERIC::FLOAT AS price, "Listings".bedrooms
FROM "Listings"
WHERE "Listings".description LIKE '%Metro%' AND "Listings".bedrooms = 4
ORDER BY price;

/* In this query we use an inner join command to combine "Listings" with "Calendar". We select the apartments that are available 
 on Valentine's day and have a private room. 
 Output: 527 rows
*/

SELECT "Listings".id, "Listings".name, "Listings".neighbourhood_cleansed
FROM "Listings"
INNER JOIN "Calendar"
ON "Listings".id = "Calendar".listing_id
WHERE "Calendar".date = '2021-02-14' AND "Calendar".available = 't' AND "Listings".room_type = 'Private room';
