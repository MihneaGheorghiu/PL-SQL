DECLARE
	CURSOR c1 IS 
		SELECT ename, sal ,MONTHS_BETWEEN(SYSDATE,hiredate) vechime,deptno
		FROM emp E
		WHERE E.sal=(SELECT MAX(sal) 
					 FROM emp
					 where deptno=E.deptno); --alegem doar pe cei care au saalariul cel mai mare din departament
					 
	CURSOR c2 IS 
		SELECT nume_ang, nume_departament ,venit,luni_vechime
		FROM rezultat E
		WHERE E.luni_vechime=(SELECT MAX(luni_vechime) 
					 FROM rezultat
					 WHERE nume_departament=E.nume_departament); --alegem doar pe cel care are vechimea cea mai mare 
		
	angaj		c1%ROWTYPE;
	angaj2		c2%ROWTYPE;
	nume_d		VARCHAR2(20);
	
BEGIN

	DELETE FROM message;
	
	OPEN c1;
	
	LOOP
			FETCH c1 INTO angaj;
			EXIT WHEN c1%NOTFOUND;
		
			SELECT dname 
			INTO nume_d 
			FROM dept 
			WHERE deptno = angaj.deptno; -- numele departamentului
			
			INSERT INTO rezultat values ( nume_d, angaj.ename, angaj.sal, angaj.vechime );
			
	END LOOP;
	
	CLOSE c1;
	
	open c2;
	
	LOOP
			FETCH c2 INTO angaj2;
			EXIT WHEN c2%NOTFOUND;
			
			INSERT INTO message values (angaj2.nume_departament, angaj2.nume_ang, angaj2.venit, angaj2.luni_vechime );
	END LOOP;
	
	--DELETE FROM rezultat; --sterg tabela provizorie
	
	COMMIT;
	
END;
/