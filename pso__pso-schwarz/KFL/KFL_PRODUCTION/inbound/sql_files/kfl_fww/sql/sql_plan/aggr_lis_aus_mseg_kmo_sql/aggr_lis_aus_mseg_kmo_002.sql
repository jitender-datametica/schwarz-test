SELECT COUNT(*) FROM (

--begin subquery
SELECT dat_buch, mandant_id FROM DBP_ETL.kmo_mseg_dat GROUP BY 1,2
--end subquery

);
