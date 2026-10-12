CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_statuscode_spr_zu_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 statuscode_id,
 spr_id,
 statuscode_bez,
 statuscode_bez_kurz,
 statuscode_bez_lang,
 7 AS system_id
FROM kfl_production_dbp_view.v_statuscode_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22;