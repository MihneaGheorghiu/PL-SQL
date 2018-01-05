undefine nume,
DECLARE
	id_ang 		number(4);
	functie_ang	varchar2(30);
	data_ang	date;

BEGIN
	select empno into id_ang from emp where ename='&&nume';
	BEGIN
		select job,hiredate into functie_ang, data_ang from emp
			where empno = id_ang;
		insert into messages values(id_ang||'-'||functie_ang,to_char(data_ang));
	END;
	EXCEPTION
		WHEN no_data_found THEN
			insert into error_tab values('&nume'||' - angajat inexistent');
		WHEN too_many_rows THEN
			insert into error_tab values('&nume'||' - prea multi');
		WHEN others THEN
			insert into error_tab values('&nume'||' - ident eronata');
END;
/
