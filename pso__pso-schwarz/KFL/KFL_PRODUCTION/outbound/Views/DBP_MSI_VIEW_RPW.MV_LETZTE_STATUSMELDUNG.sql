CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_letzte_statusmeldung (last_fg, system_id, mandant_id,
statusmeldung_id, beleg_gj, beleg_id, zeitstempel, dat, statusmeldung_ecm_lfd_nr, letzte_statuscode_id, ersteller_id) AS
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
FROM kfl_production_dbp_view.v_statusmeldung AS V01
WHERE last_fg = 1
 AND mandant_id = 1;