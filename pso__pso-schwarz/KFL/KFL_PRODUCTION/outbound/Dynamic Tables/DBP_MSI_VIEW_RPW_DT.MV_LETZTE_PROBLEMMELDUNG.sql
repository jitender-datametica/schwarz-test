CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_letzte_problemmeldung
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT last_fg,
 7 AS system_id,
 mandant_id,
 problemmeldung_id,
 beleg_gj,
 beleg_id,
 dat,
 problemmeldung_ecm_lfd_nr,
 problemcode_id AS letzte_problemcode_id
FROM kfl_production_dbp_view.v_problemmeldung AS V01
WHERE last_fg = 1
 AND mandant_id = 1;