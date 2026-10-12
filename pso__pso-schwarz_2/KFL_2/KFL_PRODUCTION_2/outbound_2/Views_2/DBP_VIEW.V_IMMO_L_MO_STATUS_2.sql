CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_l_mo_status_2 AS SELECT mandant_id,
 mo_status_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.immo_l_mo_status_2;