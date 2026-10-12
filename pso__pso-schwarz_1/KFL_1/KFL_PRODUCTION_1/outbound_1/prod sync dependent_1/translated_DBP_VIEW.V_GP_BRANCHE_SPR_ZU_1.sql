CREATE OR REPLACE VIEW kfl_production_dbp_view.v_gp_branche_spr_zu_1 (system_id, mandant_id, gp_branche_id, spr_id,
gp_branche_bez, td_update, td_insert) AS SELECT system_id,
 mandant_id,
 gp_branche_id,
 spr_id,
 gp_branche_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.gp_branche_spr_zu_1;