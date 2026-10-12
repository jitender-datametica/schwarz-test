CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_buch_grund_int AS SELECT system_id,
 mandant_id,
 buch_grund_int_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_buch_grund_int;