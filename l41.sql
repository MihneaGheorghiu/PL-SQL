DECLARE
	deptno emp.deptno%TYPE;
	job emp.job%TYPE;
	accounting char(10);
BEGIN
	FOR i IN (select distinct empno from emp)
		LOOP
			SELECT deptno, job INTO deptno, job FROM emp WHERE empno=i.empno;
				IF deptno = 10 THEN accounting := 'YES';
					IF job = 'MANAGER' THEN
						INSERT INTO status VALUES( 'Dept10-Manager');
					END IF;
					COMMIT;
				ELSE accounting := 'NO';
					IF job = 'MANAGER' THEN
						INSERT INTO status VALUES ('Alt Manager');
					END IF;
					COMMIT;
				END IF;
		END LOOP;
	COMMIT;
END;
/