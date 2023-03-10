-- using the chipotle database,
-- find how many times someone ordered a chicken or veggie bowl
-- with a quantity greater than 1

use chipotle;
select database();

show tables;

select *
from orders;

select quantity, item_name
from orders
where item_name in ('Chicken Bowl', 'Veggie Bowl')
	and quantity > 1
;
-- 35 rows

-- find all unique items with chicken
select distinct item_name
from orders
where item_name like '%chicken%'
;

select item_name -- cannot use * without providing an additional aggregate function, [think rectangle output]
from orders
where item_name like '%chicken%'
group by item_name
;

-- can group by multiple variables
-- find all unique combinations of items with chicken and their quantity
select item_name, quantity -- have to match
from orders
where item_name like '%chicken%'
group by item_name, quantity -- have to match
order by item_name
;

-- count & how many chicken bowls have been ordered?
select count(*), item_name
from orders
where item_name = 'Chicken Bowl'
;

-- for each chicken item, how many times was it ordered?
select distinct item_name, count(*)
from orders
where item_name like '%chicken%'
group by item_name
;

-- for each chicken item, how many items were actually sold?
select distinct item_name, sum(quantity)
from orders
where item_name like '%chicken%'
group by item_name
;

-- for each chicken item, what is the minimum, maximum, rounded average, sum, and count of order quantity
select distinct item_name, min(quantity), max(quantity), round(avg(quantity),1), sum(quantity), count(*)
from orders
where item_name like '%chicken%'
group by item_name
;

-- find all order items that have been ordered over 100 times
-- 1. group all items 2. get the count of each item_name 3. filter by counts greater than 100(having) 4. limit to top 5
select item_name, sum(quantity) as total_orders
from orders
group by item_name
having total_orders > 100
order by total_orders desc
limit 5
;


