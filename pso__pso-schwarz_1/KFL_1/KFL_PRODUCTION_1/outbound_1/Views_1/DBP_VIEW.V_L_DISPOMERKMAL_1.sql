CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_dispomerkmal_1 AS SELECT mandant_id,
 dispomerkmal,
 td_insert,
 td_update
FROM kfl_production_dbp_data.l_dispomerkmal_1;