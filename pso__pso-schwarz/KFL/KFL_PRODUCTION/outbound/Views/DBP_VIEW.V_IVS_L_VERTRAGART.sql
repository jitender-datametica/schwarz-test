CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_l_vertragart AS SELECT mandant_id,
 vertragart_id,
 vertragart_bez,
 spr_id
FROM kfl_production_dbp_data.ivs_l_vertragart;