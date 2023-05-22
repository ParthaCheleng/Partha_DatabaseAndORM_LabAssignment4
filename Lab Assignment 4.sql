create database e_commerce;

use e_commerce;

drop table if exists supplier;
drop table if exists customer;
drop table if exists category;
drop table if exists product;
drop table if exists supplier_pricing;
drop table if exists orders;
drop table if exists rating;


-- Creation of tables for Question 1 --

create table supplier(
 supp_id int primary key,
 supp_name varchar(50) not null,
 supp_city varchar(50) not null,
 supp_phone varchar(50) not null
);

create table customer(
 cus_id int primary key,
 cus_name varchar(20) not null,
 cus_phone varchar(10) not null,
 cus_city varchar(30) not null,
 cus_gender char
);

create table category(
 cat_id int primary key,
 cat_name varchar(20) not null
);

create table product(
 pro_id int primary key,
 pro_name varchar(20) not null default "dummy",
 pro_desc varchar(60),
 cat_id int,
 foreign key(cat_id) references category(cat_id)
);

create table supplier_pricing(
 pricing_id int primary key,
 pro_id int,
 supp_id int,
 supp_price int default 0,
 
 foreign key(pro_id) references product(pro_id),
 foreign key(supp_id) references supplier(supp_id)
);

create table orders(
 ord_id int primary key,
 ord_amount int not null,
 ord_date date not null,
 cus_id int,
 pricing_id int,
 pro_id int,
 
 foreign key(pro_id) references product(pro_id),
 foreign key(cus_id) references customer(cus_id),
 foreign key(pricing_id) references supplier_pricing(pricing_id)
);

create table rating(
 rat_id int primary key,
 ord_id int,
 rat_ratstars int not null,
 
 foreign key(ord_id) references orders(ord_id)
);


-- Insertion of values for Question 2 --

insert into supplier values(1, 'Rajesh Retails', 'Delhi', 1234567890);
insert into supplier values(2, 'Appario Ltd.', 'Mumbai', 2589631470);
insert into supplier values(3, 'Knome products', 'Banglore', 9785462315);
insert into supplier values(4, 'Bansal Retails', 'Kochi', 8975463285);
insert into supplier values(5, 'Mittal Ltd.', 'Lucknow', 7898456532);

insert into customer values(1, 'AAKASH', 9999999999, 'DELHI', 'M');
insert into customer values(2, 'AMAN', 9785463215, 'NOIDA', 'M');
insert into customer values(3, 'NEHA', 9999999999, 'MUMBAI', 'F');
insert into customer values(4, 'MEGHA', 9994562399, 'KOLKATA', 'F');
insert into customer values(5, 'PULKIT', 7895999999, 'LUCKNOW', 'M');

insert into category values(1, 'BOOKS');
insert into category values(2, 'GAMES');
insert into category values(3, 'GROCERIES');
insert into category values(4, 'ELECTRONICS');
insert into category values(5, 'CLOTHES');

insert into product values(1, 'GTA V', 'Windows 7 and above with i5 processor and 8GB RAM', 2);
insert into product values(2, 'TSHIRT', 'SIZE-L with Black, Blue and White variations', 5);
insert into product values(3, 'ROG LAPTOP', 'Windows 10 with 15inch screen, i7 processor, 1TB SSD', 4);
insert into product values(4, 'OATS', 'Highly Nutritious from Nestle', 3);
insert into product values(5, 'HARRY POTTER', 'Best Collection of all time by J.K Rowling', 1);
insert into product values(6, 'MILK', '1L Toned MIlk', 3);
insert into product values(7, 'Boat Earphones', '1.5Meter long Dolby Atmos', 4);
insert into product values(8, 'Jeans', '1.5Meter long Dolby Atmos', 5);
insert into product values(9, 'Project IGI', 'compatible with windows 7 and above', 2);
insert into product values(10, 'Hoodie', 'Black GUCCI for 13 yrs and above', 5);
insert into product values(11, 'Rich Dad Poor Dad', 'Written by RObert Kiyosaki	', 1);
insert into product values(12, 'Train Your Brain', 'By Shireen Stephen	', 1);

