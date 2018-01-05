1. un bloc pl/sql care contine cel putin o fctie ptr calculul de plecare in concediu dupa urm algoritm:
daca vechimea e mai mica de 10 ani si nu e sef pleaca in concediu la 12 luni de la angajare
vechime mai mica si e sef 11 luni
vechime mai mare > 10 ani dar nu e sef pleaca la 10 luni de la angajare in concediu
vechimea mai mare si e 10 ani pleaca la 9 luni de la angajare
den dep nume sef departament data angajare data concediu

CREATE OR REPLACE FUNCTION numar_ani(empno in number) return number as 
vechime number;
BEGIN
	SELECT (sysdate - e.hiredate) / 365 INTO vechime FROM emp e WHERE e.empno = empno;
	return vechime;
END numar_ani;

/

-- vechime number(2);
-- vechime := numar_ani(empno);