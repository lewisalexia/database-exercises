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