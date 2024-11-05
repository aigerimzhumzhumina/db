create database lab6;
CREATE TABLE locations (location_id SERIAL PRIMARY KEY, street_address VARCHAR(25),
                         postal_code VARCHAR(12), city VARCHAR(30), state_province VARCHAR(12));
CREATE TABlE departments(department_id SERIAL PRIMARY KEY, department_name VARCHAR(50) UNIQUE,
                           budget INTEGER, location_id INTEGER REFERENCES locations );
CREATE TABLE employees(employee_id SERIAL PRIMARY KEY, first_name VARCHAR(50),
                         last_name VARCHAR(50), email VARCHAR(50), phone_number VARCHAR(20),
                         salary INTEGER, department_id INTEGER REFERENCES departments);

INSERT INTO locations (street_address, postal_code, city, state_province) VALUES
('123 Elm St', '12345', 'Springfield', 'IL'),
('456 Oak Ave', '23456', 'Shelbyville', 'IL'),
('789 Pine Blvd', '34567', 'Capital City', 'IL'),
('321 Maple Dr', '45678', 'Metropolis', 'IL'),
('654 Cedar St', '56789', 'Gotham', 'NY');

INSERT INTO departments (department_name, budget, location_id) VALUES
('Sales', 500000, 1),
('Marketing', 300000, 2),
('IT', 700000, 1),
('HR', 200000, 3),
('Finance', 600000, 4);

INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id) VALUES
('John', 'Doe', 'john.doe@example.com', '555-1234', 60000, 1),
('Jane', 'Smith', 'jane.smith@example.com', '555-5678', 65000, 2),
('Sam', 'Brown', 'sam.brown@example.com', '555-8765', 70000, 3),
('Anna', 'Johnson', 'anna.johnson@example.com', '555-4321', 58000, 1),
('Tom', 'Clark', 'tom.clark@example.com', '555-1111', 72000, 3),
('Emily', 'Davis', 'emily.davis@example.com', '555-2222', 50000, 4),
('Mark', 'Wilson', 'mark.wilson@example.com', '555-3333', 55000, 4);
select e.first_name, e.last_name, e.department_id, d.department_name
from employees e
left join departments d on e.department_id = d.department_id;

select e.first_name, e.last_name, e.department_id, d.department_name
from employees e
left join departments d on e.department_id = d.department_id
where e.department_id in(80,40);

select e.first_name, e.last_name, e.department_id, d.department_name, l.city, l.state_province
from employees e
left join departments d on e.department_id = d.department_id
left join locations l on d.location_id = l.location_id;

select * from departments d
left join employees e on d.department_id = e.department_id;

select * from employees e
left join departments d on e.department_id = d.department_id;
