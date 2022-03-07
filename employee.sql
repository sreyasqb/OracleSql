create table employeeagi (
  empid varchar(16),
  emp_name varchar(20),
  DOB date,
  DOJ date,
  gender varchar(1),
  salary number(10,2),
  designation varchar(10),
  project_domain varchar(20),
  mobile_no number(10),
  dept number(10)
);
--1a
alter table employeeagi add primary key(empid);
alter table employeeagi add constraint empid2 check(regexp_like(empid,'PSG[0-9]{3}'));

--1b
alter table employeeagi add unique(mobile_no);
alter table employeeagi add constraint mno2 check(length(to_char(mobile_no))=10);
-- testing if it works
insert into employeeagi(empid,mobile_no) values ('PSG900',1134567890);
insert into employeeagi(empid,mobile_no) values ('PSG800',12234567890);

--1c
alter table employeeagi add constraint sal3 check(salary between 60000 and 10000);
alter table employeeagi drop constraint sal2;

--1d
--alter table employeeagi add constraint gen check(regexp_like(gender,'[M|F'))
alter table employeeagi add constraint gen check(gender='M' or gender='F');

--1e
alter table employeeagi add constraint age_check2 check(months_between(dob,doj)>300);
alter table employeeagi drop constraint age_check;

--1f
alter table employeeagi modify(emp_name not null);
alter table employeeagi modify(project_domain not null);
alter table employeeagi add constraint emp_proj check(emp_name not LIKE '%[0-9]%' and project_domain not LIKE '%[0-9]%');

--1g
alter table employeeagi add foreign key(dept) references department(dept_id);

--2a
create table department(
  dept_name varchar(20) primary key,
  dept_id number unique,
  dept_loc varchar(20) check(dept_loc not LIKE '%[0-9]%')
  
);



--alter table employeeagi add constraint nodata check()
--3
--1
select empid,emp_name,salary from employeeagi where (project_domain='Banking');
--2
select count(empid) as programmers from employeeagi where (designation='Programmer');
--3
select designation,count(designation) from employeeagi group by designation order by count(designation);
--4
select dept_name,count(dept_name) from departmentagi group by dept_name;
select dept_name from departmentagi , empid from employeeagi;
select empid, dept_id from departmentagi , employeeagi;
--5
select count(*) as houstonkids from employeeagi e inner join departmentagi d on d.dept_id=e.dept where d.dept_loc='Houston';
--6
select empid,emp_name,0.05*salary as increased_sal from employeeagi order by increased_sal desc; 
--7
select count(empid) as mobileappkids from employeeagi where project_domain='MobileApp';
--8

--copy template
--select count(*) from employeeagi e inner join departmentagi d on d.dept_id=e.dept where 

select * from employeeagi e left join departmentagi d on d.dept_id=e.dept where d.dept_loc='Sugarland';

--9

select emp_name from employeeagi where salary=(select max(salary) as sal_max from employeeagi e inner join ( select project_domain,count(*) as members from employeeagi group by project_domain having count(*)>2) t on t.project_domain=e.project_domain);

--10

select emp_name from employeeagi where extract(month from doj)=(select month_no from (select count(extract(month from doj)) as kids,extract(month from doj) as month_no from employeeagi where designation='Programmer' group by extract(month from doj) order by kids desc) where rownum<2);

--11
