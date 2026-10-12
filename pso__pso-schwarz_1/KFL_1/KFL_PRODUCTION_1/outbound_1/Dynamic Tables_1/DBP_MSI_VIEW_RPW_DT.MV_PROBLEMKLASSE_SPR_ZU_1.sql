CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_problemklasse_spr_zu_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 problemklasse_id,
 spr_id,
 problemklasse_bez,
 problemklasse_bez_kurz,
 problemklasse_bez_lang,
 7 AS system_id
FROM kfl_production_dbp_view.v_problemklasse_spr_zu_1
WHERE mandant_id = 1
 AND spr_id = 22;