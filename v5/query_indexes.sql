-- VACUUM ANALYZE clause was used for all the tables and enable_seqscan was set to off

CREATE INDEX index_for_query1 ON "Listing"(host_id);
DROP INDEX index_for_query1;

CREATE INDEX index_for_query2 ON "Price"(guests_included, price);
DROP INDEX index_for_query2;

CREATE INDEX index_for_query3 ON "Location"(zipcode);
DROP INDEX index_for_query3;

CREATE INDEX index_for_query4 ON "Host"(neighbourhood);
DROP INDEX index_for_query4;

CREATE INDEX index_for_query5 ON "Room"(beds);
DROP INDEX index_for_query5;

CREATE INDEX index_for_query6 ON "Host"(response_rate);
DROP INDEX index_for_query6;

CREATE INDEX index_for_query7 ON "Amenity"(amenity_name);
DROP INDEX index_for_query7;



