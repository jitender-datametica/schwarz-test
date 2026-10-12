CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_problemmeldung_obj_zu
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT 7 AS system_id,
 mandant_id,
 problemmeldung_id,
 zus_obj_id,
 wert_dec,
 wert_date,
 wert_char
FROM kfl_production_dbp_view.v_problemmeldung_obj_zu
WHERE mandant_id = 1;