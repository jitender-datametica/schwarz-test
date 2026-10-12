/* AW check 2021-05-17*/


-- begin subquery
SELECT COUNT(*)
FROM (
    SELECT MIN(dat) AS dat
    FROM dbp_data.tag
    WHERE akt_mo = 1
) AS a
INNER JOIN dbp_data.tag AS B ON a.dat = B.dat
WHERE B.dat = CURRENT_DATE("Europe/Berlin"); -- end subquery
