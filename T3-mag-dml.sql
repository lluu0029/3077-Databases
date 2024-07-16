/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T3-mag-dml.sql

--Student ID: 33107327
--Student Name: Lachlan Lu

/* Comments for your marker:




*/

/*(a)*/
DROP SEQUENCE aw_display_id_seq;
CREATE SEQUENCE aw_display_id_seq START WITH 100 INCREMENT BY 10;

DROP SEQUENCE aws_id_seq;
CREATE SEQUENCE aws_id_seq START WITH 100 INCREMENT BY 10;

DROP SEQUENCE sale_id_seq;
CREATE SEQUENCE sale_id_seq START WITH 100 INCREMENT BY 10;

commit;

/*(b)*/
-- Adding to artwork table
INSERT INTO artwork VALUES (
    1, 
    (SELECT MAX(artwork.artwork_no) + 1 FROM artwork
    WHERE artwork.ARTIST_CODE = 1), 
    'Shattered glass', 25000,  TO_DATE('30-Dec-2023 11:00', 'DD-MON-YYYY HH24:MI')
);
commit;

-- Adding to aw_status table
INSERT INTO aw_status VALUES (
    aws_id_seq.nextval, 1, 
    (SELECT artwork.ARTWORK_NO FROM artwork
    WHERE artwork.ARTIST_CODE = 1 AND lower(artwork.ARTWORK_TITLE) = 'shattered glass'), 
    TO_DATE('30-Dec-2023 11:00', 'DD-MON-YYYY HH24:MI'), 'W', NULL
);
commit;


/*(c)*/
-- Transit status
INSERT INTO aw_status VALUES (
    aws_id_seq.nextval, 1, 
    (SELECT artwork.ARTWORK_NO FROM artwork
    WHERE artwork.ARTIST_CODE = 1 AND lower(artwork.ARTWORK_TITLE) = 'shattered glass'), 
    TO_DATE('1-Jan-2024 13:00', 'DD-MON-YYYY HH24:MI'), 'T', 
    (SELECT gallery.GALLERY_ID FROM gallery
    WHERE gallery.GALLERY_PHONE = '0490556646' AND lower(gallery.GALLERY_NAME) = 'art smart')
);
commit;

-- Arrived at gallery status
INSERT INTO aw_status VALUES (
    aws_id_seq.nextval, 1, 
    (SELECT artwork.ARTWORK_NO FROM artwork
    WHERE artwork.ARTIST_CODE = 1 AND lower(artwork.ARTWORK_TITLE) = 'shattered glass'), 
    TO_DATE('1-Jan-2024 13:00', 'DD-MON-YYYY HH24:MI') + (2.5/24), 'G', 
    (SELECT gallery.GALLERY_ID FROM gallery
    WHERE gallery.GALLERY_PHONE = '0490556646' AND lower(gallery.GALLERY_NAME) = 'art smart')
);
commit;

-- AW_DISPLAY entry for the artwork.
-- Hour for when the artwork is to be displayed and display ended was not specified.
-- As such, assumed that it is 24 hours after it arrived.
INSERT INTO aw_display VALUES (
    aw_display_id_seq.nextval, 1, 
    (SELECT artwork.ARTWORK_NO FROM artwork
    WHERE artwork.ARTIST_CODE = 1 AND lower(artwork.ARTWORK_TITLE) = 'shattered glass'),
    TO_DATE('1-Jan-2024 13:00', 'DD-MON-YYYY HH24:MI') + 24/24, TO_DATE('1-Jan-2024 13:00', 'DD-MON-YYYY HH24:MI') + 24/24 + 14,
    (SELECT gallery.GALLERY_ID FROM gallery
    WHERE gallery.GALLERY_PHONE = '0490556646' AND lower(gallery.GALLERY_NAME) = 'art smart')
);
commit;


