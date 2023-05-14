DROP database IF EXISTS BacchusWinery;

CREATE database BacchusWinery;
use BacchusWinery;

DROP USER IF EXISTS 'winery'@'localhost';

CREATE USER 'winery'@'localhost' IDENTIFIED WITH mysql_native_password BY 'ILoveWine!';

GRANT ALL PRIVILEGES ON BacchusWinery.* TO 'winery'@'localhost';

DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS supplies;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS distributors;
DROP TABLE IF EXISTS supply_order;
DROP TABLE IF EXISTS shipments;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS timekeeping;


CREATE TABLE products (
    product_id INT NOT NULL AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    stock_qty INT NOT NULL,

    PRIMARY KEY(product_id)
);

CREATE TABLE suppliers(
    supplier_id INT NOT NULL AUTO_INCREMENT,
    supplier_name VARCHAR(100) NOT NULL,
    supplier_address VARCHAR(250) NOT NULL,
    supplier_phone VARCHAR(250) NOT NULL,
    supplier_email VARCHAR(250) NOT NULL,

    PRIMARY KEY(supplier_id)
);

CREATE TABLE supplies(
    supply_id INT NOT NULL AUTO_INCREMENT,
    supplier_id INT NOT NULL,
    supply_name VARCHAR(100) NOT NULL,
    stock_qty INT NOT NULL,
    
    PRIMARY KEY(supply_id),
    CONSTRAINT fk_supplier
    FOREIGN KEY(supplier_id)
        REFERENCES suppliers(supplier_id)
);

CREATE TABLE distributors(
    distributor_id INT NOT NULL AUTO_INCREMENT,
    distributor_name VARCHAR(100) NOT NULL,
    distributor_address VARCHAR(250) NOT NULL,
    distributor_phone VARCHAR(250) NOT NULL,
    distributor_email VARCHAR(250) NOT NULL,
    
    PRIMARY KEY(distributor_id)

);

CREATE TABLE supply_order(
    order_id INT NOT NULL AUTO_INCREMENT,
    supply_id INT NOT NULL,
    order_date Date NOT NULL,
    expected_date Date NOT NULL,
    delivery_date Date NOT NULL,
    qty_ordered INT NOT NULL,

    PRIMARY KEY(order_id),
    CONSTRAINT fk_part
    FOREIGN KEY(supply_id)
        REFERENCES supplies(supply_id)

);

CREATE TABLE shipments(
    shipment_id INT NOT NULL AUTO_INCREMENT,
    product_id INT NOT NULL,
    distributor_id INT NOT NULL,
    shipment_date Date NOT NULL,
    tracking_number VARCHAR(100) NOT NULL,
    qty_sold INT NOT NULL,

    PRIMARY KEY(shipment_id),
    CONSTRAINT fk_product
    FOREIGN KEY(product_id)
        REFERENCES products(product_id),
    CONSTRAINT fk_distributor
    FOREIGN KEY(distributor_id)
        REFERENCES distributors(distributor_id)
);

CREATE TABLE departments(
    department_id INT NOT NULL AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL,

    PRIMARY KEY(department_id)
);

CREATE TABLE employees(
    employee_id INT NOT NULL AUTO_INCREMENT,
    manager_id INT NULL,
    department_id INT NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_hired Date NOT NULL,
    job_title VARCHAR(100) NOT NULL,
    employment_status bit NOT NULL,

    PRIMARY KEY(employee_id),
    CONSTRAINT fk_department
    FOREIGN KEY(department_id)
        REFERENCES departments(department_id)

);

CREATE TABLE timekeeping(
    date Date NOT NULL,
    employee_id INT NOT NULL,
    hours_worked decimal NOT NULL,

    CONSTRAINT fk_employee
    FOREIGN KEY(employee_id)
        REFERENCES employees(employee_id)
    
);


INSERT INTO products(product_name, stock_qty)
VALUES('Merlot', 102);
INSERT INTO products(product_name, stock_qty)
VALUES('Cabernet', 63);
INSERT INTO products(product_name, stock_qty)
VALUES('Chablis', 89);
INSERT INTO products(product_name, stock_qty)
VALUES('Chardonnay', 47);


