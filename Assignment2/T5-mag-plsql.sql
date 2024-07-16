--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T5-mag-plsql.sql

--Student ID: 33107327
--Student Name: Lachlan Lu

/* Comments for your marker:


*/

SET SERVEROUTPUT ON

--(a) 
--Write your trigger statement, 
--finish it with a slash(/) followed by a blank line
CREATE OR REPLACE TRIGGER check_sale_price BEFORE
    INSERT ON sale FOR EACH ROW
DECLARE
    min_price NUMBER;
BEGIN
    SELECT 
        ARTWORK_MINPRICE / (1.0 - 0.2 - (gallery_sale_percent / 100)) INTO min_price FROM aw_display display
    JOIN
        gallery on gallery.GALLERY_ID = display.GALLERY_ID
    JOIN
        artwork on artwork.ARTIST_CODE = display.ARTIST_CODE AND artwork.ARTWORK_NO = display.ARTWORK_NO
    WHERE 
        display.AW_DISPLAY_ID = :new.AW_DISPLAY_ID;

    IF :new.SALE_PRICE < min_price THEN
        raise_application_error(-20000, 'Sale price cannot be below minimum of: ' || min_price);
    END IF;
END;
/
commit;
-- Write Test Harness for (a)
-- Sale price < min_price
INSERT INTO sale VALUES (
    600, TO_DATE('10-Jul-2023 10:00', 'DD-MON-YYYY HH24:MI'), 0, 1, 5
);

-- Sale price >= min_price
INSERT INTO sale VALUES (
    601, TO_DATE('10-Jul-2023 10:00', 'DD-MON-YYYY HH24:MI'), 50000, 1, 5
);

ROLLBACK;



--(b) 
-- Complete the procedure below
CREATE OR REPLACE PROCEDURE prc_insert_sale (
    p_customer_id   IN NUMBER,
    p_artist_code   IN NUMBER,
    p_artwork_no    IN NUMBER,
    p_sale_price    IN NUMBER,
    p_output    OUT VARCHAR2
) AS
    var_customer_id_found NUMBER;
    var_aw_display_found NUMBER;
    var_display_id NUMBER;
    customer_not_found EXCEPTION;
    display_not_found EXCEPTION;
BEGIN
    SELECT 
        COUNT(*) INTO var_customer_id_found FROM customer
    WHERE
        customer.CUSTOMER_ID = p_customer_id;
    
    SELECT
        COUNT(*) INTO var_aw_display_found FROM aw_display display
    WHERE
        display.ARTIST_CODE = p_artist_code AND display.artwork_no = p_artwork_no  AND SYSDATE > display.AW_DISPLAY_START_DATE AND 
        SYSDATE < NVL(display.AW_DISPLAY_END_DATE, TO_DATE('31-Dec-9999', 'DD-MON-YYYY'));
        -- NVL is used to replace a null aw_display_end_date with '31-Dec-9999' to allow for comparison.

    IF (var_customer_id_found = 0) THEN
        RAISE customer_not_found;
        p_output := 'Invalid customer id, not found';
    ELSE
        IF (var_aw_display_found = 0) THEN
            RAISE display_not_found;
            p_output := 'Invalid display, not found';
        ELSE
            INSERT INTO sale VALUES (
                SALE_ID_SEQ.NEXTVAL, SYSDATE, p_sale_price, p_customer_id, (
                    SELECT 
                        display.AW_DISPLAY_ID FROM aw_display display
                    WHERE
                        display.ARTIST_CODE = p_artist_code AND display.artwork_no = p_artwork_no  AND SYSDATE > display.AW_DISPLAY_START_DATE AND 
                        SYSDATE < NVL(display.AW_DISPLAY_END_DATE, TO_DATE('31-Dec-9999', 'DD-MON-YYYY')))
            );
            p_output := 'Sale inserted successfully';
        END IF;
    END IF;

EXCEPTION 
-- catch the error raised by the DML statements
    WHEN customer_not_found THEN
        raise_application_error(-20001, 'Customer id does not exist');
    WHEN display_not_found THEN
        raise_application_error(-20002, 'Display does not exist');
   WHEN OTHERS THEN
      raise_application_error(-20010,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
/
commit;

-- Write Test Harness for (b)
-- Invalid customer_id
DECLARE 
    output VARCHAR2(200);
BEGIN
    prc_insert_sale(1000, 2, 1, 99999, output);
    dbms_output.put_line(output);
END;
/

-- Invalid aw_display, artwork not on display.
DECLARE 
    output VARCHAR2(200);
BEGIN
    prc_insert_sale(1, 10, 1, 99999, output);
    dbms_output.put_line(output);
END;
/

-- Valid customer_id and aw_display
DECLARE 
    output VARCHAR2(200);
BEGIN
    prc_insert_sale(1, 2, 1, 99999, output);
    dbms_output.put_line(output);
END;
/

ROLLBACK;