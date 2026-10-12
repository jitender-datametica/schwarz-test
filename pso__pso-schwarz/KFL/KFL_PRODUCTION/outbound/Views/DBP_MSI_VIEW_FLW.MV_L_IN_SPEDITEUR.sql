CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_spediteur (mandant_id, spediteur_id, spediteur_name) AS
SELECT mandant_id,
 ROUND(CAST(flw_lief_nr AS BIGNUMERIC), 0) AS spediteur_id,
   TRIM(lief_name_1) || ' ' || TRIM(lief_name_2) AS spediteur_name
FROM kfl_production_dbp_view.v_flw_lieferant AS DT1
WHERE CASE
   WHEN COALESCE(ROUND(SAFE_CAST(flw_lief_nr AS BIGNUMERIC), 0), 0) > 0
   THEN 1
   ELSE 0
   END = 1;