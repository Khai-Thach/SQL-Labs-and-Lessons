--Lab 4

--Khai Thach

--Q1
select count(order_id) "ORDER_COUNT", sum(tax_amount) "TAX_TOTAL"
from orders_mgs;

--Q2
select distinct category_name,
    count(product_name) as PRODUCT_COUNT,
    max(list_price) as MOST_EXPENSIVE_PRODUCT
from categories_mgs c join products_mgs p
    on c.category_id = p.category_id
group by category_name
order by PRODUCT_COUNT desc;

--Q3
select c.email_address,
    sum(oi.item_price * oi.quantity) as ITEM_PRICE_TOTAL,
    sum(oi.discount_amount * oi.quantity) as DISCOUNT_AMOUNT_TOTAL
from customers_mgs c join orders_mgs o
    on (c.customer_id = o.customer_id)
join order_items_mgs oi
    on (o.order_id = oi.order_id)
group by email_address
order by ITEM_PRICE_TOTAL desc;

--Q4
select c.email_address,
    count(distinct o.order_id) as ORDER_COUNT,
    sum((oi.item_price - oi.discount_amount) * oi.quantity) as ORDER_TOTAL
from customers_mgs c join orders_mgs o
    on (c.customer_id = o.customer_id)
join order_items_mgs oi
    on (o.order_id = oi.order_id)
group by c.email_address
having count(o.order_id) > 1
order by ORDER_TOTAL desc;

--Q5
select c.email_address,
    count(distinct o.order_id) as ORDER_COUNT,
    sum((oi.item_price - oi.discount_amount) * oi.quantity) as ORDER_TOTAL
from customers_mgs c join orders_mgs o
    on (c.customer_id = o.customer_id)
join order_items_mgs oi
    on (o.order_id = oi.order_id)
where oi.item_price > 400
group by c.email_address
having count(o.order_id) > 1
order by ORDER_TOTAL desc;

--Q6
select p.product_name,
    sum((oi.item_price - oi.discount_amount) * oi.quantity) as PRODUCT_TOTAL
from Products_mgs p join Order_Items_mgs oi 
    on (p.product_id = oi.product_id)
group by rollup(p.product_name)
order by p.product_name;

--Q7
select c.email_address,
    count(distinct oi.product_id) as NUMBER_OF_PRODUCTS
from Customers_mgs c join Orders_mgs o
    on (c.customer_id = o.customer_id)
join Order_Items_mgs oi
    on (o.order_id = oi.order_id)
group by c.email_address
having count(distinct oi.product_id) > 1
order by c.email_address asc;


--Q8
select 
    case when grouping(c.CATEGORY_NAME) = 1 then '========' 
         else c.CATEGORY_NAME 
    end as CATEGORY_NAME,
    
    case when grouping(p.PRODUCT_NAME) = 1 then '========' 
         else p.PRODUCT_NAME 
    end as PRODUCT_NAME,
    
    sum(OI.QUANTITY) as QTY_PURCHASED
    
from categories_mgs c
join products_mgs p
    on c.category_id = p.category_id
join order_items_mgs oi
    on p.product_id = oi.product_id
group by rollup(c.category_name, p.product_name);

--Q9
select order_id,
    (item_price - discount_amount) * quantity as ITEM_AMOUNT,
    sum((item_price - discount_amount) * quantity) 
        over (partition by order_id) as ORDER_AMOUNT
from order_items_mgs
order by order_id asc;

