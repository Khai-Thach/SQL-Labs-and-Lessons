--Lab 6

--Khai Thach

--Q1
insert into categories_mgs (category_id, category_name)
values (5, 'Brass');
commit;

select category_id, category_name
from categories_mgs
where category_id = 5;

--Q2
update categories_mgs
set category_name = 'Woodwinds'
where category_id = 5;

select category_id, category_name
from categories_mgs
where category_id = 5;

--Q3
delete from categories_mgs
where category_id = 5;

select category_id, category_name
from categories_mgs
where category_id = 5;

--Q4
insert into products_mgs (product_id, category_id, product_code,
                          product_name, description, list_price,
                          date_added)
values (11, 4, 'dgx_640', 'Yamaha DGX 640 88-Key Digital Piano', 
        'Long description to come', 799.99, sysdate);

select product_id, category_id, product_code, 
       product_name, description, list_price, date_added
from products_mgs
where category_id = 4;

--Q5
update products_mgs
set discount_percent = 35
where product_code = 'dgx_640';

select discount_percent
from products_mgs
where product_code = 'dgx_640';

--Q6
select category_id
from categories_mgs
where category_name = 'Keyboards';

delete from products_mgs
where category_id = 4;

delete from categories_mgs
where category_id = 4;

--Q7
insert into customers_mgs (customer_id, email_address, password,
                           first_name, last_name)
values (9, 'rick@raven.com', 'sesame', 'Rick', 'Raven');

select customer_id, email_address, password,
       first_name, last_name
from customers_mgs
where customer_id = 9;

--Q8
update customers_mgs
set password = 'secret'
where email_address = 'rick@raven.com';

select password
from customers_mgs
where email_address = 'rick@raven.com';

--Q9
update customers_mgs
set password = 'reset';

select password
from customers_mgs;

--Q10
rollback;