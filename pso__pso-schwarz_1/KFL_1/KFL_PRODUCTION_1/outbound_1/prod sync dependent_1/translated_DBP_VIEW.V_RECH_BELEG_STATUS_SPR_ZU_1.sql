CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rech_beleg_status_spr_zu_1 (system_id, mandant_id, spr_id,
rech_beleg_status_id, rech_beleg_status_bez, td_update, td_insert) AS SELECT system_id,
 mandant_id,
 spr_id,
 rech_beleg_status_id,
 rech_beleg_status_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.rech_beleg_status_spr_zu_1;