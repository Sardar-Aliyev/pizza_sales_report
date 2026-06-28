select * from pizza_sales;

--Total Revenue
select sum(total_price) as total_revenue from pizza_sales;

--Average Order Value
select sum(total_price)/ count(DISTINCT(order_id)) as avg_value_order from pizza_sales;

--Total Pizzas Sold
select sum(quantity) as total_pizza_sold from pizza_sales;

--. Total Orders
select count(DISTINCT(order_id)) as total_order from pizza_sales;

--Average Pizzas Per Order
select round(sum(quantity)/count(DISTINCT(order_id)),2) avg_pizza_per_order from pizza_sales;

--Daily Trend for Total Orders
select to_char(order_date,'day') as day,count(DISTINCT(order_id)) as order_count
from pizza_sales
group by  to_char(order_date,'day')
order by 2 desc;

select to_char(order_date,'mon') as day,count(DISTINCT(order_id)) as order_count
from pizza_sales
group by  to_char(order_date,'mon')
order by 2 desc

--Hourly Trend for Total Orders
SELECT to_char(to_timestamp(order_time,'HH24:MI:SS'),'HH24') AS order_hour,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY TO_CHAR(TO_TIMESTAMP(order_time,'HH24:MI:SS'),'HH24')
ORDER BY order_hour;

--% of Sales by Pizza Category
select pizza_category,sum(total_price) as total_price,round(sum(total_price)*100/(select sum(total_price) from pizza_sales),2) as pct
from pizza_sales
group by pizza_category;


--% of Size by Pizza Category
select pizza_size,round(sum(total_price),2) as total_price,round(sum(total_price)*100/(select sum(total_price) from pizza_sales),2) as pct
from pizza_sales
group by pizza_size
order by 3 desc;


--Total Pizzas Sold by Pizza Category
select pizza_category,sum(quantity) as total_quantity_byCategroy
from pizza_sales
group by pizza_category;


--top 5 pizza by revenue
select pizza_name,total_revenue,dr from (
select pizza_name,sum(total_price) as total_revenue,dense_rank () over (order by sum(total_price) desc) as dr
from pizza_sales
group by pizza_name)
where dr <=5;


--bottom 5 pizza by revenue
select pizza_name,total_revenue,dr from (
select pizza_name,sum(total_price) as total_revenue,dense_rank () over (order by sum(total_price) asc) as dr
from pizza_sales
group by pizza_name)
where dr <=5;


--top 5 pizza by quantity

select pizza_name,total_quantity,dr from (
select pizza_name,sum(quantity) as total_quantity,dense_rank () over (order by sum(quantity) desc) as dr
from pizza_sales
group by pizza_name)
where dr <=5;

-- top 5 pizza bu orders
select pizza_name,total_orders,dr from (
select pizza_name,count(distinct(order_id)) as total_orders,dense_rank () over (order by count(distinct(order_id)) desc) as dr
from pizza_sales
group by pizza_name)
where dr <=5;




