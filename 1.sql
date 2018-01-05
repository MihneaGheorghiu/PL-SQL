set serveroutput on;

create or replace function status(credits in number) return varchar2 as
begin
	if credits=0 then return 'Inactive';
	elsif credits <=20 then return 'Part Time';
	else return 'Full Time';
	end if;
end status;

declare

stat varchar2(30);
begin
	stat:=status(&cred);
	dbms_output.put_line('Credit_type='||stat);
end;