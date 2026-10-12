CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_touchpoint_spr_zu AS SELECT mandant_id,
 touchpoint_id,
 spr_id,
 touchpoint_bez
FROM kfl_production_dbp_data.crm_touchpoint_spr_zu;