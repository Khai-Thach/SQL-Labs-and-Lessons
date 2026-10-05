--Lab 13

--Khai Thach

--Q1
-- Create the stored function
CREATE OR REPLACE FUNCTION discount_price
(
   item_id_par NUMBER
)
RETURN NUMBER
AS
    discount_price_var NUMBER;
BEGIN
    SELECT item_price - discount_amount
    INTO   discount_price_var
    FROM   order_items
    WHERE  item_id = item_id_par;
    
    RETURN discount_price_var;
END;
/

-- Test with a SELECT statement
SELECT item_id,
       item_price,
       discount_amount,
       discount_price(item_id) AS discount_price
FROM   order_items;

--Q2
-- Turn on output printing
SET SERVEROUTPUT ON

-- Create the stored procedure
CREATE OR REPLACE PROCEDURE update_product_discount
(
   product_id_par    NUMBER,
   discount_pct_par  NUMBER
)
AS
BEGIN
    IF discount_pct_par < 0 THEN
        DBMS_OUTPUT.PUT_LINE('The discount percent must be a positive number.');
        RAISE VALUE_ERROR;
    ELSE
        UPDATE products
        SET    discount_percent = discount_pct_par
        WHERE  product_id = product_id_par;
        
        DBMS_OUTPUT.PUT_LINE('Product ' || product_id_par || 
                             ' discount updated to ' || discount_pct_par || '%.');
    END IF;
END;
/

-- Test 1: Valid call (no error) – updates product 1 to 15% discount
CALL update_product_discount(1, 15);

-- Test 2: Invalid call (negative value – triggers value error)
CALL update_product_discount(1, -5);

-- Restore original discount_percent value for product 1
UPDATE products
SET    discount_percent = 0
WHERE  product_id = 1;

--Q3
-- Create the trigger
CREATE OR REPLACE TRIGGER products_before_update
    BEFORE UPDATE OF discount_percent ON products
    FOR EACH ROW
BEGIN
    -- Raise error if discount is out of the 0–100 range
    IF :NEW.discount_percent > 100 OR :NEW.discount_percent < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 
            'Discount percent must be between 0 and 100!');
    
    -- Auto-convert decimal input (e.g. 0.2) to percentage (e.g. 20)
    ELSIF :NEW.discount_percent < 1 THEN
        :NEW.discount_percent := :NEW.discount_percent * 100;
    END IF;
END;
/

-- Test 1: Valid update using a decimal – trigger converts 0.25 → 25
UPDATE products
SET    discount_percent = 0.25
WHERE  product_id = 1;

-- Verify the conversion
SELECT product_id, discount_percent
FROM   products
WHERE  product_id = 1;

-- Test 2: Invalid update – trigger raises an error (value > 100)
UPDATE products
SET    discount_percent = 150
WHERE  product_id = 1;

-- Rollback to restore the original value
ROLLBACK;