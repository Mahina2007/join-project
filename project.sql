create table if not exists customers (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    address VARCHAR(100),
    mobile_phone VARCHAR(32)
);

create table if not exists products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price INT,
    discount INT
);

create type  orders_status AS ENUM ('completed', 'pending', 'delayed');
create table if not exists orders (
    id SERIAL PRIMARY KEY,
    user_id INT,
    product_id INT,
    orders_count INT,
    status orders_status,
    constraint fk_user_id foreign key (user_id) references customers(id),
    constraint fk_product_id foreign key (product_id) references products(id)
);


-- Insert customers
INSERT INTO customers (full_name, address, mobile_phone) VALUES
  ('Alice Johnson', '123 Maple St, Springfield', '+1234567890'),
  ('Bob Smith', '456 Oak Ave, Riverside', '+2345678901'),
  ('Carol Lee', '789 Pine Rd, Brookfield', '+3456789012'),
  ('David Kim', '101 Elm St, Greenfield', '+4567890123'),
  ('Eva Chen', '202 Birch Blvd, Lakeside', '+5678901234'),
  ('Frank Doyle', '303 Cedar St, Hilltown', '+6789012345'),
  ('Grace Park', '404 Walnut Ln, Riverbend', '+7890123456'),
  ('Henry Adams', '505 Chestnut Dr, Sunnyvale', '+8901234567'),
  ('Isabella Rossi', '606 Spruce Ct, Northfield', '+9012345678'),
  ('Jack Nguyen', '707 Willow Ave, Eastwood', '+1234509876');

-- Insert products
INSERT INTO products (name, price, discount) VALUES
  ('Wireless Mouse', 2500, 10),
  ('Mechanical Keyboard', 7000, 15),
  ('HD Monitor', 15000, 20),
  ('USB-C Hub', 3000, 5),
  ('Gaming Chair', 22000, 25),
  ('Laptop Stand', 3500, 10),
  ('Bluetooth Speaker', 4500, 12),
  ('External Hard Drive', 8500, 18),
  ('Webcam 1080p', 5200, 8),
  ('Noise Cancelling Headphones', 12000, 20);

-- Insert orders
INSERT INTO orders (user_id, product_id, orders_count, status) VALUES
  (1, 2, 1, 'completed'),
  (2, 5, 3, 'pending'),
  (3, 1, 2, 'delayed'),
  (4, 4, 1, 'completed'),
  (5, 7, 1, 'pending'),
  (6, 9, 2, 'completed'),
  (7, 3, 4, 'delayed'),
  (8, 6, 1, 'completed'),
  (9, 8, 2, 'pending'),
  (10, 10, 1, 'completed');

insert into orders (user_id, product_id, orders_count, status) values
    (1, 2, 3, 'pending'),
    (1, 3, 3, 'pending');


