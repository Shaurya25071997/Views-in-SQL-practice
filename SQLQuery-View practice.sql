create database practice1

use practice1

create table salesman (salesman_id int, name varchar(100),  city varchar(100), commission float)

Insert into salesman values(5001, 'James Hoog',  'New York', 0.15)
Insert into salesman values(5002, 'Nail Knite',  'Paris', 0.13)
Insert into salesman values(5005, 'Pit Alex',  'London', 0.11)
Insert into salesman values(5006, 'Mc Lyon',  'Paris', 0.14)
Insert into salesman values(5007, 'Paul Adam',  'Rome', 0.13)
Insert into salesman values(5003, 'Lauson Hen',  'San Jose', 0.12)

create table customer (customer_id int, cust_name varchar(100),  city varchar(100), grade int, salesman_id int)

Insert into customer values(3002, 'Nick Rimando',  'New York', 100, 5001)
Insert into customer values(3007, 'Brad Davis',  'New York', 200, 5001)
Insert into customer values(3005, 'Graham Zusi',  'California', 200, 5002)
Insert into customer values(3008, 'Julia Green',  'London', 300, 5002)
Insert into customer values(3004, 'Fabian Johnson',  'Paris', 300, 5006)
Insert into customer values(3009, 'Geoff Cameron',  'Berlin', 100, 5003)
Insert into customer values(3003, 'Jozy Altidor',  'Moscow', 200, 5007)
Insert into customer values(3001, 'Brad Guzan',  'London', 400, 5005)

select * from customer

create table orders (ord_no int, purch_amt float,  ord_date date, customer_id int, salesman_id int)

Insert into orders values(70001, 150.5, '2012-10-05', 3005, 5002)
Insert into orders values(70009, 270.65, '2012-09-10', 3001, 5005)
Insert into orders values(70002, 65.26, '2012-10-05', 3002, 5001)
Insert into orders values(70004, 110.5, '2012-08-17', 3009, 5003)
Insert into orders values(70007, 948.5, '2012-09-10', 3005, 5002)
Insert into orders values(70005, 2400.6, '2012-07-27', 3007, 5001)
Insert into orders values(70008, 5760, '2012-09-10', 3002, 5001)
Insert into orders values(70010, 1983.43, '2012-10-10', 3004, 5006)
Insert into orders values(70003, 2480.4, '2012-10-10', 3009, 5003)
Insert into orders values(70012, 250.45, '2012-06-27', 3008, 5002)
Insert into orders values(70011, 75.29, '2012-08-17', 3008, 5002)
Insert into orders values(70013, 3045.6, '2012-04-25', 3002, 5001)

select * from orders


---------------From the following table, create a view for those salespeople who belong to the city of New York.--------------

select * from salesman

create view newyorksatff

as select * from salesman where city = 'New York'

select * from newyorksatff


---------------------From the following table, create a view for all salespersons. Return salesperson ID, name, and city.------------------

select * from salesman

create view salesown

as select salesman_id, name, city from salesman 

select * from salesown


---------- From the following table, create a view to locate the salespeople in the city 'New York'.--------------

select * from salesman

create view salespeople

as select * from salesman where city = 'New York'

select * from salespeople

-------------------------From the following table, create a view that counts the number of customers in each grade.----------------

select * from customer

create view gradecount(grade, number)

as select grade, count(*) from customer group by grade;

select * from gradecount

--------------------From the following table, create a view to count the number of unique customers, compute the average and the total purchase amount of customer orders by each date.-

select * from orders

create view eachdate

as select ord_date, count(distinct customer_id) as cust_id , avg(purch_amt) as cpurch, sum(purch_amt) as tpurch from orders group by ord_date

select * from eachdate


--------------From the following tables, create a view to get the salesperson and customer by name. Return order name, purchase amount, salesperson ID, name, customer name.-----------------

select * from salesman
select * from customer
select * from orders

create view nameorders

as select ord_no,purch_amt, a.salesman_id, name, cust_name from orders a, customer b, salesman c where a.customer_id = b.customer_id AND a.salesman_id = c.salesman_id


select * from nameorders

-------------------------------------From the following table, create a view to find the salesperson who handles a customer who makes the highest order of the day. Return order date, salesperson ID, name.----------------------
select * from salesman
select * from orders

create view elitesalesman

as select b.ord_date, a.salesman_id , a.name from salesman a, orders b where a.salesman_id = b.salesman_id and purch_amt = (select max(purch_amt) from orders c where c.ord_date = b.ord_date)

select * from elitesalesman


-------From the following table, create a view to find the salesperson who deals with the customer with the highest order at least three times per day. Return salesperson ID and name.------------

select * from customer
select * from salesman

alter view incentive

as select distinct salesman_id, name from elitesalesman a where 3 <= (select count(*) from elitesalesman b where a.salesman_id = b.salesman_id)

select * from incentive

------------From the following table, create a view to find all the customers who have the highest grade. Return all the fields of customer.----

select * from customer

create view highgrade

as select * from customer where grade = (select max(grade) from customer);

select * from highgrade;

-------------------------------From the following table, create a view to count the number of salespeople in each city. Return city, number of salespersons----------
select * from salesman

create view numbersalesperson

as select city, count(distinct salesman_id) as salesperson from salesman group by city;

select * from numbersalesperson

---- From the following table, create a view to compute the average purchase amount and total purchase amount for each salesperson. Return name, average purchase and total purchase amount. (Assume all names are unique.).-------

select * from salesman
select * from orders

create view norders
as select name, avg(purch_amt) as avgp_amt, sum(purch_amt) as sump__amt from salesman a , orders b where a.salesman_id = b.salesman_id group by name;

select * from norders

-----From the following table, create a view to identify salespeople who work with multiple clients. Return all the fields of salesperson.------


select * from salesman
select * from customer

create view salespeoples

as select * from salesman a where 1 < (select count(*) from customer b where a.salesman_id = b.salesman_id) 

select * from salespeoples

-----From the following table, create a view that shows all matching customers with salespeople, ensuring that at least one customer in the city of the customer is served by the salesperson in the city of the salesperson.------

create view citymatch(custcity, salescity)

as select distinct a.city , b.city from customer a , salesman b where a.salesman_id = b.salesman_id

select * from citymatch

----- From the following table, create a view to display the number of orders per day. Return order date and number of orders.------


select * from orders

alter view dateord(ord_date, odcount)

as select ord_date, count(*) from orders group by ord_date;

select * from dateord


-----------From the following table, create a view to find the salespeople who placed orders on October 10th, 2012. Return all the fields of salesperson.-----------

select * from salesman
select * from orders

create view salesmanoct

as select * from salesman where salesman_id in (select salesman_id from orders where ord_date = '2012-10-10');

select * from salesmanoct

----- From the following table, create a view to find the salespersons who issued orders on either August 17th, 2012 or October 10th, 2012. Return salesperson ID, order number and customer ID.-----

select * from orders


create view salesmonoctaug

as select salesman_id, customer_id, ord_no from orders where ord_date in('2012-08-17', '2012-10-10');

select * from salesmonoctaug














