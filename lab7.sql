create database lab7;
create table countries (name varchar);

create index idx_name on countries(name);



CREATE TABLE departments (
    name varchar,
    department_id int,
    budget int
);

CREATE TABLE employees (
    name varchar,
    surname varchar,
    salary int,
    department_id int
);

create index idx_name_surname on employees (name, surname);


create unique index unique_idx_salary on employees (salary);

create index idx_hash_substring_name on employees using hash (substring(name from 1 for 4));

create index idx_employees_salary on employees (salary);
create index idx_departments_budget on departments (budget);
