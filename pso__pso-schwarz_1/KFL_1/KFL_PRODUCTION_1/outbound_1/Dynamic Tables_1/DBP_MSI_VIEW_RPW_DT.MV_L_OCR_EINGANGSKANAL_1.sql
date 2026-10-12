CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_l_ocr_eingangskanal_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT *
FROM kfl_production_dbp_view.v_l_ocr_eingangskanal_1
WHERE mandant_id = 1;