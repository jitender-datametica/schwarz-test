CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_l_gebiet_2 (mandant_id, gebiet_id, td_update, td_insert) AS SELECT
 mandant_id,
 gebiet_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.immo_l_gebiet_2;