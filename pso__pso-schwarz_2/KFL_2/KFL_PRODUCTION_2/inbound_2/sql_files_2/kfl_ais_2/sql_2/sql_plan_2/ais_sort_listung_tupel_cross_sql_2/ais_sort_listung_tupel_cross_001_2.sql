--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT COUNT(*) FROM (

--begin subquery
SELECT *
FROM DBP_DATA.tag_2
WHERE dat = CURRENT_DATE AND
      wtag_id IN (6,7)

--end subquery

);

