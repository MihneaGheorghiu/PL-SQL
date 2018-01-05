create or replace function employes (depart in number) return number as
nr number;
begin
	select count(empno) into nr from emp where deptno=depart and
	empno not in (select empno from emp where upper(job)='MANAGER');
	return nr;
end employes;

declare
no_emp number;
name emp.ename%type;
dep emp.deptno%type;
begin
	for i in (select empno from emp where upper(job)='MANAGER')
	loop
		select ename, deptno into name, dep from emp where empno=i.empno;
		no_emp:=employes(dep);
		dbms_output.put_line('Employes for manager '||name||' = '||no_emp);
	end loop;
end;