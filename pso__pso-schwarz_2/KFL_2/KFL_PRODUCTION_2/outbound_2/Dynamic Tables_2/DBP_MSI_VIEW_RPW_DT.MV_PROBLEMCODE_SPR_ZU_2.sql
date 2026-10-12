CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_problemcode_spr_zu_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 problemcode_id,
 spr_id,
 problemcode_bez,
 problemcode_bez_kurz,
 problemcode_bez_lang,
 7 AS system_id
FROM kfl_production_dbp_view.v_problemcode_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22;