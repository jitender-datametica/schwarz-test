CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_letzte_statusmeldung_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT last_fg,
 7 AS system_id,
 mandant_id,
 statusmeldung_id,
 beleg_gj,
 beleg_id,
 zeitstempel,
 dat,
 statusmeldung_ecm_lfd_nr,
 statuscode_id AS letzte_statuscode_id,
 ersteller_id
FROM kfl_production_dbp_view.v_statusmeldung_2 AS V01
WHERE last_fg = 1
 AND mandant_id = 1;