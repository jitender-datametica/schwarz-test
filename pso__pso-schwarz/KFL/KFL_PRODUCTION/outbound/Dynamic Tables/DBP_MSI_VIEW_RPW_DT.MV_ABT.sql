CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_abt
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT abt_id,
 arthiertyp_id,
 mandant_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_abt
WHERE mandant_id = 1
 AND arthiertyp_id = 2
 AND abt_id NOT IN (0, -1, -2, -3);