CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_art_wg_zu_per_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 art_id,
 wg_id,
 wug_id,
 arthiertyp_id
FROM kfl_production_dbp_view.v_art_wg_zu_per_2 AS V01
WHERE mandant_id <> 1
 AND arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31';