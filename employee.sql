create table employee (
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
alter table employee add primary key(empid);
alter table employee add constraint empid check(regexp_like(empid,'PSG[0-9]{3}'));

--1b
alter table employee add unique(mobile_no);
alter table employee add constraint mno check(length(to_char(mobile_no))=10);
-- testing if it works
insert into employee(empid,mobile_no) values ('PSG900',1134567890);
insert into employee(empid,mobile_no) values ('PSG800',12234567890);

--1c
alter table employee add constraint sal check(salary between 60000 and 20000);

--1d
--alter table employee add constraint gen check(regexp_like(gender,'[M|F'))
alter table employee add constraint gen check(gender='M' or gender='F');

--1e
alter table employee add constraint age_check check(months_between(dob,doj)>300);

--1f
alter table employee modify(emp_name not null);
alter table employee modify(project_domain not null);
alter table employee add constraint emp_proj check(emp_name not LIKE '%[0-9]%' and project_domain not LIKE '%[0-9]%');

--1g
alter table employee add foreign key(dept) references department(dept_id);

--2a
create table department(
  dept_name varchar(20) primary key,
  dept_id number unique,
  dept_loc varchar(20) check(dept_loc not LIKE '%[0-9]%')
  
);

--alter table employee add constraint nodata check()

