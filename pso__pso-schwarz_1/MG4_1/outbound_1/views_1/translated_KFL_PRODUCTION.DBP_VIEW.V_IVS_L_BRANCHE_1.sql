CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_l_branche_1 (mandant_id, branche_id, branche_bez, spr_id) AS SELECT
 mandant_id,
 branche_id,
 branche_bez,
 spr_id
FROM kfl_production_dbp_data.ivs_l_branche_1;