CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_row_grund AS SELECT system_id,
 mandant_id,
 row_grund_id,
 bnk_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_row_grund;