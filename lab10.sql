create database lab10;
create table books(book_id integer primary key, title varchar, author varchar, price decimal, quantity integer);
create table orders(order_id integer primary key, book_id integer,
                    foreign key(book_id) references books(book_id),
                    customer_id integer, order_date date, quantity integer);
create table customers(customer_id integer primary key, name varchar, email varchar);
insert into books values(1,'Database 101', 'A. Smith', 40.00, 10),
                        (2, 'Learn SQL', 'B. Johnson', 35.00, 15),
                        (3, 'Advanced DB', 'C. Lee', 50.00, 5);
insert into customers values(101, 'John Doe', 'johndoe@example.com'),
                            (102, 'Jane Doe', 'janedoe@example.com');
begin;
insert into orders values(1, 1, 101, now(), 2);
update books set quantity = quantity - 2
             where book_id = 1;
commit;

begin;
DO $$
    begin
if(select quantity from books where book_id = 3) < 10 then
   RAISE NOTICE 'Not enough stock available for book_id = 3';
        ROLLBACK;
else
    insert into orders values(2, 3, 102, now(), 10);
    update books set quantity = quantity - 10 where book_id = 3;
update books set price = 35 where book_id = 2;
end if;
end;
$$;
commit;
begin;
set transaction isolation level read committed;
select price from books where book_id = 2;

begin;
update customers set email = 'a_zhumzhumina@kbtu.kz' where customer_id = 101;
commit;
