-- RECAP from basic statements
use numbers;
select database();

-- show me categories for only supergroup one and rename

-- 2. write basic query and run (SELECE * FROM table)
-- 2. use the WHERE to filter your rows
-- 3. Go back to the SELECT and enter in the columns that you want

SELECT category as supergroup_one_category, supergroup
from numbers2
where supergroup = 'one'
;


