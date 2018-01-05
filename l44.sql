DECLARE
	salary emp.sal%TYPE;
	manager emp.mgr%TYPE;
	lastname emp.ename%TYPE;
	starting_empno constant NUMBER(4):=7902;
BEGIN
	SELECT sal, mgr INTO salary,manager FROM emp
		WHERE empno=starting_empno;
		WHILE salary<4000
			LOOP
				SELECT sal,mgr,ename INTO salary,manager,lastname
				FROM emp WHERE empno=manager;
			END LOOP;
	INSERT INTO messages VALUES(salary,lastname);
	COMMIT;
END;
/