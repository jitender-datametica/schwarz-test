--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT COUNT(*) FROM (

--begin subquery
SELECT   dat
FROM DBP_DATA.artbew_agg_wt_2
GROUP BY 1

--end subquery

);

