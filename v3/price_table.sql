CREATE TABLE "Price" AS (SELECT id AS listing_id, price, weekly_price, monthly_price, security_deposit, 
cleaning_fee, guests_included, extra_people, minimum_nights, maximum_nights, minimum_minimum_nights, 
maximum_minimum_nights, minimum_maximum_nights, maximum_maximum_nights, minimum_nights_avg_ntm, 
maximum_nights_avg_ntm FROM "Listings");

ALTER TABLE "Price"
ADD FOREIGN KEY (listing_id) REFERENCES "Listings"(id);

UPDATE  "Price"
SET 
price = REPLACE(price,'$',''),
weekly_price = REPLACE(weekly_price,'$',''),
monthly_price = REPLACE(monthly_price,'$',''),
security_deposit = REPLACE(security_deposit,'$',''),
cleaning_fee = REPLACE(cleaning_fee,'$',''),
extra_people = REPLACE(extra_people,'$','');

UPDATE  "Price"
SET 
price = REPLACE(price,',',''),
weekly_price = REPLACE(weekly_price,',',''),
monthly_price = REPLACE(monthly_price,',',''),
security_deposit = REPLACE(security_deposit,',',''),
cleaning_fee = REPLACE(cleaning_fee,',',''),
extra_people = REPLACE(extra_people,',','');

ALTER TABLE "Price" 
ALTER COLUMN price TYPE NUMERIC(10,0) USING price::NUMERIC,
ALTER COLUMN weekly_price TYPE NUMERIC(10,0) USING weekly_price::NUMERIC,
ALTER COLUMN monthly_price TYPE NUMERIC(10,0) USING monthly_price::NUMERIC,
ALTER COLUMN security_deposit TYPE NUMERIC(10,0) USING security_deposit::NUMERIC,
ALTER COLUMN cleaning_fee TYPE NUMERIC(10,0) USING cleaning_fee::NUMERIC,
ALTER COLUMN extra_people TYPE NUMERIC(10,0) USING extra_people::NUMERIC,
ALTER COLUMN minimum_nights_avg_ntm TYPE NUMERIC(10,1) USING minimum_nights_avg_ntm::NUMERIC,
ALTER COLUMN maximum_nights_avg_ntm TYPE NUMERIC(10,1) USING maximum_nights_avg_ntm::NUMERIC;