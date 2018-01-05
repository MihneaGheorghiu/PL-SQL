CREATE TABLE comisioane (den_depart varchar2(15), nume_sef
 varchar2(14),
	sal_sef number, nume_ang varchar2(14), comision_primit number);

DECLARE

PROCEDURE proc (sef IN number,nume_sef IN char) IS
   
   nr_ang_1 number;
   nr_ang_2 number;
   vechime number;
   sal_sef number;
   nume_ang emp.ename%type;
   comision number;	
   dendep varchar2(15);
   BEGIN
	nr_ang_1:=0;
	nr_ang_2:=0;
	for i in 
	   (select empno, (floor((months_between(sysdate,hiredate))/12))
 vechime from emp where mgr=sef)
	loop
	   vechime:=i.vechime;
	   if vechime <10 then
		nr_ang_1:=nr_ang_1+1;
	   else 
		nr_ang_2:=nr_ang_2+1;
	   END if; 
	END loop;

	select sal into sal_sef from emp where empno=sef;

	
	for i in
	  (select empno,ename,(floor((months_between(sysdate,hiredate))/12))
 vechime,deptno from emp where mgr=sef)
	  loop
	      nume_ang:=i.ename;
	      vechime:=i.vechime;
		  select dname into dendep from dept where deptno = i.deptno;
	      
		if vechime<10 then
			comision:=(30/100 * sal_sef)/nr_ang_1;
	      		insert into comisioane
 (den_depart,nume_sef,sal_sef,nume_ang,comision_primit)
				values (dendep,nume_sef,sal_sef,nume_ang,comision);
		else 
			comision:=(70/100 * sal_sef)/nr_ang_2;
	      		insert into comisioane
 (den_depart,nume_sef,sal_sef,nume_ang,comision_primit)
				values (dendep,nume_sef,sal_sef,nume_ang,comision);
		end if;	
	   end loop;
   END;
BEGIN
DECLARE
	id_dept 		emp.deptno%type;
	den_dept 		dept.dname%type;
	nume_sef		emp.ename%type;
	sal_sef			emp.sal%type;
	nume_ang		emp.sal%type;	
	vechime_ang		number(3);
	comision_primit		emp.comm%type;
	empno_sef 		emp.empno%type;

	mai_multi_sefi 		exception;
	sef_fara_subaltern	exception;
BEGIN
	for i in
	
	(select distinct a.empno,a.ename from emp a,emp b 
	where a.empno=b.mgr)

	loop
		empno_sef := i.empno;
		nume_sef:=i.ename;
		
		BEGIN
			proc (empno_sef,nume_sef);
	
		END;
	END loop;
	
END;
END;
/
select * from comisioane;
drop TABLE comisioane;