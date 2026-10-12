CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mcx_l_kategorie AS SELECT kat_id,
 teilbereich_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.mcx_l_kategorie;