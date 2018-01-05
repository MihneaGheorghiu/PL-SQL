undefine id_dep,
DECLARE
	den_depart	varchar2(30);
	com_max		number(7,2);
BEGIN
	select max(nvl(comm,0)) into com_max from emp where deptno = &&id_dep;
	select dname into den_depart from dept where deptno = &id_dep;
	DECLARE
		nume_ang	varchar2(20);
		data_ang	date;
	BEGIN
		select ename, hiredate into nume_ang, data_ang from emp
			where deptno = &id_dep and nvl(comm,0) = com_max;
		dbms_output.put_line('Angajatul '||nume_ang||' angajat la '||data_ang||
					' in departamentul '||den_depart||
					' are comisionul '||com_max);
		EXCEPTION
			WHEN no_data_found THEN
				dbms_output.put_line('Nu exista angajat cu comision maxim');
			WHEN too_many_rows THEN
				dbms_output.put_line('Prea multi cu comision maxim');
	END;
	EXCEPTION
		WHEN no_data_found THEN
			dbms_output.put_line('Nu exista departamentul '||&id_dep);
END;
/
