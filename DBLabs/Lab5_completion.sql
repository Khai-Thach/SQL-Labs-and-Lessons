--Lab 5

--Khai Thach

--Q1
select distinct category_name
from categories_mgs
where category_id in (select distinct category_id from products_mgs)
order by category_name;


--Q2
select product_name, list_price
from products_mgs
where list_price > (select avg(list_price) from products_mgs)
order by list_price desc;
   

--Q3
select category_name
from categories_mgs 
where not exists
(
    select *
    from products_mgs
    where products_mgs.category_id = categories_mgs.category_id
);
    

--Q4
select email_address, max(order_total) as MAX_ORDER_TOTAL
from 
(
    select c.email_address, o.order_id, sum(oi.quantity * (oi.item_price - oi.discount_amount)) as order_total
    from customers_mgs c join orders_mgs o
        on c.customer_id = o.customer_id
    join order_items_mgs oi
        on o.order_id = oi.order_id
    group by c.email_address, o.order_id
)
group by email_address;


--Q5
select product_name, discount_percent
from products_mgs
where discount_percent in
(
    select discount_percent
    from products_mgs
    group by discount_percent
    having count(*) = 1
)
order by product_name;


--Q6
select c.email_address, o.order_id, o.order_date
from customers_mgs c join orders_mgs o
    on c.customer_id = o.customer_id
where o.order_date =
(
    select min(order_date)
    from orders_mgs oo
    where oo.customer_id = o.customer_id
)
order by c.email_address;