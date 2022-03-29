SET SERVEROUTPUT ON;

--declare
--  message varchar(20):='susa op';
--begin 
--  dbms_output.put_line(message || 'lessgoo');
--end;


--IF EXAMPLE
--declare 
--  sales number:=600;
--begin 
--  if sales>700 then
--    dbms_output.put_line(sales || ' is good');
--  end if;
--end;

--ELSE EXAMPLE
--declare 
--  sales number:=600;
--begin 
--  if sales>700 then
--    dbms_output.put_line(sales || ' is good');
--  else
--    dbms_output.put_line(sales || ' will not get you anywhere!');
--  end if;
--end;

--ELSIF EXAMPLE
--declare 
--  gender char:='M';
--  tax_rate number(2,2);
--begin 
--  if gender='M' then
--    tax_rate:=0.2;
--  elsif gender='F' then
--    tax_rate:=0.15;
--  else
--    tax_rate:=0.12;
--  end if;
--  dbms_output.put_line('tax rate for the employee is ' || tax_rate);
--end;


--Basic LOOP
--declare 
--  i int:=0;
--begin 
--  loop 
--    if i>10 then 
--      exit;
--    end if;
----    exit when i>10;
--      
--    dbms_output.put_line('i is ' || i);
--    i:=i+1;
--  end loop;
--end;


--FOR LOOP
--begin 
--  for i in 0..10 loop
--    dbms_output.put_line('i is ' || i);
--  end loop;
--end;

--WHILE LOOP
--declare 
--  i int:=0;
--begin
--  while i<=10 loop
--    dbms_output.put_line('i is ' || i);
--    i:=i+1;
--  end loop;
--end;


--IMPLICIT CURSOR
--declare 
--  total_rows int;
--begin
--  update tcsprac set pocket_money = pocket_money+500;
--  if sql%notfound then 
--    dbms_output.put_line('no customer selected');
--  elsif sql%found then 
--    total_rows:=sql%rowcount;
--    dbms_output.put_line('total lines is ' || total_rows);
--  end if;
--end;

--EXPLICIT CURSOR
--declare
--  r_no tcsprac.rno%type;
--  s_name tcsprac.sName%type; 
--  
--  cursor tcs_students is select rno,sname from tcsprac;
--begin 
--  open tcs_students;
--  loop 
--    fetch tcs_students into r_no, s_name;
--    exit when tcs_students%notfound;
--    dbms_output.put_line(r_no || s_name  );
--  end loop;
--  close tcs_students;
--end;


--basic procedure
--create or replace procedure greetings as
--begin
--  dbms_output.put_line('greetings world');
--end;
--execute greetings;

--procedure with parameters
--DECLARE 
--   a number; 
--   b number; 
--   c number;
--PROCEDURE findMin(x IN number, y IN number, z OUT number) IS 
--BEGIN 
--   IF x < y THEN 
--      z:= x; 
--   ELSE 
--      z:= y; 
--   END IF; 
--END;   
--BEGIN 
--   a:= 23; 
--   b:= 45; 
--   findMin(a, b, c); 
--   dbms_output.put_line(' Minimum     of (23, 45) : ' || c); 
--END;

--create or replace procedure student(rno in varchar,sname in varchar,pm in number,mot in number) is
--begin
--  insert into tcsprac values(rno,sname,pm,mot);
--end;

begin
  student('Tejas','20PT37',5000,92);
end;







