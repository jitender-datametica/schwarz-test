CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_l_vertragart AS SELECT vertragart_id,
 vertragart_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_ivs_l_vertragart
WHERE spr_id = 22;