CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_hr_objekt_filiale_bereich_zu AS SELECT DISTINCT OEB.hr_objekt_bereich_id
 ,
 OEB.hr_objekt_bereich_id AS filiale_bereich_l3_id,
 OEB.hr_objekt_bereich_level2_id AS filiale_bereich_l2_id,
 LVL2.hr_objekt_bereich_level1_id AS filiale_bereich_l1_id
FROM kfl_production_dbp_view.v_l_org_einheit_bereich AS OEB
 INNER JOIN kfl_production_dbp_view.v_l_org_einheit_bereich_level2 AS LVL2 ON OEB.hr_objekt_bereich_level2_id = LVL2.hr_objekt_bereich_level2_id
  
GROUP BY OEB.hr_objekt_bereich_id,
 filiale_bereich_l3_id,
 filiale_bereich_l2_id,
 filiale_bereich_l1_id;