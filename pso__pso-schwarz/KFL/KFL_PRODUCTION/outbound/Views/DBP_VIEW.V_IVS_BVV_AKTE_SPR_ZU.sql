CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_bvv_akte_spr_zu AS SELECT bvv_akte_id,
 mandant_id,
 spr_id,
 bvv_akte_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.ivs_bvv_akte_spr_zu;