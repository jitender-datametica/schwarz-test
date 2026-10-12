CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_ocr_eingangskanal_spr_zu_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 ocr_eingangskanal_id,
 ocr_eingangskanal_bez
FROM kfl_production_dbp_view.v_ocr_eingangskanal_spr_zu_1
WHERE spr_id = 22
 AND mandant_id = 1;