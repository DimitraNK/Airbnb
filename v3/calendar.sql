UPDATE "Calendar"
SET 
price = REPLACE(price,'$',''),
adjusted_price = REPLACE(adjusted_price,'$','');

UPDATE "Calendar"
SET 
price = REPLACE(price,',',''),
adjusted_price = REPLACE(adjusted_price,',','');

ALTER TABLE "Calendar"
ALTER COLUMN price TYPE NUMERIC(10,0) USING price::NUMERIC,
ALTER COLUMN adjusted_price TYPE NUMERIC(10,0) USING adjusted_price::NUMERIC;