insert into supplier_pricing values(1, 1, 2, 1500);
insert into supplier_pricing values(2, 3, 5, 30000);
insert into supplier_pricing values(3, 5, 1, 3000);
insert into supplier_pricing values(4, 2, 3, 2500 );
insert into supplier_pricing values(5, 4, 1, 1000);

insert into orders values(101,1500, '2021-10-06', 2, 1);
insert into orders values(102,1000, '2021-10-12', 3, 5);
insert into orders values(103,30000, '2021-09-16', 5, 2);
insert into orders values(104,1500, '2021-10-05', 1, 1);
insert into orders values(105,3000, '2021-08-16', 4, 3);
insert into orders values(109,3000, '2021-01-10', 5, 3);
insert into orders values(110,2500, '2021-09-10', 2, 4);
insert into orders values(111,1000, '2021-09-15', 4, 5);
insert into orders values(114,1000, '2021-09-16', 3, 5);
insert into orders values(115,3000, '2021-09-16', 5, 3);

insert into rating values(1,101, 4);
insert into rating values(2,102, 3);
insert into rating values(3,103, 1);
insert into rating values(4,104, 2);
insert into rating values(5,105, 4);
insert into rating values(6,109, 3);
insert into rating values(7,110, 5);
insert into rating values(8,111, 3);
insert into rating values(9,114, 1);
insert into rating values(10,115, 1);

-- Question 3 solution --

select count(t2.cus_gender) as totalCustomers, t2.cus_gender from
(select t1.cus_id,t1.cus_gender, t1.ord_amount, t1.cus_name from
(select orders.*, customer.cus_gender,customer.cus_name from orders inner join customer where orders.cus_id=customer.cus_id having
orders.ord_amount>=3000)
as t1 group by t1.cus_id) as t2 group by t2.cus_gender; 

-- Question 4 solution --

select product.pro_name, orders.* from orders, supplier_pricing, product where orders.cus_id=2 and orders.pricing_id=supplier_pricing.pricing_id and supplier_pricing.pro_id=product.pro_id;

-- Question 5 solution --

select supplier.* from supplier where supplier.supp_id in (select supp_id from supplier_pricing group by supp_id having count(supp_id)>1) group by supplier.supp_id;

-- Qustion 6 solution --

select category.cat_id, category.cat_name, min(t3.min_price) as Min_Price from category inner join
(select product.cat_id, product.pro_name, t2.* from product inner join 
(select pro_id, min(supp_price) as Min_Price from supplier_pricing group by pro_id)
 as t2 where t2.pro_id=product.pro_id)
 as t3 where t3.cat_id=category.cat_id group by t3.cat_id;
 
 -- Question 7 solution --
 
 select product.pro_id, product.pro_name from orders inner join supplier_pricing on supplier_pricing.pricing_id=orders.pricing_id inner join product
 on product.pro_id=supplier_pricing.pro_id where orders.ord_date>"2021-10-05";
 
 -- Question 8 solution --
 
 select customer.cus_name,customer.cus_gender from customer where customer.cus_name like 'A%' or customer.cus_name like '%A';
 
 -- Question 9 solution --

select S.SUPP_NAME, SP_RO_2.*,

CASE
	WHEN AverageRating = 5 THEN 'Excellent Service'
	WHEN AverageRating > 4 THEN 'Good Service'    
	WHEN AverageRating > 2 THEN 'Average Service'    
    ELSE 'Poor Service'
END As 'TypeOfService'
  from supplier S inner join (
select SUPP_ID, AVG(RAT_RATSTARS) as AverageRating from (
	select SP.SUPP_ID, RO.ORD_ID, RO.RAT_RATSTARS 
	from supplier_pricing SP inner join (
		select O.ORD_ID, O.PRICING_ID, R.RAT_RATSTARS from 
		orders O inner join Rating R ON
		O.ORD_ID = R.ORD_ID
	) as RO
	on SP.PRICING_ID = RO.PRICING_ID
) as SP_RO
group by supp_id
) as SP_RO_2
ON S.SUPP_ID = SP_RO_2.SUPP_ID;





