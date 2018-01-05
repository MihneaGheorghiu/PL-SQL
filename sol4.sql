SELECT	temp.dname DEN_DEPT, temp.ename NUME, temp.hiredate DATA_ANG,
	TO_CHAR(temp.hiredate, 'MONTH') LUNA_PRIMA,
	temp.sal SALARIU, temp.comm COMISION, ROUND(temp.sal * 0.15) PRIMA
FROM (SELECT * FROM emp, dept WHERE emp.deptno = dept.deptno) temp
WHERE MONTHS_BETWEEN(sysdate, temp.hiredate) > 25 * 12
AND NVL(temp.comm, 0) = 0;
