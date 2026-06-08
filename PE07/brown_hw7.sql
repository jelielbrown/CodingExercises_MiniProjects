-- AUTHOR: Jeliel Brown
-- DATE: 11/13/2025
-- ISTE-230 HW7

-- PART 1

DROP DATABASE IF EXISTS brown_acme_online;
CREATE DATABASE brown_acme_online;
USE brown_acme_online;

CREATE TABLE Category (
    category_name VARCHAR(35) NOT NULL,
    shipping_per_pound DECIMAL(4, 2) NULL,
    offers_allowed ENUM('y', 'n') NOT NULL DEFAULT 'n',
    CONSTRAINT category_pk PRIMARY KEY (category_name)
);

CREATE TABLE Offer (
    offer_code VARCHAR(15) NOT NULL,
    discount_amt VARCHAR(35) NOT NULL,
    min_amount DECIMAL(4, 2) NOT NULL,
    expiration_date DATE NOT NULL,
    CONSTRAINT offer_pk PRIMARY KEY (offer_code)
);

CREATE TABLE Customer (
    customer_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    customer_name VARCHAR(50) NOT NULL,
    address VARCHAR(150) NOT NULL,
    email VARCHAR(80) NULL,
    customer_type ENUM('BUSINESS', 'HOME', 'BOTH', 'NONE') DEFAULT 'NONE',
    CONSTRAINT customer_pk PRIMARY KEY (customer_id)
);

CREATE TABLE Ordered (
    order_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    total_cost DECIMAL(10, 2) NULL,
    customer_id INT UNSIGNED NOT NULL,
    offer_code VARCHAR(15) NULL,
    CONSTRAINT ordered_pk PRIMARY KEY (order_id),
    CONSTRAINT ordered_customer_id_fk FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
    CONSTRAINT ordered_offer_code_fk FOREIGN KEY (offer_code) REFERENCES Offer(offer_code)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

CREATE TABLE Item (
    item_number INT UNSIGNED NOT NULL AUTO_INCREMENT,
    item_name VARCHAR(35) NOT NULL,
    description VARCHAR(255) NULL,
    model_number VARCHAR(50) NOT NULL,
    price DECIMAL(8, 2) NOT NULL,
    category_name VARCHAR(35) NULL,
    CONSTRAINT item_pk PRIMARY KEY (item_number),
    CONSTRAINT item_category_name_fk FOREIGN KEY (category_name) REFERENCES Category(category_name)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

CREATE TABLE LineItem (
    order_id INT UNSIGNED NOT NULL,
    item_number INT UNSIGNED NOT NULL,
    quantity TINYINT UNSIGNED NOT NULL,
    shipping_amount DECIMAL(6, 2) NULL,
    CONSTRAINT line_item_pk PRIMARY KEY (order_id, item_number),
    CONSTRAINT line_item_order_id_fk FOREIGN KEY (order_id) REFERENCES Ordered(order_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    CONSTRAINT line_item_item_number_fk FOREIGN KEY (item_number) REFERENCES Item(item_number)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

CREATE TABLE Business (
    customer_id INT UNSIGNED NOT NULL,
    payment_terms VARCHAR(50) NOT NULL,
    CONSTRAINT business_pk PRIMARY KEY (customer_id),
    CONSTRAINT business_customer_id_fk FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE PurchaseContact (
    contact_name VARCHAR(50) NULL,
    customer_id INT UNSIGNED NOT NULL,
    contact_phone CHAR(12) NOT NULL,
    CONSTRAINT purchase_contact_pk PRIMARY KEY (customer_id, contact_phone),
    CONSTRAINT purchase_contact_customer_id_fk FOREIGN KEY (customer_id) REFERENCES Business(customer_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE InsuranceCompany (
    co_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(80) NOT NULL,
    CONSTRAINT insurance_company_pk PRIMARY KEY (co_id)
);

CREATE TABLE InsurancePolicy (
    policy_num VARCHAR(25) NOT NULL,
    patient_id INT UNSIGNED NOT NULL,
    ins_co_id SMALLINT UNSIGNED NOT NULL,
    CONSTRAINT insurance_policy_pk PRIMARY KEY (policy_num),
    CONSTRAINT insurance_policy_patient_id_fk FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
    CONSTRAINT insurance_policy_ins_co_id_fk FOREIGN KEY (ins_co_id) REFERENCES Insurance_Company(co_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

CREATE TABLE Patient (
    patient_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    CONSTRAINT patient_pk PRIMARY KEY (patient_id)
);

CREATE TABLE Guarantee (
    order_id INT UNSIGNED NOT NULL,
    customer_id INT UNSIGNED NOT NULL,
    url VARCHAR(50) NULL,
    refund_amount DECIMAL(12, 2) NULL,
    CONSTRAINT guarantee_pk PRIMARY KEY (order_id),
    CONSTRAINT guarantee_order_id_fk FOREIGN KEY (order_id) REFERENCES Ordered(order_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    CONSTRAINT guarantee_customer_id_fk FOREIGN KEY (customer_id) REFERENCES Home(customer_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

CREATE TABLE Home (
    customer_id INT UNSIGNED NOT NULL,
    credit_card_num CHAR(16) NOT NULL,
    card_expiration_date CHAR(6) NOT NULL,
    CONSTRAINT home_pk PRIMARY KEY (customer_id),
    CONSTRAINT home_customer_id_fk FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- PART 2

INSERT INTO Category(category_name, shipping_per_pound, offers_allowed)
VALUES('Books', 0.99, 'y');
INSERT INTO Category(category_name, shipping_per_pound, offers_allowed)
VALUES('Home', 1.99, 'y');
INSERT INTO Category(category_name, shipping_per_pound, offers_allowed)
VALUES('Jewelry', 0.99, 'n');
INSERT INTO Category(category_name, shipping_per_pound, offers_allowed)
VALUES('Toys', 0.99, 'y');

INSERT INTO Item(item_name, description, model_number, price, category_name)
VALUES('Cabbage Patch Doll', 'Baby boy doll', 'Boy', 39.95, 'Toys');
INSERT INTO Item(item_name, description)
VALUES('The Last Lecture', 'Written by Randy Pausch', 'Hardcover', 9.95, 'Books');
INSERT INTO Item(item_name, description)
VALUES('Keurig Beverage Maker', 'Keurig Platinum Edition Beverage Maker in Red', 'Platinum Edition', 299.95, 'Home');
INSERT INTO Item(item_name, description)
VALUES('1ct diamond ring in white gold', 'diamond is certified vvs, D, round', '64gt32', 4000.00, 'Jewelry');

INSERT INTO Offer(offer_code, discount_amt, min_amount, expiration_date)
VALUES('345743213', '20% off', 20.00, '2013-12-31');
INSERT INTO Offer(offer_code, discount_amt, min_amount, expiration_date)
VALUES('4567890123', '30% off', 30.00, '2013-12-31');