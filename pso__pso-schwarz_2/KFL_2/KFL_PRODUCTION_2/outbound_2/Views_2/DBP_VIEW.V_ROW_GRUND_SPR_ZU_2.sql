CREATE OR REPLACE VIEW kfl_production_dbp_view.v_row_grund_spr_zu_2 AS SELECT system_id,
 mandant_id,
 spr_id,
 row_grund_id,
 row_grund_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.row_grund_spr_zu_2;