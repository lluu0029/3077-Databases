/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T4-mag-mods.sql

--Student ID: 33107327
--Student Name: Lachlan Lu

/* Comments for your marker:




*/

/*(a)*/
-- Initial table structure and data of ARTIST prior to any changes.
DESC artist;
SELECT * FROM artist;

-- Creating attribute 'num_artwork_selling_sold' to represent the number of 
-- artworks an artist is selling or has sold.
ALTER TABLE artist
ADD num_artwork_selling_sold NUMBER(4);
-- Column comment
COMMENT ON COLUMN artist.num_artwork_selling_sold IS
'Number of artworks artist is selling or has sold';
commit;
-- DESC used to show structural change to ARTIST
DESC artist;

-- Adding data to 'num_artwork_selling_sold' for each artist.
-- NVL is used to replace a NULL count with zero.
UPDATE artist
SET artist.num_artwork_selling_sold = NVL((SELECT COUNT(*) FROM (
        SELECT 
            artwork.ARTIST_CODE, artwork.ARTWORK_NO FROM artwork
        MINUS
        SELECT  
            aw_status.ARTIST_CODE, aw_status.ARTWORK_NO FROM aw_status
        WHERE
            lower(aw_status.AWS_STATUS) = 'r') art_submitted
        WHERE 
            artist.ARTIST_CODE = art_submitted.ARTIST_CODE
        GROUP BY
            art_submitted.ARTIST_CODE), 0);
commit;
-- SELECT used to show data changes in artist.
SELECT * FROM artist;

/*(b)*/
DROP TABLE customer_artist_purchases CASCADE CONSTRAINTS;

-- Create table customer_artist_purchases to show the number of purchases a 
-- customer has bought from an artist.
CREATE TABLE customer_artist_purchases AS 
    (SELECT 
        customer.CUSTOMER_ID, artist_code, COUNT(artist_code) as purchases_from_artist FROM customer
    JOIN
        sale on customer.CUSTOMER_ID = sale.CUSTOMER_ID
    JOIN
        aw_display display on sale.AW_DISPLAY_ID = display.AW_DISPLAY_ID
    GROUP BY
        customer.CUSTOMER_ID, ARTIST_CODE);
commit;

-- Column comment
COMMENT ON COLUMN customer_artist_purchases.purchases_from_artist IS
'Number of artworks purchased by a customer from an artist';
commit;

-- Adding primary key
ALTER TABLE customer_artist_purchases 
ADD CONSTRAINT customer_artist_purchases_pk PRIMARY KEY (customer_id, artist_code);
commit;

-- Adding foreign key for customer_id
ALTER TABLE customer_artist_purchases 
ADD CONSTRAINT customer_id_customer_artist_purchases_fk FOREIGN KEY (customer_id)
REFERENCES customer (customer_id);
commit;

-- Adding foreign key for artist_code
ALTER TABLE customer_artist_purchases 
ADD CONSTRAINT artist_code_customer_artist_purchases_fk FOREIGN KEY (artist_code)
REFERENCES artist (artist_code);
commit;

-- Select to show the table
SELECT * FROM customer_artist_purchases;