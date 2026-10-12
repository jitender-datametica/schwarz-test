--[OK] statement is translated correctly (syntax and type checks are fine)


-- begin subquery
SELECT COUNT(*)
FROM dbp_data.tag_1
WHERE
    dat = CURRENT_DATE("Europe/Berlin")
    AND wtag_id IN (6, 7); -- end subquery
