set serveroutput on;
DECLARE
	dept_name 	dept.dname%TYPE;
	emp_name 	emp.ename%TYPE;
	emp_hiredate 	emp.hiredate%TYPE;
	emp_sal 	emp.sal%TYPE;
	emp_vechime 	NUMBER(2);
	mgr_sal 	emp.sal%TYPE;
	mgr_name 	emp.ename%TYPE;

BEGIN
	-- pentru toti angajatii mai vechi de 25 de ani
	FOR i IN ( 	SELECT e.empno, e.mgr
			FROM emp e
			WHERE MONTHS_BETWEEN( SYSDATE, e.hiredate ) >= 25 * 12 )
		LOOP
			-- daca au manager
			IF i.mgr IS NOT NULL THEN

				-- citesc salariu, nume, data ang, vechime
				SELECT e.sal, e.ename, e.hiredate , MONTHS_BETWEEN( SYSDATE, e.hiredate ) / 12
				INTO emp_sal, emp_name, emp_hiredate , emp_vechime
				FROM emp e
				WHERE e.empno = i.empno;			

				-- citesc numele departamentului
				SELECT dname 
				INTO dept_name
				FROM dept d, emp e
				WHERE e.deptno = d.deptno
				AND e.empno = i.empno;

				-- citesc salariul si numele sefului
				SELECT m.sal, m.ename
				INTO mgr_sal, mgr_name
				FROM emp m
				WHERE i.mgr = m.empno;

				-- daca salariul e mai mare decat jumatate din venitul sefului il introduc in tabela
				IF ( emp_sal > mgr_sal / 2 ) 
					THEN dbms_output.put_line(RPAD(dept_name, 14, ' ')||RPAD(emp_name, 11, ' ')||RPAD(emp_hiredate, 18, ' ')||RPAD(mgr_name, 11, ' ')||RPAD(mgr_sal, 11, ' ')||RPAD(emp_sal, 11, ' ')||RPAD(emp_vechime, 11, ' '));
					-- INSERT INTO rezultat VALUES(dept_name, emp_name, emp_hiredate, mgr_name, mgr_sal, emp_sal, emp_vechime);
				END IF;	

			END IF;
		END LOOP;
END;
/