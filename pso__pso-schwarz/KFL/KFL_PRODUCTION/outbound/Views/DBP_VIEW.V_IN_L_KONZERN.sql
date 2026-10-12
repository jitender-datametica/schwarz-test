CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_l_konzern AS SELECT mandant_id,
 konzern_id,
 konzern_name
FROM kfl_production_dbp_data.in_l_konzern;