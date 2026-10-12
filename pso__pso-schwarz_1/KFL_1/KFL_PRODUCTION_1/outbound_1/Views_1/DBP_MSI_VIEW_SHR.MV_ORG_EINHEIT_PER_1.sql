CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_org_einheit_per_1 (mandant_id, hr_objekt_id, kjmo) AS SELECT
 mandant_id,
 hr_objekt_id,
 kjmo
FROM kfl_production_dbp_view.v_org_einheit_per_1 AS V01;