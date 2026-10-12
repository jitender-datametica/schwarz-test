CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ewm_exception_spr_zu AS SELECT mandant_id,
 lagernummer_id,
 spr_id,
 ewm_exception_id,
 ewm_exception_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.ewm_exception_spr_zu;