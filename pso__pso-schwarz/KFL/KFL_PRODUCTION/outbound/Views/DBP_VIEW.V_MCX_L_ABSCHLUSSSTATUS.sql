CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mcx_l_abschlussstatus AS SELECT abschluss_id,
 umfrage_id,
 abschluss_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.mcx_l_abschlussstatus;