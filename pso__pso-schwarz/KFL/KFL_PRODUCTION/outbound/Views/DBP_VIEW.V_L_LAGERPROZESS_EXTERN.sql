CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_lagerprozess_extern AS SELECT mandant_id,
 lagerprozess_extern_id,
 lagerprozess_intern_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_lagerprozess_extern;