CREATE OR REPLACE VIEW kfl_production_dbp_view.v_problemmeldung_obj_zu_1 AS SELECT system_id,
 mandant_id,
 problemmeldung_id,
 zus_obj_id,
 wert_dec,
 wert_date,
 wert_char
FROM kfl_production_dbp_data.problemmeldung_obj_zu_1;