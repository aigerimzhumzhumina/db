create database lab8;
create table salesman (salesman_id integer, name varchar(50), city varchar(50), commission float);
create table customers (customer_id integer, cust_name varchar(50), city varchar(50), grade integer, salesman_id integer);
create table orders (ord_id integer, purch_amt float, ord_date date, customer_id integer, salesman_id integer);
insert into salesman values
                         (5001,'James Hoog' ,'New York',0.15),
                         (5002, 'Nail Knite', 'Paris',0.13),
                         (5005, 'Pit Alex','London',0.11),
                         (5006,'Mc Lyon','Paris',0.14),
                         (5003,'Lauson Hen',default,0.12),
                         (5007, 'Paul Adam','Rome',0.13);
insert into customers values
                            (3002, 'Nick Rimando', 'New York', 100, 5001),
                            (3005, 'Graham Zusi', 'California', 200, 5002),
                            (3001, 'Brad Guzan', 'London',  default, 5005),
                            (3004, 'Fabian Johns', 'Paris', 300, 5006),
                            (3007, 'Brad Davis', 'New York', 200, 5001),
                            (3009,'Geoff Camero', 'Berlin', 100, 5003),
                            (3008, 'Julian Green', 'London', 300, 5002);
insert into orders values
                       (70001, 150.5,'2012-10-05', 3005, 5002),
                       (70009, 270.65, '2012-09-10', 3001, 5005),
                       (70002, 65.26, '2012-10-05', 3002, 5001),
                       (70004, 110.5, '2012-08-17', 3009, 5003),
                       (70007, 948.5, '2012-09-10', 3005, 5002),
                       (70005, 2400.6, '2012-07-27', 3007, 5001),
                       (70008, 5760, '2012-09-10', 3002, 5001);
create role junior_dev replication login;
create view s_new_york as select * from salesman where city = 'New York';
create view s_c_name as select
    o.ord_id,
    s.name,
    c.cust_name
from
    orders o
join
    salesman s
on
    o.salesman_id = s.salesman_id
join
    customers c
on
    o.customer_id = c.customer_id;
grant all on s_c_name to junior_dev;
create view highest_grade as select * from customers where grade = (select max(grade) from customers) ;
grant select on highest_grade to junior_dev;
create view num_of_s as select count(*) from salesman group by city;
create view more_than_1_cust as select *
                                from salesman
                                where salesman_id in
                                (select salesman_id from customers
                                group by salesman_id
                                having count(*)>1);
create role intern;
grant junior_dev to intern;