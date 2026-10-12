CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mcx_l_antwort_ok_fg AS SELECT antwort_id,
 umfrage_id,
 ok_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.mcx_l_antwort_ok_fg;