use albums_db;
select database();
show create table albums;
/* CREATE TABLE `albums` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `artist` varchar(240) DEFAULT NULL,
  `name` varchar(240) NOT NULL,
  `release_date` int DEFAULT NULL,
  `sales` float DEFAULT NULL,
  `genre` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1
*/
-- The Primary Key for Albums is 'id'

SELECT name
from albums;
-- The column named name represents a variable character string up to 240 stating the album's name
select sales
from albums;
-- The sales column represents total album sales with an unsigned float

select *
from albums
where artist = 'pink floyd';
-- the albums by pink floyd are the dark side of the moon and the wall and a null value(?)

show columns in albums;
select release_date, artist, name
from albums
where artist = 'the beatles';
-- Sgt. Pepper's Lonely Hearts Club Band was released in 1967.

select genre, artist, name
from albums
where name = 'nevermind';
-- The genre for nevermind is grunge, alternative rock

select release_date, name
from albums
where release_date between 1990 and 1999;
-- The albums released in the 1990's are the bodyguard, jagged little pill, come on over, falling into you,
-- let's talk about love, dangerous, the immaculate collection, titanic: music from the motion picture, 
-- metallica, nevermind, and supernatural

select sales, name
from albums
where sales < 20;
-- The albums with less than 20 million sales were Grease: the original soundtrack from the motion picture,
-- bad, sgt. pepper's lonely hearts club band, dirty dancing, let's talk about love, dangerous, 
-- the immaculate collection, abbey road, born in the U.S.A., brothers in arms, titanic: music from the 
-- motion picture, nevermind, and the wall
