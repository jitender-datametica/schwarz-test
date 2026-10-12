CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_bv_quelle_2 AS SELECT mandant_id,
 bv_quelle_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_bv_quelle_2;