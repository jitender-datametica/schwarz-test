CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_wg_per_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT wg_id,
 arthiertyp_id,
 mandant_id,
 lead_mwst_id,
 dat_von,
 abt_id,
 dat_bis,
 7 AS system_id,
 owg_id
FROM kfl_production_dbp_view.v_wg_per_2
WHERE mandant_id = 1
 AND arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31'
 AND abt_id NOT IN (0, -1, -2, -3);