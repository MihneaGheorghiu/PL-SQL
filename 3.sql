create or replace function salar (emp_no in number, hiredate in date)
return number as
sal number;
begin
	select nvl(sal,0)+nvl(comm,0) into sal from emp where empno=emp_no;
	if months_between(sysdate,hiredate) < 60 then sal:=sal*1.1;
	elsif months_between(sysdate,hiredate) > 120 then sal:=sal*1.3;
	else sal:=sal*1.2;
	end if;
	return sal;
end salar;

declare
dep dept.dname%type;
empp emp.empno%type;
name emp.ename%type;
sal_tot number;
begin
for i in (select distinct empno, hiredate from emp)
	loop
	sal_tot:=round(salar(i.empno,i.hiredate));
	select a.dname,b.empno,b.ename into dep,empp, name from dept a, emp b
	where b.empno=i.empno and a.deptno=b.deptno;
	insert into salary(dname,empno,ename,sal)
		values(dep,empp,name,sal_tot);
	end loop;
end;

create table salary (dname varchar2(30), empno number, ename varchar2(30), sal number );