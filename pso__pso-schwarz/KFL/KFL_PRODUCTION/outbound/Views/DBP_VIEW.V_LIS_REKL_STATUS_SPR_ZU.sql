CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lis_rekl_status_spr_zu AS SELECT mandant_id,
 lis_rekl_status_id,
 spr_id,
 lis_rekl_status_bez
FROM kfl_production_dbp_data.lis_rekl_status_spr_zu;