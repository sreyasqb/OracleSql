create table supplier(
  sno integer primary key,
  sname varchar(30),
  status integer,
  city varchar(30),
  constraint sname  check(initcap(sname)=sname),
  constraint cname  check(initcap(city)=city),
  constraint statuscheck check(mod(status,10)=0)
  
);
create table part(
  pno integer primary key,
  pname varchar(30),
  color varchar(30),
  weight number(10,2),
  city varchar(30),
  constraint paname  check(initcap(pname)=pname),
  constraint colname  check(initcap(color)=color),
  constraint caname  check(initcap(city)=city)
  
);
create table shipment(
  sno integer ,
  pno integer ,
  qty integer,
  price number(10,8),
  foreign key (sno) references supplier(sno),
  foreign key (pno) references part(pno),
  constraint pricecheck check(qty<1000),
  primary key(sno,pno)
);

drop table shipment;

--supplier
insert into supplier values (1,'Smith',20,'London');
insert into supplier values (2,'Jones',10,'Paris');
insert into supplier values (3,'Blake',30,'Paris');
insert into supplier values (4,'Clark',20,'London');
insert into supplier values (5,'Adams',30,NULL);
--part
insert into part values (1,'Nut','Red',12,'London');
insert into part values (2,'Bolt','Green',17,'Paris');
insert into part values (3,'Screw',NULL,17,'Rome');
insert into part values (4,'Screw','Red',14,'London');
insert into part values (5,'Cam','Blue',12,'Paris');
insert into part values (6,'Cog','Red',19,'London');
--shipment

insert into shipment values (1,1,300,0.005);
insert into shipment values (1,2,200,0.009);
insert into shipment values (1,3,400,0.004);
insert into shipment values (1,4,200,0.009);
insert into shipment values (1,5,100,0.01);
insert into shipment values (1,6,100,0.01);
insert into shipment values (2,1,300,0.006);
insert into shipment values (2,2,400,0.004);
insert into shipment values (3,2,200,0.009);
insert into shipment values (3,3,300,NULL);
insert into shipment values (4,2,200,0.008);
insert into shipment values (4,3,null,null);
insert into shipment values (4,4,300,0.006);
insert into shipment values (4,5,400,0.003);

--questions

--1
select * from shipment ship inner join part p on ship.pno=p.pno where sno=2;
--2
select p.pname,p2.pname,p.color from part p2 inner join part p on p2.color=p.color where p.pno!=p2.pno;
--3
select s1.sname,s2.sname,s1.city from supplier s1 inner join supplier s2 on s2.city=s1.city where  s1.sno!=s2.sno;
--4
select * from supplier where city!='Paris';
--5
select sno as sales_guy from shipment group by sno having count(pno)= (select count(*) from part);
--6
select * from shipment where qty between 300 and 750;
--7
select distinct p.pname from shipment ship inner join part p on ship.pno=p.pno where ship.qty between 200 and 750;
--8
select unique(sup.sname) from shipment ship inner join supplier sup on ship.sno=sup.sno where ship.pno=2 or ship.pno=4 ;
--9
select pno from shipment where sno=3;
--select * from shipment where sno = all(select pno from shipment where sno=3);
--10
select distinct(sno) from shipment ship inner join part p on ship.pno=p.pno where color='Red';
--11
select distinct pname from (select count(*) as count_no,pno as part_no from shipment ship group by pno having(count(*))>2) p INNER JOIN part s ON s.pno = p.part_no;
--select count(*) as count_no,pno as part_no from shipment ship group by pno having(count(*))>2;
--12
select sno,sname from supplier where sno not in (select ship.sno from shipment ship inner join part p on p.pno=ship.pno where color='Red');
--13
--select * from shipment ship inner join part p on ship.pno=p.pno ;
--select * from supplier ;
--14
select * from supplier where sno not in (select distinct sno from shipment);
--15
select distinct(sno) from shipment where pno in (select pno from shipment where sno=2) and sno!=2;
--16
select p.pname from shipment sh inner join part p on sh.pno=p.pno where sno=(select sno from supplier where sname='Blake') ;
--17
select * from shipment where not price is null order by price desc;
--18
select * from supplier where city in (select city from supplier where sno=1) and sno!=1;
--19

select pno from shipment group by pno having count(pno)>1;
--20
select sno from supplier where status<(select avg(status) from supplier);
--21
select count(sno) as count_no from supplier;
--22
select count(unique(sno)) as count_no from shipment;

--23
select s.sname,p.pname from shipment sh inner join part p on sh.pno=p.pno inner join supplier s on s.sno=sh.sno where price/qty =(select max(price/qty) from shipment); 
--24
select s.sname,sa.max_price,s.sno from (select max(price) as max_price,sno from shipment group by sno order by max_price desc) sa inner join supplier s on s.sno=sa.sno where rownum<3;
--25
select s.*,sa.total from (select sno,sum(price*qty) as total from shipment group by sno order by total desc) sa inner join supplier s on sa.sno=s.sno where rownum<2;
--26
select sno,count(pno) as cpno from shipment group by sno;
--27
select s.sname,s.sno,s.status from (select sno,sum(qty) as sum_qty from shipment group by sno having sum(qty)=1300) sa inner join supplier s on sa.sno=s.sno;
--28
--doesnt make sense question
--29

delete from part where pno=(select pno from (select pno,count(*) as number_parts from shipment group by pno order by number_parts) where rownum<2);
--30
update supplier set status=50 where sno=(select sno from (select sno,sum(qty*price) as total from shipment group by sno order by total desc) where rownum<2);
--31
CREATE VIEW viewpart AS SELECT p.* FROM part p inner join shipment sh on p.pno=sh.pno;



