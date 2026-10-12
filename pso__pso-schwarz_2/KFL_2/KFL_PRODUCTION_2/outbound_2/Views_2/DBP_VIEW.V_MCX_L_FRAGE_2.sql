CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mcx_l_frage_2 AS SELECT frage_id,
 umfrage_id,
 frage_ex_typ,
 frage_status,
 td_update,
 td_insert
FROM kfl_production_dbp_data.mcx_l_frage_2;