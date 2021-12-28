--create table titanic (
--  first_name varchar(20),
--  last_name varchar(20),
--  gender CHAR(1),
--  age number(3),
--  class_no number(1),
--  fare number(5,2),
--  embarked varchar(20),
--  survived varchar(3)
--  
--);
--desc titanic;

--insert into titanic values ('Braund','Mr Owen Harris','M',22,3,7.25,'southamption','no');
--select * from titanic;

--extra chumma commands
select table_name from user_tables;

--somethin
alter table titanic add passenger_type varchar(20);
desc titanic;

update titanic set embarked='Cherbourg-Octeville'  where  embarked='Cherbourg';

update titanic set passenger_type= case fare when 0 then 'Crew' else 'passenger' end; 

--few extra constrains added by maam
alter table titanic add primary key (first_name);
--select first_name from titanic order by first_name;
alter table titanic add constraint fare check(fare<=600);--u can just do add check
--select fare from titanic where fare>300;
alter table titanic add check (gender='M' or gender='F');
alter table titanic add check (embarked is not NULL and last_name is not null and survived is not null);
alter table titanic add check (survived='yes' or survived='no');
alter table titanic add check (class_no between 1 and 3);

--select statements
--q1
select first_name,age,embarked,fare from titanic;
--q2
select last_name from titanic where passenger_type='passenger' and last_name like 'A%';
--q3
select * from titanic where age<10;
--q4
select first_name from titanic where embarked='Queenstown';
--q5
select first_name from titanic where gender='F' and embarked='Southampton' and survived='yes';
--q6
select first_name from titanic where age between 50 and 70;
--q7
select last_name from titanic where length(last_name)<7;
--q8
select first_name from titanic where class_no=1;
--q9
select count(survived) from titanic where survived='yes';
--q10
select count(case gender when 'M' then 1 else null end) as male_surviors,count(case gender when 'F' then 1 else null end) as female_survivors from titanic where  survived='yes' and passenger_type='passenger'  ;
--q11
select count(case gender when 'M' then 1 else null end) as male_surviors,count(case gender when 'F' then 1 else null end) as female_survivors from titanic where  survived='yes' and passenger_type='passenger' 
group by class_no order by count(case survived when 'yes' then 1 else null end) desc;
--q12
select max(fare)-min(fare) as fare_difference from titanic where fare!=0;
--q13
select count(case gender when 'M' then 1 else null end) as male ,count(case gender when 'F' then 1 else null end) as female from titanic where embarked='Southampton' and passenger_type='passenger';
--select count(gender) from titanic where embarked='Southampton' group by gender;

--q14
select min(fare) as least,max(fare) as highest,round(avg(fare),2) as average from titanic where embarked='Cherbourg-Octeville';

--q15
select last_name from titanic where age is null order by last_name;

--q16
select max(fare) as highest,min(fare) as least,sum(fare) as total,round(avg(fare),2) as average from titanic where fare!=0 group by class_no;

--q17
select class_no from titanic where passenger_type='passenger' group by class_no having count(class_no)>200;

--q18
select * from titanic where gender='F' and survived='yes' and age= (select min(age) from titanic);

--q19
select last_name,class_no,age from titanic where class_no=1 order by age;

--q20
select round(count(case when gender='M' and survived='no' then 1 else null end)/count(case when gender='M' then 1 else null end),2) as male_death_percent,round(count(case when gender='F' and survived='no' then 1 else null end)/count(case when gender='F' then 1 else null end),2) as female_death_percent from titanic;

--q21
select * from titanic where embarked='Queenstown' and gender='M' and age=(select min(age) from titanic where embarked='Queenstown' and gender='M');
select * from titanic where embarked='Queenstown' and gender='F' and age=(select max(age) from titanic where embarked='Queenstown' and gender='F');

--q22
select * from titanic ti where fare=(select max(fare) from titanic where class_no=ti.class_no group by class_no) order by class_no;
--not done

--q23
select max(embarked) from titanic where gender='F';

--q24
select class_no from titanic where passenger_type='passenger' group by class_no having count(class_no)>100;

--q25
select * from titanic ti where gender='M'  and age>(select max(age) from titanic where gender='F' and class_no=ti.class_no group by class_no) order by class_no;

--q26
select * from titanic order by embarked;

--q27
select * from (select count(gender) as women_power,gender from titanic where survived='yes'  group by gender order by count(gender) DESC) where rownum<2 ;

