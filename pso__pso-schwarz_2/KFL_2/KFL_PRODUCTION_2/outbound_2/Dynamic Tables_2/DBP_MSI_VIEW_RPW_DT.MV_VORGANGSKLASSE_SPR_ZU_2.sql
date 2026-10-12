CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_vorgangsklasse_spr_zu_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT 7 AS system_id,
 mandant_id,
 vorgangsklasse_id,
 spr_id,
 vorgangsklasse_bez,
 vorgangsklasse_bez_kurz,
 vorgangsklasse_bez_lang
FROM kfl_production_dbp_view.v_vorgangsklasse_spr_zu_2
WHERE mandant_id = 1;