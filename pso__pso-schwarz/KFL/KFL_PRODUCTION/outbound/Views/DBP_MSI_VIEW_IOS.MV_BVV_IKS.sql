CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_bvv_iks (mandant_id, projekt_id, rpm_hierarchie_id,
in_projekt_id, psp_id, land_id, wup_id, wup_standort, projekt_nr, rpm_projekt_typ_id, testmarkt_fg, in_lief_id,
rpm_status_id, rpm_phase_id, rpm_phase_bez, wrg_id_rpm, ims_projekt_typ_id, in_projekt_id_char, psp_id_char, psp_end_nr
, wg_psp_end_nr, in_wg_id, normal_bvv_leist_id, bvv_leist_id, wrg_id, wrg_typ_id, faktor, kurs, ausblend,
menge_besch_best, betrag_besch_best, betrag_besch_best_nt, betrag_obligo, betrag_obligo_nt, betrag_obligo_plan,
betrag_ist_kosten, betrag_ist_kosten_neu, betrag_bkz, betrag_infra, betrag_rueckst, betrag_ist_orst_oinfra,
infra_rueck_betrag_neu, betrag_ist_orst_oinfra_neu, betrag_ist_kosten_nt, psp_baukosten_zu_akt, betrag_kosten_prognose,
rownumber, betrag_mmk_prognose, betrag_zea_prognose, betrag_hochrechnung, psp_kosten_prognose, psp_zea_prognose,
psp_mmk_prognose, psp_c1_25, psp_c2_26, psp_a1_02, projekt_b2_22, psp_c3_27, psp_c4_28, psp_b4_24, projekt_b3_23,
psp_c5_34, psp_c6_29, psp_c7_32, psp_c6_38, psp_c2_37, bkz_a1_02, bkz_b4_24, psp_akt_prognose,
kosten_prognose_version_id, dat_kosten_prognose_version, akt_budget_dat, bkz_obligo, betrag_hochrechnung_ohne_bkz,
psp_konditionswert, psp_betrag_konditionswert_gebucht, psp_betrag_konditionswert_ungebucht,
bkz_betrag_konditionswert_gebucht, bkz_betrag_konditionswert_ungebucht) AS SELECT sub00.mandant_id,
 sub00.projekt_id,
 sub00.rpm_hierarchie_id,
 sub00.in_projekt_id,
 sub00.psp_id,
 sub00.land_id,
 sub00.wup_id,
 sub00.wup_standort,
 sub00.projekt_nr,
 sub00.rpm_projekt_typ_id,
 sub00.testmarkt_fg,
  CASE
  WHEN COALESCE(sub00.lief_best, sub00.lief_ist_kosten, sub00.lief_obligo) IS NULL
  THEN CAST(- 1 AS BIGNUMERIC)
  ELSE COALESCE(sub00.lief_best, sub00.lief_ist_kosten, sub00.lief_obligo)
  END AS in_lief_id,
 sub00.rpm_status_id,
 sub00.rpm_phase_id,
 sub00.rpm_phase_bez,
 sub00.wrg_id_rpm,
 sub00.ims_projekt_typ_id,
 sub00.in_projekt_id_char,
 sub00.psp_id_char,
 COALESCE(bvv.bvv_leist_id, ROUND(CAST('99' || CAST(sub00.psp_end_nr AS STRING) AS BIGNUMERIC), 0)) AS psp_end_nr,
  CASE
  WHEN bvv.bvv_leist_id IS NOT NULL
  THEN 0
  ELSE 1
  END AS wg_psp_end_nr,
 sub00.in_wg_id,
 bvv.bvv_leist_id AS normal_bvv_leist_id,
 COALESCE(bvv.bvv_leist_id, ROUND(CAST('99' || CAST(sub00.psp_end_nr AS STRING) AS BIGNUMERIC), 0)) AS bvv_leist_id,
 V99.wrg_id,
 V99.wrg_typ_id,
 ROUND(sub00.betrag_besch_best * KURS0.faktor, 4) AS faktor,
 KURS0.kurs,
  CASE
  WHEN sub00.psp_end_nr IN (3, 4, 5, 6, 7)
  THEN 1
  WHEN sub00.psp_end_nr = 2 OR sub00.psp_end_nr = 1 AND sub00.in_wg_id = '-1'
  THEN 0
  ELSE 1
  END AS ausblend,
  sub00.menge_besch_best * KURS0.faktor AS menge_besch_best,
 ROUND(sub00.betrag_besch_best * KURS0.faktor, 4) AS betrag_besch_best,
 ROUND(sub00.betrag_besch_best_nt * KURS0.faktor, 4) AS betrag_besch_best_nt,
  sub00.betrag_obligo * KURS0.faktor AS betrag_obligo,
  sub00.betrag_obligo_nt * KURS0.faktor AS betrag_obligo_nt,
  sub00.betrag_obligo_plan * KURS0.faktor AS betrag_obligo_plan,
  sub00.betrag_ist_kosten * KURS0.faktor AS betrag_ist_kosten,
  sub00.betrag_ist_kosten_neu * KURS0.faktor AS betrag_ist_kosten_neu,
  sub00.betrag_bkz * KURS0.faktor AS betrag_bkz,
  sub00.betrag_infra * KURS0.faktor AS betrag_infra,
  sub00.betrag_rueckst * KURS0.faktor AS betrag_rueckst,
  sub00.betrag_ist_orst_oinfra * KURS0.faktor AS betrag_ist_orst_oinfra,
  sub00.infra_rueck_betrag_neu * KURS0.faktor AS infra_rueck_betrag_neu,
  sub00.betrag_ist_orst_oinfra_neu * KURS0.faktor AS betrag_ist_orst_oinfra_neu,
  sub00.betrag_ist_kosten_nt * KURS0.faktor AS betrag_ist_kosten_nt,
  COALESCE(sub00.psp_baukosten_34, sub00.psp_baukosten_28, sub00.psp_baukosten_27, sub00.psp_baukosten_26, sub00.psp_baukosten_24
   ) * KURS0.faktor AS psp_baukosten_zu_akt,
  IFNULL(sub00.betrag_kosten_prognose, 0) * KURS0.faktor AS betrag_kosten_prognose,
 ROW_NUMBER() OVER (PARTITION BY CAST(sub00.mandant_id AS STRING), sub00.projekt_id, sub00.rpm_hierarchie_id, CAST(sub00.in_projekt_id AS STRING)
    , CAST(sub00.psp_id AS STRING), sub00.land_id, CAST(sub00.wup_id AS STRING), sub00.wup_standort, sub00.projekt_nr, CAST(sub00.psp_end_nr AS STRING)
    , sub00.in_wg_id, CAST(V99.wrg_typ_id AS STRING), CAST(bvv.bvv_leist_id AS STRING) ORDER BY sub00.psp_id IS NULL,
    sub00.psp_id, V99.wrg_typ_id IS NULL, V99.wrg_typ_id, bvv.bvv_leist_id IS NULL, bvv.bvv_leist_id) AS rownumber,
  sub00.betrag_mmk_prognose * KURS0.faktor AS betrag_mmk_prognose,
  sub00.betrag_zea_prognose * KURS0.faktor AS betrag_zea_prognose,
   (IFNULL(sub00.betrag_ist_kosten, 0) + IFNULL(sub00.betrag_obligo, 0) + IFNULL(sub00.betrag_mmk_prognose, 0) + IFNULL(sub00
     .betrag_zea_prognose, 0)) * KURS0.faktor AS betrag_hochrechnung,
  sub00.psp_kosten_prognose * KURS0.faktor AS psp_kosten_prognose,
  sub00.psp_zea_prognose * KURS0.faktor AS psp_zea_prognose,
  sub00.psp_mmk_prognose * KURS0.faktor AS psp_mmk_prognose,
  sub00.psp_c1_25 * KURS0.faktor AS psp_c1_25,
  sub00.psp_c2_26 * KURS0.faktor AS psp_c2_26,
  sub00.psp_a1_02 * KURS0.faktor AS psp_a1_02,
  sub00.projekt_b2_22 * KURS0.faktor AS projekt_b2_22,
  sub00.psp_c3_27 * KURS0.faktor AS psp_c3_27,
  sub00.psp_c4_28 * KURS0.faktor AS psp_c4_28,
  sub00.psp_b4_24 * KURS0.faktor AS psp_b4_24,
  sub00.projekt_b3_23 * KURS0.faktor AS projekt_b3_23,
  sub00.psp_c5_34 * KURS0.faktor AS psp_c5_34,
  sub00.psp_c6_29 * KURS0.faktor AS psp_c6_29,
  sub00.psp_c7_32 * KURS0.faktor AS psp_c7_32,
  sub00.psp_c6_38 * KURS0.faktor AS psp_c6_38,
  sub00.psp_c2_37 * KURS0.faktor AS psp_c2_37,
  sub00.bkz_a1_02 * KURS0.faktor AS bkz_a1_02,
  sub00.bkz_b4_24 * KURS0.faktor AS bkz_b4_24,
  COALESCE(sub00.psp_c5_34, sub00.psp_c6_38, sub00.psp_c4_28, sub00.psp_c3_27, sub00.psp_c2_26) * KURS0.faktor AS
 psp_akt_prognose,
 IKPP.kosten_prognose_version_id,
 IKPP.dat_kosten_prognose_version,
 sub00.akt_budget_dat,
   CASE
   WHEN sub00.bkz_b4_24 IS NOT NULL AND KURS0.faktor IS NOT NULL
   THEN sub00.bkz_b4_24 * KURS0.faktor
   ELSE sub00.bkz_a1_02 * KURS0.faktor
   END - CASE
    WHEN sub00.betrag_bkz IS NULL
    THEN 0
    ELSE sub00.betrag_bkz
    END * KURS0.faktor AS bkz_obligo,
   (IFNULL(sub00.betrag_ist_kosten, 0) + IFNULL(sub00.betrag_obligo, 0) + IFNULL(sub00.betrag_mmk_prognose, 0) + IFNULL(sub00
       .betrag_zea_prognose, 0) - IFNULL(CASE
        WHEN sub00.bkz_b4_24 IS NOT NULL AND KURS0.faktor IS NOT NULL
        THEN sub00.bkz_b4_24 * KURS0.faktor
        ELSE sub00.bkz_a1_02 * KURS0.faktor
        END - CASE
         WHEN sub00.betrag_bkz IS NULL
         THEN 0
         ELSE sub00.betrag_bkz
         END * KURS0.faktor, 0) - IFNULL(sub00.betrag_bkz, 0)) * KURS0.faktor AS betrag_hochrechnung_ohne_bkz,
 SUM(CAST(CASE
    WHEN sub00.psp_end_nr IN (1, 2)
    THEN pkw.betrag_konditionswert_gebucht
    ELSE NULL
    END AS NUMERIC)) AS psp_konditionswert,
 SUM(CAST(CASE
    WHEN sub00.psp_end_nr IN (1, 2)
    THEN pkw.betrag_konditionswert_gebucht
    ELSE NULL
    END AS NUMERIC)) AS psp_betrag_konditionswert_gebucht,
 SUM(CAST(CASE
    WHEN sub00.psp_end_nr IN (1, 2, 3, 4)
    THEN pkw.betrag_konditionswert_ungebucht
    ELSE NULL
    END AS NUMERIC)) AS psp_betrag_konditionswert_ungebucht,
 SUM(CAST(CASE
    WHEN sub00.psp_end_nr IN (1, 2, 3) AND pkw.konditionsart_id IN (1060, 1110, 1120, 1320, 3110, 3310, 8060, 8320)
    THEN pkw.betrag_konditionswert_gebucht
    ELSE NULL
    END AS NUMERIC)) AS bkz_betrag_konditionswert_gebucht,
 SUM(CAST(CASE
    WHEN sub00.psp_end_nr IN (1, 2, 3) AND pkw.konditionsart_id IN (1060, 1110, 1120, 1320, 3110, 3310, 8060, 8320)
    THEN pkw.betrag_konditionswert_ungebucht
    ELSE NULL
    END AS NUMERIC)) AS bkz_betrag_konditionswert_ungebucht
