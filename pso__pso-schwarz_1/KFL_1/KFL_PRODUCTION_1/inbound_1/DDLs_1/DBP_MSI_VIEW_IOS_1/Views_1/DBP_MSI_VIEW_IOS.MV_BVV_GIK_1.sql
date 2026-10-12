CREATE
OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_BVV_GIK_1 as -- Faktview : Gesamtinvestitionskosten
-- 20160726 kkai0912 : neu für Projekt P0533
-- 20160823 ssch0611 : Kurs_1-Join angepasst
-- 20160913kkai0912 : full outer join mit ios_datenfreigabe_ime_1
-- 20171107hmue2308 : Left join entfernt. Siehe Excel-Datei in AP0015930, SPEC0028048
-- 20180810 nfis0811: Umstellung GIK auf IMS Logik
SELECT
   DISTINCT ALLES.mandant_id,
   ALLES.rpm_hierarchie_id,
   ALLES.testmarkt_fg,
   ALLES.projekt_id AS projekt_id,
   ALLES.projekt_nr,
   ALLES.psp_id,
   ALLES.psp_id_char,
   ALLES.psp_end_nr,
   ALLES.AUSBLEND -- Flag für Prognose + IST Kosten
,
   ALLES.gesamt_investitions_kosten,
   ALLES.wrg_id AS wrg_id,
   ALLES.wrg_typ_id,
   ALLES.FAKTOR,
   ALLES.kurs_1
FROM
   (
      SELECT
         iipd.mandant_id,
         rpm_hierarchie_id,
         rpm.testmarkt_fg,
         cpro.projekt_id AS projekt_id,
         ipro.projekt_ext_id AS projekt_nr,
         iipd.psp_id,
         v02.psp_id_char,
         v02.psp_end_nr,
         COALESCE(best.in_wg_id, '-1') AS in_wg_id,
         v99.wrg_id AS wrg_id,
         v99.wrg_typ_id,
         kurs.FAKTOR,
         kurs.kurs_1,
         CASE
            WHEN v02.psp_end_nr IN (3, 4, 5, 6, 7) THEN 1
            WHEN v02.psp_end_nr = 2
            OR (
               v02.psp_end_nr = 1
               AND (
                  in_wg_id = '-1'
                  OR in_wg_id IS NULL
               )
            ) THEN 0
            ELSE 1
         END AS AUSBLEND -- Flag für Prognose + IST Kosten
, ROUND(iipd.plan_betrag * FAKTOR :: DECIMAL(18, 4),4) AS gesamt_investitions_kosten
      FROM
         dbp_view.v_ims_invest_plan_det_1 iipd
         JOIN dbp_view.v_in_psp_element_1 v02 ON iipd.mandant_id = v02.mandant_id
         AND iipd.psp_id = v02.psp_id
         JOIN dbp_view.v_in_projekt_1 ipro ON ipro.mandant_id = v02.mandant_id
         AND ipro.in_projekt_id = v02.in_projekt_id
         AND ipro.ims_projekt_typ_id IN ('E', 'G', 'B') -- nur definierte Projekte
         JOIN dbp_view.v_cpr_projekt_per_1 cpro ON cpro.cpr_ext_id = ipro.projekt_ext_id
         AND cpro.dat_bis = '9999-12-31'
         JOIN dbp_view.v_rpm_element_per_1 rpm ON rpm.projekt_id = cpro.cpr_ext_id
         AND rpm.dat_bis = '9999-12-31'
         LEFT JOIN (
            SELECT
               DISTINCT ibbk.mandant_id,
               ibbk.psp_id,
               ibbd.in_wg_id
            FROM
               dbp_view.v_in_besch_best_kontierung_1 ibbk
               JOIN dbp_view.v_in_besch_best_det_1 ibbd ON ibbd.best_beleg_id = ibbk.best_beleg_id
               AND ibbd.best_beleg_pos_id = ibbk.best_beleg_pos_id
               AND ibbd.mandant_id = ibbk.mandant_id
               AND ibbd.loesch_id = '' -- nur gueltige Bestellungen
               AND ibbk.psp_id > 0
            GROUP BY
               1,
               2,
               3
         ) best ON best.mandant_id = iipd.mandant_id
         AND best.psp_id = iipd.psp_id
         JOIN dbp_view.v_mandant_wrg_typ_zu_1 v99 ON v99.mandant_id = iipd.mandant_id
         JOIN dbp_msi_view_ios.mv_user_kurs_1 kurs_1 ON kurs.mandant_id = v99.mandant_id --AND kurs.von_wrg
         AND kurs.wrg_typ_id = v99.wrg_typ_id
         AND kurs.wrg_id = v99.wrg_id
   ) ALLES;