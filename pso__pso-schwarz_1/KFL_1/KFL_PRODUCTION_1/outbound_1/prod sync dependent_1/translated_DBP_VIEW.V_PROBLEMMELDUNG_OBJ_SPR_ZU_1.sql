CREATE OR REPLACE VIEW kfl_production_dbp_view.v_problemmeldung_obj_spr_zu_1 (system_id, mandant_id, spr_id, zus_obj_id,
zus_obj_bez, td_update, td_insert) AS SELECT system_id,
 mandant_id,
 spr_id,
 zus_obj_id,
 zus_obj_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.problemmeldung_obj_spr_zu_1;