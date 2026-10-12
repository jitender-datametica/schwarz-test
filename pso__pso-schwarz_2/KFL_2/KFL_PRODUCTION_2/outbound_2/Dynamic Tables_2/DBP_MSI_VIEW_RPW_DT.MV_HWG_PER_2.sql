CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_hwg_per_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT hwg_id,
 arthiertyp_id,
 mandant_id,
 dat_von,
 dat_bis,
 abt_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_hwg_per_2
WHERE mandant_id = 1
 AND arthiertyp_id = 2;