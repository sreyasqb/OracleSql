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
select emp_name,designation,project_domain from employeeagi order by emp_name,designation,project_domain;
--12
select project_domain,sum(salary) as sum,avg(salary) as average from employeeagi group by project_domain;
--13
select dept_name from employeeagi e inner join departmentagi d on d.dept_id=e.dept where e.designation='Project Leader';
--14
select emp_name,dob from employeeagi where extract(month from dob)=4;
--15
select * from employeeagi where dob=(select min(dob) from employeeagi);
--17
select emp_name from employeeagi e inner join departmentagi d on d.dept_id=e.dept where (e.salary between 2500 and 18000 and d.dept_name='IT');
--18
select extract(year from current_date)-extract(year from min(dob))-1900 as oldest_age from employeeagi;
--19
select empid,emp_name from employeeagi where mobile_no is null;
--20
select gender,avg(extract(year from current_date)-extract(year from dob)-1900) as average from employeeagi group by gender;
--21
select emp_name from employeeagi where extract(month from dob)=extract(month from current_date);
--22
select emp_name from employeeagi where (designation='System Analyst' or designation='Project Leader') and extract(year from doj)<91;
--23
select count(*) as female_count from employeeagi where (gender='F' and extract(year from current_date)-extract(year from dob)-1900>10);
--24
select * from employeeagi where extract(month from dob) not in (3,10);
-25
select emp_name,dept_loc,mobile_no from employeeagi e inner join departmentagi d on d.dept_id=e.dept order by  dob; 
--26
select round(avg(salary),2) as avg_sal,max(salary) as max_sal,min(salary) as min_sal from employeeagi where salary>1000;
--27
select max(salary)-min(salary) as diff from employeeagi;
--28
select emp_name from employeeagi where length(emp_name)>=5;
--29
select unique(project_domain) from employeeagi;
--30
select * from (select count(*) as kids,project_domain from employeeagi group by project_domain order by kids ) where rownum<2;
--31
select emp_name from employeeagi where dob=(select min(dob) from employeeagi where extract(year from dob)=70 and gender='F');
--32
select * from (select count(extract(year from dob)) as kids,extract(year from dob) as year_no from employeeagi group by extract(year from dob) order by kids desc) where rownum<2;
--33
select * from (select count(extract(month from dob)) as kids,extract(month from dob) as month_no from employeeagi group by extract(month from dob) order by kids desc) where rownum<2;
--34
select emp_name from employeeagi where salary<(select avg(salary) from employeeagi where gender='F') and gender='M';
--35
select emp_name from employeeagi where salary>(select avg(salary) from employeeagi where gender='M') and gender='F';
--36
select unique(e1.emp_name),e1.salary from employeeagi e1 inner join employeeagi e2 on e1.salary=e2.salary where e1.empid!=e2.empid order by salary ;
--37
select min(salary) from (select emp_name,salary from employeeagi order by salary desc) where rownum<3;
--38
select emp_name from employeeagi where salary>any(select avg(salary) from employeeagi group by dept);
--39
select count(*) from employeeagi e inner join departmentagi d on d.dept_id=e.dept where 


