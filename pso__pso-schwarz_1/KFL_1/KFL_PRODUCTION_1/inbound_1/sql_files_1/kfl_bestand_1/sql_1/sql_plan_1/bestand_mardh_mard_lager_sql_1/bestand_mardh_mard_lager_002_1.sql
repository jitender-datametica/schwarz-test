--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT COUNT(*) FROM (

--begin subquery
SELECT mandant_id, COUNT(*)
FROM DBP_ETL.bestand_mardh_mard_vz_log_1
GROUP BY 1

--end subquery

);

