CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_problemmeldung_obj (system_id, mandant_id, zus_obj_id, td_update,
td_insert) AS SELECT system_id,
 mandant_id,
 zus_obj_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_problemmeldung_obj;