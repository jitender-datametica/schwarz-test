CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_l_branche_2 AS SELECT mandant_id,
 branche_id,
 branche_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.immo_l_branche_2;