/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T2-mag-insert.sql

--Student ID: 33107327
--Student Name: Lachlan Lu

/* Comments for your marker:




*/

-- Task 2
--Load the AW_STATUS, AW_DISPLAY and SALE tables with your own test data using the
--supplied T2-mag-insert.sql script file, and SQL commands which will insert as a minimum,
--the following sample data:
--(i) 10 AW_DISPLAY entries
--  ● Involved at least 2 different display galleries
--  ● Included at least 3 different artwork display start dates
--  ● Included at least 5 different artworks
--  ● Involved at least 2 different artists
--(ii) 4 SALE entries
--(iii) Required AW_STATUS entries to support the AW_DISPLAY and SALE data you add

--------------------------------------
--INSERT INTO aw_display
--------------------------------------

-- #1: Artist 1, artwork 1
INSERT INTO aw_display VALUES (
    1, 1, 1, TO_DATE('15-Jun-2023 10:00', 'DD-MON-YYYY HH24:MI'), NULL, 1
);

-- #2: Artist 1, artwork 2
INSERT INTO aw_display VALUES (
    2, 1, 2, TO_DATE('15-Jun-2023 13:00', 'DD-MON-YYYY HH24:MI'), NULL, 1
);

-- #3: Artist 2, artwork 1
INSERT INTO aw_display VALUES (
    3, 2, 1, TO_DATE('16-Jun-2023 16:00', 'DD-MON-YYYY HH24:MI'), NULL, 1
);

-- #4: Artist 3, artwork 1
INSERT INTO aw_display VALUES (
    4, 3, 1, TO_DATE('17-Jun-2023 08:00', 'DD-MON-YYYY HH24:MI'), NULL, 1
);

-- #5: Artist 4, artwork 1
INSERT INTO aw_display VALUES (
    5, 4, 1, TO_DATE('17-Jun-2023 12:00', 'DD-MON-YYYY HH24:MI'), NULL, 2
);

-- #6: Artist 5, artwork 1
INSERT INTO aw_display VALUES (
    6, 5, 1, TO_DATE('17-Jun-2023 12:00', 'DD-MON-YYYY HH24:MI'), NULL, 2
);

-- #7: Artist 5, artwork 2
INSERT INTO aw_display VALUES (
    7, 5, 2, TO_DATE('18-Jun-2023 17:00', 'DD-MON-YYYY HH24:MI'), 
    TO_DATE('23-Jun-2023 16:00', 'DD-MON-YYYY HH24:MI'), 2
);

-- #8: Artist 7, artwork 1
INSERT INTO aw_display VALUES (
    8, 7, 1, TO_DATE('18-Jun-2023 14:00', 'DD-MON-YYYY HH24:MI'), 
    TO_DATE('24-Jun-2023 13:00', 'DD-MON-YYYY HH24:MI'), 2
);

-- #9: Artist 8, artwork 1
INSERT INTO aw_display VALUES (
    9, 8, 1, TO_DATE('21-Jun-2023 08:00', 'DD-MON-YYYY HH24:MI'), 
    TO_DATE('26-Jun-2023 09:00', 'DD-MON-YYYY HH24:MI'), 1
);

-- 10: Artist 8, artwork 2
INSERT INTO aw_display VALUES (
    10, 8, 2, TO_DATE('21-Jun-2023 10:00', 'DD-MON-YYYY HH24:MI'), 
    TO_DATE('29-Jun-2023 11:00', 'DD-MON-YYYY HH24:MI'), 1
);

--------------------------------------
--INSERT INTO aw_status
--------------------------------------
-- #1: Artist 1, artwork 1
INSERT INTO aw_status VALUES (
    14, 1, 1, TO_DATE('13-Jun-2023 08:00', 'DD-MON-YYYY HH24:MI'), 'T', 1
);
INSERT INTO aw_status VALUES (
    15, 1, 1, TO_DATE('13-Jun-2023 10:00', 'DD-MON-YYYY HH24:MI'), 'G', 1
);

-- #2: Artist 1, artwork 2
INSERT INTO aw_status VALUES (
    16, 1, 2, TO_DATE('14-Jun-2023 11:00', 'DD-MON-YYYY HH24:MI'), 'T', 1
);
INSERT INTO aw_status VALUES (
    17, 1, 2, TO_DATE('14-Jun-2023 14:00', 'DD-MON-YYYY HH24:MI'), 'G', 1
);

-- #3: Artist 2, artwork 1
INSERT INTO aw_status VALUES (
    18, 2, 1, TO_DATE('16-Jun-2023 12:00', 'DD-MON-YYYY HH24:MI'), 'T', 1
);
INSERT INTO aw_status VALUES (
    19, 2, 1, TO_DATE('16-Jun-2023 15:00', 'DD-MON-YYYY HH24:MI'), 'G', 1
);

