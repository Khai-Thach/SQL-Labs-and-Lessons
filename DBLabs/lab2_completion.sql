--Lab 2

--Khai Thach

--Q1
select product_code, product_name, list_price, discount_percent
from products_mgs
order by list_price desc;

--Q2 
select last_name || ', ' || first_name as full_name
from customers_mgs
where last_name >= 'M'
order by last_name asc;

--Q3
select product_name, list_price, date_added 
from products_mgs
where list_price > 500 and list_price < 2000
order by date_added desc;

--Q4
select product_name, list_price, discount_percent, 
list_price * (discount_percent / 100) as discount_amount,
list_price - (list_price * (discount_percent / 100)) as discount_price
from products_mgs
order by discount_price desc
fetch first 5 rows only;

--Q5
select item_id, item_price, discount_amount, quantity,
item_price * quantity as price_total,
discount_amount * quantity as discount_total,
(item_price - discount_amount) * quantity as item_total
from order_items_mgs
where (item_price - discount_amount) * quantity > 500
order by item_total desc;

--Q6
select order_id, order_date, ship_date
from orders_mgs
where ship_date is NULL;

--Q7 
select sysdate as today_unformatted, to_char(sysdate, 'MM/DD/YYYY') as today_formatted
from dual;

--Q8
select 100 as price, .07 as tax_rate, 100 * .07 as tax_amount, 100 + (100 * .07) as total
from dual;


