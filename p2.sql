set serveroutput on,
undefine ecuson,
DECLARE
	nume_ang 	varchar2(20);
	den_depart	varchar2(30);
	salariu		number;
	data_ang	date;

BEGIN
	select a.ename, a.sal, a.hiredate, b.dname 
		into nume_ang, salariu, data_ang, den_depart from emp a, dept b
		where a.empno = &&ecuson and a.deptno = b.deptno;
	dbms_output.put_line('Angajatul '||nume_ang||' angajat in '||data_ang||
				' are salariul '||salariu);
	EXCEPTION
		WHEN no_data_found THEN
			dbms_output.put_line('Nu exista');
		WHEN too_many_rows THEN
			dbms_output.put_line('Prea multi');
		WHEN others THEN
			dbms_output.put_line('Eroare de selectie');
END;
/
