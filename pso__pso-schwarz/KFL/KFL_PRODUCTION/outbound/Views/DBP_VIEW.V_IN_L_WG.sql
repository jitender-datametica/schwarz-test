CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_l_wg AS SELECT mandant_id,
 in_wg_id,
 in_wg_struktur_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_l_wg;