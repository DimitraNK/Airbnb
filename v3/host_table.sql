CREATE TABLE "Host" AS (SELECT DISTINCT host_id AS id, host_url AS url, host_name AS name, 
host_since AS since, host_location AS location, host_about AS about,
host_response_time AS response_time, host_response_rate AS response_rate, 
host_acceptance_rate AS acceptance_rate, host_is_superhost AS is_superhost,
host_thumbnail_url AS thumbnail_url, host_picture_url AS picture_url, 
host_neighbourhood AS neighbourhood, host_listings_count AS listings_count,
host_total_listings_count AS total_listings_count, host_verifications AS verifications, 
host_has_profile_pic AS has_profile_pic, host_identity_verified AS identity_verified,
calculated_host_listings_count AS calculated_listings_count FROM "Listings");

ALTER TABLE "Host"
ADD PRIMARY KEY (id);

ALTER TABLE "Listings"
ADD FOREIGN KEY (host_id) REFERENCES "Host"(id);