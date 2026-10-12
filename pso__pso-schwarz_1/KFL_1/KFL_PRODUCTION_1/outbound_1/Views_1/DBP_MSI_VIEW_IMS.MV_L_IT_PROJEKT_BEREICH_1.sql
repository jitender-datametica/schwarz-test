CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_it_projekt_bereich_1 AS SELECT CAST(V01.hr_objekt_ebene1_id AS BIGNUMERIC)
 AS it_projekt_bereich_id,
 V01.mandant_id,
 MAX(V01.hr_objekt_ebene1_bez) AS it_projekt_bereich_bez,
 MAX(V03.sparte_id) AS sparte_id
FROM kfl_production_dbp_view.v_org_einheit_hierarchie_1 AS V01
 INNER JOIN (SELECT hr_objekt_ebene1_id,
   mandant_id,
   spr_id,
   MAX(kjmo) AS max_kjmo
  FROM kfl_production_dbp_view.v_org_einheit_hierarchie_1
  WHERE spr_id = 22
  GROUP BY mandant_id,
   hr_objekt_ebene1_id,
   spr_id) AS v02 ON V01.hr_objekt_ebene1_id = v02.hr_objekt_ebene1_id AND V01.mandant_id = v02.mandant_id AND V01.kjmo
    = v02.max_kjmo AND V01.spr_id = v02.spr_id
 INNER JOIN kfl_production_dbp_view.v_l_org_einheit_sparte_1 AS V03 ON V01.hr_objekt_ebene1_id = V03.hr_objekt_ebene11_id
  AND V01.mandant_id = V03.mandant_id
GROUP BY it_projekt_bereich_id,
 V01.mandant_id
UNION ALL
SELECT ROUND(CAST(it_projekt_bereich_id AS BIGNUMERIC), 0) AS it_projekt_bereich_id,
 mandant_id,
 it_projekt_bereich_bez,
 sparte_id
FROM kfl_production_dbp_view.v_l_it_projekt_bereich_1;