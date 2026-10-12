/* AW check 2021-05-17*/
SELECT COUNT(*) FROM (

--begin subquery
SELECT *
FROM DBP_DATA.tag_1
WHERE dat = CURRENT_DATE AND
      wtag_id BETWEEN 2 AND 3

--end subquery

);
