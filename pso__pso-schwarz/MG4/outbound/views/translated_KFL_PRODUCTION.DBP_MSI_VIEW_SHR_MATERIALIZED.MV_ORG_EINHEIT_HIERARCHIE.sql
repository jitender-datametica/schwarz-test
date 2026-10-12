-- 20210715 richternic - SPEC0119986 Mandant 4/7 sind nun die deutschen Uebersetzung soweit gepflegt

-- 20150615 kkaiser - FB will im Land 6/7 nur landesspezifische Daten anzeigen lassen, deutsche Werte sind in diesen Ländern mangelhaft gepflegt

-- 20240129 twie: NSR4267530 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr_materialized.mv_org_einheit_hierarchie (mandant_id,
hr_objekt_ebene1_id, hr_objekt_ebene2_id, hr_objekt_ebene3_id, hr_objekt_ebene4_id, hr_objekt_ebene5_id,
hr_objekt_ebene6_id, hr_objekt_ebene7_id, hr_objekt_ebene8_id, hr_objekt_ebene9_id, hr_objekt_ebene10_id,
hr_objekt_ebene11_id, kostenstelle_id, hr_objekt_ebene1_bez, hr_objekt_ebene2_bez, hr_objekt_ebene3_bez,
hr_objekt_ebene4_bez, hr_objekt_ebene5_bez, hr_objekt_ebene6_bez, hr_objekt_ebene7_bez, hr_objekt_ebene8_bez,
hr_objekt_ebene9_bez, hr_objekt_ebene10_bez, hr_objekt_ebene11_bez, kjmo, mandant_sort_id, user_id) AS SELECT v01.mandant_id
 ,
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
 v01.kjmo,
 v01.om_sort_id AS mandant_sort_id,
 LOWER(v03.user_id) AS user_id
FROM kfl_production_dbp_msi_view_shr_materialized.tbl_mv_org_einheit_hierarchie AS v01
 INNER JOIN (SELECT v021.user_id,
   v021.hr_objekt_ebene1_id,
   v021.mandant_id,
   v022.session_id
  FROM kfl_production_dbp_security.user_hr_objekt_id_zu AS v021
   INNER JOIN kfl_production_dbp_msi.akt_msi_user AS v022 ON v021.user_id = v022.user_id) AS v03 ON v01.hr_objekt_ebene1_id
     = v03.hr_objekt_ebene1_id AND v01.mandant_id = v03.mandant_id AND v03.session_id = ABS(FARM_FINGERPRINT(SESSION_USER()
     ))
 INNER JOIN kfl_production_dbp_msi.akt_msi_user AS v04 ON v03.user_id = v04.user_id AND v04.session_id = ABS(FARM_FINGERPRINT(SESSION_USER()
     ))
 INNER JOIN kfl_production_dbp_msi_v_view.v_user_spr_zu AS v05 ON v04.user_id = v05.user_id AND v01.spr_id = v05.spr_id;