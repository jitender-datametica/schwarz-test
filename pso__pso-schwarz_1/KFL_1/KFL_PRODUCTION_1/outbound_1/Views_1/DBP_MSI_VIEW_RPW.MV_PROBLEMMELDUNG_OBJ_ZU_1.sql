CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_problemmeldung_obj_zu_1 (system_id, mandant_id,
problemmeldung_id, zus_obj_id, wert_dec, wert_date, wert_char) AS SELECT 7 AS system_id,
 mandant_id,
 problemmeldung_id,
 zus_obj_id,
 wert_dec,
 wert_date,
 wert_char
FROM kfl_production_dbp_view.v_problemmeldung_obj_zu_1
WHERE mandant_id = 1;