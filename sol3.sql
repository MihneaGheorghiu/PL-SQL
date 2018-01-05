SELECT 	dept.dname DEN_DEPT, emp.ename NUME, emp.hiredate DATA_ANG,
	TO_CHAR(ADD_MONTHS(TRUNC(sysdate, 'YEAR'), 12 - ROUND(MONTHS_BETWEEN(TRUNC(emp.hiredate, 'YEAR'), emp.hiredate) + 0.5)), 'MONTH') LUNA_PRIMA,
	emp.sal SALARIU, emp.comm COMISION, ROUND(emp.sal * 0.15) PRIMA
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND MONTHS_BETWEEN(sysdate, emp.hiredate) > 25 * 12
AND NVL(emp.comm, 0) = 0;
