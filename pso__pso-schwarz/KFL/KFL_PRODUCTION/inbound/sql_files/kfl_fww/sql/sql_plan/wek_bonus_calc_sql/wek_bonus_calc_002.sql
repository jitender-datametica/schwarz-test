/* AW check 2021-05-17*/
SELECT COUNT(*) FROM (

--begin subquery
SELECT wtag_id
FROM (SELECT MIN(dat) AS dat
      FROM DBP_DATA.tag
      WHERE akt_mo = 1) a
JOIN DBP_DATA.tag b
  ON a.dat = b.dat
WHERE b.dat = CURRENT_DATE

--end subquery

);
