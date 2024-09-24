create database lab2;
create table countries(
    country_id serial PRIMARY KEY,
    country_name varchar, region_id integer,
    population integer
);
insert into countries(country_name, region_id, population)
values('Japan', 392, 124000000);
insert into countries(country_id, country_name)
values(default, 'Netherlands');
insert into countries(country_name, region_id, population)
values('Switzerland', default, 8800000);
insert into countries(country_name, region_id, population)
values
('Romania', '6546546', 19000000),
('Italy', 431659, 59000000),
('France', 321478, 68000000);
alter table countries
alter column country_name set default 'Kazakhstan';
insert into countries(region_id, population)
values(4962409, 20000000);
insert into countries default values;
create table countries_new(like countries);
insert into countries_new
select country_id, country_name, region_id, population
from countries;
update countries_new
set region_id = 1
where region_id is null;
select country_name,
       population * 1.1 as "New Population"
from countries_new;
delete
from countries
where population<100000000;
delete
from countries_new as c
using countries as c2
where c.country_id = c2.country_id
returning *;
delete
from countries
returning *;
