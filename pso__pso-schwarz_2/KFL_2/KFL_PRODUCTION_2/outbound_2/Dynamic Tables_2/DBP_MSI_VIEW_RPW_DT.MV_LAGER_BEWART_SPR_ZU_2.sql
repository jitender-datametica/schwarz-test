CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_lager_bewart_spr_zu_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 lager_bewart_id,
 spr_id,
 lager_bewart_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_lager_bewart_spr_zu_2 AS V01
WHERE mandant_id = 1
 AND spr_id = 22
 AND system_id NOT IN (2, 17, 28, 32, 48, 53);