-- 20240129 twie: NSR4267530 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

-- 20210715 richternic - SPEC0119986 Mandant 4/7 sind nun die deutschen Uebersetzung soweit gepflegt

-- 20150615 kkaiser - FB will im Land 6/7 nur landesspezifische Daten anzeigen lassen, deutsche Werte sind in diesen Ländern mangelhaft gepflegt

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr_materialized.mv_org_einheit_hierarchie (mandant_id,
hr_objekt_ebene1_id, hr_objekt_ebene2_id, hr_objekt_ebene3_id, hr_objekt_ebene4_id, hr_objekt_ebene5_id,
hr_objekt_ebene6_id, hr_objekt_ebene7_id, hr_objekt_ebene8_id, hr_objekt_ebene9_id, hr_objekt_ebene10_id,
hr_objekt_ebene11_id, kostenstelle_id, hr_objekt_ebene1_bez, hr_objekt_ebene2_bez, hr_objekt_ebene3_bez,
hr_objekt_ebene4_bez, hr_objekt_ebene5_bez, hr_objekt_ebene6_bez, hr_objekt_ebene7_bez, hr_objekt_ebene8_bez,
hr_objekt_ebene9_bez, hr_objekt_ebene10_bez, hr_objekt_ebene11_bez, kjmo, mandant_sort_id, user_id) AS SELECT V01.mandant_id
 ,
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
 V01.kjmo,
 V01.om_sort_id AS mandant_sort_id,
 LOWER(v03.user_id) AS user_id
FROM kfl_production_dbp_msi_view_shr_materialized.tbl_mv_org_einheit_hierarchie AS V01
 INNER JOIN (SELECT V021.user_id,
   V021.hr_objekt_ebene1_id,
   V021.mandant_id,
   V022.session_id
  FROM kfl_production_dbp_security.user_hr_objekt_id_zu AS V021
   INNER JOIN kfl_production_dbp_msi.akt_msi_user AS V022 ON V021.user_id = V022.user_id) AS v03 ON V01.hr_objekt_ebene1_id
     = v03.hr_objekt_ebene1_id AND V01.mandant_id = v03.mandant_id AND v03.session_id = ABS(FARM_FINGERPRINT(SESSION_USER()
     ))
 INNER JOIN kfl_production_dbp_msi.akt_msi_user AS V04 ON v03.user_id = V04.user_id AND V04.session_id = ABS(FARM_FINGERPRINT(SESSION_USER()
     ))
 INNER JOIN kfl_production_dbp_msi_v_view.v_user_spr_zu AS V05 ON V04.user_id = V05.user_id AND V01.spr_id = V05.spr_id;