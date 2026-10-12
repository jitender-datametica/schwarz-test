CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_owg_per
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT owg_id,
 arthiertyp_id,
 mandant_id,
 dat_von,
 dat_bis,
 hwg_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_owg_per
WHERE mandant_id = 1
 AND arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31';