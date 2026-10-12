--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT COUNT(*) FROM (

--begin subquery
SELECT dat_buch 
FROM DBP_DATA.lagerbew_det_delta_2
LIMIT 1
--end subquery

);

