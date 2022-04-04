--creating the table
create table athletes(
  name varchar(25),
  short_name varchar(20),
  gender char,
  birth_date date,
  birth_country varchar(20),
  country_code varchar(20),
  discipline_code varchar(20) ,
  residence_country varchar(20),
  height_m_ft number(10,2),
  url varchar(150) primary key,
  foreign key (country_code) references country(country_code),
  foreign key (discipline_code) references discipline(discipline_code)
);


--ALTER TABLE athletes MODIFY COLUMN url varchar(150); 

--creting country table
create table country(
  country_code varchar(20) primary key,
  country_name varchar(20)
);

create table discipline(
  discipline_code varchar(20) primary key,
  discipline_name varchar(20)
);


create table events(
  medal_type varchar(20),
  medal_date date,
  athlete_link varchar(150),
  event varchar(30),
  foreign key (athlete_link) references athletes(url),
  CONSTRAINT PK_Person PRIMARY KEY (event,athlete_link)
);



--QUESTION SET 1

--1
select name, height_m_ft from athletes where height_m_ft>1.67;
--2
select round(avg(extract(year from current_date)-extract(year from a.birth_date)),2) as average_ice_hockey_women from athletes a inner join discipline d on a.discipline_code= d.discipline_code where gender='Female';
--3
select count(discipline_code),gender, discipline_code from athletes group by discipline_code, gender order by discipline_code;
--4
select a.name,a.short_name, a.residence_country, a.birth_country from athletes a inner join events e on a.url=e.athlete_link where a.birth_country!= a.residence_country;
--5
select c.country_code,c.country_name,i.total,i.medal_type from country c inner join (select count(e.medal_type) as total,e.medal_type,i.country_code from events e inner join(select a.country_code,a.url,i.total from athletes a inner join (select * from (select count(*) as total,a.country_code from athletes a inner join events e on a.url=e.athlete_link group by a.country_code order by total desc) i where rownum<4) i on a.country_code=i.country_code) i on e.athlete_link=i.url group by i.country_code, e.medal_type order by i.country_code) i on c.country_code=i.country_code;
--6
select country_name from country c inner join (select * from (select count(*) as total,country_code from (select DISTINCT a.country_code, a.discipline_code from athletes a inner join discipline d on a.discipline_code= d.discipline_code ) group by country_code) where total=(select count(*) from discipline)) i on i.country_code= c.country_code ;
--7
select distinct a.name, extract(year from current_date)-extract(year from a.birth_date) as age, a.residence_country,a.birth_country,total from athletes a inner join (select count(e.medal_type) as total,a.name from athletes a inner join events e on e.athlete_link=a.url group by a.name,e.medal_type) i on a.name=i.name where a.country_code in ('FRA','GER','CRO','BIH') order by a.name;
--8
--ALL THE ATHLETES WHO HAVE WON GREATER THAN OR EQUAL TO 2 MEDALS AND HAVING BIRTHDAY IN THIS MONTH
select distinct a.name,i.total,a.birth_date from athletes a inner join (select count(e.medal_type) as total,a.name from athletes a inner join events e on e.athlete_link=a.url group by a.name,e.medal_type having count(e.medal_type)>=2) i on a.name=i.name where extract(month from a.birth_date)=extract(month from current_date);

--9
alter table discipline add rank char;
update discipline set rank='O' where discipline_code in (select discipline_code from (select count(*) as total, discipline_code from athletes group by discipline_code having count(discipline_code)>30));

alter table discipline add rank char;
update discipline set rank='A' where discipline_code in (select discipline_code from (select count(*) as total, discipline_code from athletes group by discipline_code having count(discipline_code) between 20 and 30));

alter table discipline add rank char;
update discipline set rank='B' where discipline_code in (select discipline_code from (select count(*) as total, discipline_code from athletes group by discipline_code having count(discipline_code) between 10 and 20));

alter table discipline add rank char;
update discipline set rank='C' where discipline_code in (select discipline_code from (select count(*) as total, discipline_code from athletes group by discipline_code having count(discipline_code) between 0 and 10));
