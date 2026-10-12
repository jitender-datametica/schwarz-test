CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_letzte_problemmeldung_1 (last_fg, system_id, mandant_id,
problemmeldung_id, beleg_gj, beleg_id, dat, problemmeldung_ecm_lfd_nr, letzte_problemcode_id) AS SELECT last_fg,
 7 AS system_id,
 mandant_id,
 problemmeldung_id,
 beleg_gj,
 beleg_id,
 dat,
 problemmeldung_ecm_lfd_nr,
 problemcode_id AS letzte_problemcode_id
FROM kfl_production_dbp_view.v_problemmeldung_1 AS V01
WHERE last_fg = 1
 AND mandant_id = 1;