-- #4: Artist 3, artwork 1
INSERT INTO aw_status VALUES (
    20, 3, 1, TO_DATE('16-Jun-2023 15:00', 'DD-MON-YYYY HH24:MI'), 'T', 1
);
INSERT INTO aw_status VALUES (
    21, 3, 1, TO_DATE('16-Jun-2023 18:00', 'DD-MON-YYYY HH24:MI'), 'G', 1
);

-- #5: Artist 4, artwork 1
INSERT INTO aw_status VALUES (
    22, 4, 1, TO_DATE('17-Jun-2023 09:00', 'DD-MON-YYYY HH24:MI'), 'T', 2
);
INSERT INTO aw_status VALUES (
    23, 4, 1, TO_DATE('17-Jun-2023 11:00', 'DD-MON-YYYY HH24:MI'), 'G', 2
);

-- #6: Artist 5, artwork 1
INSERT INTO aw_status VALUES (
    24, 5, 1, TO_DATE('17-Jun-2023 09:00', 'DD-MON-YYYY HH24:MI'), 'T', 2
);
INSERT INTO aw_status VALUES (
    25, 5, 1, TO_DATE('17-Jun-2023 11:00', 'DD-MON-YYYY HH24:MI'), 'G', 2
);

-- #7: Artist 5, artwork 2
INSERT INTO aw_status VALUES (
    26, 5, 2, TO_DATE('17-Jun-2023 12:00', 'DD-MON-YYYY HH24:MI'), 'T', 2
);
INSERT INTO aw_status VALUES (
    27, 5, 2, TO_DATE('17-Jun-2023 14:00', 'DD-MON-YYYY HH24:MI'), 'G', 2
);
INSERT INTO aw_status VALUES (
    28, 5, 2, TO_DATE('23-Jun-2023 16:00', 'DD-MON-YYYY HH24:MI'), 'S', NULL
);

-- #8: Artist 7, artwork 1
INSERT INTO aw_status VALUES (
    29, 7, 1, TO_DATE('18-Jun-2023 08:00', 'DD-MON-YYYY HH24:MI'), 'T', 2
);
INSERT INTO aw_status VALUES (
    30, 7, 1, TO_DATE('18-Jun-2023 12:00', 'DD-MON-YYYY HH24:MI'), 'G', 2
);
INSERT INTO aw_status VALUES (
    31, 7, 1, TO_DATE('24-Jun-2023 13:00', 'DD-MON-YYYY HH24:MI'), 'S', NULL
);

-- #9: Artist 8, artwork 1
INSERT INTO aw_status VALUES (
    32, 8, 1, TO_DATE('19-Jun-2023 08:00', 'DD-MON-YYYY HH24:MI'), 'T', 1
);
INSERT INTO aw_status VALUES (
    33, 8, 1, TO_DATE('20-Jun-2023 12:00', 'DD-MON-YYYY HH24:MI'), 'G', 1
);
INSERT INTO aw_status VALUES (
    34, 8, 1, TO_DATE('26-Jun-2023 09:00', 'DD-MON-YYYY HH24:MI'), 'S', NULL
);

-- 10: Artist 8, artwork 2
INSERT INTO aw_status VALUES (
    35, 8, 2, TO_DATE('19-Jun-2023 08:00', 'DD-MON-YYYY HH24:MI'), 'T', 1
);
INSERT INTO aw_status VALUES (
    36, 8, 2, TO_DATE('20-Jun-2023 12:00', 'DD-MON-YYYY HH24:MI'), 'G', 1
);
INSERT INTO aw_status VALUES (
    37, 8, 2, TO_DATE('29-Jun-2023 11:00', 'DD-MON-YYYY HH24:MI'), 'S', NULL
);

--------------------------------------
--INSERT INTO sale
--------------------------------------
-- #7: Artist 5, artwork 2
INSERT INTO sale VALUES (
    1, TO_DATE('23-Jun-2023 16:00', 'DD-MON-YYYY HH24:MI'), 70000, 1, 7
);

-- #8: Artist 7, artwork 1
INSERT INTO sale VALUES (
    2, TO_DATE('24-Jun-2023 13:00', 'DD-MON-YYYY HH24:MI'), 20000, 3, 8
);

-- #9: Artist 8, artwork 1
-- Minimum sale = 23100 / (1.00 - .20 - .056) = 23100 / .744 = 31048.39
INSERT INTO sale VALUES (
    3, TO_DATE('26-Jun-2023 09:00', 'DD-MON-YYYY HH24:MI'), 31048.39, 5, 9
);

-- #10: Artist 8, artwork 2
INSERT INTO sale VALUES (
    4, TO_DATE('29-Jun-2023 11:00', 'DD-MON-YYYY HH24:MI'), 65000, 6, 10
);


commit;