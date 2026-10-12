--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT COUNT(*) FROM (

--begin subquery
SELECT mandant_id
      ,COUNT(*)   AS AnzSaetze
      ,MIN(gjmo)  AS Min_GJMO
FROM DBP_ETL.vis_monat_bestand_wg_log_2
GROUP BY mandant_id

--end subquery

);

