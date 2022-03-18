/* We use two inner join commands. We use them to connect "Location" with "Geolocation" and "Listing".
 We select all the listings that have a zipcode and are in 'ΑΜΠΕΛΟΚΗΠΟΙ', 'ΓΟΥΔΙ' or 'ΙΛΙΣΙΑ' and 
 present all the important information for that listing regarding it's location. 
 That could help people who want to find a listing in those three areas 
 and want information about each listing's location.
Output: 743 rows.
*/
SELECT "Listing".name, "Geolocation".properties_neighbourhood, "Location".zipcode, "Location".latitude, "Location".longitude, "Listing".neighborhood_overview 
FROM "Location"
INNER JOIN "Geolocation"
ON "Geolocation".properties_neighbourhood = "Location".neighbourhood_cleansed
INNER JOIN "Listing"
ON "Listing".id = "Location".listing_id
WHERE ("Location".zipcode IS NOT NULL) AND ("Geolocation".properties_neighbourhood = 'ΑΜΠΕΛΟΚΗΠΟΙ' OR 
	"Geolocation".properties_neighbourhood = 'ΓΟΥΔΙ' OR "Geolocation".properties_neighbourhood = 'ΙΛΙΣΙΑ');
	

/* We use two outer join commands. We use them to connect "Host" with "Price" and "Listing".
 We select all the neighbourhoods (we exclude null values) with the cheapest listings where the host 
 responds within one day. This is useful for travelers that need a quick response and are looking
 for the cheapest choice. 
Output: 33 rows.
*/
SELECT "Host".neighbourhood, MIN("Price".price), "Host".response_time
FROM "Host"
LEFT OUTER JOIN "Listing"
ON "Host".id = "Listing".host_id
LEFT OUTER JOIN "Price"
ON "Listing".id = "Price".listing_id
GROUP BY "Host".neighbourhood, "Host".response_time
HAVING "Host".response_time = 'within a day' AND "Host".neighbourhood IS NOT NULL;


/* We use a left outer join command to connect "Room" with "Calendar".
 We select all the listings that are available from 6th to 8th of June and have more than 5 beds.
 This accomodates large groups of people that want to travel at that time. 
Output: 317 rows.
*/
SELECT "Room".listing_id, "Room".beds
FROM "Room"
LEFT OUTER JOIN "Calendar"
ON "Calendar".listing_id = "Room".listing_id
WHERE "Calendar".date BETWEEN '2020-06-06' AND '2020-06-08' AND "Calendar".available = 'true' 
GROUP BY "Room".listing_id
HAVING "Room".beds > 5;


/* We use an inner join command to connect "Listing" with "Host".
 We select all the listings where there are more than 20 reviews and the host's responce rate is 100%.
 This is useful for people who want to read a lot of reviews before booking and want the host to respond. 
Output: 3598 rows.
*/
SELECT "Listing".id, "Host".id , "Host".name,"Listing".number_of_reviews
FROM "Listing"
INNER JOIN "Host"
ON "Host".id = "Listing".host_id
WHERE "Host".response_rate = '100%' AND "Listing".number_of_reviews > 20;


/* We use an inner join command to connect "Connection" with "Amenity".
 We select all the listings where the amenities include wifi. Wifi's amenity_id is 195.
 This is useful for people who want to have access to the internet. 
Output: 11130 rows.
*/
SELECT "Connection".listing_id, "Amenity".amenity_name
FROM "Connection"
INNER JOIN "Amenity"
ON "Connection".amenity_id = "Amenity".amenity_id
WHERE "Connection".amenity_id = "Amenity".amenity_id AND "Amenity".amenity_name = 'Wifi';