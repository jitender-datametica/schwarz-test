CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_in_mehr_minderkosten (mandant_id, psp_id, psp_id_char,
psp_end_nr, ims_projekt_typ_id, in_projekt_id, in_wg_id, best_beleg_id, wrg_id, wrg_typ_id, kurs, projekt_id, projekt_nr
, mmk_nr, mmk_titel, mmk_iks_relevant_fg, dat_mmk, mmk_betrag_gesamt, mmk_betrag_gepr, mmk_betrag_abg, mmk_betrag_anerk
, mmk_betrag_offen, mmk_bemerkung, mmk_verursacher, mmk_betrag_zus, mmk_betrag_zus_beschr, mmk_nachtrag_nr, in_lief_id,
in_lief_nr, lief_name_1, lief_name_2, bvv_vertrag_nr, dat_vertrag_beginn, rpm_hierarchie_id) AS SELECT IMMK.mandant_id,
 IMMK.psp_id,
 IPSP.psp_id_char,
 IPSP.psp_end_nr,
 V02.ims_projekt_typ_id,
 IMMK.in_projekt_id,
 IMMK.in_wg_id,
 IMMK.best_beleg_id,
 IMMK.wrg_id,
 V99.wrg_typ_id,
 KURS0.kurs,
 V03.projekt_id,
 V02.projekt_ext_id AS projekt_nr,
 IMMK.mmk_nr,
 IMMK.mmk_titel,
  CASE
  WHEN IMMK.mmk_iks_relevant_fg = 1
  THEN 'X'
  ELSE ' '
  END AS mmk_iks_relevant_fg,
 IMMK.dat_mmk,
 ROUND(CAST(CASE
    WHEN IMMK.wrg_id = 'EUR'
    THEN COALESCE(IMMK.mmk_betrag_gesamt, 0)
    ELSE COALESCE(IMMK.mmk_betrag_gesamt, 0) * KURS0.faktor
    END AS NUMERIC), 4) AS mmk_betrag_gesamt,
 ROUND(CAST(CASE
    WHEN IMMK.wrg_id = 'EUR'
    THEN COALESCE(IMMK.mmk_betrag_gepr, 0)
    ELSE COALESCE(IMMK.mmk_betrag_gepr, 0) * KURS0.faktor
    END AS NUMERIC), 4) AS mmk_betrag_gepr,
 ROUND(CAST(CASE
    WHEN IMMK.wrg_id = 'EUR'
    THEN COALESCE(IMMK.mmk_betrag_abg, 0)
    ELSE COALESCE(IMMK.mmk_betrag_abg, 0) * KURS0.faktor
    END AS NUMERIC), 4) AS mmk_betrag_abg,
 ROUND(CAST(CASE
    WHEN IMMK.wrg_id = 'EUR'
    THEN COALESCE(IMMK.mmk_betrag_anerk, 0)
    ELSE COALESCE(IMMK.mmk_betrag_anerk, 0) * KURS0.faktor
    END AS NUMERIC), 4) AS mmk_betrag_anerk,
 ROUND(CAST(CASE
    WHEN IMMK.wrg_id = 'EUR'
    THEN COALESCE(IMMK.mmk_betrag_offen, 0)
    ELSE COALESCE(IMMK.mmk_betrag_offen, 0) * KURS0.faktor
    END AS NUMERIC), 4) AS mmk_betrag_offen,
 IMMK.mmk_bemerkung,
 IMMK.mmk_verursacher,
 CAST(CASE
   WHEN IMMK.mmk_betrag_zus_baug > 0
   THEN IMMK.mmk_betrag_zus_baug * KURS0.faktor
   WHEN IMMK.mmk_betrag_zus_plan > 0
   THEN IMMK.mmk_betrag_zus_plan * KURS0.faktor
   WHEN IMMK.mmk_betrag_zus_uplan > 0
   THEN IMMK.mmk_betrag_zus_uplan * KURS0.faktor
   WHEN IMMK.mmk_betrag_zus_auss > 0
   THEN IMMK.mmk_betrag_zus_auss * KURS0.faktor
   WHEN IMMK.mmk_betrag_zus_verg > 0
   THEN IMMK.mmk_betrag_zus_verg * KURS0.faktor
   WHEN IMMK.mmk_betrag_zus_beh > 0
   THEN IMMK.mmk_betrag_zus_beh * KURS0.faktor
   WHEN IMMK.mmk_betrag_zus_hand > 0
   THEN IMMK.mmk_betrag_zus_hand * KURS0.faktor
   WHEN IMMK.mmk_betrag_zus_unv > 0
   THEN IMMK.mmk_betrag_zus_unv * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS mmk_betrag_zus,
 CAST(CASE
   WHEN IMMK.mmk_betrag_zus_baug > 0
   THEN 'Baugenehmigung'
   WHEN IMMK.mmk_betrag_zus_plan > 0
   THEN 'unvollständige Planung'
   WHEN IMMK.mmk_betrag_zus_uplan > 0
   THEN 'Planungs-änderung'
   WHEN IMMK.mmk_betrag_zus_auss > 0
   THEN 'unvollständige Ausschreibung'
   WHEN IMMK.mmk_betrag_zus_verg > 0
   THEN 'Änderungen aus Vergabe'
   WHEN IMMK.mmk_betrag_zus_beh > 0
   THEN 'Auflagen Behörden'
   WHEN IMMK.mmk_betrag_zus_hand > 0
   THEN 'Änderung Handelskonzept'
   WHEN IMMK.mmk_betrag_zus_unv > 0
   THEN 'Unvorher-gesehenes'
   ELSE ' '
   END AS STRING) AS mmk_betrag_zus_beschr,
 SUBSTR(CAST(CASE
    WHEN IMMK.mmk_nachtrag_nr = '0'
    THEN '99'
    ELSE IMMK.mmk_nachtrag_nr
    END AS STRING), 1, 10) AS mmk_nachtrag_nr,
 IBB.in_lief_id,
 IL.in_lief_nr,
 INLIEF.lief_name_1,
 INLIEF.lief_name_2,
 ILBA.bvv_vertrag_nr,
 ILBA.dat_vertrag_beginn,
 RPM.rpm_hierarchie_id
FROM kfl_production_dbp_view.v_in_mehr_minderkosten AS IMMK
 INNER JOIN kfl_production_dbp_view.v_in_psp_element AS IPSP ON IMMK.mandant_id = IPSP.mandant_id AND IMMK.psp_id = IPSP
   .psp_id
 INNER JOIN kfl_production_dbp_view.v_in_projekt AS V02 ON IPSP.mandant_id = V02.mandant_id AND IPSP.in_projekt_id = V02
   .in_projekt_id
 LEFT JOIN kfl_production_dbp_view.v_in_besch_best AS IBB ON IMMK.mandant_id = IBB.mandant_id AND IMMK.best_beleg_id =
   IBB.best_beleg_id
 LEFT JOIN kfl_production_dbp_view.v_in_lieferant AS IL ON IBB.in_lief_id = IL.in_lief_id AND IBB.mandant_id = IL.mandant_id
   
 LEFT JOIN kfl_production_dbp_view.v_in_besch_best_akte_zu AS IBBA ON IMMK.mandant_id = IBBA.mandant_id AND IMMK.best_beleg_id
    = IBBA.best_beleg_id
 LEFT JOIN kfl_production_dbp_view.v_ivs_l_bvv_akte AS ILBA ON IBBA.bvv_akte_id = ILBA.bvv_akte_id AND IBBA.mandant_id =
   ILBA.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_cpr_projekt_per AS V03 ON V02.projekt_ext_id = V03.cpr_ext_id AND V03.dat_bis =
   DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_rpm_element_per AS RPM ON V03.cpr_ext_id = RPM.projekt_id AND RPM.dat_bis =
   DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_in_lieferant AS INLIEF ON IBB.mandant_id = INLIEF.mandant_id AND IBB.in_lief_id =
   INLIEF.in_lief_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS V99 ON IMMK.mandant_id = V99.mandant_id
 INNER JOIN kfl_production_dbp_msi_view_ios.mv_user_kurs AS KURS0 ON V99.mandant_id = KURS0.mandant_id AND V99.wrg_typ_id
     = KURS0.wrg_typ_id AND V99.wrg_id = KURS0.wrg_id;