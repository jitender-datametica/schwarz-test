CREATE OR REPLACE VIEW kfl_production_dbp_view.v_belegart_spr_zu_2 (system_id, mandant_id, spr_id, belegart_id,
belegart_bez, td_update, td_insert) AS SELECT system_id,
 mandant_id,
 spr_id,
 belegart_id,
 belegart_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.belegart_spr_zu_2;