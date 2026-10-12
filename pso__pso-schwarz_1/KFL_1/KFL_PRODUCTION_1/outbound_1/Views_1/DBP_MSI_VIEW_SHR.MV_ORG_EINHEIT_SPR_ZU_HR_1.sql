CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_org_einheit_spr_zu_hr_1 (mandant_id, hr_objekt_id, spr_id,
hr_objekt_bez) AS SELECT mandant_id,
 hr_objekt_id,
 spr_id,
 hr_objekt_bez
FROM kfl_production_dbp_view.v_org_einheit_spr_zu_1 AS V01
WHERE spr_id = 65;