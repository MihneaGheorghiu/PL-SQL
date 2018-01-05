CREATE TABLE messages 
(	charcol1 varchar2(256),
	charcol2 varchar2(256)
)
/
CREATE TABLE lista
(
	id_dept	number(2),
	den_dept varchar2(14),
	nr_angajati number(3),
	nr_comisioane number(3),
	suma_comisioane number(6)
)
/
SET SERVEROUTPUT ON
/
DELETE FROM lista
/
DELETE FROM messages
/
DECLARE
	v_id_dept	lista.id_dept%TYPE;
	den_dept	lista.den_dept%TYPE;
	nr_angajati	lista.nr_angajati%TYPE;
	nr_comisioane	lista.nr_angajati%TYPE;
	suma_comisioane	lista.suma_comisioane%TYPE;
	e		EXCEPTION;
BEGIN
	FOR d in (SELECT deptno from dept)
	LOOP
		SELECT dname INTO den_dept FROM dept WHERE deptno = d.deptno;
		SELECT count(*) INTO nr_angajati FROM emp WHERE deptno = d.deptno;
		SELECT count(*) INTO nr_comisioane FROM emp 
		WHERE deptno = d.deptno AND nvl(comm, 0) > 0;
		SELECT SUM(nvl(comm, 0)) INTO suma_comisioane FROM emp 
		WHERE deptno = d.deptno;

		IF nr_angajati = 0 THEN RAISE e;
		END IF;

		insert into lista values(d.deptno, den_dept, nr_angajati, nr_comisioane, suma_comisioane);
	END LOOP;
EXCEPTION
	WHEN e THEN
		INSERT INTO messages VALUES('Nu a fost gasit nici un angajat!', '');
	WHEN OTHERS THEN 
	BEGIN
		NULL;
	END;
END;
/
SELECT * FROM lista
/
SELECT * FROM messages
/

		msg := SUBSTR(SQLERM, 1, 100);
		INSERT INTO messages VALUES(msg, '');