INSERT INTO suppliers(supplier_name,supplier_address,supplier_phone,supplier_email)
VALUES('Glass Bottle Co.', '7824 N Holland Ave, Dallas, Texas 75001', '508-662-1234', 'sally.watson@glassco.com');
INSERT INTO suppliers(supplier_name,supplier_address,supplier_phone,supplier_email)
VALUES('Corks and Company', '9271 W Wayward Pl, Augusta, Maine 04330', '207-119-5872', 'customerservice@corksandco.com');
INSERT INTO suppliers(supplier_name,supplier_address,supplier_phone,supplier_email)
VALUES('Supply Warehouse', '261 S 61st Street, Savannah, Georgia 31302', '402-879-2235', 'shipments@supplywarehouse.com');
INSERT INTO suppliers(supplier_name,supplier_address,supplier_phone,supplier_email)
VALUES('The Label Makers', '9982 E Butler Dr, Lincoln, Nebraska 68506', '402-333-1987', 'orders@labelmakers.com');
INSERT INTO suppliers(supplier_name,supplier_address,supplier_phone,supplier_email)
VALUES('Big Box', '1330 6th Ave, New York City, New York 10010', '212-587-2000', 'customer.support@bigbox.com');
INSERT INTO suppliers(supplier_name,supplier_address,supplier_phone,supplier_email)
VALUES('Shaan Inc', '1920 Army Trail Rd, Hanover Park, Illinois 60103', '630-830-8212', 'msr123@gmail.com');


INSERT into supplies(supplier_id, supply_name, stock_qty)
VALUES(1,'Glass Bottles', 600);
INSERT into supplies(supplier_id, supply_name, stock_qty)
VALUES(1,'Corks', 1250);
INSERT into supplies(supplier_id, supply_name, stock_qty)
VALUES(3,'Paper Labels', 753);
INSERT into supplies(supplier_id, supply_name, stock_qty)
VALUES(3,'Cardboard Boxes', 847);
INSERT into supplies(supplier_id, supply_name, stock_qty)
VALUES(6,'Vats', 14);
INSERT into supplies(supplier_id, supply_name, stock_qty)
VALUES(6,'Tubing', 26);


INSERT INTO distributors(distributor_name, distributor_address, distributor_phone, distributor_email)
VALUES('Wines-R-Us', '2253 W Wexford Pl, Sioux Falls, South Dakota, 57104', '605-445-9852', 'sales@winesrus.com');
INSERT INTO distributors(distributor_name, distributor_address, distributor_phone, distributor_email)
VALUES('Cork Supply', '5312 N Highland Blv, Las Vegas, Nevada, 94510', '707-746-4353', 'sales@corksupplyusa.com');
INSERT INTO distributors(distributor_name, distributor_address, distributor_phone, distributor_email)
VALUES('East Coast Distributors', '3434 Drury Lane, Charleston, South Carolina, 29407', '219-864-2615', 'support@ecd.com');
INSERT INTO distributors(distributor_name, distributor_address, distributor_phone, distributor_email)
VALUES('U-Line', '3030 U-Line Dr, Naples, Florida, 34117', '800-395-5510', 'support@uline.com');
INSERT INTO distributors(distributor_name, distributor_address, distributor_phone, distributor_email)
VALUES('JJs Wine', '4700 S Louise Ave, Minneapolis, Minneapolis, 55401', '612-878-3320', 'orders@jjswine.com');
INSERT INTO distributors(distributor_name, distributor_address, distributor_phone, distributor_email)
VALUES('Penns Keggs', '8904 S Birch Rd, Shawnee, Kansas, 68820', '535-213-9955', 'sales@pkeggs.com');


INSERT INTO supply_order(supply_id, order_date, expected_date, delivery_date, qty_ordered)
VALUES(5, '2020-03-20', '2020-04-05', '2020-04-30', 3);
INSERT INTO supply_order(supply_id, order_date, expected_date, delivery_date, qty_ordered)
VALUES(1, '2021-01-12', '2021-01-27', '2021-01-27', 250);
INSERT INTO supply_order(supply_id, order_date, expected_date, delivery_date, qty_ordered)
VALUES(2, '2021-02-21', '2021-03-01', '2021-03-01', 175);
INSERT INTO supply_order(supply_id, order_date, expected_date, delivery_date, qty_ordered)
VALUES(4, '2022-08-15', '2022-08-24', '2022-08-20', 150);
INSERT INTO supply_order(supply_id, order_date, expected_date, delivery_date, qty_ordered)
VALUES(6, '2022-10-01', '2022-10-16', '2022-10-16', 25);
INSERT INTO supply_order(supply_id, order_date, expected_date, delivery_date, qty_ordered)
VALUES(3, '2023-01-14', '2023-01-28', '2023-01-27', 400);

