/* AW check 2021-05-17*/


-- begin subquery
SELECT COUNT(*)
FROM dbp_data.tag_1
WHERE
    dat = CURRENT_DATE("Europe/Berlin")
    AND wtag_id BETWEEN 2 AND 4; -- end subquery
