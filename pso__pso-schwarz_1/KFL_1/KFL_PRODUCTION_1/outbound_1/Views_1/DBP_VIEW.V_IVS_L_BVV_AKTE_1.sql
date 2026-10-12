CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_l_bvv_akte_1 AS SELECT bvv_akte_id,
 mandant_id,
 bvv_vertrag_nr,
 dat_vertrag_beginn,
 td_update,
 td_insert
FROM kfl_production_dbp_data.ivs_l_bvv_akte_1;