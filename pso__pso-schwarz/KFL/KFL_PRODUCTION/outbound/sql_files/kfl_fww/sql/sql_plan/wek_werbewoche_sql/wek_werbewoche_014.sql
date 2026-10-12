/* AW check 2021-05-17*/


-- begin subquery
SELECT COUNT(*)
FROM dbp_data.tag
WHERE
    dat = CURRENT_DATE("Europe/Berlin")
    AND wtag_id BETWEEN 2 AND 3; -- end subquery
