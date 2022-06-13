set serveroutput on;

q1 
create or replace trigger q1 before delete on actor for each row
declare
    c integer:=0;
begin
    
end;

delete from actor where act_id=117;





--q2
--create or replace trigger q2 before insert on movie for each row
--declare 
--    c integer;
--begin
--    select count(*) into c from movie where mov_year= :new.mov_year;
----    dbms_output.put_line(c);
--    if (c>5) then
--        raise_application_error(-20111,'Movie Limit Exceeded');
--    else
--        dbms_output.put_line('INSERTION SUCCESSFULL');
--    end if;
--end;

--select mov_year,count(*) as count from movie group by mov_year;
--insert into movie values ('1000','SREYAS MOVIE',1997,'Kannada');
--delete from movie where mov_id='1000';

--q3 
--create or replace trigger q3 before insert on movie_cast for each row
--declare
--    mc integer:=0;
--    fc integer:=0;
--    g actor.act_gender%type;
--    cursor c is select act_id from movie_cast where mov_id= :new.mov_id;
--begin
--    for n in c loop
--        select act_gender into g from actor where act_id=n.act_id;
--        if ( g='M') then
--            mc:=mc+1;
--        elsif (g='F') then
--            fc:=fc+1;
--        end if;
--        
--        if (mc>1) then
--            raise_application_error(-20111,'MALE COUNT EXCEEDED : '|| mc);
--        elsif (fc>1) then
--            raise_application_error(-20111,'FEMALE COUNT EXCEEDED : '|| fc);
--        end if;  
--    end loop;
--    dbms_output.put_line('INSERTION SUCCESFULL');
--end;

--insert into movie_cast values (107,904,'RACHEL');
--delete from movie_cast where role='COOL BRO';
--select count(*),mov_id from movie_cast group by mov_id;
--select * from movie_cast where mov_id=904;


--q4
--create or replace trigger q4 before insert on movie_cast for each row
--declare
--    cursor c is select mov_id from movie_cast where act_id= :new.act_id; 
--    nec integer:=0;
--    i integer:=0;
--    lang movie.mov_lang%type;
--begin
--    for n in c loop
--        i:=i+1;
--        dbms_output.put_line(n.mov_id);
--        select mov_lang into lang from movie where mov_id=n.mov_id;
--        dbms_output.put_line(lang);
--        if (lang='English') then
--            exit;
--            dbms_output.put_line(n.mov_id);
--        else
--            nec:=nec+1;
--        end if;
--    end loop;
--    if (i=nec) then
--        raise_application_error(-20111,'ENGLISH ROLE DOESNT EXIST ');
--    else
--        dbms_output.put_line('SUCCESFULL');
--    end if;
--    
----    select count(*) into c from 
--end;
--
--insert into movie_cast values (101,901,'COOL BRO');
--delete from movie_cast where role='COOL BRO';
--select * from movie_cast where mov_id=901;





--q5

--create or replace trigger q5 before insert on movie for each row
--declare
--    ec integer;
--    nec integer;
--begin
--    select count(*) into ec from movie where mov_lang='English' and mov_year= :new.mov_year;
--    select count(*) into nec from movie where mov_lang!='English' and mov_year= :new.mov_year;
--    if ( :new.mov_lang!='English' and nec+1>ec) then
--        raise_application_error(-20111,'no of english languages are less, English: ' || ec || 'Non English : ' || nec+1);
--    else
--        dbms_output.put_line('INSERTION SUCCESFULL');
--    end if;
--end;
--
--insert into movie values ('1001','SREYAS MOVIE3',1994,'TAMIL');
--select count(*),mov_lang from movie where mov_year=1994 group by mov_lang;

--select count(*) from movie where mov_year=1994 and mov_lang='English';
--select count(*) from movie where mov_year=1994 and mov_lang!='English';




