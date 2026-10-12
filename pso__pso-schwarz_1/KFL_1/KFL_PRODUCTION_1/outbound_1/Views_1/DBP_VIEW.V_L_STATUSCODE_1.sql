CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_statuscode_1 AS SELECT system_id,
 mandant_id,
 statuscode_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_statuscode_1;