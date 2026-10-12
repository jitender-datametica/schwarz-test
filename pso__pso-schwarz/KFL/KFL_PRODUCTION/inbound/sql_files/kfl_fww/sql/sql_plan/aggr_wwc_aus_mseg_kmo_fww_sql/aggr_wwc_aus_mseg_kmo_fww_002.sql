SELECT COUNT(*) FROM (

--begin subquery
SELECT dat_buch, 
       mandant_id,
       kjmo,
       kjwo 
FROM DBP_ETL.kmo_mseg_dat_wwc 
GROUP BY 1,2,3,4
--end subquery

);

