CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_org_einheit_hierarchie_1 (mandant_id, hr_objekt_ebene1_id,
hr_objekt_ebene2_id, hr_objekt_ebene3_id, hr_objekt_ebene4_id, hr_objekt_ebene5_id, hr_objekt_ebene6_id,
hr_objekt_ebene7_id, hr_objekt_ebene8_id, hr_objekt_ebene9_id, hr_objekt_ebene10_id, hr_objekt_ebene11_id,
kostenstelle_id, hr_objekt_ebene1_bez, hr_objekt_ebene2_bez, hr_objekt_ebene3_bez, hr_objekt_ebene4_bez,
hr_objekt_ebene5_bez, hr_objekt_ebene6_bez, hr_objekt_ebene7_bez, hr_objekt_ebene8_bez, hr_objekt_ebene9_bez,
hr_objekt_ebene10_bez, hr_objekt_ebene11_bez, mandant_sort_id, user_id) AS SELECT v01.mandant_id,
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
 V03.user_id
FROM kfl_production_dbp_view.v_org_einheit_hierarchie_1 AS v01
 INNER JOIN (SELECT v021.user_id,
   v021.hr_objekt_ebene1_id,
   v021.mandant_id
  FROM kfl_production_dbp_security.user_hr_objekt_id_zu_1 AS v021
   INNER JOIN kfl_production_dbp_msi_data.akt_msi_user_1 AS v022 ON v021.user_id = v022.user_id AND v022.session_id = ABS(FARM_FINGERPRINT(SESSION_USER()
       ))) AS V03 ON v01.hr_objekt_ebene1_id = V03.hr_objekt_ebene1_id AND v01.mandant_id = V03.mandant_id AND v01.spr_id
    = 22
QUALIFY (ROW_NUMBER() OVER (PARTITION BY v01.mandant_id, v01.hr_objekt_ebene11_id ORDER BY v01.kjmo IS NULL, v01.kjmo))
  = 1;