CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_org_einheit_hierarchie_sk_2 (mandant_id, hr_objekt_ebene1_id,
hr_objekt_ebene2_id, hr_objekt_ebene3_id, hr_objekt_ebene4_id, hr_objekt_ebene5_id, hr_objekt_ebene6_id,
hr_objekt_ebene7_id, hr_objekt_ebene8_id, hr_objekt_ebene9_id, hr_objekt_ebene10_id, hr_objekt_ebene11_id,
kostenstelle_id, hr_objekt_ebene1_bez, hr_objekt_ebene2_bez, hr_objekt_ebene3_bez, hr_objekt_ebene4_bez,
hr_objekt_ebene5_bez, hr_objekt_ebene6_bez, hr_objekt_ebene7_bez, hr_objekt_ebene8_bez, hr_objekt_ebene9_bez,
hr_objekt_ebene10_bez, hr_objekt_ebene11_bez, mandant_sort_id, user_id) AS SELECT V01.mandant_id,
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
 V03.user_id
FROM kfl_production_dbp_view.v_org_einheit_hierarchie_2 AS V01
 INNER JOIN (SELECT V021.user_id,
   V021.hr_objekt_ebene1_id,
   V021.mandant_id
  FROM kfl_production_dbp_security.user_hr_objekt_id_zu_2 AS V021
   INNER JOIN kfl_production_dbp_msi_data.akt_msi_user_2 AS V022 ON V021.user_id = V022.user_id) AS V03 ON V01.hr_objekt_ebene1_id
     = V03.hr_objekt_ebene1_id AND V01.mandant_id = V03.mandant_id AND V01.spr_id = 108
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(V01.mandant_id AS STRING), V01.hr_objekt_ebene11_id ORDER BY V01.kjmo
      IS NULL, V01.kjmo)) = 1;