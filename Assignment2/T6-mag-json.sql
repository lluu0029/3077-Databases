/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T6-mag-json.sql

--Student ID: 33107327
--Student Name: Lachlan Lu


/* Comments for your marker:




*/

-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT TO GENERATE 
-- THE COLLECTION OF JSON DOCUMENTS HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    JSON_OBJECT (
        '_id' VALUE artist.ARTIST_CODE, 'name' VALUE artist_gname || ' ' || artist_fname, 
        'address' VALUE JSON_OBJECT (
            'street' VALUE artist_street,
            'city' VALUE artist_city,
            'state' VALUE state_code
        ),
        'phone' VALUE artist_phone, 'no_artworks' VALUE num_artwork_selling_sold,
        'artworks' VALUE JSON_ARRAYAGG(
            JSON_OBJECT(
            'no' VALUE artwork_no,
            'title' VALUE artwork_title,
            'minimum_price' VALUE artwork_minprice
            )
        ) FORMAT JSON ) 
        || ','
FROM
    artist
JOIN
    artwork on artist.ARTIST_CODE = artwork.ARTIST_CODE
GROUP BY
    artist.artist_code, artist.artist_gname, artist.artist_fname, artist.artist_street, artist.artist_city, artist.artist_phone, 
    artist.state_code, artist.num_artwork_selling_sold;