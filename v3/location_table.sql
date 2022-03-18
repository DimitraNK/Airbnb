CREATE TABLE "Location" AS (SELECT id AS listing_id, street, neighbourhood, neighbourhood_cleansed, city, 
state, zipcode, market, smart_location, country_code, country, latitude, longitude,
is_location_exact FROM "Listings");

ALTER TABLE "Listings"
DROP CONSTRAINT "Listings_neighbourhood_cleansed_fkey";

ALTER TABLE "Listings"
DROP CONSTRAINT "Listings_neighbourhood_cleansed_fkey1";

ALTER TABLE "Location"
ADD FOREIGN KEY (neighbourhood_cleansed) REFERENCES "Neighbourhoods"(neighbourhood);

-- In drop_columns.sql we drop neighbourhood_cleansed so we must add a foreign key to a different table.
ALTER TABLE "Neighbourhoods"
ADD FOREIGN KEY (neighbourhood) REFERENCES "Geolocation"(properties_neighbourhood);