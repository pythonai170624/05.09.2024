-- Targil 1
-- 0
 CREATE TABLE shopping (id INTEGER PRIMARY KEY, name TEXT, amount INTEGER);
-- Creates the table

-- 1
 drop table shopping
-- deletes the table

-- 2
 ALTER table shopping RENAME to shopp
 ALTER table shopp RENAME to shopping
-- changes the table

-- 3
INSERT INTO shopping VALUES (1, 'Avokado', 5);
INSERT INTO shopping VALUES (2, 'Milk', 2);
INSERT INTO shopping VALUES (3, 'Bread', 3);
INSERT INTO shopping VALUES (4, 'Chocolate', 8);
INSERT INTO shopping VALUES (5, 'Bamba', 5);
INSERT INTO shopping VALUES (6, 'Orange', 10);
-- insert

-- 4
select * from shopping s
-- shows all columns and all rows

-- 5
select id, name from shopping s
-- show id, name and all rows

-- 6
SELECT * FROM shopping WHERE amount > 5;
SELECT * FROM shopping WHERE amount = 2;
SELECT * FROM shopping WHERE name LIKE 'Bamba';
-- find by condition

-- 7
DELETE from shopping WHERE name like 'Orange';
-- delete

-- 8
--UPDATE shopping s SET s.name = 'Bisli' WHERE id > 1
--UPDATE shopping s SET s.amount=1 WHERE s.name LIKE 'Milk'
-- update

-- 9
ALTER TABLE shopping ADD COLUMN maavar;
-- add column

-- 10
UPDATE shopping SET maavar=6 WHERE id=1;
UPDATE shopping SET maavar=3 WHERE id=2;
UPDATE shopping SET maavar=12 WHERE id=3;
UPDATE shopping SET maavar=8 WHERE id=4;
UPDATE shopping SET maavar=5 WHERE id=5;
-- update

-- 11
SELECT * FROM shopping WHERE amount > 1 AND maavar > 5;
SELECT * FROM shopping WHERE maavar BETWEEN 3 AND 5;

-- 12.
SELECT * FROM shopping ORDER BY maavar limit 4;
SELECT * FROM shopping ORDER BY maavar DESC limit 1;
-- order by -- sorts the table by the specific column(s), you can use limit to select only few records

-- 13
CREATE TABLE books (id INTEGER PRIMARY KEY, name TEXT);
INSERT INTO books VALUES (1, 'SQL PROGRAMMING');
INSERT INTO books VALUES (2, 'CSHARP PROGRAMMING');
DELETE FROM books;
select * from books;

-- 14
SELECT count(*)
	from shopping;

SELECT MAX(amount)
	from shopping;

SELECT *, (select MAX(amount) from shopping) max_amount
	from shopping;

--SELECT * from shopping WHERE amount != 8;

SELECT *
	from shopping
	WHERE amount <> (select MAX(amount) from shopping);

SELECT AVG(amount)
	from shopping;
SELECT MIN(amount)
	from shopping;

-- 15
INSERT INTO shopping VALUES (6, 'Onions', 3, 6);
INSERT INTO shopping VALUES (7, 'Orio', 1, 8);

select distinct maavar , count(*)
	from shopping s ;

Select maavar , count(*), avg(amount), max(amount)
	FROM shopping
	GROUP BY maavar;

-- 17
select maavar, count(*) cnt
	FROM shopping s
	GROUP BY maavar
	HAVING cnt > 1;
select maavar, count(*) cnt
	FROM shopping s
	WHERE amount != 1 -- filter of row
	GROUP BY maavar
	HAVING cnt > 1; -- filter of group

-- 18
CREATE TABLE prices (id INTEGER PRIMARY KEY, price INTEGER);
INSERT INTO prices VALUES (1, 3);
INSERT INTO prices VALUES (2, 7);
INSERT INTO prices VALUES (3, 12);
INSERT INTO prices VALUES (4, 5);
INSERT INTO prices VALUES (5, 3);
INSERT INTO prices VALUES (6, 2);
INSERT INTO prices VALUES (7, 10);

-- join shopping and price with inner join
select s.*, p.price price_for_one, s.amount * p.price total_price
	from shopping s
	join prices p
		on s.id = p.id;

-- find max price for each maavar
select maavar, max(p.price)
	from shopping s
	join prices p
		on s.id = p.id
	GROUP BY maavar;

-- how to get the details of the most expensive price?
select s.*, p.price price_for_one, s.amount * p.price total_price
from shopping s
join prices p
	on s.id = p.id
where p.price = (select max(price) from prices);

select * from prices;
select * from shopping s;

-- Targil 2

-- 1
CREATE TABLE students (
ID INTEGER PRIMARY KEY,
NAME TEXT NOT NULL,
CITY TEXT NOT NULL,
BIRTH INTEGER NOT NULL
);

CREATE TABLE grades (
ID INTEGER PRIMARY KEY,
GRADE INTEGER);

INSERT INTO students
	values
	(1, 'SHALOM', 'TEL AVIV', 1974),
	(2, 'YURI', 'RAANANA', 1980),
	(3, 'ANAT', 'RISHON', 1994),
	(4, 'DANA', 'REHOVOT', 1990),
	(5, 'OMER', 'JERUSALEM', 1987);

INSERT INTO grades
	values
	(1, 95),
	(2, 70),
	(3, 85),
	(4, 99),
	(5, 91);

INSERT INTO grades
	values
	(7, 95);

INSERT INTO students
	values
	(6, 'SHALOM', 'TEL AVIV', 1974);

-- 2
SELECT s.name, g.grade
	from students s
	full outer join grades g on s.id=g.id;

-- 3
select avg(grade)
	from grades;

-- 4
alter table students add column EXCELLENT;

SELECT s.name, g.grade
	from students s
	inner join grades g on s.id=g.id;

update students
	set EXCELLENT = 'YES'
	where id in (
		SELECT s.id
		from students s
		join grades g on s.id=g.id
		where g.grade > 90
	);

update students
	set EXCELLENT = 'NO'
	where id in (
		SELECT s.id
		from students s
		join grades g on s.id=g.id
		where g.grade <= 90
	);

delete from students where id = 6;
delete from grades where id = 7;

-- adding excellent to grade table
alter table grades add column EXCELLENT;

--update grades
--set EXCELLENT = NULL
--where true;

-- upgrade to yes/no in 1 command using case-when
update grades
set EXCELLENT = CASE WHEN grade > 90 THEN 'YES'
				ELSE 'NO'
				END
where true;

-- 5
-- above avg
SELECT s.*, g.grade, (select avg(grade) from grades) AVG
	from students s
	inner join grades g on s.id=g.id
	where g.grade > (select avg(grade) from grades);

-- 6
-- highest
SELECT s.*, g.grade
	from students s
	inner join grades g on s.id=g.id
	where g.grade = (select max(grade) from grades);


SELECT * FROM students;
SELECT * FROM grades;

SELECT DATETIME();
SELECT 2 * 8;

update students
	set birth = birth + 1
	where id >= 1;