FROM (SELECT sub02.land_id,
    sub02.mandant_id,
    sub02.wup_id,
    sub02.wup_standort,
    sub02.projekt_nr,
    sub02.projekt_id,
    sub02.rpm_projekt_typ_id,
    sub02.rpm_hierarchie_id,
    sub02.testmarkt_fg,
    sub02.lief_ist_kosten,
    sub02.lief_obligo,
    sub02.lief_best,
    sub02.rpm_status_id,
    sub02.rpm_phase_id,
    sub02.rpm_phase_bez,
    sub02.wrg_id_rpm,
    sub02.ims_projekt_typ_id,
    sub02.in_projekt_id_char,
    sub02.in_projekt_id,
    sub02.psp_id_char,
    sub02.psp_id,
    sub02.psp_end_nr,
    sub02.in_wg_id,
    sub02.menge_besch_best,
    sub02.betrag_besch_best,
    sub02.betrag_besch_best_nt,
    sub02.betrag_obligo,
    sub02.betrag_obligo_nt,
    sub02.betrag_obligo_plan,
    sub02.betrag_ist_kosten,
    sub02.betrag_ist_kosten_neu,
    sub02.betrag_bkz,
    sub02.betrag_infra,
    sub02.betrag_rueckst,
    sub02.betrag_ist_orst_oinfra,
    sub02.infra_rueck_betrag_neu,
    sub02.betrag_ist_orst_oinfra_neu,
    sub02.betrag_ist_kosten_nt,
    ikp.betrag_kosten_prognose,
    ikp.betrag_mmk_prognose,
    ikp.betrag_zea_prognose,
    sub02.psp_c1_25,
    sub02.psp_c2_26,
    sub02.psp_a1_02,
    sub02.projekt_b2_22,
    sub02.psp_c3_27,
    sub02.psp_c4_28,
    sub02.psp_b4_24,
    sub02.projekt_b3_23,
    sub02.psp_c5_34,
    sub02.psp_c6_29,
    sub02.psp_c7_32,
    sub02.psp_c6_38,
    sub02.psp_c2_37,
    sub02.bkz_a1_02,
    sub02.bkz_b4_24,
    NULL AS psp_baukosten_24,
    NULL AS psp_baukosten_26,
    NULL AS psp_baukosten_27,
    NULL AS psp_baukosten_28,
    NULL AS psp_baukosten_34,
    NULL AS psp_baukosten_zu_akt,
    sub02.psp_kosten_prognose,
    sub02.psp_zea_prognose,
    sub02.psp_mmk_prognose,
    sub02.akt_budget_dat
   FROM (SELECT psp.land_id,
      psp.mandant_id,
      psp.wup_id,
      psp.wup_standort,
      psp.projekt_nr,
      psp.projekt_id,
      psp.rpm_projekt_typ_id,
      psp.rpm_hierarchie_id,
      psp.testmarkt_fg,
      fakt.lief_ist_kosten,
      fakt.lief_obligo,
      fakt.lief_best,
      psp.rpm_status_id,
      psp.rpm_phase_id,
      psp.rpm_phase_bez,
      psp.wrg_id_rpm,
      psp.ims_projekt_typ_id,
      psp.in_projekt_id_char,
      psp.in_projekt_id,
      psp.psp_id_char,
      psp.psp_id,
       CASE
       WHEN psp.ims_projekt_typ_id = 'B'
       THEN 3
       ELSE psp.psp_end_nr
       END AS psp_end_nr,
       CASE
       WHEN psp.ims_projekt_typ_id = 'B'
       THEN '-1'
       ELSE fakt.in_wg_id
       END AS in_wg_id,
      SUM(fakt.menge_best_bme) AS menge_besch_best,
      SUM(fakt.betrag_besch_best) AS betrag_besch_best,
      SUM(fakt.betrag_besch_best_nt) AS betrag_besch_best_nt,
      SUM(fakt.betrag_obligo) AS betrag_obligo,
      SUM(fakt.betrag_obligo_nt) AS betrag_obligo_nt,
      SUM(fakt.betrag_obligo_plan) AS betrag_obligo_plan,
      SUM(fakt.betrag_ist_kosten) AS betrag_ist_kosten,
      SUM(fakt.betrag_bkz) AS betrag_bkz,
      SUM(fakt.betrag_ist_kosten_neu) AS betrag_ist_kosten_neu,
      SUM(fakt.betrag_infra) AS betrag_infra,
      SUM(fakt.betrag_rueckst) AS betrag_rueckst,
      SUM(fakt.betrag_ist_orst_oinfra) AS betrag_ist_orst_oinfra,
      SUM(fakt.infra_rueck_betrag_neu) AS infra_rueck_betrag_neu,
      SUM(fakt.betrag_ist_orst_oinfra_neu) AS betrag_ist_orst_oinfra_neu,
      SUM(fakt.betrag_ist_kosten_nt) AS betrag_ist_kosten_nt,
      SUM(fakt.psp_c1_25) AS psp_c1_25,
      SUM(fakt.psp_c2_26) AS psp_c2_26,
      SUM(fakt.psp_a1_02) AS psp_a1_02,
      SUM(fakt.projekt_b2_22) AS projekt_b2_22,
      SUM(fakt.psp_c3_27) AS psp_c3_27,
      SUM(fakt.psp_c4_28) AS psp_c4_28,
      SUM(fakt.psp_b4_24) AS psp_b4_24,
      SUM(fakt.projekt_b3_23) AS projekt_b3_23,
      SUM(fakt.psp_c5_34) AS psp_c5_34,
      SUM(fakt.psp_c6_29) AS psp_c6_29,
      SUM(fakt.psp_c7_32) AS psp_c7_32,
      SUM(fakt.psp_c6_38) AS psp_c6_38,
      SUM(fakt.psp_c2_37) AS psp_c2_37,
      SUM(fakt.bkz_a1_02) AS bkz_a1_02,
      SUM(fakt.bkz_b4_24) AS bkz_b4_24,
      SUM(fakt.psp_kosten_prognose) AS psp_kosten_prognose,
      SUM(fakt.betrag_zea_prognose) AS psp_zea_prognose,
      SUM(fakt.betrag_mmk_prognose) AS psp_mmk_prognose,
      MAX(fakt.akt_budget_dat) AS akt_budget_dat
     FROM (SELECT CPRO.land_id,
        IPSP.mandant_id,
        COALESCE(WUP.aktuell_wup_id, RPM.wup_id) AS wup_id,
        RPM.wup_standort,
        CPRO.cpr_ext_id AS projekt_nr,
        CPRO.projekt_id,
        RPM.rpm_projekt_typ_id,
        RPM.rpm_hierarchie_id,
        RPM.testmarkt_fg,
        RPM.rpm_status_id,
        RPM.rpm_phase_id,
        RPSZ.rpm_phase_bez,
        RPM.wrg_id AS wrg_id_rpm,
        IPRO.ims_projekt_typ_id,
        IPRO.in_projekt_id_char,
        IPRO.in_projekt_id,
        IPSP.psp_id_char,
        IPSP.psp_id,
        IPSP.psp_end_nr
       FROM kfl_production_dbp_view.v_in_psp_element AS IPSP
        INNER JOIN kfl_production_dbp_view.v_in_projekt AS IPRO ON IPSP.mandant_id = IPRO.mandant_id AND IPSP.in_projekt_id
            = IPRO.in_projekt_id AND IPRO.ims_projekt_typ_id IN ('E', 'G', 'B')
        INNER JOIN kfl_production_dbp_view.v_cpr_projekt_per AS CPRO ON IPRO.projekt_ext_id = CPRO.cpr_ext_id AND CPRO.dat_bis
           = DATE '9999-12-31'
        INNER JOIN kfl_production_dbp_view.v_rpm_element_per AS RPM ON CPRO.cpr_ext_id = RPM.projekt_id AND RPM.dat_bis
          = DATE '9999-12-31'
        INNER JOIN kfl_production_dbp_view.v_rpm_phase_spr_zu AS RPSZ ON RPM.rpm_phase_id = RPSZ.rpm_phase_id AND RPM.rpm_projekt_typ_id
            = RPSZ.rpm_projekt_typ_id AND RPSZ.spr_id = 22
        LEFT JOIN kfl_production_dbp_view.v_wup AS WUP ON RPM.wup_id = WUP.wup_id AND RPM.mandant_id = WUP.mandant_id
       GROUP BY CPRO.land_id,
        IPSP.mandant_id,
        wup_id,
        RPM.wup_standort,
        projekt_nr,
        CPRO.projekt_id,
        RPM.rpm_projekt_typ_id,
        RPM.rpm_hierarchie_id,
        RPM.testmarkt_fg,
        RPM.rpm_status_id,
        RPM.rpm_phase_id,
        RPSZ.rpm_phase_bez,
        wrg_id_rpm,
        IPRO.ims_projekt_typ_id,
        IPRO.in_projekt_id_char,
        IPRO.in_projekt_id,
        IPSP.psp_id_char,
        IPSP.psp_id,
        IPSP.psp_end_nr) AS psp
      LEFT JOIN (SELECT ibbk.psp_id,
         ibbk.mandant_id,
         COALESCE(ibbd.in_wg_id, '-1') AS in_wg_id,
         ibbk.best_beleg_id,
         ibbk.best_beleg_pos_id,
         ibbk.kontierung_pos_id,
         ibbd.unterposition_typ_id,
         ikd.bestell_text,
         ikd.lief_ist_kosten,
         op.lief_obligo,
         IBB.in_lief_id AS lief_best,
         ibbd.menge_best_bme,
          ibbd.betrag_pos_netto_best_wrg * CASE
           WHEN ibbd.retourenpos_fg = 1
           THEN - 1
           ELSE 1
           END AS betrag_besch_best,
          CASE
          WHEN ibbd.unterposition_typ_id = 'N'
          THEN CAST(ibbd.betrag_pos_netto_best_wrg * CASE
             WHEN ibbd.retourenpos_fg = 1
             THEN - 1
             ELSE 1
             END AS NUMERIC)
          ELSE ibbd.betrag_pos_netto_best_wrg * CASE
             WHEN ibbd.retourenpos_fg = 1
             THEN - 1
             ELSE 1
             END * 0.00
          END AS betrag_besch_best_nt,
         op.betrag AS betrag_obligo,
          CASE
          WHEN ibbd.unterposition_typ_id = 'N'
          THEN CAST(op.betrag AS NUMERIC)
          ELSE op.betrag * 0.00
          END AS betrag_obligo_nt,
         op.betrag_plan AS betrag_obligo_plan,
         ikd.anzahl,
         ikd.betrag AS betrag_ist_kosten,
         ikd.betrag_neu AS betrag_ist_kosten_neu,
         ikd.bkz_betrag AS betrag_bkz,
         ikd.infra_betrag AS betrag_infra,
         ikd.rueckst_betrag AS betrag_rueckst,
           ikd.betrag - IFNULL(ikd.infra_betrag, 0) - IFNULL(ikd.rueckst_betrag, 0) AS betrag_ist_orst_oinfra,
         ikd.infra_rueck_betrag_neu,
          ikd.betrag - IFNULL(ikd.infra_rueck_betrag_neu, 0) AS betrag_ist_orst_oinfra_neu,
          CASE
          WHEN ibbd.unterposition_typ_id = 'N'
          THEN CAST(ikd.betrag AS NUMERIC)
          ELSE ikd.betrag * 0.00
          END AS betrag_ist_kosten_nt,
         CAST(NULL AS NUMERIC) AS psp_c1_25,
         CAST(NULL AS NUMERIC) AS psp_c2_26,
         CAST(NULL AS NUMERIC) AS psp_a1_02,
         CAST(NULL AS NUMERIC) AS projekt_b2_22,
         CAST(NULL AS NUMERIC) AS psp_c3_27,
         CAST(NULL AS NUMERIC) AS psp_c4_28,
         CAST(NULL AS NUMERIC) AS psp_b4_24,
         CAST(NULL AS NUMERIC) AS projekt_b3_23,
         CAST(NULL AS NUMERIC) AS psp_c5_34,
         CAST(NULL AS NUMERIC) AS psp_c6_29,
         CAST(NULL AS NUMERIC) AS psp_c7_32,
         CAST(NULL AS NUMERIC) AS psp_c6_38,
         CAST(NULL AS NUMERIC) AS psp_c2_37,
         CAST(NULL AS NUMERIC) AS bkz_a1_02,
         CAST(NULL AS NUMERIC) AS bkz_b4_24,
         CAST(NULL AS NUMERIC) AS psp_kosten_prognose,
         CAST(NULL AS NUMERIC) AS betrag_zea_prognose,
         CAST(NULL AS NUMERIC) AS betrag_mmk_prognose,
         DATE(NULL) AS akt_budget_dat
        FROM (SELECT psp_id,
           mandant_id,
           best_beleg_id,
           best_beleg_pos_id,
           kontierung_pos_id
          FROM kfl_production_dbp_view.v_in_besch_best_kontierung) AS ibbk
         LEFT JOIN (SELECT IKD1.mandant_id,
           IKD1.in_lief_id AS lief_ist_kosten,
            CASE
            WHEN IKD1.best_beleg_id = - 1 OR IKD1.best_beleg_id IS NULL
            THEN ibb.best_beleg_id
            ELSE IKD1.best_beleg_id
            END AS best_beleg_id,
            CASE
            WHEN IKD1.best_beleg_pos_id = 0
            THEN ibb.best_beleg_pos_id
            ELSE IKD1.best_beleg_pos_id
            END AS best_beleg_pos_id,
           IKD1.psp_id,
           MAX(IKD1.bestell_text) AS bestell_text,
           SUM(IKD1.betrag) AS betrag,
            SUM(IKD1.betrag) - SUM(CASE
              WHEN IKD1.kostenart_id = '0000092300' OR IKD1.kostenart_id = '0000228000' OR IKD1.kostenart_id =
                 '0000750014' OR IKD1.kostenart_id = '0000710170' AND IKD1.gegenkonto_id IN ('0000991907', '0000710170'
                  , '2000505972', '0000750070')
              THEN IKD1.betrag
              ELSE 0
              END) AS betrag_neu,
           SUM(CASE
             WHEN IKD1.kostenart_id = '0000092300' OR IKD1.kostenart_id = '0000228000' OR IKD1.kostenart_id =
                '0000750014' OR IKD1.kostenart_id = '0000710170' AND IKD1.gegenkonto_id IN ('0000991907', '0000710170',
                 '2000505972', '0000750070')
             THEN IKD1.betrag
             ELSE NULL
             END) AS bkz_betrag,
           SUM(CASE
             WHEN IKD1.kostenart_id LIKE '%550100'
             THEN IKD1.betrag
             ELSE NULL
             END) AS infra_betrag,
           SUM(CASE
             WHEN IKD1.kostenart_id = '0000244900' OR IKD1.kostenart_id = '0000514320' OR IKD1.kostenart_id =
                '0000514000' AND IKD1.gegenkonto_id IN ('0000097150', '0000097800')
             THEN IKD1.betrag
             ELSE NULL
             END) AS rueckst_betrag,
           SUM(CASE
             WHEN IKD1.gegenkonto_id IN ('0000097500', '0000097702', '0000097150', '0000097800', '0000097602',
               '0000097600', '0000097610', '0000099700', '0000095610')
             THEN IKD1.betrag
             ELSE NULL
             END) AS infra_rueck_betrag_neu,
           COUNT(*) AS anzahl
          FROM kfl_production_dbp_view.v_ist_kosten_det AS IKD1
           LEFT JOIN (SELECT mandant_id,
             folge_beleg_id,
             dat_buch,
             MAX(best_beleg_id) AS best_beleg_id,
             MAX(best_beleg_pos_id) AS best_beleg_pos_id
            FROM kfl_production_dbp_view.v_in_best_belegfluss
            GROUP BY mandant_id,
             folge_beleg_id,
             dat_buch) AS ibb ON IKD1.ref_beleg_id = ibb.folge_beleg_id AND IKD1.dat_buch = ibb.dat_buch AND IKD1.mandant_id
              = ibb.mandant_id
          WHERE IKD1.hb2_fg = 1
           AND (CASE
              WHEN IKD1.best_beleg_id = - 1
              THEN ibb.best_beleg_id
              WHEN IKD1.best_beleg_id IS NULL
              THEN ibb.best_beleg_id
              ELSE IKD1.best_beleg_id
              END, CASE
              WHEN IKD1.best_beleg_pos_id = 0
              THEN ibb.best_beleg_pos_id
              ELSE IKD1.best_beleg_pos_id
              END, IKD1.mandant_id) IN (SELECT (best_beleg_id, best_beleg_pos_id, mandant_id)
             FROM kfl_production_dbp_view.v_in_besch_best_kontierung)
           AND LTRIM(TRIM(COLLATE(IKD1.kostenart_id, '')), '0') NOT IN ('912000', '979002', 'H912000', 'H979002',
             '880100', '940003', '991907')
          GROUP BY IKD1.mandant_id,
           lief_ist_kosten,
           best_beleg_id,
           best_beleg_pos_id,
           IKD1.psp_id) AS ikd ON ibbk.mandant_id = ikd.mandant_id AND ibbk.best_beleg_id = ikd.best_beleg_id AND ibbk.best_beleg_pos_id
             = ikd.best_beleg_pos_id AND ibbk.psp_id = ikd.psp_id
         LEFT JOIN kfl_production_dbp_view.v_in_besch_best_det AS ibbd ON ibbk.mandant_id = ibbd.mandant_id AND ibbk.best_beleg_id
              = ibbd.best_beleg_id AND ibbk.best_beleg_pos_id = ibbd.best_beleg_pos_id AND ibbd.loesch_id = ''
         LEFT JOIN (SELECT mandant_id,
           krk_id,
           psp_id,
           kostenart_id,
           obligo_version_id,
           obligo_wrg_typ_id,
           gj,
           buchungsperiode_id,
           ref_beleg_id,
           ref_beleg_pos_id,
           ref_termin_pos_id,
           ref_kontierung_id,
           ref_objektart_id,
           in_lief_id AS lief_obligo,
           ref_beleg_typ_id,
           auftrag_id,
           dat_bis,
           loesch_id,
           wrg_id,
           menge_einh_id,
           buchungskreis_id,
           in_art_id,
           anlage_id,
           anlage_sub_id,
           kostenstelle_id,
           sparte_id,
           berichts_position_invest_id,
           berichts_position_it_id,
           psp_id_char_alt,
           bestell_text,
           bedarf_nr,
           SUM(betrag) AS betrag,
           SUM(menge) AS menge,
           SUM(betrag_plan) AS betrag_plan
          FROM kfl_production_dbp_view.v_obligo_per
          GROUP BY mandant_id,
           krk_id,
           psp_id,
           kostenart_id,
           obligo_version_id,
           obligo_wrg_typ_id,
           gj,
           buchungsperiode_id,
           ref_beleg_id,
           ref_beleg_pos_id,
           ref_termin_pos_id,
           ref_kontierung_id,
           ref_objektart_id,
           lief_obligo,
           ref_beleg_typ_id,
           auftrag_id,
           dat_bis,
           loesch_id,
           wrg_id,
           menge_einh_id,
           buchungskreis_id,
           in_art_id,
           anlage_id,
           anlage_sub_id,
           kostenstelle_id,
           sparte_id,
           berichts_position_invest_id,
           berichts_position_it_id,
           psp_id_char_alt,
           bestell_text,
           bedarf_nr) AS op ON ibbd.mandant_id = op.mandant_id AND ibbd.best_beleg_id = op.ref_beleg_id AND ibbd.best_beleg_pos_id
               = op.ref_beleg_pos_id AND ibbk.psp_id = op.psp_id AND op.dat_bis = DATE '9999-12-31' AND CAST(CASE
             WHEN op.loesch_id = ''
             THEN '0'
             ELSE op.loesch_id
             END AS FLOAT64) = 0
         LEFT JOIN kfl_production_dbp_view.v_in_besch_best AS IBB ON ibbd.mandant_id = IBB.mandant_id AND ibbd.best_beleg_id
            = IBB.best_beleg_id
        GROUP BY ibbk.psp_id,
         ibbk.mandant_id,
         ibbd.in_wg_id,
         ibbk.best_beleg_id,
         ibbk.best_beleg_pos_id,
         ibbk.kontierung_pos_id,
         ibbd.unterposition_typ_id,
         ikd.bestell_text,
         ibbd.menge_best_bme,
         betrag_besch_best,
         betrag_besch_best_nt,
         betrag_obligo,
         betrag_obligo_nt,
         betrag_obligo_plan,
         ikd.anzahl,
         ikd.lief_ist_kosten,
         op.lief_obligo,
         lief_best,
         betrag_ist_kosten,
         betrag_ist_kosten_neu,
         betrag_bkz,
         betrag_infra,
         betrag_rueckst,
         ikd.infra_rueck_betrag_neu,
         betrag_ist_kosten_nt,
         psp_c1_25,
         psp_c2_26,
         psp_a1_02,
         projekt_b2_22,
         psp_c3_27,
         psp_c4_28,
         psp_b4_24,
         projekt_b3_23,
         psp_c5_34,
         psp_c6_29,
         psp_c7_32,
         psp_c6_38,
         psp_c2_37,
         bkz_a1_02,
         bkz_b4_24,
         psp_kosten_prognose
        UNION ALL
        SELECT IPSP.psp_id,
         IPSP.mandant_id,
         '-1' AS in_wg_id,
         0 AS best_beleg_id,
         0 AS best_beleg_pos_id,
         0 AS kontierung_pos_id,
         '' AS unterposition_typ_id,
         ikd.bestell_text,
         CAST(NULL AS BIGNUMERIC) AS lief_ist_kosten,
         CAST(NULL AS BIGNUMERIC) AS lief_obligo,
         CAST(NULL AS BIGNUMERIC) AS lief_best,
         CAST(NULL AS NUMERIC) AS menge_best_bme,
         CAST(NULL AS NUMERIC) AS betrag_besch_best,
         CAST(NULL AS NUMERIC) AS betrag_besch_best_nt,
         CAST(NULL AS NUMERIC) AS betrag_obligo,
         CAST(NULL AS NUMERIC) AS betrag_obligo_nt,
         CAST(NULL AS NUMERIC) AS betrag_obligo_plan,
         ikd.anzahl,
         ikd.betrag AS betrag_ist_kosten,
         ikd.betrag_neu AS betrag_ist_kosten_neu,
         ikd.bkz_betrag AS betrag_bkz,
         ikd.infra_betrag AS betrag_infra,
         ikd.rueckst_betrag AS betrag_rueckst,
           ikd.betrag - IFNULL(ikd.infra_betrag, 0) - IFNULL(ikd.rueckst_betrag, 0) AS betrag_ist_orst_oinfra,
         ikd.infra_rueck_betrag_neu,
          ikd.betrag - IFNULL(ikd.infra_rueck_betrag_neu, 0) AS betrag_ist_orst_oinfra_neu,
          ikd.betrag * 0 AS betrag_ist_kosten_nt,
         ppm.psp_c1_25,
         ppm.psp_c2_26,
         ppm.psp_a1_02,
         ppm.projekt_b2_22,
         ppm.psp_c3_27,
         ppm.psp_c4_28,
         ppm.psp_b4_24,
         ppm.projekt_b3_23,
         ppm.psp_c5_34,
         ppm.psp_c6_29,
         ppm.psp_c7_32,
         ppm.psp_c6_38,
         ppm.psp_c2_37,
         ppm.bkz_a1_02,
         ppm.bkz_b4_24,
         ppm.psp_kosten_prognose,
         ppm.betrag_zea_prognose,
         ppm.betrag_mmk_prognose,
         ppm.akt_budget_dat
        FROM kfl_production_dbp_view.v_in_psp_element AS IPSP
         INNER JOIN kfl_production_dbp_view.v_in_projekt AS IPRO ON IPSP.mandant_id = IPRO.mandant_id AND IPSP.in_projekt_id
             = IPRO.in_projekt_id AND IPRO.ims_projekt_typ_id IN ('E', 'G', 'B')
         INNER JOIN kfl_production_dbp_view.v_cpr_projekt_per AS CPRO ON IPRO.projekt_ext_id = CPRO.cpr_ext_id AND CPRO
           .dat_bis = DATE '9999-12-31'
         INNER JOIN kfl_production_dbp_view.v_rpm_element_per AS RPM ON CPRO.cpr_ext_id = RPM.projekt_id AND RPM.dat_bis
            = DATE '9999-12-31'
         LEFT JOIN (SELECT psp_id,
           mandant_id,
           '-' AS beleg_bez,
           '-' AS bestell_text,
           SUM(betrag) AS betrag,
            SUM(betrag) - SUM(CASE
              WHEN kostenart_id = '0000092300' OR kostenart_id = '0000228000' OR kostenart_id = '0000750014' OR
                 kostenart_id = '0000710170' AND gegenkonto_id IN ('0000991907', '0000710170', '2000505972',
                  '0000750070')
              THEN betrag
              ELSE 0
              END) AS betrag_neu,
           SUM(CASE
             WHEN kostenart_id = '0000092300' OR kostenart_id = '0000228000' OR kostenart_id = '0000750014' OR
                kostenart_id = '0000710170' AND gegenkonto_id IN ('0000991907', '0000710170', '2000505972', '0000750070'
                 )
             THEN betrag
             ELSE NULL
             END) AS bkz_betrag,
           SUM(CASE
             WHEN kostenart_id LIKE '%550100'
             THEN betrag
             ELSE NULL
             END) AS infra_betrag,
           SUM(CASE
             WHEN kostenart_id = '0000244900' OR kostenart_id = '0000514320' OR kostenart_id = '0000514000' AND
                gegenkonto_id IN ('0000097150', '0000097800')
             THEN betrag
             ELSE NULL
             END) AS rueckst_betrag,
           SUM(CASE
             WHEN gegenkonto_id IN ('0000097500', '0000097702', '0000097150', '0000097800', '0000097602', '0000097600',
               '0000097610', '0000099700', '0000095610')
             THEN betrag
             ELSE NULL
             END) AS infra_rueck_betrag_neu,
           COUNT(*) AS anzahl
          FROM kfl_production_dbp_view.v_ist_kosten_det
          WHERE hb2_fg = 1
           AND (mandant_id, beleg_id, beleg_pos_id) NOT IN (SELECT (IKD.mandant_id, IKD.beleg_id, IKD.beleg_pos_id)
             FROM kfl_production_dbp_view.v_ist_kosten_det AS IKD
              LEFT JOIN (SELECT mandant_id,
                folge_beleg_id,
                dat_buch,
                MAX(best_beleg_id) AS best_beleg_id,
                MAX(best_beleg_pos_id) AS best_beleg_pos_id
               FROM kfl_production_dbp_view.v_in_best_belegfluss
               GROUP BY mandant_id,
                folge_beleg_id,
                dat_buch) AS ibb ON IKD.ref_beleg_id = ibb.folge_beleg_id AND IKD.dat_buch = ibb.dat_buch AND IKD.mandant_id
                 = ibb.mandant_id
             WHERE IKD.hb2_fg = 1
              AND (CASE
                 WHEN IKD.best_beleg_id = - 1
                 THEN ibb.best_beleg_id
                 WHEN IKD.best_beleg_id IS NULL
                 THEN ibb.best_beleg_id
                 ELSE IKD.best_beleg_id
                 END, CASE
                 WHEN IKD.best_beleg_pos_id = 0
                 THEN ibb.best_beleg_pos_id
                 ELSE IKD.best_beleg_pos_id
                 END, IKD.mandant_id) IN (SELECT (best_beleg_id, best_beleg_pos_id, mandant_id)
                FROM kfl_production_dbp_view.v_in_besch_best_kontierung)
              AND LTRIM(TRIM(COLLATE(IKD.kostenart_id, '')), '0') NOT IN ('912000', '979002', 'H912000', 'H979002',
                '880100', '940003', '991907'))
           AND LTRIM(TRIM(COLLATE(kostenart_id, '')), '0') NOT IN ('912000', '979002', 'H912000', 'H979002', '880100',
             '940003', '991907')
          GROUP BY psp_id,
           mandant_id) AS ikd ON IPSP.psp_id = ikd.psp_id AND IPSP.mandant_id = ikd.mandant_id
         LEFT JOIN (SELECT RPM0.mandant_id,
           RPM0.rpm_hierarchie_id,
           CAST(CASE
             WHEN RFG.fin_gruppe_id IN ('FK0110_FG0110', 'FK0170_FG0110', 'FK0180_FG0110')
             THEN 1
             WHEN RFG.fin_gruppe_id IN ('FK0110_FG0120', 'FK0170_FG0120', 'FK0180_FG0120')
             THEN 2
             WHEN RFG.fin_gruppe_id IN ('FK0120_FG0110')
             THEN 3
             WHEN RFG.fin_gruppe_id IN ('FK0120_FG0120')
             THEN 4
             WHEN RFG.fin_gruppe_id IN ('FK0130_FG0110')
             THEN 5
             WHEN RFG.fin_gruppe_id IN ('FK0130_FG0120')
             THEN 6
             WHEN RFG.fin_gruppe_id IN ('FK0130_FG0130')
             THEN 7
             WHEN RFG.fin_gruppe_id IN ('FK0160_FG0120') OR RFG.fin_gruppe_id IN ('FK0120_FG0130')
             THEN 3
             ELSE - 1
             END AS BIGNUMERIC) AS psp_end_nr,
           RFP.wrg_id,
           SUM(CASE
             WHEN RFP.rpm_plantyp_id IN (25) AND CAST(CASE
                 WHEN RFG.fin_gruppe_id IN ('FK0110_FG0110', 'FK0110_FG0120', 'FK0170_FG0110', 'FK0180_FG0110', 'FK0170_FG0120', 'FK0180_FG0120')
                 THEN 1
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0110', 'FK0120_FG0120', 'FK0130_FG0110', 'FK0130_FG0120', 'FK0130_FG0130')
                 THEN 2
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0130')
                 THEN 9
                 WHEN RFG.fin_gruppe_id IN ('FK0160_FG0120')
                 THEN 3
                 ELSE - 1
                 END AS BIGNUMERIC) = 2
             THEN RFP.betrag
             ELSE NULL
             END) AS psp_c1_25,
           SUM(CASE
             WHEN RFP.rpm_plantyp_id IN (26) AND CAST(CASE
                 WHEN RFG.fin_gruppe_id IN ('FK0110_FG0110', 'FK0110_FG0120', 'FK0170_FG0110', 'FK0180_FG0110', 'FK0170_FG0120', 'FK0180_FG0120')
                 THEN 1
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0110', 'FK0120_FG0120', 'FK0130_FG0110', 'FK0130_FG0120', 'FK0130_FG0130')
                 THEN 2
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0130')
                 THEN 9
                 WHEN RFG.fin_gruppe_id IN ('FK0160_FG0120')
                 THEN 3
                 ELSE - 1
                 END AS BIGNUMERIC) = 2
             THEN RFP.betrag
             ELSE NULL
             END) AS psp_c2_26,
           SUM(CASE
             WHEN RFP.rpm_plantyp_id IN (2) AND CAST(CASE
                 WHEN RFG.fin_gruppe_id IN ('FK0110_FG0110', 'FK0110_FG0120', 'FK0170_FG0110', 'FK0180_FG0110', 'FK0170_FG0120', 'FK0180_FG0120')
                 THEN 1
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0110', 'FK0120_FG0120', 'FK0130_FG0110', 'FK0130_FG0120', 'FK0130_FG0130')
                 THEN 2
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0130')
                 THEN 9
                 WHEN RFG.fin_gruppe_id IN ('FK0160_FG0120')
                 THEN 3
                 ELSE - 1
                 END AS BIGNUMERIC) IN (1, 2, 9)
             THEN RFP.betrag
             ELSE NULL
             END) AS psp_a1_02,
           SUM(CASE
             WHEN RFP.rpm_plantyp_id IN (22) AND CAST(CASE
                 WHEN RFG.fin_gruppe_id IN ('FK0110_FG0110', 'FK0110_FG0120', 'FK0170_FG0110', 'FK0180_FG0110', 'FK0170_FG0120', 'FK0180_FG0120')
                 THEN 1
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0110', 'FK0120_FG0120', 'FK0130_FG0110', 'FK0130_FG0120', 'FK0130_FG0130')
                 THEN 2
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0130')
                 THEN 9
                 WHEN RFG.fin_gruppe_id IN ('FK0160_FG0120')
                 THEN 3
                 ELSE - 1
                 END AS BIGNUMERIC) = 3
             THEN RFP.betrag
             ELSE NULL
             END) AS projekt_b2_22,
           SUM(CASE
             WHEN RFP.rpm_plantyp_id IN (27) AND CAST(CASE
                 WHEN RFG.fin_gruppe_id IN ('FK0110_FG0110', 'FK0110_FG0120', 'FK0170_FG0110', 'FK0180_FG0110', 'FK0170_FG0120', 'FK0180_FG0120')
                 THEN 1
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0110', 'FK0120_FG0120', 'FK0130_FG0110', 'FK0130_FG0120', 'FK0130_FG0130')
                 THEN 2
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0130')
                 THEN 9
                 WHEN RFG.fin_gruppe_id IN ('FK0160_FG0120')
                 THEN 3
                 ELSE - 1
                 END AS BIGNUMERIC) = 2
             THEN RFP.betrag
             ELSE NULL
             END) AS psp_c3_27,
           SUM(CASE
             WHEN RFP.rpm_plantyp_id IN (28) AND CAST(CASE
                 WHEN RFG.fin_gruppe_id IN ('FK0110_FG0110', 'FK0110_FG0120', 'FK0170_FG0110', 'FK0180_FG0110', 'FK0170_FG0120', 'FK0180_FG0120')
                 THEN 1
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0110', 'FK0120_FG0120', 'FK0130_FG0110', 'FK0130_FG0120', 'FK0130_FG0130')
                 THEN 2
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0130')
                 THEN 9
                 WHEN RFG.fin_gruppe_id IN ('FK0160_FG0120')
                 THEN 3
                 ELSE - 1
                 END AS BIGNUMERIC) = 2
             THEN RFP.betrag
             ELSE NULL
             END) AS psp_c4_28,
           SUM(CASE
             WHEN RFP.rpm_plantyp_id IN (24) AND CAST(CASE
                 WHEN RFG.fin_gruppe_id IN ('FK0110_FG0110', 'FK0110_FG0120', 'FK0170_FG0110', 'FK0180_FG0110', 'FK0170_FG0120', 'FK0180_FG0120')
                 THEN 1
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0110', 'FK0120_FG0120', 'FK0130_FG0110', 'FK0130_FG0120', 'FK0130_FG0130')
                 THEN 2
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0130')
                 THEN 9
                 WHEN RFG.fin_gruppe_id IN ('FK0160_FG0120')
                 THEN 3
                 ELSE - 1
                 END AS BIGNUMERIC) IN (1, 2, 9)
             THEN RFP.betrag
             ELSE NULL
             END) AS psp_b4_24,
           SUM(CASE
             WHEN RFP.rpm_plantyp_id IN (23) AND CAST(CASE
                 WHEN RFG.fin_gruppe_id IN ('FK0110_FG0110', 'FK0110_FG0120', 'FK0170_FG0110', 'FK0180_FG0110', 'FK0170_FG0120', 'FK0180_FG0120')
                 THEN 1
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0110', 'FK0120_FG0120', 'FK0130_FG0110', 'FK0130_FG0120', 'FK0130_FG0130')
                 THEN 2
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0130')
                 THEN 9
                 WHEN RFG.fin_gruppe_id IN ('FK0160_FG0120')
                 THEN 3
                 ELSE - 1
                 END AS BIGNUMERIC) = 3
             THEN RFP.betrag
             ELSE NULL
             END) AS projekt_b3_23,
           SUM(CASE
             WHEN RFP.rpm_plantyp_id IN (34) AND CAST(CASE
                 WHEN RFG.fin_gruppe_id IN ('FK0110_FG0110', 'FK0110_FG0120', 'FK0170_FG0110', 'FK0180_FG0110', 'FK0170_FG0120', 'FK0180_FG0120')
                 THEN 1
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0110', 'FK0120_FG0120', 'FK0130_FG0110', 'FK0130_FG0120', 'FK0130_FG0130')
                 THEN 2
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0130')
                 THEN 9
                 WHEN RFG.fin_gruppe_id IN ('FK0160_FG0120')
                 THEN 3
                 ELSE - 1
                 END AS BIGNUMERIC) = 2
             THEN RFP.betrag
             ELSE NULL
             END) AS psp_c5_34,
           SUM(CASE
             WHEN RFP.rpm_plantyp_id IN (29) AND CAST(CASE
                 WHEN RFG.fin_gruppe_id IN ('FK0110_FG0110', 'FK0110_FG0120', 'FK0170_FG0110', 'FK0180_FG0110', 'FK0170_FG0120', 'FK0180_FG0120')
                 THEN 1
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0110', 'FK0120_FG0120', 'FK0130_FG0110', 'FK0130_FG0120', 'FK0130_FG0130')
                 THEN 2
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0130')
                 THEN 9
                 WHEN RFG.fin_gruppe_id IN ('FK0160_FG0120')
                 THEN 3
                 ELSE - 1
                 END AS BIGNUMERIC) = 2
             THEN RFP.betrag
             ELSE NULL
             END) AS psp_c6_29,
           SUM(CASE
             WHEN RFP.rpm_plantyp_id IN (32) AND CAST(CASE
                 WHEN RFG.fin_gruppe_id IN ('FK0110_FG0110', 'FK0110_FG0120', 'FK0170_FG0110', 'FK0180_FG0110', 'FK0170_FG0120', 'FK0180_FG0120')
                 THEN 1
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0110', 'FK0120_FG0120', 'FK0130_FG0110', 'FK0130_FG0120', 'FK0130_FG0130')
                 THEN 2
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0130')
                 THEN 9
                 WHEN RFG.fin_gruppe_id IN ('FK0160_FG0120')
                 THEN 3
                 ELSE - 1
                 END AS BIGNUMERIC) = 2
             THEN RFP.betrag
             ELSE NULL
             END) AS psp_c7_32,
           SUM(CASE
             WHEN RFP.rpm_plantyp_id IN (38) AND CAST(CASE
                 WHEN RFG.fin_gruppe_id IN ('FK0110_FG0110', 'FK0110_FG0120', 'FK0170_FG0110', 'FK0180_FG0110', 'FK0170_FG0120', 'FK0180_FG0120')
                 THEN 1
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0110', 'FK0120_FG0120', 'FK0130_FG0110', 'FK0130_FG0120', 'FK0130_FG0130')
                 THEN 2
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0130')
                 THEN 9
                 WHEN RFG.fin_gruppe_id IN ('FK0160_FG0120')
                 THEN 3
                 ELSE - 1
                 END AS BIGNUMERIC) = 2
             THEN RFP.betrag
             ELSE NULL
             END) AS psp_c6_38,
           SUM(CASE
             WHEN RFP.rpm_plantyp_id IN (37) AND CAST(CASE
                 WHEN RFG.fin_gruppe_id IN ('FK0110_FG0110', 'FK0110_FG0120', 'FK0170_FG0110', 'FK0180_FG0110', 'FK0170_FG0120', 'FK0180_FG0120')
                 THEN 1
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0110', 'FK0120_FG0120', 'FK0130_FG0110', 'FK0130_FG0120', 'FK0130_FG0130')
                 THEN 2
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0130')
                 THEN 9
                 WHEN RFG.fin_gruppe_id IN ('FK0160_FG0120')
                 THEN 3
                 ELSE - 1
                 END AS BIGNUMERIC) = 2
             THEN RFP.betrag
             ELSE NULL
             END) AS psp_c2_37,
           SUM(CASE
             WHEN RFP.rpm_plantyp_id IN (2) AND CAST(CASE
                 WHEN RFG.fin_gruppe_id IN ('FK0110_FG0110', 'FK0110_FG0120', 'FK0170_FG0110', 'FK0180_FG0110', 'FK0170_FG0120', 'FK0180_FG0120')
                 THEN 1
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0110', 'FK0120_FG0120', 'FK0130_FG0110', 'FK0130_FG0120', 'FK0130_FG0130')
                 THEN 2
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0130')
                 THEN 9
                 WHEN RFG.fin_gruppe_id IN ('FK0160_FG0120')
                 THEN 3
                 ELSE - 1
                 END AS BIGNUMERIC) IN (9)
             THEN RFP.betrag
             ELSE NULL
             END) AS bkz_a1_02,
           SUM(CASE
             WHEN RFP.rpm_plantyp_id IN (24) AND CAST(CASE
                 WHEN RFG.fin_gruppe_id IN ('FK0110_FG0110', 'FK0110_FG0120', 'FK0170_FG0110', 'FK0180_FG0110', 'FK0170_FG0120', 'FK0180_FG0120')
                 THEN 1
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0110', 'FK0120_FG0120', 'FK0130_FG0110', 'FK0130_FG0120', 'FK0130_FG0130')
                 THEN 2
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0130')
                 THEN 9
                 WHEN RFG.fin_gruppe_id IN ('FK0160_FG0120')
                 THEN 3
                 ELSE - 1
                 END AS BIGNUMERIC) IN (9)
             THEN RFP.betrag
             ELSE NULL
             END) AS bkz_b4_24,
           SUM(CASE
             WHEN RFP.rpm_plantyp_id IN (24) AND RFG.fin_gruppe_id IN ('FK0110_FG0110', 'FK0110_FG0120')
             THEN RFP.betrag
             ELSE NULL
             END) AS psp_kosten_prognose,
           SUM(CASE
             WHEN RFG.fin_gruppe_id IN ('FK0170_FG0110', 'FK0170_FG0120') AND CAST(CASE
                 WHEN RFG.fin_gruppe_id IN ('FK0110_FG0110', 'FK0170_FG0110', 'FK0180_FG0110')
                 THEN 1
                 WHEN RFG.fin_gruppe_id IN ('FK0110_FG0120', 'FK0170_FG0120', 'FK0180_FG0120')
                 THEN 2
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0110')
                 THEN 3
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0120')
                 THEN 4
                 WHEN RFG.fin_gruppe_id IN ('FK0130_FG0110')
                 THEN 5
                 WHEN RFG.fin_gruppe_id IN ('FK0130_FG0120')
                 THEN 6
                 WHEN RFG.fin_gruppe_id IN ('FK0130_FG0130')
                 THEN 7
                 WHEN RFG.fin_gruppe_id IN ('FK0160_FG0120') OR RFG.fin_gruppe_id IN ('FK0120_FG0130')
                 THEN 3
                 ELSE - 1
                 END AS BIGNUMERIC) IN (1, 2)
             THEN RFP.betrag
             ELSE NULL
             END) AS betrag_zea_prognose,
           SUM(CASE
             WHEN RFG.fin_gruppe_id IN ('FK0180_FG0110', 'FK0180_FG0120') AND CAST(CASE
                 WHEN RFG.fin_gruppe_id IN ('FK0110_FG0110', 'FK0170_FG0110', 'FK0180_FG0110')
                 THEN 1
                 WHEN RFG.fin_gruppe_id IN ('FK0110_FG0120', 'FK0170_FG0120', 'FK0180_FG0120')
                 THEN 2
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0110')
                 THEN 3
                 WHEN RFG.fin_gruppe_id IN ('FK0120_FG0120')
                 THEN 4
                 WHEN RFG.fin_gruppe_id IN ('FK0130_FG0110')
                 THEN 5
                 WHEN RFG.fin_gruppe_id IN ('FK0130_FG0120')
                 THEN 6
                 WHEN RFG.fin_gruppe_id IN ('FK0130_FG0130')
                 THEN 7
                 WHEN RFG.fin_gruppe_id IN ('FK0160_FG0120') OR RFG.fin_gruppe_id IN ('FK0120_FG0130')
                 THEN 3
                 ELSE - 1
                 END AS BIGNUMERIC) IN (1, 2)
             THEN RFP.betrag
             ELSE NULL
             END) AS betrag_mmk_prognose,
           MAX(CASE
             WHEN RFP.rpm_plantyp_id IN (24)
             THEN RFK.fin_kat_version_dat
             ELSE NULL
             END) AS akt_budget_dat
          FROM kfl_production_dbp_view.v_rpm_element_per AS RPM0
           INNER JOIN kfl_production_dbp_view.v_rpm_fin_kategorie AS RFK ON RPM0.rpm_hierarchie_id = RFK.rpm_hierarchie_id
            
           INNER JOIN kfl_production_dbp_view.v_rpm_fin_gruppe AS RFG ON RFK.fin_kat_hierarchie_id = RFG.fin_kat_hierarchie_id
            
           INNER JOIN kfl_production_dbp_view.v_rpm_fin_plan AS RFP ON RFG.fin_gruppe_hierarchie_id = RFP.fin_gruppe_hierarchie_id
                AND RFP.dat_bis = DATE '9999-12-31' AND RFP.rpm_plantyp_id IN (2, 22, 23, 24, 25, 26, 27, 28, 29, 32, 34
               , 35, 36, 37, 38) AND RFP.betrag <> 0
          WHERE RPM0.rpm_status_id <> - 1
           AND RPM0.dat_bis = DATE '9999-12-31'
          GROUP BY RPM0.mandant_id,
           RPM0.rpm_hierarchie_id,
           psp_end_nr,
           RFP.wrg_id) AS ppm ON RPM.rpm_hierarchie_id = ppm.rpm_hierarchie_id AND RPM.mandant_id = ppm.mandant_id AND
           IPSP.psp_end_nr = ppm.psp_end_nr) AS fakt ON psp.psp_id = fakt.psp_id AND psp.mandant_id = fakt.mandant_id
     GROUP BY psp.land_id,
      psp.mandant_id,
      psp.wup_id,
      psp.wup_standort,
      psp.projekt_nr,
      psp.projekt_id,
      psp.rpm_projekt_typ_id,
      psp.rpm_hierarchie_id,
      psp.testmarkt_fg,
      fakt.lief_ist_kosten,
      fakt.lief_obligo,
      fakt.lief_best,
      psp.rpm_status_id,
      psp.rpm_phase_id,
      psp.rpm_phase_bez,
      psp.wrg_id_rpm,
      psp.ims_projekt_typ_id,
      psp.in_projekt_id_char,
      psp.in_projekt_id,
      psp.psp_id_char,
      psp.psp_id,
      psp.psp_end_nr,
      fakt.in_wg_id) AS sub02
    LEFT JOIN (SELECT mandant_id,
      in_projekt_id,
      psp_id,
      in_wg_id,
      betrag_kosten_prognose,
      betrag_mmk_prognose,
      betrag_zea_prognose,
      wrg_id
     FROM kfl_production_dbp_view.v_in_kosten_prognose) AS ikp ON sub02.mandant_id = ikp.mandant_id AND sub02.psp_id =
       ikp.psp_id AND sub02.in_wg_id = ikp.in_wg_id
   UNION ALL
   SELECT psp.land_id,
    psp.mandant_id,
    psp.wup_id,
    psp.wup_standort,
    psp.projekt_nr,
    psp.projekt_id,
    psp.rpm_projekt_typ_id,
    psp.rpm_hierarchie_id,
    psp.testmarkt_fg,
    CAST(NULL AS BIGNUMERIC) AS lief_ist_kosten,
    CAST(NULL AS BIGNUMERIC) AS lief_obligo,
    CAST(NULL AS BIGNUMERIC) AS lief_best,
    psp.rpm_status_id,
    psp.rpm_phase_id,
    psp.rpm_phase_bez,
    psp.wrg_id_rpm,
    psp.ims_projekt_typ_id,
    psp.in_projekt_id_char,
    psp.in_projekt_id,
    psp.psp_id_char,
    psp.psp_id,
    psp.psp_end_nr,
    ikp.in_wg_id,
    CAST(NULL AS NUMERIC) AS menge_besch_best,
    CAST(NULL AS NUMERIC) AS betrag_besch_best,
    CAST(NULL AS NUMERIC) AS betrag_besch_best_nt,
    CAST(NULL AS NUMERIC) AS betrag_obligo,
    CAST(NULL AS NUMERIC) AS betrag_obligo_nt,
    CAST(NULL AS NUMERIC) AS betrag_obligo_plan,
    CAST(NULL AS NUMERIC) AS betrag_ist_kosten,
    CAST(NULL AS BIGNUMERIC) AS betrag_ist_kosten_neu,
    CAST(NULL AS BIGNUMERIC) AS betrag_bkz,
    CAST(NULL AS BIGNUMERIC) AS betrag_infra,
    CAST(NULL AS BIGNUMERIC) AS betrag_rueckst,
    CAST(NULL AS BIGNUMERIC) AS betrag_ist_orst_oinfra,
    CAST(NULL AS BIGNUMERIC) AS infra_rueck_betrag_neu,
    CAST(NULL AS BIGNUMERIC) AS betrag_ist_orst_oinfra_neu,
    CAST(NULL AS BIGNUMERIC) AS betrag_ist_kosten_nt,
    SUM(ikp.betrag_kosten_prognose) AS betrag_kosten_prognose,
    SUM(ikp.betrag_mmk_prognose) AS betrag_mmk_prognose,
    SUM(ikp.betrag_zea_prognose) AS betrag_zea_prognose,
    CAST(NULL AS BIGNUMERIC) AS psp_baukosten_24,
    CAST(NULL AS BIGNUMERIC) AS psp_baukosten_26,
    CAST(NULL AS BIGNUMERIC) AS psp_baukosten_27,
    CAST(NULL AS BIGNUMERIC) AS psp_baukosten_28,
    CAST(NULL AS BIGNUMERIC) AS psp_baukosten_34,
    CAST(NULL AS BIGNUMERIC) AS psp_baukosten_zu_akt,
    CAST(NULL AS BIGNUMERIC) AS psp_kosten_prognose,
    CAST(NULL AS BIGNUMERIC) AS psp_zea_prognose,
    CAST(NULL AS BIGNUMERIC) AS psp_mmk_prognose,
    CAST(NULL AS BIGNUMERIC) AS akt_budget_dat,
    CAST(NULL AS BIGNUMERIC) AS psp_c1_25,
    CAST(NULL AS BIGNUMERIC) AS psp_c2_26,
    CAST(NULL AS BIGNUMERIC) AS psp_a1_02,
    CAST(NULL AS BIGNUMERIC) AS projekt_b2_22,
    CAST(NULL AS BIGNUMERIC) AS psp_c3_27,
    NULL AS psp_c4_28,
    NULL AS psp_b4_24,
    NULL AS projekt_b3_23,
    NULL AS psp_c5_34,
    NULL AS psp_c6_29,
    NULL AS psp_c7_32,
    CAST(NULL AS BIGNUMERIC) AS psp_c6_38,
    CAST(NULL AS BIGNUMERIC) AS psp_c2_37,
    CAST(NULL AS BIGNUMERIC) AS bkz_a1_02,
    CAST(CAST(NULL AS STRING) AS DATE) AS bkz_b4_24
   FROM (SELECT CPRO.land_id,
      IPSP.mandant_id,
      COALESCE(WUP.aktuell_wup_id, RPM.wup_id) AS wup_id,
      RPM.wup_standort,
      CPRO.cpr_ext_id AS projekt_nr,
      CPRO.projekt_id,
      RPM.rpm_projekt_typ_id,
      RPM.rpm_hierarchie_id,
      RPM.testmarkt_fg,
      RPM.rpm_status_id,
      RPM.rpm_phase_id,
      RPSZ.rpm_phase_bez,
      RPM.wrg_id AS wrg_id_rpm,
      IPRO.ims_projekt_typ_id,
      IPRO.in_projekt_id_char,
      IPRO.in_projekt_id,
      IPSP.psp_id_char,
      IPSP.psp_id,
      IPSP.psp_end_nr
     FROM kfl_production_dbp_view.v_in_psp_element AS IPSP
      INNER JOIN kfl_production_dbp_view.v_in_projekt AS IPRO ON IPSP.mandant_id = IPRO.mandant_id AND IPSP.in_projekt_id
          = IPRO.in_projekt_id AND IPRO.ims_projekt_typ_id IN ('E', 'G', 'B')
      INNER JOIN kfl_production_dbp_view.v_cpr_projekt_per AS CPRO ON IPRO.projekt_ext_id = CPRO.cpr_ext_id AND CPRO.dat_bis
         = DATE '9999-12-31'
      INNER JOIN kfl_production_dbp_view.v_rpm_element_per AS RPM ON CPRO.cpr_ext_id = RPM.projekt_id AND RPM.dat_bis =
        DATE '9999-12-31'
      INNER JOIN kfl_production_dbp_view.v_rpm_phase_spr_zu AS RPSZ ON RPM.rpm_phase_id = RPSZ.rpm_phase_id AND RPM.rpm_projekt_typ_id
          = RPSZ.rpm_projekt_typ_id AND RPSZ.spr_id = 22
      LEFT JOIN kfl_production_dbp_view.v_wup AS WUP ON RPM.wup_id = WUP.wup_id AND RPM.mandant_id = WUP.mandant_id) AS
    psp
    INNER JOIN (SELECT mandant_id,
      in_projekt_id,
      psp_id,
      in_wg_id,
      betrag_kosten_prognose,
      betrag_mmk_prognose,
      betrag_zea_prognose,
      wrg_id
     FROM kfl_production_dbp_view.v_in_kosten_prognose
     WHERE in_wg_id <> '-1'
      AND (mandant_id, psp_id, in_wg_id) NOT IN (SELECT (IBBK.mandant_id, IBBK.psp_id, IBBD.in_wg_id)
        FROM kfl_production_dbp_view.v_in_besch_best_kontierung AS IBBK
         INNER JOIN kfl_production_dbp_view.v_in_besch_best_det AS IBBD ON IBBK.best_beleg_id = IBBD.best_beleg_id AND
              IBBK.best_beleg_pos_id = IBBD.best_beleg_pos_id AND IBBK.mandant_id = IBBD.mandant_id AND IBBD.loesch_id =
            '' AND IBBK.psp_id > 0)) AS ikp ON psp.psp_id = ikp.psp_id AND psp.mandant_id = ikp.mandant_id
   GROUP BY psp.land_id,
    psp.mandant_id,
    psp.wup_id,
    psp.wup_standort,
    psp.projekt_nr,
    psp.projekt_id,
    psp.rpm_projekt_typ_id,
    psp.rpm_hierarchie_id,
    psp.testmarkt_fg,
    lief_ist_kosten,
    lief_obligo,
    lief_best,
    psp.rpm_status_id,
    psp.rpm_phase_id,
    psp.rpm_phase_bez,
    psp.wrg_id_rpm,
    psp.ims_projekt_typ_id,
    psp.in_projekt_id_char,
    psp.in_projekt_id,
    psp.psp_id_char,
    psp.psp_id,
    psp.psp_end_nr,
    ikp.in_wg_id,
    menge_besch_best,
    betrag_besch_best,
    betrag_besch_best_nt,
    betrag_obligo,
    betrag_obligo_nt,
    betrag_obligo_plan,
    betrag_ist_kosten,
    betrag_ist_kosten_neu,
    betrag_bkz,
    betrag_infra,
    betrag_rueckst,
    betrag_ist_orst_oinfra,
    infra_rueck_betrag_neu,
    betrag_ist_orst_oinfra_neu,
    betrag_ist_kosten_nt) AS sub00
 LEFT JOIN (SELECT DISTINCT LPWZ.mandant_id,
   LBL.psp_end_nr,
   LPWZ.in_wg_id,
   LPWZ.bvv_leist_id
  FROM kfl_production_dbp_view.v_leistung_psp_wg_zu AS LPWZ
   INNER JOIN kfl_production_dbp_view.v_l_bvv_leistung AS LBL ON LPWZ.bvv_leist_id = LBL.bvv_leist_id) AS bvv ON sub00.mandant_id
     = bvv.mandant_id AND sub00.psp_end_nr = bvv.psp_end_nr AND sub00.in_wg_id = bvv.in_wg_id
 LEFT JOIN kfl_production_dbp_view.v_in_kosten_prognose AS IKPP ON sub00.mandant_id = IKPP.mandant_id AND sub00.psp_id =
    IKPP.psp_id AND sub00.in_wg_id = IKPP.in_wg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS V99 ON sub00.mandant_id = V99.mandant_id
 LEFT JOIN (SELECT mandant_id,
   psp_id,
   wrg_id,
   konditionsart_id,
   wrg_typ_id,
   '-1' AS in_wg_id,
   SUM(betrag_konditionswert_gebucht) AS betrag_konditionswert_gebucht,
   SUM(betrag_konditionswert_ungebucht) AS betrag_konditionswert_ungebucht
  FROM (SELECT DISTINCT PKW.mandant_id,
     PKW.psp_id,
     KURS.nach_wrg_id AS wrg_id,
     PKW.konditionsart_id,
     KURS.wrg_typ_id,
      CASE
      WHEN PKW.wrg_id = KURS.wrg_id
      THEN PKW.betrag_konditionswert_gebucht
      ELSE PKW.betrag_konditionswert_gebucht * KURS.faktor
      END AS betrag_konditionswert_gebucht,
      CASE
      WHEN PKW.wrg_id = KURS.wrg_id
      THEN PKW.betrag_konditionswert_ungebucht
      ELSE PKW.betrag_konditionswert_ungebucht * KURS.faktor
      END AS betrag_konditionswert_ungebucht
    FROM kfl_production_dbp_view.v_psp_konditionswert AS PKW
     LEFT JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS V990 ON PKW.mandant_id = V990.mandant_id AND PKW.wrg_id =
       V990.wrg_id
     INNER JOIN kfl_production_dbp_msi_view_ios.mv_user_kurs_konditionswert AS KURS ON PKW.mandant_id = KURS.mandant_id
      AND PKW.wrg_id = KURS.von_wrg_id) AS pkw2
  GROUP BY mandant_id,
   psp_id,
   wrg_id,
   konditionsart_id,
   wrg_typ_id) AS pkw ON sub00.mandant_id = pkw.mandant_id AND sub00.psp_id = pkw.psp_id AND sub00.in_wg_id = pkw.in_wg_id
      AND V99.wrg_id = pkw.wrg_id AND V99.wrg_typ_id = pkw.wrg_typ_id
 INNER JOIN kfl_production_dbp_msi_view_ios.mv_user_kurs AS KURS0 ON V99.mandant_id = KURS0.mandant_id AND V99.wrg_typ_id
     = KURS0.wrg_typ_id AND V99.wrg_id = KURS0.wrg_id
