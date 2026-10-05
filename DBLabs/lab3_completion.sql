--Lab 3

--Khai Thach

--Q1
select category_name, product_name, list_price
from categories_mgs c join products_mgs p on (c.category_id = p.category_id)
order by category_name, product_name asc;
--Q2
select first_name, last_name, line1, city, state, zip_code
from customers_mgs c join addresses_mgs a on (c.customer_id = a.customer_id)
where email_address = 'allan.sherwood@yahoo.com';
--Q3
select first_name, last_name, line1, city, state, zip_code
from customers_mgs c join addresses_mgs a on (c.customer_id = a.customer_id)
where address_id = shipping_address_id;
--Q4
select last_name, first_name, order_date, 
product_name, item_price, discount_amount, quantity
from customers_mgs c join orders_mgs o on (c.customer_id = o.customer_id)
join order_items_mgs i on (i.order_id = o.order_id)
join products_mgs p on (p.product_id = i.product_id)
order by last_name, order_date, product_name asc;
--Q5
select distinct p.product_name, p.list_price
from products_mgs p join products_mgs m on (p.list_price = m.list_price) 
and p.product_id <> m.product_id
order by product_name asc;
--Q6
select category_name, product_id
from categories_mgs c left join products_mgs p on (c.category_id = p.category_id)
where product_id is null;
--Q7
select 'SHIPPED' as ship_status, order_id, order_date
from orders_mgs
where ship_date is not null
union
select 'NOT SHIPPED' as ship_status, order_id, order_date
from orders_mgs
where ship_date is null
order by order_date asc;