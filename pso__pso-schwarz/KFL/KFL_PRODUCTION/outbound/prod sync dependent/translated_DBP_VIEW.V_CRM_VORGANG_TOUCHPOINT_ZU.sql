CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_vorgang_touchpoint_zu (mandant_id, crm_vorgang_id, touchpoint_id,
touchpoint_count) AS SELECT mandant_id,
 crm_vorgang_id,
 touchpoint_id,
 touchpoint_count
FROM kfl_production_dbp_data.crm_vorgang_touchpoint_zu;