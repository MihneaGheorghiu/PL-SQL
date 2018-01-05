BEGIN
	FOR v in 1..10
	LOOP
		UPDATE messages SET charcol2=800
			where charcol1=v;
		--COMMIT;
		EXIT WHEN SQL%ROWCOUNT=2;
	END LOOP;
END;
/