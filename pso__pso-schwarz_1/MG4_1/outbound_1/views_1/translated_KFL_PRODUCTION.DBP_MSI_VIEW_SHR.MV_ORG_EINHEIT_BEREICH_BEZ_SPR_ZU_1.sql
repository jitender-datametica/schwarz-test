CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_org_einheit_bereich_bez_spr_zu_1 (mandant_id, hr_objekt_id,
hr_objekt_bez_kurz, hr_objekt_bereich_id, hr_objekt_bereich_bez) AS SELECT v01.mandant_id,
 v01.hr_objekt_id,
 v01.hr_objekt_bez_kurz,
 v01.hr_objekt_bereich_id,
 v02.hr_objekt_bereich_bez
FROM kfl_production_dbp_view.v_l_org_einheit_1 AS v01
 INNER JOIN kfl_production_dbp_view.v_org_einheit_bereich_spr_zu_1 AS v02 ON v01.hr_objekt_bereich_id = v02.hr_objekt_bereich_id
  
WHERE v02.spr_id = 22;