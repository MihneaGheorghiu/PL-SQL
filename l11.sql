DROP TRIGGER trig_sal;

CREATE TRIGGER trig_sal AFTER DELETE OR INSERT OR UPDATE OF sal ON emp 
FOR EACH ROW

DECLARE 
	operatie varchar(8);
	sal_tot_dep number;
BEGIN
	IF DELETING THEN operatie := 'delete';
	END IF;
	IF INSERTING THEN operatie := 'insert';
	END IF;
	IF UPDATING THEN operatie := 'update';
	END IF;

	INSERT INTO log_mesg VALUES	(:new.ename, :old.sal, :new.sal, user, 
					to_char(sysdate, 'HH24:MI:SS'), operatie);

	SELECT total_sal INTO sal_tot_dep FROM total_dep WHERE dep = :new.deptno;	

	sal_tot_dep := sal_tot_dep - :old.sal + :new.sal;
	UPDATE total_dep SET total_sal = sal_tot_dep WHERE dep = :new.deptno;

	EXCEPTION
		WHEN no_data_found THEN 
		INSERT INTO total_dep VALUES(:new.deptno, :new.sal);
END;
/