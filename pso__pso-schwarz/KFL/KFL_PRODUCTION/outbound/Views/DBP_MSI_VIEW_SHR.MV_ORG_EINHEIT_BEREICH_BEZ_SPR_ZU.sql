CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_org_einheit_bereich_bez_spr_zu AS SELECT V01.mandant_id,
 V01.hr_objekt_id,
 V01.hr_objekt_bez_kurz,
 V01.hr_objekt_bereich_id,
 V02.hr_objekt_bereich_bez
FROM kfl_production_dbp_view.v_l_org_einheit AS V01
 INNER JOIN kfl_production_dbp_view.v_org_einheit_bereich_spr_zu AS V02 ON V01.hr_objekt_bereich_id = V02.hr_objekt_bereich_id
  
WHERE V02.spr_id = 22;