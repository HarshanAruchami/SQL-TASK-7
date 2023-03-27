create table Student_details (student_id int primary key identity(1,1),student_name varchar(25),departmant varchar(25),score int)
insert into Student_details values('Hemanth','Bsc-It',500)
insert into Student_details values('Harshan','Bsc-It',490),('Sharon','Bsc-It',480),('Karthi','Bsc-Ct',495),('Siva Barath','BCA',450),('Hari','BCA',460),('Vasanth','BCA',490),('Vikram','BCA',478),('Rinita','Bsc-ct',460)
insert into Student_details values('Harita','Bsc-It',480),('Yamini','Bsc-Ct',478),('Harishmitha','BCA',496),('Srikanth','BCA',454),('Priyadharshan','Bsc-Ct',465),('Selva','BCA',492),('Dhanaprakash','Bsc-it',479),('Arun','BCA',461),('venkit','BCA',478),('Vignesh','BCA',455)
insert into Student_details values('DivyaPrakash','Bsc-It',498),('Raina','Bsc-It',480),('Dhana','Bsc-Ct',500),('Virat','BCA',550),('Balaji','BCA',465),('Ravi','BCA',490)

select * from Student_details

--a. Create a table with 25 records for various departments using the following details:
--studentid(pk), studentname, department, score
--1. Create a non-clustered index for department.
create index h_index on student_details (departmant)
exec sp_helpindex student_details
--2. Create a filtered index for department='BCA'
create index r_index on student_details (departmant) where departmant = 'BCA'
exec sp_helpindex student_details
--3. Create a view for students in BCA department.
create view stud_bca as select * from student_details where departmant = 'BCA'
select * from stud_bca
--4. Apply Rank() for all the students based on score.
select *  ,Rank() over(order by score desc) as Rank_ from Student_details
--5. Apply Dense_Rank() for students in each department based on score.
select * ,DENSE_RANK() over(partition by Departmant order by Score desc ) as DEPARTMENT_RANK from Student_details 

--b. Create 2 tables Manager(id(pk), name) and Employee(eid(pk),ename,mid(fk), department).
Create table Manager (id int primary key,name varchar(20))
create table Employee(eid int primary key, ename varchar (20),mid int references manager(id)) 
--table insertion
insert into Manager values(101,'jeya'),(102,'Harshan'),(103,'hemanth'),(104,'surya'),(105,'kumar')
insert into Employee  values (1,'nandha',101),(2,'ram',102),(3,'vinoth',103),(4,'shiva',104),(5,'vicky',105)
--select query for both the tables
select * from Manager
select * from Employee
--drop query for both the tables
drop table Manager
drop table Employee
--1. Create a complex view by retrieving the records from Manager and Employee table.
create view man_emp_tbl 
as select m.id,m.name,e.eid,e.ename 
from Manager as m 
inner join Employee as e 
on m.id=e.mid

select * from man_emp_tbl
drop view man_emp_tbl
--2. Show the working of 'on delete cascade on update set default' for the above tables
alter table Employee drop constraint [FK__Employee__mid__6774552F]--removing the foriegn key
alter table employee drop column mid
--performing the on delete cascade on update set default
alter table Employee add  mid int default 101 constraint FK__Employee__mid_del_cas_update_default foreign key (mid) references manager(id)on delete cascade on update set default 

delete from Manager where  id=101
update Manager set  id=101 where id=103
update manager set name='karthi' where id = 103
insert into manager values(103,'siva')
--truncation the table
truncate table employee
--on update set defatul checking
insert into employee (eid,ename) values (9,'david')
update manager set id=106 where id =104
update manager 
delete from manager where id=101
select * from Manager
select * from Employee   