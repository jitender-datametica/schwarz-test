CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_l_besitzstatus_2 (mandant_id, besitzstatus_id, td_update, td_insert
) AS SELECT mandant_id,
 besitzstatus_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.immo_l_besitzstatus_2;