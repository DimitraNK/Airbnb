CREATE TABLE "Amenity" AS
(SELECT DISTINCT UNNEST(amenities::text[]) AS amenity_name FROM "Room" );
 
ALTER  TABLE "Amenity"
ADD COLUMN amenity_id SERIAL PRIMARY KEY;

CREATE TABLE "Connection" AS
(SELECT temp.listing_id , "Amenity".amenity_id FROM "Amenity",
  (SELECT "Room".listing_id AS listing_id, UNNEST(amenities::text[]) AS amenity_name FROM "Room") AS temp
WHERE temp.amenity_name = "Amenity".amenity_name);

ALTER TABLE "Connection"
ADD PRIMARY KEY(listing_id, amenity_id);

ALTER TABLE "Room"
ADD PRIMARY KEY(listing_id);

ALTER TABLE "Connection"
ADD FOREIGN KEY(listing_id) REFERENCES "Room"(listing_id),
ADD FOREIGN KEY(amenity_id) REFERENCES "Amenity"(amenity_id);

ALTER TABLE "Room"
DROP COLUMN amenities;