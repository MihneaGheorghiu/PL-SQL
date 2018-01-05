CREATE TABLE LISTA_REZ (
	den_dep varchar2(10), 
	nume varchar2(10), 
	data_ang date,
	is_sef varchar2(2),
	vechime number(2), 
	zile_co number(7, 2)
)

/

CREATE TABLE MESSAGES (
	message varchar2 (32)
)

/

CREATE OR REPLACE FUNCTION vechime_angajat(empno in number) return number as 
vechime number;
BEGIN
	SELECT (sysdate - e.hiredate) / 365 INTO vechime FROM emp e WHERE e.empno = empno;
	return vechime;
END vechime_angajat;

/

--CREATE OR REPLACE FUNCTION zile_concediu(empno in number, is_sef in number) return number as
CREATE OR REPLACE FUNCTION zile_concediu(vechime in number, is_sef in number) return number as
	-- vechime number(2);
BEGIN
	-- vechime := vechime_angajat(empno);
	IF is_sef > 0
	THEN
		BEGIN
			IF vechime < 25 THEN RETURN 20;
			ELSE RETURN 22;
			END IF;
		END;
	ELSE
		BEGIN
			IF vechime < 25 THEN RETURN 15;
			ELSE RETURN 17;
			END IF;
		END;
	END IF;
END zile_concediu;

/

DECLARE
zile number(2);
vechime number(2);
is_sef number(2);
nume_dept dept.dname%type;
str_is_sef varchar2(2);
BEGIN
	FOR e IN (SELECT * FROM emp)
	LOOP
		SELECT count(*) INTO is_sef FROM emp WHERE e.empno = mgr;
		
		 IF is_sef > 0 THEN str_is_sef := 'DA';
		 ELSE str_is_sef := 'NU';
		END IF;
		
		vechime := (sysdate - e.hiredate) / 365;
		zile := zile_concediu(vechime, is_sef);
		
		SELECT d.dname INTO nume_dept FROM dept d WHERE d.deptno = e.deptno;
		
		INSERT INTO LISTA_REZ(den_dep, nume, data_ang, is_sef, vechime, zile_co)
		VALUES(nume_dept, e.ename, e.hiredate, str_is_sef, vechime, zile);
	END LOOP;

END;

/
SELECT * from LISTA_REZ
/
SELECT * from MESSAGES
/
DROP TABLE LISTA_REZ
/
DROP TABLE MESSAGES
/


