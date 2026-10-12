CREATE OR REPLACE VIEW kfl_production_dbp_view.v_sap_dwh_spr_zu AS SELECT mandant_id,
 spr_id,
 sap_spr_id,
 spr
FROM kfl_production_dbp_data.sap_dwh_spr_zu;