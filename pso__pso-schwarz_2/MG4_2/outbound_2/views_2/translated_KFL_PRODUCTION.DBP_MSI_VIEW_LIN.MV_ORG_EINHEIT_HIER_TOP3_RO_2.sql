CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_org_einheit_hier_top3_ro_2 (mandant_id, hr_objekt_ebene1_id,
hr_objekt_ebene2_id, hr_objekt_ebene3_id, hr_objekt_ebene4_id, hr_objekt_ebene5_id, hr_objekt_ebene6_id,
hr_objekt_ebene7_id, hr_objekt_ebene8_id, hr_objekt_ebene9_id, hr_objekt_ebene10_id, hr_objekt_ebene11_id,
kostenstelle_id, hr_objekt_ebene1_bez, hr_objekt_ebene2_bez, hr_objekt_ebene3_bez, hr_objekt_ebene4_bez,
hr_objekt_ebene5_bez, hr_objekt_ebene6_bez, hr_objekt_ebene7_bez, hr_objekt_ebene8_bez, hr_objekt_ebene9_bez,
hr_objekt_ebene10_bez, hr_objekt_ebene11_bez, mandant_sort_id, kjmo) AS SELECT v01.mandant_id,
 v01.hr_objekt_ebene1_id,
 v01.hr_objekt_ebene2_id,
 v01.hr_objekt_ebene3_id,
 v01.hr_objekt_ebene4_id,
 v01.hr_objekt_ebene5_id,
 v01.hr_objekt_ebene6_id,
 v01.hr_objekt_ebene7_id,
 v01.hr_objekt_ebene8_id,
 v01.hr_objekt_ebene9_id,
 v01.hr_objekt_ebene10_id,
 v01.hr_objekt_ebene11_id,
 v01.kostenstelle_id,
 v01.hr_objekt_ebene1_bez,
 v01.hr_objekt_ebene2_bez,
 v01.hr_objekt_ebene3_bez,
 v01.hr_objekt_ebene4_bez,
 v01.hr_objekt_ebene5_bez,
 v01.hr_objekt_ebene6_bez,
 v01.hr_objekt_ebene7_bez,
 v01.hr_objekt_ebene8_bez,
 v01.hr_objekt_ebene9_bez,
 v01.hr_objekt_ebene10_bez,
 v01.hr_objekt_ebene11_bez,
 v01.om_sort_id AS mandant_sort_id,
 v01.kjmo
FROM kfl_production_dbp_view.v_org_einheit_hierarchie_2 AS v01
 INNER JOIN kfl_production_dbp_view.v_monat_2 AS v02 ON v01.kjmo = v02.kjmo
WHERE v01.spr_id = 95
 AND v02.akt_mo BETWEEN - 3 AND 0
 AND (v01.mandant_id = 4 AND v01.hr_objekt_ebene1_id = 35084871 OR v01.mandant_id = 7 AND v01.hr_objekt_ebene1_id =
      35000075 OR v01.mandant_id NOT IN (4, 7));