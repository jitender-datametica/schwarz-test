CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_gp_zusatz_per
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT mandant_id,
 gp_id,
 einkaufsorganisation_id,
 dat_von,
 entgelt_mind_kz,
 ret_sperrprofil_id,
 7 AS system_id,
 dat_bis
FROM kfl_production_dbp_view.v_gp_zusatz_per
WHERE (gp_id, mandant_id, dat_bis) IN (SELECT (gp_id, mandant_id, MAX(dat_bis))
   FROM kfl_production_dbp_view.v_gp_zusatz_per
   WHERE mandant_id = 1
   GROUP BY gp_id,
    mandant_id);