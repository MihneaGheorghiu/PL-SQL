# sa se scr o procedura pl/sql care distribuie salariul sefului de departament sub forma de comision angajatilor din dept respectiv in functie de vechime.
#daca vechimea e < de 10 ani, toti angajatii primesc o cota parrte din 30% din salariul sefului. 
#daca vechimea e >= de 10 ani, suma distribuita tuturor angajatilor din categ e de 70% din salariul sefului.

#se vor data cel putin urm exceptii:"
#	- exista mai multi sefi intr-un dept ->suma distrib = suma salariilor acestor sefi
#	- exista sefi fara subalterni

#antetul liste:
#	denumire dept,	numar angajati,	nume sef, salariu sef, nume angajat, vechime angajat, comision primit

select * from emp where mgr = (select empno from emp where job = 'PRESIDENT') order by deptno;

select count(*) from emp where deptno = 10 and mgr = (select empno from emp where job = 'PRESIDENT');

select sum(sal) from emp where deptno = 10 and mgr = (select empno from emp where job = 'PRESIDENT');



select deptno from dept;

/*
DECLARE

  var_sef_sal emp.sal%TYPE;
  var_sef_nume emp.ename%TYPE;
  var_salariu emp.sal%TYPE;
  var_ang_no emp.enpno%TYPE
  var_ang_name emp.ename%TYPE



BEGIN

FOR dep IN ( select deptno from dept order by deptno)
LOOP

  select sum(sal) into var_salariu from emp where deptno = dep.deptno and mgr = (select empno from emp where job = 'PRESIDENT');   #salariul tuturor sefilor din acest departament


  FOR sef IN (select empno from emp where mgr = (select empno from emp where job = 'PRESIDENT') and deptno = dep.deptno order by deptno) #toti angajatii din dept Dept 
  LOOP
    select empno into var_ang_no , ename into var_ang_name from emp where mgr = sef.empno ;

    if months_between(sysdate,hiredate) < 10*12 then
    update emp 

    else
    end if;


  END LOOP;


END LOOP;


END;*/


DECLARE

  PROCEDURE calcul_comision (comm OUT NUMBER, angajat IN NUMBER) IS
    aa emp.hiredate%TYPE
    nr_ang NUMBER
salariul NUMBER
    BEGIN
      select sal into salariul from emp where empno  = ( select mgr  from emp where empno = angajat );

      select hiredate into aa from emp where empno = angajat;

      select count(*) into nr_ang from emp where empno = ( select mgr  from emp where empno = angajat );

      if months_between(sysdate,a) < 10*12 then 
         comm = salariul*0.3 / nr_ang;
      elsif
         comm = salariul*0.7 / nr_ang;
      end if;

    END;



  var_sef_sal emp.sal%TYPE;
  var_sef_nume emp.ename%TYPE;
  var_salariu emp.sal%TYPE;
  var_ang_no emp.enpno%TYPE
  var_ang_name emp.ename%TYPE

  comm NUMBER;

BEGIN

FOR dep IN ( select deptno from dept order by deptno)
LOOP

  FOR ang IN (select empno from emp where and deptno = dep.deptno #toti angajatii din dept Dept 
  LOOP

    calcul_comision(comm,);    

    select empno into var_ang_no , ename into var_ang_name from emp where mgr = sef.empno ;

    if months_between(sysdate,hiredate) < 10*12 then
    update emp 

    else
    end if;


  END LOOP;


END LOOP;


END;