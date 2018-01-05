DECLARE
	v_count NUMBER(2);
BEGIN
	FOR v_count IN 1..10
		LOOP
			IF v_count NOT IN (6,8) THEN
				INSERT INTO messages (charcol1) VALUES (v_count);
				--COMMIT;
			END IF;
		END LOOP;
	COMMIT;
END;
/