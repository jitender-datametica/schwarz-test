CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_bestellart_spr_zu_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 bestellart_id,
 spr_id,
 bestellart_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_bestellart_spr_zu_2
WHERE spr_id = 22
 AND mandant_id = 1;