/*(d)*/
-- AW_STATUS for when it is sold.
INSERT INTO aw_status VALUES (
    aws_id_seq.nextval, 1, 
    (SELECT artwork.ARTWORK_NO FROM artwork
    WHERE artwork.ARTIST_CODE = 1 AND lower(artwork.ARTWORK_TITLE) = 'shattered glass'),
    TO_DATE('4-Jan-2024 11:30', 'DD-MON-YYYY HH24:MI'), 'S', 
    (SELECT gallery.GALLERY_ID FROM gallery
    WHERE gallery.GALLERY_PHONE = '0490556646' AND lower(gallery.GALLERY_NAME) = 'art smart')
);
commit;

-- SALE entry for the sale.
INSERT INTO sale VALUES (
    sale_id_seq.nextval, TO_DATE('4-Jan-2024 11:30', 'DD-MON-YYYY HH24:MI'), 24999.99,
    (SELECT customer.CUSTOMER_ID FROM customer
    WHERE customer.CUSTOMER_PHONE = 0458708402 AND lower(customer.CUSTOMER_GNAME) = 'lois' 
    AND lower(customer.CUSTOMER_FNAME) = 'hawkshaw'),
    (SELECT aw_display.AW_DISPLAY_ID FROM aw_display
    WHERE aw_display.ARTIST_CODE = 1 AND aw_display.ARTWORK_NO = (
        SELECT artwork.ARTWORK_NO FROM artwork
        WHERE artwork.ARTIST_CODE = 1 AND lower(artwork.ARTWORK_TITLE) = 'shattered glass')
    )
);
commit;

UPDATE aw_display
SET
    aw_display_end_date = TO_DATE('4-Jan-2024 11:30', 'DD-MON-YYYY HH24:MI')
WHERE
    artist_code = 1 AND artwork_no = (
    SELECT artwork.ARTWORK_NO FROM artwork
    WHERE artwork.ARTIST_CODE = 1 AND lower(artwork.ARTWORK_TITLE) = 'shattered glass');
commit;


/*(e)*/
-- Delete entry from sale
DELETE FROM SALE
WHERE
    sale_price = 24999.99 AND customer_id = (SELECT customer.CUSTOMER_ID FROM customer
    WHERE customer.CUSTOMER_PHONE = 0458708402 AND lower(customer.CUSTOMER_GNAME) = 'lois' 
    AND lower(customer.CUSTOMER_FNAME) = 'hawkshaw')
    AND aw_display_id = (SELECT aw_display.AW_DISPLAY_ID FROM aw_display
    WHERE aw_display.ARTIST_CODE = 1 AND aw_display.ARTWORK_NO = (
        SELECT artwork.ARTWORK_NO FROM artwork
        WHERE artwork.ARTIST_CODE = 1 AND lower(artwork.ARTWORK_TITLE) = 'shattered glass'));
commit;

-- Delete entry from aw_status
DELETE FROM aw_status
WHERE
    artist_code = 1 AND artwork_no = (SELECT artwork.ARTWORK_NO FROM artwork
    WHERE artwork.ARTIST_CODE = 1 AND lower(artwork.ARTWORK_TITLE) = 'shattered glass')
    AND lower(aws_status) = 's';
commit;

-- Update aw_display to revert back to the original display end date.
-- Original display_start_date = TO_DATE('1-Jan-2024 13:00', 'DD-MON-YYYY HH24:MI') + 24/24
UPDATE aw_display
SET
    aw_display_end_date = TO_DATE('1-Jan-2024 13:00', 'DD-MON-YYYY HH24:MI') + 24/24 + 14
WHERE
    artist_code = 1 AND artwork_no = (SELECT artwork.ARTWORK_NO FROM artwork
    WHERE artwork.ARTIST_CODE = 1 AND lower(artwork.ARTWORK_TITLE) = 'shattered glass')
    AND aw_display_start_date = TO_DATE('1-Jan-2024 13:00', 'DD-MON-YYYY HH24:MI') + 24/24;
commit;