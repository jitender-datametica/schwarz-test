CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_kunde_2 AS SELECT mandant_id,
 in_kunde_id,
 kunde_nr,
 system_id,
 kunde_name,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_kunde_2;