--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT COUNT(*) FROM (

--begin subquery
SELECT wtag_id 
FROM DBP_DATA.tag
WHERE dat = CURRENT_DATE AND
      wtag_id = 1

--end subquery

);

