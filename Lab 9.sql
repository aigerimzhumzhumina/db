create database lab9;
create function increase_value(a integer) RETURNS integer AS $$
BEGIN
    RETURN a + 10;
end;
$$
language plpgsql;
create function compare_numbers(a integer, b integer, out result varchar) AS
    $$
    BEGIN
        case
        when a > b then result = 'Greater';
        when a = b then result = 'Equal';
        else  result = 'Lesser';
        end case;
    END
    $$
language plpgsql;
select compare_numbers(5,5);

create function number_series(x integer) RETURNS VOID AS $$
declare i integer;
BEGIN
    for i in 1..x loop
        raise notice '%', i;
        end loop;
end
$$
language plpgsql;
select number_series(3);
create or replace function find_employee(pattern varchar) RETURNS TABLE(employee_id integer,
                                                                        name varchar(50),
                                                                        last_name varchar(50),
                                                                        email varchar(50),
                                                                        phone_number varchar(20),
                                                                        salary integer,
                                                                        department_id integer)
    AS $$
    begin
        return query
    select employees.employee_id,
           employees.first_name,
           employees.last_name,
           employees.email,
           employees.phone_number,
           employees.salary,
           employees.department_id
    from employees where first_name ilike pattern;
end
    $$
language plpgsql;
select find_employee('Tom');
drop function list_products;

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,  -- Unique ID for each category
    category_name VARCHAR(100) NOT NULL  -- Name of the category (e.g., Electronics, Clothing)
);
CREATE TABLE products (
    product_id INTEGER,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2),
    category_id INTEGER NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);
create or replace function list_products(category varchar)RETURNS TABLE(
id integer, name varchar, price_r decimal(10,2), category_id_r integer
                                                            ) AS $$
 begin
     return query
     select product_id, product_name, price, p.category_id
     from products p join categories c on p.category_id = c.category_id
     where c.category_name = category;
 end;
    $$
language plpgsql;

-- Inserting categories into the categories table

INSERT INTO categories (category_name) VALUES ('Electronics');
INSERT INTO categories (category_name) VALUES ('Clothing');
INSERT INTO categories (category_name) VALUES ('Home & Kitchen');
INSERT INTO categories (category_name) VALUES ('Sports');
INSERT INTO categories (category_name) VALUES ('Books');
-- Inserting products into the products table
-- Electronics products
INSERT INTO products (product_name, price, category_id)
VALUES
    ('Laptop', 999.99, 1),
    ('Smartphone', 799.99, 1),
    ('Smartwatch', 199.99, 1);

-- Clothing products
INSERT INTO products (product_name, price, category_id)
VALUES
    ('T-shirt', 19.99, 2),
    ('Jeans', 39.99, 2),
    ('Jacket', 59.99, 2);

-- Home & Kitchen products
INSERT INTO products (product_name, price, category_id)
VALUES
    ('Blender', 59.99, 3),
    ('Microwave', 120.99, 3),
    ('Vacuum Cleaner', 150.99, 3);

-- Sports products
INSERT INTO products (product_name, price, category_id)
VALUES
    ('Football', 22.99, 4),
    ('Basketball', 30.99, 4),
    ('Tennis Racket', 49.99, 4);

-- Books
INSERT INTO products (product_name, price, category_id)
VALUES
    ('The Great Gatsby', 9.99, 5),
    ('1984', 8.99, 5),
    ('Moby Dick', 11.99, 5);

select list_products('Electronics');

create or replace function calculate_bonus(salary float, out bonus float) AS $$

    begin
        bonus = salary*0.2;
    end;
$$
language plpgsql;
drop function calculate_bonus;
create or replace function update_salary(inout salary float) RETURNS FLOAT AS

    $$
    begin
        salary = salary + calculate_bonus(salary);
    end;
    $$
language plpgsql;
select calculate_bonus(5000.0);
select update_salary(5000.0);

create or replace function complex_calculation(str varchar, a integer, out result varchar) AS $$

    begin
        begin
        str = upper(str);
        end;
        begin
        a = a*a;
        end;
        result = 'compute operation ' || a || ', string manipulation ' || str;
    end;
    $$
language plpgsql;
select complex_calculation('hello', 5);