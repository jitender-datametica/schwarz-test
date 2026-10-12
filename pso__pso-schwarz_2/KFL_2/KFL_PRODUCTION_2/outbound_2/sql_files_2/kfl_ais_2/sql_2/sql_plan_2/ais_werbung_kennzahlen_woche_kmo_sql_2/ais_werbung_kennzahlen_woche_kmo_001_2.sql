--[OK] statement is translated correctly (syntax and type checks are fine)


-- begin subquery
SELECT COUNT(*)
FROM dbp_data.tag_2
WHERE
    dat = CURRENT_DATE("Europe/Berlin")
    AND wtag_id = 1; -- end subquery
