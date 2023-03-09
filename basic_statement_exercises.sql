use albums_db;
select database();
show create table albums;

SELECT name
from albums;
-- The column named name represents a variable character string up to 240 stating the album's name

select sales
from albums;
-- The sales column represents *likely millions of copies sold* with an unsigned float

select *
from albums
where artist = 'pink floyd';

show columns in albums;
select release_date, name
from albums
where name = "Sgt. Pepper's Lonely Hearts Club Band";

select genre, artist, name
from albums
where name = 'nevermind';

select release_date, name
from albums
where release_date between 1990 and 1999;

select sales, name
from albums
where sales < 20;