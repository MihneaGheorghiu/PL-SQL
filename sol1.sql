--@E:\!!!!!!!!!!!!!\sol1

-- scoate o lista de premiere dupa algoritmul:
-- ang care nu au primit comision primesc o prima de 10% din salariu
-- ceilalti primesc ca prima salariul max pe dept din care fac parte
-- managerii si presedintele nu primesc prima


SELECT 	dept.dname DEN_DEPT, emp.ename NUME, emp.hiredate DATA_ANG,
	TO_CHAR(ADD_MONTHS(TRUNC(sysdate, 'YEAR'), ROUND(MONTHS_BETWEEN(emp.hiredate, TRUNC(emp.hiredate, 'YEAR')) + 0.5)), 'MONTH') LUNA_PRIMA,
	emp.sal SALARIU, emp.comm COMISION, ROUND(emp.sal * 0.15) PRIMA
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND MONTHS_BETWEEN(sysdate, emp.hiredate) > 25 * 12
AND NVL(emp.comm, 0) = 0;
