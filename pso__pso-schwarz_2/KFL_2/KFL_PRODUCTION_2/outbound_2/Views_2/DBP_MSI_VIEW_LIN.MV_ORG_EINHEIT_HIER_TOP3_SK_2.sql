CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_org_einheit_hier_top3_sk_2 (mandant_id, hr_objekt_ebene1_id,
hr_objekt_ebene2_id, hr_objekt_ebene3_id, hr_objekt_ebene4_id, hr_objekt_ebene5_id, hr_objekt_ebene6_id,
hr_objekt_ebene7_id, hr_objekt_ebene8_id, hr_objekt_ebene9_id, hr_objekt_ebene10_id, hr_objekt_ebene11_id,
kostenstelle_id, hr_objekt_ebene1_bez, hr_objekt_ebene2_bez, hr_objekt_ebene3_bez, hr_objekt_ebene4_bez,
hr_objekt_ebene5_bez, hr_objekt_ebene6_bez, hr_objekt_ebene7_bez, hr_objekt_ebene8_bez, hr_objekt_ebene9_bez,
hr_objekt_ebene10_bez, hr_objekt_ebene11_bez, mandant_sort_id, kjmo) AS SELECT V01.mandant_id,
 V01.hr_objekt_ebene1_id,
 V01.hr_objekt_ebene2_id,
 V01.hr_objekt_ebene3_id,
 V01.hr_objekt_ebene4_id,
 V01.hr_objekt_ebene5_id,
 V01.hr_objekt_ebene6_id,
 V01.hr_objekt_ebene7_id,
 V01.hr_objekt_ebene8_id,
 V01.hr_objekt_ebene9_id,
 V01.hr_objekt_ebene10_id,
 V01.hr_objekt_ebene11_id,
 V01.kostenstelle_id,
 V01.hr_objekt_ebene1_bez,
 V01.hr_objekt_ebene2_bez,
 V01.hr_objekt_ebene3_bez,
 V01.hr_objekt_ebene4_bez,
 V01.hr_objekt_ebene5_bez,
 V01.hr_objekt_ebene6_bez,
 V01.hr_objekt_ebene7_bez,
 V01.hr_objekt_ebene8_bez,
 V01.hr_objekt_ebene9_bez,
 V01.hr_objekt_ebene10_bez,
 V01.hr_objekt_ebene11_bez,
 V01.om_sort_id AS mandant_sort_id,
 V01.kjmo
FROM kfl_production_dbp_view.v_org_einheit_hierarchie_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_monat_2 AS V02 ON V01.kjmo = V02.kjmo
WHERE V01.spr_id = 108
 AND V02.akt_mo BETWEEN - 3 AND 0
 AND (V01.mandant_id = 4 AND V01.hr_objekt_ebene1_id = 35084871 OR V01.mandant_id = 7 AND V01.hr_objekt_ebene1_id =
      35000075 OR V01.mandant_id NOT IN (4, 7));