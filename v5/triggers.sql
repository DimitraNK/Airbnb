CREATE FUNCTION decrease_hlc()
	RETURNS trigger AS
$$
BEGIN
UPDATE "Host" 
SET listings_count = listings_count - 1
WHERE id = OLD.host_id;
RETURN OLD;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER deleteTrigger 
AFTER DELETE ON "Listing"
FOR EACH ROW
EXECUTE PROCEDURE decrease_hlc();


CREATE FUNCTION increase_hlc()
	RETURNS trigger AS
$$
BEGIN
UPDATE "Host" 
SET listings_count = listings_count + 1
WHERE id = NEW.host_id;
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER insertTrigger 
AFTER INSERT ON "Listing"
FOR EACH ROW
EXECUTE PROCEDURE increase_hlc();

/* When a new record is inserted or a record is updated in "Room" we check if the number of beds is greater than zero. If it is we allow 
 the insertion or the update. If it is not we return null and let the user know that the number of beds is not valid. 
*/

CREATE FUNCTION beds()
	RETURNS trigger AS
$$
BEGIN
IF NEW.beds <= 0 THEN
	RAISE NOTICE 'Invalid number of beds.';
	RETURN NULL;
END IF;
RETURN NEW;
END; 
$$

LANGUAGE plpgsql;

CREATE TRIGGER insertBedTrigger 
BEFORE INSERT OR UPDATE ON "Room"
FOR EACH ROW
EXECUTE PROCEDURE  beds();
