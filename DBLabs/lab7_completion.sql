--Lab 7
--Khai Thach

--Q1
CREATE INDEX order_date_index
ON orders_mgs (order_date);

--Q2
DROP TABLE Downloads_ex;
DROP TABLE Users_ex;
DROP TABLE Products_ex;

DROP SEQUENCE user_id_seq;
DROP SEQUENCE download_id_seq;
DROP SEQUENCE product_id_seq;

CREATE SEQUENCE user_id_seq;
CREATE SEQUENCE download_id_seq;
CREATE SEQUENCE product_id_seq;

CREATE TABLE Users_ex
(
    user_id  NUMBER  PRIMARY KEY,
    email_address   VARCHAR2(50) UNIQUE NOT NULL,
    first_name  VARCHAR2(50)    NOT NULL,
    last_name   VARCHAR2(50)    NOT NULL
);

CREATE TABLE Products_ex
(
    product_id  NUMBER  PRIMARY KEY,
    product_name VARCHAR2(50) UNIQUE
);

CREATE TABLE Downloads_ex
(
    download_id NUMBER  PRIMARY KEY,
    user_id NUMBER  NOT NULL,
    download_date   DATE   NOT NULL,
    filename    VARCHAR2(50)   NOT NULL,
    product_id  NUMBER NOT NULL,
    CONSTRAINT downloads_fk_users_ex
        FOREIGN KEY (user_id) REFERENCES Users_ex (user_id),
    CONSTRAINT downloads_fk_products_ex
        FOREIGN KEY (product_id) REFERENCES Products_ex (product_id)
);

--Q3
INSERT INTO Users_ex VALUES (user_id_seq.NEXTVAL, 'johnsmith@gmail.com', 'John', 'Smith');
INSERT INTO Users_ex VALUES (user_id_seq.NEXTVAL, 'jabedoe@yahoo.com', 'Jane', 'Doe');

INSERT INTO Downloads_ex VALUES (download_id_seq.NEXTVAL, 1, SYSDATE, 'pedals_are_falling.mpd', 2);
INSERT INTO Downloads_ex VALUES (download_id_seq.NEXTVAL, 2, SYSDATE, 'turn_signal.mp3', 1);
INSERT INTO Downloads_ex VALUES (download_id_seq.NEXTVAL, 2, SYSDATE, 'one_horse_town.mpd', 2);

INSERT INTO Products_ex VALUES (product_id_seq.NEXTVAL, 'Local Music Vol 1');
INSERT INTO Products_ex VALUES (product_id_seq.NEXTVAL, 'Local Music Vol 2');

--Q4
ALTER TABLE Products_ex
ADD product_price NUMBER(5,2)  DEFAULT 9.99;

ALTER TABLE Products_ex
ADD date_added DATE;

--Q5
ALTER TABLE Users_ex
MODIFY first_name VARCHAR2(20) NULL;

UPDATE Users_ex
SET first_name = NULL
WHERE user_id = 1;

UPDATE Users_ex
SET first_name = 'fake_firstname_1234567890'
WHERE user_id = 1;