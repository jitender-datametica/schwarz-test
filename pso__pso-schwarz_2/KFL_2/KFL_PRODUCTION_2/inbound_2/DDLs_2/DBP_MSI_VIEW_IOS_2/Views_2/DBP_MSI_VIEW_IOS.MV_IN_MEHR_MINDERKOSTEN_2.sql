CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_IN_MEHR_MINDERKOSTEN_2
-- in_mehr_minder_kosten (ZBV_DETAILMMK)
-- Mehr-Minderkosten, angereichert um PSP-Stammdaten
-- 2015-10-06 ssch0611 : Projekt 0533 initial
-- 2015-12-08 kkai0912: 2 Felder hinzugefügt (dat_mmk, mmk_betrag_gesamt)
-- 2016-02-25 kkai0912: 8 Betragsfelder auf Beschreibung und Betragsfeld zusammengeschrumpft
-- 2016-07-13 kkai0912: KURS_2 View statt DATA
-- 180727 nfis0811 - SPEC0038216: Einfügen in_lief_id, rpm_hierarchie_id und bvv_vertrag_nr
(
mandant_id
,psp_id
,psp_id_char
,psp_end_nr
,ims_projekt_typ_id
,in_projekt_id
,in_wg_id
,best_beleg_id
,wrg_id
,wrg_typ_id
,kurs_2
,projekt_id
,projekt_nr
,mmk_nr
,mmk_titel
,mmk_iks_relevant_fg
,dat_mmk
,mmk_betrag_gesamt
,mmk_betrag_gepr
,mmk_betrag_abg
,mmk_betrag_anerk
,mmk_betrag_offen
,mmk_bemerkung
,mmk_verursacher
,mmk_betrag_zus
,mmk_betrag_zus_beschr
,mmk_nachtrag_nr
,in_lief_id
,in_lief_nr
,lief_name_1
,lief_name_2
,bvv_vertrag_nr
,dat_vertrag_beginn
,rpm_hierarchie_id
)
AS
   SELECT
   immk.mandant_id, immk.psp_id, ipsp.psp_id_char, ipsp.psp_end_nr, v02.ims_projekt_typ_id, immk.in_projekt_id, immk.in_wg_id AS in_wg_id  -- Dummy_2-Wert nocht nicht (korrekt) definiert
   , immk.best_beleg_id, immk.wrg_id, v99.wrg_typ_id, kurs.kurs_2, v03.projekt_id, v02.projekt_ext_id AS projekt_nr, immk.mmk_nr, immk.mmk_titel, CASE WHEN immk.mmk_iks_relevant_fg = 1 THEN 'X'   ELSE ' ' END AS mmk_iks_relevant_fg, dat_mmk, CAST( CASE
   WHEN immk.wrg_id  = 'EUR' THEN COALESCE( immk.mmk_betrag_gesamt  ,0) ELSE  COALESCE(immk.mmk_betrag_gesamt   ,0) * FAKTOR END
   AS DECIMAL(18,4) ) AS mmk_betrag_gesamt, CAST( CASE
   WHEN immk.wrg_id  = 'EUR' THEN COALESCE( immk.mmk_betrag_gepr  ,0) ELSE  COALESCE(immk.mmk_betrag_gepr   ,0) * FAKTOR  END
   AS DECIMAL(18,4) ) AS mmk_betrag_gepr, CAST( CASE
   WHEN immk.wrg_id  = 'EUR' THEN COALESCE( immk.mmk_betrag_abg  ,0) ELSE  COALESCE(immk.mmk_betrag_abg   ,0) * FAKTOR  END
   AS DECIMAL(18,4) ) AS mmk_betrag_abg, CAST( CASE
   WHEN immk.wrg_id  = 'EUR' THEN COALESCE( immk.mmk_betrag_anerk  ,0) ELSE  COALESCE(immk.mmk_betrag_anerk   ,0) * FAKTOR  END
   AS DECIMAL(18,4) ) AS mmk_betrag_anerk, CAST( CASE
   WHEN immk.wrg_id  = 'EUR' THEN COALESCE( immk.mmk_betrag_offen  ,0) ELSE  COALESCE(immk.mmk_betrag_offen   ,0) * FAKTOR  END
   AS DECIMAL(18,4) ) AS mmk_betrag_offen, immk.mmk_bemerkung, immk.mmk_verursacher, CAST( CASE
   WHEN immk.mmk_betrag_zus_baug > 0 THEN immk.mmk_betrag_zus_baug * FAKTOR
   WHEN immk.mmk_betrag_zus_plan   > 0 THEN immk.mmk_betrag_zus_plan * FAKTOR
   WHEN immk.mmk_betrag_zus_uplan > 0 THEN immk.mmk_betrag_zus_uplan * FAKTOR
   WHEN immk.mmk_betrag_zus_auss  > 0 THEN immk.mmk_betrag_zus_auss * FAKTOR
   WHEN immk.mmk_betrag_zus_verg   > 0 THEN immk.mmk_betrag_zus_verg * FAKTOR
   WHEN immk.mmk_betrag_zus_beh    > 0 THEN immk.mmk_betrag_zus_beh * FAKTOR
   WHEN immk.mmk_betrag_zus_hand  > 0 THEN immk.mmk_betrag_zus_hand * FAKTOR
   WHEN immk.mmk_betrag_zus_unv    > 0 THEN  immk.mmk_betrag_zus_unv * FAKTOR END AS DECIMAL(18,4) ) AS mmk_betrag_zus, CAST( CASE
   WHEN immk.mmk_betrag_zus_baug > 0 THEN 'Baugenehmigung'
   WHEN immk.mmk_betrag_zus_plan   > 0 THEN 'unvollständige Planung'
   WHEN immk.mmk_betrag_zus_uplan > 0 THEN 'Planungs-änderung'
   WHEN immk.mmk_betrag_zus_auss  > 0 THEN 'unvollständige Ausschreibung'
   WHEN immk.mmk_betrag_zus_verg   > 0 THEN 'Änderungen aus Vergabe'
   WHEN immk.mmk_betrag_zus_beh    > 0 THEN 'Auflagen Behörden'
   WHEN immk.mmk_betrag_zus_hand  > 0 THEN 'Änderung Handelskonzept'
   WHEN immk.mmk_betrag_zus_unv    > 0 THEN  'Unvorher-gesehenes'                       ELSE ' ' END AS VARCHAR (40)) AS mmk_betrag_zus_beschr, CAST( CASE
   WHEN immk.mmk_nachtrag_nr = '0' THEN '99' ELSE immk.mmk_nachtrag_nr END
   AS CHAR(10) ) AS mmk_nachtrag_nr, ibb.in_lief_id, il.in_lief_nr, inlief.lief_name_1, inlief.lief_name_2, ilba.bvv_vertrag_nr, ilba.dat_vertrag_beginn, rpm.rpm_hierarchie_id
   FROM dbp_view.v_in_mehr_minderkosten_2 immk

   JOIN dbp_view.v_in_psp_element_2 ipsp
   ON ipsp.mandant_id = immk.mandant_id
   AND ipsp.psp_id = immk.psp_id

   JOIN dbp_view.v_in_projekt_2 v02
   ON v02.mandant_id = ipsp.mandant_id
   AND v02.in_projekt_id = ipsp.in_projekt_id
   LEFT JOIN dbp_view.v_in_besch_best_2 ibb
   ON immk.mandant_id = ibb.mandant_id
   AND immk.best_beleg_id = ibb.best_beleg_id
   LEFT JOIN dbp_view.v_in_lieferant_2 il
   ON ibb.in_lief_id = il.in_lief_id AND ibb.mandant_id = il.mandant_id
   LEFT JOIN dbp_view.v_in_besch_best_akte_zu_2  ibba
   ON immk.mandant_id = ibba.mandant_id
   AND immk.best_beleg_id = ibba.best_beleg_id
   LEFT JOIN dbp_view.v_ivs_l_bvv_akte_2 ilba
   ON  ilba.bvv_akte_id = ibba.bvv_akte_id AND ilba.mandant_id = ibba.mandant_id
   LEFT JOIN dbp_view.v_cpr_projekt_per_2 v03
   ON  v03.cpr_ext_id = v02.projekt_ext_id
   AND v03.dat_bis = '9999-12-31'
   LEFT JOIN dbp_view.v_rpm_element_per_2  rpm
   ON   v03.cpr_ext_id  = rpm.projekt_id
   AND rpm.dat_bis = '9999-12-31'
   LEFT JOIN dbp_view.v_in_lieferant_2 inlief
   ON ibb.mandant_id = inlief.mandant_id
   AND ibb.in_lief_id = inlief.in_lief_id

   JOIN dbp_view.v_mandant_wrg_typ_zu_2 v99
   ON  v99.mandant_id = immk.mandant_id

   JOIN dbp_msi_view_ios.mv_user_kurs_2 kurs_2
   ON  kurs.mandant_id = v99.mandant_id --AND kurs.von_wrg
   AND kurs.wrg_typ_id = v99.wrg_typ_id
   AND kurs.wrg_id     = v99.wrg_id;