create table plecari
(denumire_dep varchar2(30),
nume varchar2(30),
sef_depart varchar2(30),
data_ang date,
concediu date);


insert into plecari(denumire_dep, nume, sef_depart, data_ang,concediu) values ('AAA','BBB','CCC',sysdate,sysdate);
	




set serveroutput on;

create or replace function sefff(data_ang in date) return date as
data date;
begin
	if months_between(sysdate, data_ang)/12<10 then data:=add_months(data_ang,11);
	else data:= add_months(data_ang,9);
	return data;
	end if;
end sefff;

create or replace function angajjj(data_ang in date) return date as
data date;
begin
	if months_between(sysdate, data_ang)/12<10 then data:=(data_ang,12);
	else data:= (data_ang,10);
	return data;
	end if;
end angajjj;

create or replace function esef(tag in number) return number as
t number;
begin
	t:=0;
	for i in(select empno, ename, mgr from emp)
	loop
		if i.mgr=tag then
			t:=1;
		end if;
	end loop;
	return t;
end esef;

create or replace function s(tag in number) return varchar2 as
nume varchar2(30);
begin
	nume:='gigi';
	for i in (select ename,empno from emp)
	loop
		if i.empno=tag then
			nume:=i.ename;
		end if;
	end loop;
	return nume;
end s;

declare
	name emp.ename%type;
	dep_name dept.dname%type;
	dep varchar2(30);
	data_ang date;
	plecare date;
	seful varchar2(30);
	x exception;

begin
	for i in(select empno,job,ename,mgr,hiredate from emp)
	loop
		select ename,deptno, hiredate into name, dep, data_ang from emp where empno=i.empno;
		
	/*	if i.job='' then raise x;
		end if;

		exception
		when x then dbms_output.put_line('Exceptie');*/

		if esef(i.empno)=1 then
			plecare:=sefff(data_ang);
			seful:=i.ename;
		else
			plecare:=angajjj(data_ang);
			seful:=s(i.mgr);
			
		end if;
	select dname into dep_name from dept where deptno=dep;
	
	insert into plecari(denumire_dep, nume, sef_depart, data_ang,concediu) 
		values (dep_name,name,seful,i.hiredate,plecare);


	end loop;
end;


