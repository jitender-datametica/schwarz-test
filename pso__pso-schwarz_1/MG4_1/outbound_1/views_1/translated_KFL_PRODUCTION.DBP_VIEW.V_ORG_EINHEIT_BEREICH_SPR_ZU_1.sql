CREATE OR REPLACE VIEW kfl_production_dbp_view.v_org_einheit_bereich_spr_zu_1 (mandant_id, hr_objekt_bereich_id, spr_id,
hr_objekt_bereich_bez) AS SELECT mandant_id,
 hr_objekt_bereich_id,
 spr_id,
 hr_objekt_bereich_bez
FROM kfl_production_dbp_data.org_einheit_bereich_spr_zu_1;