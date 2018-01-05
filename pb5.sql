
CREATE TABLE messages 
(	charcol1 varchar2(256)
	
)
/
CREATE TABLE bloc
(
	id_dept	number(2),
	den_dept varchar2(14),
	nr_angajati number(2),
	nr_comisioane number(2),
	suma_comisioane number(8)
)

/
DELETE FROM bloc
/
DELETE FROM messages
/
DECLARE
	v_id_dept	bloc.id_dept%TYPE;
	den_dept	bloc.den_dept%TYPE;
	nr_angajati	bloc.nr_angajati%TYPE;
	nr_comisioane	bloc.nr_angajati%TYPE;
	suma_comisioane	bloc.suma_comisioane%TYPE;
	exep		EXCEPTION;
BEGIN
	FOR d in (SELECT deptno from dept)
	LOOP
	   BEGIN
		SELECT dname INTO den_dept FROM dept WHERE deptno = d.deptno;
		SELECT count(*) INTO nr_angajati FROM emp WHERE deptno = d.deptno;
		SELECT count(*) INTO nr_comisioane FROM emp 
		WHERE deptno = d.deptno AND nvl(comm, 0) > 0;
		SELECT SUM(nvl(comm, 0)) INTO suma_comisioane FROM emp 
		WHERE deptno = d.deptno;

		IF nr_angajati = 0 THEN RAISE exep;
		END IF;

		insert into bloc values(d.deptno, den_dept, nr_angajati, nr_comisioane, suma_comisioane);
		
		EXCEPTION
		WHEN exep THEN
			INSERT INTO messages VALUES('nr de angajatio 0', '');
		WHEN OTHERS THEN 
		BEGIN
			NULL;
		END;

	    END;	
	END LOOP;

END;
/
SELECT * FROM bloc
/
SELECT charcol1 FROM messages
/

		