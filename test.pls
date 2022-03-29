SET SERVEROUTPUT ON;

DECLARE 
   message  varchar2(20):= 'Hello, World!'; 
   num1 INTEGER;
   num2 double PRECISION;
BEGIN 
  declare 
    message varchar(10):='agilam';
    begin
      dbms_output.put_line(message||'yupup');
    end;
  
END; 
