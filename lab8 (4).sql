set serveroutput on;

declare
CURSOR c1 IS select distinct deptno from emp;
CURSOR c2 (dep NUMBER) IS select empno, ename, sal from emp where deptno = dep;
dep dept.dname%type;
sal_mediu emp.sal%type;
prima emp.sal%type;
nume_ang emp.ename%type;

begin
	dbms_output.put_line(rpad('Departament',12)||' '||rpad('Sal mediu', 10)||' '||rpad('Nume angajat', 12)||' '||rpad('Salariu', 10)||' '||rpad('Prima',8));
	for i in c1
	loop
		--determin numele departamentului
		select dname into dep from dept where deptno = i.deptno;
		
		--determin salariul mediu pe departament
		select avg(sal) into sal_mediu from emp where deptno = i.deptno;
		
		for j in c2(i.deptno)
		loop
			if j.sal < sal_mediu then
				prima := 0.1 * j.sal;
			else 
				prima := 0.2 * j.sal;
			end if;
			dbms_output.put_line(rpad(dep,12)||' '||rpad(sal_mediu, 10)||' '||rpad(j.ename, 12)||' '||rpad(j.sal, 10)||' '||rpad(prima,8));
		end loop;
		
	end loop;
end;
/