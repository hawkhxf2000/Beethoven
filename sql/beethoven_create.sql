drop schema if exists beethoven cascade;
create schema beethoven;
set
search_path to beethoven;
-- staffs(ID, fist_name,last_name,date_of_birth,position,address,phone_no,email)
create table staff
(
    id            integer generated always as identity primary key,
    first_name    text                                          not null,
    last_name     text                                          not null,
    date_of_birth date                                          not null,
    position      text                                          not null,
    address       text                                          not null,
    phone_no      text                                          not null,
    email         text                                          not null,
    create_date   date                     default current_date not null,
    last_update   timestamp with time zone default now()        not null,
)
    );

-- Members(ID,first_name,last_name,address,phone_no,email,create_date,last_update)
create table member
(
    id          integer generated always as identity primary key,
    first_name  text                                          not null,
    last_name   text                                          not null,
    address     text,
    phone_no    text,
    email       text,
    create_date date                     default current_date not null,
    last_update timestamp with time zone default now()        not null,
);

-- Inventory(ID,category_type,brand,model,product_date, product_country, warehousing_date,
-- warehousing_cost, description)
create table inventory
(
    id                integer generated always as identity primary key,
    category_type     enum('Upright Piano','Grand Piano','Digital Piano','Other Keyboard') not null,
    brand             enum('STEINWAY&SONS','SEILER','YAMAHA')       not null,
    model             text                                          not null,
    produced_date     date                                          not null,
    producing_country enum('GERMANY','USA','JAPAN')                 not null,
    list_price        decimal(10, 2)                                not null,
    warehousing_date  date                     default current_date not null,
    warehousing_cost  decimal(10, 2)                                not null,
    description       text,
);

-- Sale Record(ID, sale_date,inventories_id*,sale_price,discount,member_id*,staff_id* )
create table sale
(
    id           integer generated always as identity primary key,
    sale_date    date default current_date                not null,
    inventory_id integer references inventory (id) unique not null,
    discount     decimal(10, 2)                           not null,
    sale_price   decimal(10, 2)                           not null,
    member_id    integer references member (id),
    staff_id     integer references staff (id)            not null,
);

-- Bills (ID, date,member_id*, price,discount,sub_total,tax,total,staff_id*)
create table bill
(
    id           integer generated always as identity primary key,
    bill_date    date default current_date                        not null,
    member_id    integer references member (id),
    sale_id      integer references sale (id)                     not null,
    price        decimal(10, 2) references inventory (list_price) not null,
    discount     decimal(10, 2) references sale (discount)        not null,
    sub_total    decimal(10, 2) references sale (sale_price)      not null,
    tax          decimal(10, 2)                                   not null,
    total        decimal(10, 2)                                   not null,
    staff_id     integer references staff (staff_id)              not null,
);