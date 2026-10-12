CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_artkz_posten
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT posten_id,
 posten_bez,
 mandant_id,
 spr_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_artkz_posten
WHERE mandant_id = 1;