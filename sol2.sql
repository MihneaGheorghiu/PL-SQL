SELECT 	a.deptno DEN_DEP, a.ename NUME, a.hiredate DATA_ANG, a.JOB,
	a.sal SALARIU, a.comm COMISION, 
	decode(a.comm, 0, 0.1*a.sal, 
		NULL, 0, 0.1*a.sal,
		(select max(sal) from emp where deptno == a.deptno)) PRIMA
FROM emp a;



-- scoate o lista de premiere dupa algoritmul:
-- ang care nu au primit comision primesc o prima de 10% din salariu
-- ceilalti primesc ca prima salariul max pe dept din care fac parte
-- managerii si presedintele nu primesc prima
