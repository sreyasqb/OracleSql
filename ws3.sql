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