GROUP BY sub00.mandant_id,
 sub00.projekt_id,
 sub00.rpm_hierarchie_id,
 sub00.in_projekt_id,
 sub00.psp_id,
 sub00.land_id,
 sub00.wup_id,
 sub00.wup_standort,
 sub00.projekt_nr,
 sub00.rpm_projekt_typ_id,
 sub00.testmarkt_fg,
 in_lief_id,
 sub00.rpm_status_id,
 sub00.rpm_phase_id,
 sub00.rpm_phase_bez,
 sub00.wrg_id_rpm,
 sub00.ims_projekt_typ_id,
 sub00.in_projekt_id_char,
 sub00.psp_id_char,
 sub00.psp_end_nr,
 wg_psp_end_nr,
 sub00.in_wg_id,
 normal_bvv_leist_id,
 bvv_leist_id,
 V99.wrg_id,
 V99.wrg_typ_id,
 KURS0.faktor,
 KURS0.kurs,
 ausblend,
 menge_besch_best,
 betrag_besch_best,
 betrag_besch_best_nt,
 betrag_obligo,
 betrag_obligo_nt,
 betrag_obligo_plan,
 betrag_ist_kosten,
 betrag_ist_kosten_neu,
 betrag_bkz,
 betrag_infra,
 betrag_rueckst,
 betrag_ist_orst_oinfra,
 infra_rueck_betrag_neu,
 betrag_ist_orst_oinfra_neu,
 betrag_ist_kosten_nt,
 psp_baukosten_zu_akt,
 betrag_kosten_prognose,
 betrag_mmk_prognose,
 betrag_zea_prognose,
 betrag_hochrechnung,
 psp_kosten_prognose,
 psp_zea_prognose,
 psp_mmk_prognose,
 psp_c1_25,
 psp_c2_26,
 psp_a1_02,
 projekt_b2_22,
 psp_c3_27,
 psp_c4_28,
 psp_b4_24,
 projekt_b3_23,
 psp_c5_34,
 psp_c6_29,
 psp_c7_32,
 psp_c6_38,
 psp_c2_37,
 bkz_a1_02,
 bkz_b4_24,
 psp_akt_prognose,
 IKPP.kosten_prognose_version_id,
 IKPP.dat_kosten_prognose_version,
 sub00.akt_budget_dat,
 bkz_obligo,
 betrag_hochrechnung_ohne_bkz;