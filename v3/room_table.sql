CREATE TABLE "Room" AS (SELECT id AS listing_id, accommodates, bathrooms, bedrooms, beds, bed_type,
amenities, square_feet, price, weekly_price, monthly_price, security_deposit FROM "Listings");

ALTER TABLE "Room"
ADD FOREIGN KEY (listing_id) REFERENCES "Listings"(id);