INSERT INTO shipments(product_id, distributor_id, shipment_date, tracking_number, qty_sold)
VALUES(1,5,'2022-10-01', 'ZSK12554789321', 175);
INSERT INTO shipments(product_id, distributor_id, shipment_date, tracking_number, qty_sold)
VALUES(2,3,'2022-11-12', 'LSZH1233457866', 200);
INSERT INTO shipments(product_id, distributor_id, shipment_date, tracking_number, qty_sold)
VALUES(4,1,'2022-11-13', 'KKJ123347532124', 150);
INSERT INTO shipments(product_id, distributor_id, shipment_date, tracking_number, qty_sold)
VALUES(3,2,'2022-11-30', 'ZKJ66987542134258', 250);
INSERT INTO shipments(product_id, distributor_id, shipment_date, tracking_number, qty_sold)
VALUES(4,6,'2022-12-15', 'LKSJ1233456782123', 275);
INSERT INTO shipments(product_id, distributor_id, shipment_date, tracking_number, qty_sold)
VALUES(1,5,'2022-12-20', 'ZUI55423162875462', 300);
INSERT INTO shipments(product_id, distributor_id, shipment_date, tracking_number, qty_sold)
VALUES(2,4,'2023-01-01', 'ZKS1457866325152', 275);


INSERT INTO departments(department_name)
VALUES('Finance');
INSERT INTO departments(department_name)
VALUES('Marketing');
INSERT INTO departments(department_name)
VALUES('Production');
INSERT INTO departments(department_name)
VALUES('Distribution');
INSERT INTO departments(department_name)
VALUES('Executive');
INSERT INTO departments(department_name)
VALUES('Human Resources');


INSERT INTO employees(manager_id, department_id, first_name, last_name, date_hired, job_title, employment_status)
VALUES(null, 1, 'Janet', 'Collins', '2000-05-05', 'Finance Director', 1);
INSERT INTO employees(manager_id, department_id, first_name, last_name, date_hired, job_title, employment_status)
VALUES(null, 2, 'Roz', 'Murphy', '2000-07-29', 'Marketing Director', 1);
INSERT INTO employees(manager_id, department_id, first_name, last_name, date_hired, job_title, employment_status)
VALUES(2, 2, 'Bob', 'Ulrich', '2000-10-25', 'Assistant Marketing Director', 1);
INSERT INTO employees(manager_id, department_id, first_name, last_name, date_hired, job_title, employment_status)
VALUES(null, 3, 'Henry', 'Doyle', '2000-04-01', 'Production Manager', 1);
INSERT INTO employees(manager_id, department_id, first_name, last_name, date_hired, job_title, employment_status)
VALUES(null, 4, 'Maria', 'Costanza', '2001-01-15', 'Distribution Manager', 1);
INSERT INTO employees(manager_id, department_id, first_name, last_name, date_hired, job_title, employment_status)
VALUES(null, 5, 'Stan', 'Bacchus', '2018-01-24', 'Owner', 1);
INSERT INTO employees(manager_id, department_id, first_name, last_name, date_hired, job_title, employment_status)
VALUES(null, 5, 'Davis', 'Bacchus', '2018-01-24', 'Owner', 1);

INSERT INTO timekeeping(date, employee_id, hours_worked)
VALUES('2023-01-20', 1, 7.5);
INSERT INTO timekeeping(date, employee_id, hours_worked)
VALUES('2023-01-20', 3, 8);
INSERT INTO timekeeping(date, employee_id, hours_worked)
VALUES('2023-01-21', 3, 7.5);
INSERT INTO timekeeping(date, employee_id, hours_worked)
VALUES('2023-01-21', 4, 6.5);
INSERT INTO timekeeping(date, employee_id, hours_worked)
VALUES('2023-01-22', 5, 9.5);
INSERT INTO timekeeping(date, employee_id, hours_worked)
VALUES('2023-01-23', 5, 9.5);