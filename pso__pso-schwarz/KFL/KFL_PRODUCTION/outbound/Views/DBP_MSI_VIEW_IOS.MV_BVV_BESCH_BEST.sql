CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_bvv_besch_best (land_id, mandant_id, wup_id, wup_standort,
projekt_nr, projekt_id, rpm_projekt_typ_id, rpm_hierarchie_id, testmarkt_fg, rpm_phase_id, rpm_phase_bez, wrg_id_rpm,
ims_projekt_typ_id, in_projekt_id_char, in_projekt_id, psp_id_char, psp_id, psp_end_nr, wg_psp_end_nr, in_lief_id,
in_wg_id, bvv_leist_id, best_beleg_id, best_beleg_pos_id, endrech_fg, kontierung_pos_id, unterposition_typ_id,
bestell_text, menge_best_bme, kurs, wrg_id, wrg_typ_id, faktor, ausblend, rang, rang2, psp_betrag_konditionswert_gebucht
, psp_betrag_konditionswert_ungebucht, psp_betrag_konditionswert, betrag_besch_best_0, betrag_besch_best_nt_0,
betrag_obligo_0, betrag_obligo_nt_0, betrag_ist_kosten_0, einbehalt_abnahme, einbehalt_sicherheit,
einbehalt_gewaehrleistung, einbehalt_vertragsstrafe, einbehalt_rechnungen, einbehalt_subunternehmer, betrag_abschlag_01
, betrag_abschlag_02, betrag_abschlag_03, betrag_abschlag_04, betrag_abschlag_05, betrag_abschlag_06, betrag_abschlag_07
, betrag_abschlag_08, betrag_abschlag_09, betrag_abschlag_10, betrag_abschlag_1x, bvv_akte_id, bvv_akte_bez,
bvv_vertrag_nr, dat_vertrag_beginn, einkaeufer_grp_id) AS SELECT psp.land_id,
 psp.mandant_id,
 COALESCE(W.aktuell_wup_id, psp.wup_id) AS wup_id,
 psp.wup_standort,
 psp.projekt_nr,
 psp.projekt_id,
 psp.rpm_projekt_typ_id,
 psp.rpm_hierarchie_id,
 psp.testmarkt_fg,
 psp.rpm_phase_id,
 psp.rpm_phase_bez,
 psp.wrg_id_rpm,
 psp.ims_projekt_typ_id,
 psp.in_projekt_id_char,
 psp.in_projekt_id,
 psp.psp_id_char,
 psp.psp_id,
 psp.psp_end_nr,
  CASE
  WHEN bvv.bvv_leist_id IS NOT NULL
  THEN 0
  ELSE 1
  END AS wg_psp_end_nr,
 fakt.in_lief_id,
 fakt.in_wg_id,
 COALESCE(bvv.bvv_leist_id, ROUND(CAST('99' || CAST(psp.psp_end_nr AS STRING) AS BIGNUMERIC), 0)) AS bvv_leist_id,
 fakt.best_beleg_id,
 fakt.best_beleg_pos_id,
 COALESCE(fakt.endrech_fg, 0) AS endrech_fg,
 fakt.kontierung_pos_id,
 fakt.unterposition_typ_id,
 fakt.bestell_text_obligo AS bestell_text,
 fakt.menge_best_bme,
 CAST(KURS0.kurs AS NUMERIC) AS kurs,
 V99.wrg_id,
 V99.wrg_typ_id,
 KURS0.umrechnungskurs AS faktor,
  CASE
  WHEN psp.psp_end_nr IN (3, 4, 5, 6, 7)
  THEN 1
  WHEN psp.psp_end_nr = 2 OR psp.psp_end_nr = 1 AND fakt.in_wg_id = '-1'
  THEN 0
  ELSE 1
  END AS ausblend,
 RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.best_beleg_pos_id AS STRING)
    , CAST(fakt.psp_id AS STRING), fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL, fakt
    .mandant_id, fakt.best_beleg_id IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id IS NULL
    , fakt.in_wg_id, V99.wrg_typ_id IS NULL, V99.wrg_typ_id, fakt.dat_buch IS NULL, fakt.dat_buch, fakt.rech_beleg_id
    IS NULL, fakt.rech_beleg_id) AS rang,
 DENSE_RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.psp_id AS STRING)
    , fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL, fakt.mandant_id, fakt.best_beleg_id
    IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id IS NULL, fakt.in_wg_id, V99.wrg_typ_id
    IS NULL, V99.wrg_typ_id, CASE
     WHEN fakt.dat_buch IS NOT NULL
     THEN fakt.dat_buch
     ELSE CURRENT_DATE
     END IS NULL, CASE
     WHEN fakt.dat_buch IS NOT NULL
     THEN fakt.dat_buch
     ELSE CURRENT_DATE
     END, fakt.rech_beleg_id IS NULL, fakt.rech_beleg_id) AS rang2,
 CAST(CASE
   WHEN (RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.best_beleg_pos_id AS STRING)
         , CAST(fakt.psp_id AS STRING), fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL,
         fakt.mandant_id, fakt.best_beleg_id IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id
         IS NULL, fakt.in_wg_id, V99.wrg_typ_id IS NULL, V99.wrg_typ_id, fakt.dat_buch IS NULL, fakt.dat_buch, fakt.rech_beleg_id
         IS NULL, fakt.rech_beleg_id)) = 1 AND pkw.in_wg_id = fakt.in_wg_id
   THEN pkw.betrag_konditionswert_gebucht * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS psp_betrag_konditionswert_gebucht,
 CAST(CASE
   WHEN (RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.best_beleg_pos_id AS STRING)
         , CAST(fakt.psp_id AS STRING), fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL,
         fakt.mandant_id, fakt.best_beleg_id IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id
         IS NULL, fakt.in_wg_id, V99.wrg_typ_id IS NULL, V99.wrg_typ_id, fakt.dat_buch IS NULL, fakt.dat_buch, fakt.rech_beleg_id
         IS NULL, fakt.rech_beleg_id)) = 1 AND pkw.in_wg_id = fakt.in_wg_id
   THEN pkw.betrag_konditionswert_ungebucht * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS psp_betrag_konditionswert_ungebucht,
 CAST(CASE
   WHEN (RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.best_beleg_pos_id AS STRING)
         , CAST(fakt.psp_id AS STRING), fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL,
         fakt.mandant_id, fakt.best_beleg_id IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id
         IS NULL, fakt.in_wg_id, V99.wrg_typ_id IS NULL, V99.wrg_typ_id, fakt.dat_buch IS NULL, fakt.dat_buch, fakt.rech_beleg_id
         IS NULL, fakt.rech_beleg_id)) = 1 AND pkw.in_wg_id = fakt.in_wg_id
   THEN pkw.betrag_konditionswert_gebucht * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS psp_betrag_konditionswert,
 CAST(CASE
   WHEN (RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.best_beleg_pos_id AS STRING)
        , CAST(fakt.psp_id AS STRING), fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL,
        fakt.mandant_id, fakt.best_beleg_id IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id
        IS NULL, fakt.in_wg_id, V99.wrg_typ_id IS NULL, V99.wrg_typ_id, fakt.dat_buch IS NULL, fakt.dat_buch, fakt.rech_beleg_id
        IS NULL, fakt.rech_beleg_id)) = 1
   THEN fakt.betrag_besch_best * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS betrag_besch_best_0,
 CAST(CASE
   WHEN (RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.best_beleg_pos_id AS STRING)
        , CAST(fakt.psp_id AS STRING), fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL,
        fakt.mandant_id, fakt.best_beleg_id IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id
        IS NULL, fakt.in_wg_id, V99.wrg_typ_id IS NULL, V99.wrg_typ_id, fakt.dat_buch IS NULL, fakt.dat_buch, fakt.rech_beleg_id
        IS NULL, fakt.rech_beleg_id)) = 1
   THEN fakt.betrag_besch_best_nt * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS betrag_besch_best_nt_0,
 CAST(CASE
   WHEN (RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.best_beleg_pos_id AS STRING)
        , CAST(fakt.psp_id AS STRING), fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL,
        fakt.mandant_id, fakt.best_beleg_id IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id
        IS NULL, fakt.in_wg_id, V99.wrg_typ_id IS NULL, V99.wrg_typ_id, fakt.dat_buch IS NULL, fakt.dat_buch, fakt.rech_beleg_id
        IS NULL, fakt.rech_beleg_id)) = 1
   THEN fakt.betrag_obligo * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS betrag_obligo_0,
 CAST(CASE
   WHEN (RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.best_beleg_pos_id AS STRING)
        , CAST(fakt.psp_id AS STRING), fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL,
        fakt.mandant_id, fakt.best_beleg_id IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id
        IS NULL, fakt.in_wg_id, V99.wrg_typ_id IS NULL, V99.wrg_typ_id, fakt.dat_buch IS NULL, fakt.dat_buch, fakt.rech_beleg_id
        IS NULL, fakt.rech_beleg_id)) = 1
   THEN fakt.betrag_obligo_nt * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS betrag_obligo_nt_0,
   CASE
   WHEN (RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.best_beleg_pos_id AS STRING)
        , CAST(fakt.psp_id AS STRING), fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL,
        fakt.mandant_id, fakt.best_beleg_id IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id
        IS NULL, fakt.in_wg_id, V99.wrg_typ_id IS NULL, V99.wrg_typ_id, fakt.dat_buch IS NULL, fakt.dat_buch, fakt.rech_beleg_id
        IS NULL, fakt.rech_beleg_id)) = 1
   THEN SUM(fakt.betrag_ist_kosten) OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), fakt.best_beleg_id, CAST(fakt.psp_id AS STRING)
      , fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING), CAST(fakt.best_beleg_pos_id AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
   ELSE NULL
   END * ROUND(CAST(KURS0.faktor AS NUMERIC), 4) AS betrag_ist_kosten_0,
 CAST(CASE
   WHEN (RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.best_beleg_pos_id AS STRING)
        , CAST(fakt.psp_id AS STRING), fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL,
        fakt.mandant_id, fakt.best_beleg_id IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id
        IS NULL, fakt.in_wg_id, V99.wrg_typ_id IS NULL, V99.wrg_typ_id, fakt.dat_buch IS NULL, fakt.dat_buch, fakt.rech_beleg_id
        IS NULL, fakt.rech_beleg_id)) = 1
   THEN fakt.einbehalt_abnahme * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS einbehalt_abnahme,
 CAST(CASE
   WHEN (RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.best_beleg_pos_id AS STRING)
        , CAST(fakt.psp_id AS STRING), fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL,
        fakt.mandant_id, fakt.best_beleg_id IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id
        IS NULL, fakt.in_wg_id, V99.wrg_typ_id IS NULL, V99.wrg_typ_id, fakt.dat_buch IS NULL, fakt.dat_buch, fakt.rech_beleg_id
        IS NULL, fakt.rech_beleg_id)) = 1
   THEN fakt.einbehalt_sicherheit * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS einbehalt_sicherheit,
 CAST(CASE
   WHEN (RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.best_beleg_pos_id AS STRING)
        , CAST(fakt.psp_id AS STRING), fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL,
        fakt.mandant_id, fakt.best_beleg_id IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id
        IS NULL, fakt.in_wg_id, V99.wrg_typ_id IS NULL, V99.wrg_typ_id, fakt.dat_buch IS NULL, fakt.dat_buch, fakt.rech_beleg_id
        IS NULL, fakt.rech_beleg_id)) = 1
   THEN fakt.einbehalt_gewaehrleistung * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS einbehalt_gewaehrleistung,
 CAST(CASE
   WHEN (RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.best_beleg_pos_id AS STRING)
        , CAST(fakt.psp_id AS STRING), fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL,
        fakt.mandant_id, fakt.best_beleg_id IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id
        IS NULL, fakt.in_wg_id, V99.wrg_typ_id IS NULL, V99.wrg_typ_id, fakt.dat_buch IS NULL, fakt.dat_buch, fakt.rech_beleg_id
        IS NULL, fakt.rech_beleg_id)) = 1
   THEN fakt.einbehalt_vertragsstrafe * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS einbehalt_vertragsstrafe,
 CAST(CASE
   WHEN (RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.best_beleg_pos_id AS STRING)
        , CAST(fakt.psp_id AS STRING), fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL,
        fakt.mandant_id, fakt.best_beleg_id IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id
        IS NULL, fakt.in_wg_id, V99.wrg_typ_id IS NULL, V99.wrg_typ_id, fakt.dat_buch IS NULL, fakt.dat_buch, fakt.rech_beleg_id
        IS NULL, fakt.rech_beleg_id)) = 1
   THEN fakt.einbehalt_rechnungen * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS einbehalt_rechnungen,
 CAST(CASE
   WHEN (RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.best_beleg_pos_id AS STRING)
        , CAST(fakt.psp_id AS STRING), fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL,
        fakt.mandant_id, fakt.best_beleg_id IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id
        IS NULL, fakt.in_wg_id, V99.wrg_typ_id IS NULL, V99.wrg_typ_id, fakt.dat_buch IS NULL, fakt.dat_buch, fakt.rech_beleg_id
        IS NULL, fakt.rech_beleg_id)) = 1
   THEN fakt.einbehalt_subunternehmer * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS einbehalt_subunternehmer,
 CAST(CASE
   WHEN (DENSE_RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.psp_id AS STRING)
        , fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL, fakt.mandant_id, fakt.best_beleg_id
        IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id IS NULL, fakt.in_wg_id, V99.wrg_typ_id
        IS NULL, V99.wrg_typ_id, CASE
         WHEN fakt.dat_buch IS NOT NULL
         THEN fakt.dat_buch
         ELSE CURRENT_DATE
         END IS NULL, CASE
         WHEN fakt.dat_buch IS NOT NULL
         THEN fakt.dat_buch
         ELSE CURRENT_DATE
         END, fakt.rech_beleg_id IS NULL, fakt.rech_beleg_id)) = 1
   THEN fakt.betrag_ist_kosten * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS betrag_abschlag_01,
 CAST(CASE
   WHEN (DENSE_RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.psp_id AS STRING)
        , fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL, fakt.mandant_id, fakt.best_beleg_id
        IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id IS NULL, fakt.in_wg_id, V99.wrg_typ_id
        IS NULL, V99.wrg_typ_id, CASE
         WHEN fakt.dat_buch IS NOT NULL
         THEN fakt.dat_buch
         ELSE CURRENT_DATE
         END IS NULL, CASE
         WHEN fakt.dat_buch IS NOT NULL
         THEN fakt.dat_buch
         ELSE CURRENT_DATE
         END, fakt.rech_beleg_id IS NULL, fakt.rech_beleg_id)) = 2
   THEN fakt.betrag_ist_kosten * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS betrag_abschlag_02,
 CAST(CASE
   WHEN (DENSE_RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.psp_id AS STRING)
        , fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL, fakt.mandant_id, fakt.best_beleg_id
        IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id IS NULL, fakt.in_wg_id, V99.wrg_typ_id
        IS NULL, V99.wrg_typ_id, CASE
         WHEN fakt.dat_buch IS NOT NULL
         THEN fakt.dat_buch
         ELSE CURRENT_DATE
         END IS NULL, CASE
         WHEN fakt.dat_buch IS NOT NULL
         THEN fakt.dat_buch
         ELSE CURRENT_DATE
         END, fakt.rech_beleg_id IS NULL, fakt.rech_beleg_id)) = 3
   THEN fakt.betrag_ist_kosten * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS betrag_abschlag_03,
 CAST(CASE
   WHEN (DENSE_RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.psp_id AS STRING)
        , fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL, fakt.mandant_id, fakt.best_beleg_id
        IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id IS NULL, fakt.in_wg_id, V99.wrg_typ_id
        IS NULL, V99.wrg_typ_id, CASE
         WHEN fakt.dat_buch IS NOT NULL
         THEN fakt.dat_buch
         ELSE CURRENT_DATE
         END IS NULL, CASE
         WHEN fakt.dat_buch IS NOT NULL
         THEN fakt.dat_buch
         ELSE CURRENT_DATE
         END, fakt.rech_beleg_id IS NULL, fakt.rech_beleg_id)) = 4
   THEN fakt.betrag_ist_kosten * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS betrag_abschlag_04,
 CAST(CASE
   WHEN (DENSE_RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.psp_id AS STRING)
        , fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL, fakt.mandant_id, fakt.best_beleg_id
        IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id IS NULL, fakt.in_wg_id, V99.wrg_typ_id
        IS NULL, V99.wrg_typ_id, CASE
         WHEN fakt.dat_buch IS NOT NULL
         THEN fakt.dat_buch
         ELSE CURRENT_DATE
         END IS NULL, CASE
         WHEN fakt.dat_buch IS NOT NULL
         THEN fakt.dat_buch
         ELSE CURRENT_DATE
         END, fakt.rech_beleg_id IS NULL, fakt.rech_beleg_id)) = 5
   THEN fakt.betrag_ist_kosten * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS betrag_abschlag_05,
 CAST(CASE
   WHEN (DENSE_RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.psp_id AS STRING)
        , fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL, fakt.mandant_id, fakt.best_beleg_id
        IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id IS NULL, fakt.in_wg_id, V99.wrg_typ_id
        IS NULL, V99.wrg_typ_id, CASE
         WHEN fakt.dat_buch IS NOT NULL
         THEN fakt.dat_buch
         ELSE CURRENT_DATE
         END IS NULL, CASE
         WHEN fakt.dat_buch IS NOT NULL
         THEN fakt.dat_buch
         ELSE CURRENT_DATE
         END, fakt.rech_beleg_id IS NULL, fakt.rech_beleg_id)) = 6
   THEN fakt.betrag_ist_kosten * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS betrag_abschlag_06,
 CAST(CASE
   WHEN (DENSE_RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.psp_id AS STRING)
        , fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL, fakt.mandant_id, fakt.best_beleg_id
        IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id IS NULL, fakt.in_wg_id, V99.wrg_typ_id
        IS NULL, V99.wrg_typ_id, CASE
         WHEN fakt.dat_buch IS NOT NULL
         THEN fakt.dat_buch
         ELSE CURRENT_DATE
         END IS NULL, CASE
         WHEN fakt.dat_buch IS NOT NULL
         THEN fakt.dat_buch
         ELSE CURRENT_DATE
         END, fakt.rech_beleg_id IS NULL, fakt.rech_beleg_id)) = 7
   THEN fakt.betrag_ist_kosten * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS betrag_abschlag_07,
 CAST(CASE
   WHEN (DENSE_RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.psp_id AS STRING)
        , fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL, fakt.mandant_id, fakt.best_beleg_id
        IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id IS NULL, fakt.in_wg_id, V99.wrg_typ_id
        IS NULL, V99.wrg_typ_id, CASE
         WHEN fakt.dat_buch IS NOT NULL
         THEN fakt.dat_buch
         ELSE CURRENT_DATE
         END IS NULL, CASE
         WHEN fakt.dat_buch IS NOT NULL
         THEN fakt.dat_buch
         ELSE CURRENT_DATE
         END, fakt.rech_beleg_id IS NULL, fakt.rech_beleg_id)) = 8
   THEN fakt.betrag_ist_kosten * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS betrag_abschlag_08,
 CAST(CASE
   WHEN (DENSE_RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.psp_id AS STRING)
        , fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL, fakt.mandant_id, fakt.best_beleg_id
        IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id IS NULL, fakt.in_wg_id, V99.wrg_typ_id
        IS NULL, V99.wrg_typ_id, CASE
         WHEN fakt.dat_buch IS NOT NULL
         THEN fakt.dat_buch
         ELSE CURRENT_DATE
         END IS NULL, CASE
         WHEN fakt.dat_buch IS NOT NULL
         THEN fakt.dat_buch
         ELSE CURRENT_DATE
         END, fakt.rech_beleg_id IS NULL, fakt.rech_beleg_id)) = 9
   THEN fakt.betrag_ist_kosten * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS betrag_abschlag_09,
 CAST(CASE
   WHEN (DENSE_RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.psp_id AS STRING)
        , fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL, fakt.mandant_id, fakt.best_beleg_id
        IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id IS NULL, fakt.in_wg_id, V99.wrg_typ_id
        IS NULL, V99.wrg_typ_id, CASE
         WHEN fakt.dat_buch IS NOT NULL
         THEN fakt.dat_buch
         ELSE CURRENT_DATE
         END IS NULL, CASE
         WHEN fakt.dat_buch IS NOT NULL
         THEN fakt.dat_buch
         ELSE CURRENT_DATE
         END, fakt.rech_beleg_id IS NULL, fakt.rech_beleg_id)) = 10
   THEN fakt.betrag_ist_kosten * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS betrag_abschlag_10,
 CAST(CASE
   WHEN (DENSE_RANK() OVER (PARTITION BY CAST(fakt.mandant_id AS STRING), psp.projekt_id, fakt.best_beleg_id, CAST(fakt.psp_id AS STRING)
        , fakt.in_wg_id, CAST(V99.wrg_typ_id AS STRING) ORDER BY fakt.mandant_id IS NULL, fakt.mandant_id, fakt.best_beleg_id
        IS NULL, fakt.best_beleg_id, fakt.psp_id IS NULL, fakt.psp_id, fakt.in_wg_id IS NULL, fakt.in_wg_id, V99.wrg_typ_id
        IS NULL, V99.wrg_typ_id, CASE
         WHEN fakt.dat_buch IS NOT NULL
         THEN fakt.dat_buch
         ELSE CURRENT_DATE
         END IS NULL, CASE
         WHEN fakt.dat_buch IS NOT NULL
         THEN fakt.dat_buch
         ELSE CURRENT_DATE
         END, fakt.rech_beleg_id IS NULL, fakt.rech_beleg_id)) > 10
   THEN fakt.betrag_ist_kosten * KURS0.faktor
   ELSE NULL
   END AS NUMERIC) AS betrag_abschlag_1x,
 IBBA.bvv_akte_id,
 IBASZ.bvv_akte_bez,
 ILBA.bvv_vertrag_nr,
 ILBA.dat_vertrag_beginn,
 V01.einkaeufer_grp_id
FROM (SELECT CPRO.land_id,
   IPSP.mandant_id,
   RPM.wup_id,
   RPM.wup_standort,
   CPRO.cpr_ext_id AS projekt_nr,
   CPRO.projekt_id,
   RPM.rpm_projekt_typ_id,
   RPM.rpm_hierarchie_id,
   RPM.testmarkt_fg,
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
   INNER JOIN kfl_production_dbp_view.v_in_projekt AS IPRO ON IPSP.mandant_id = IPRO.mandant_id AND IPSP.in_projekt_id =
      IPRO.in_projekt_id AND IPRO.ims_projekt_typ_id IN ('E', 'G', 'B')
   INNER JOIN kfl_production_dbp_view.v_cpr_projekt_per AS CPRO ON IPRO.projekt_ext_id = CPRO.cpr_ext_id AND CPRO.dat_bis
      = PARSE_DATE('%F', '9999-12-31')
   INNER JOIN kfl_production_dbp_view.v_rpm_element_per AS RPM ON CPRO.cpr_ext_id = RPM.projekt_id AND RPM.dat_bis =
     PARSE_DATE('%F', '9999-12-31')
   INNER JOIN kfl_production_dbp_view.v_rpm_phase_spr_zu AS RPSZ ON RPM.rpm_phase_id = RPSZ.rpm_phase_id AND RPM.rpm_projekt_typ_id
       = RPSZ.rpm_projekt_typ_id AND RPSZ.spr_id = 22) AS psp
 LEFT JOIN (SELECT IBBK.psp_id,
    IBBK.mandant_id,
    COALESCE(IBBD.in_wg_id, '-1') AS in_wg_id,
    IBB.in_lief_id,
    IBBK.best_beleg_id,
    IBBK.best_beleg_pos_id,
    IBBK.kontierung_pos_id,
    IBBD.menge_best_bme,
     IBBD.betrag_pos_netto_best_wrg * CASE
      WHEN IBBD.retourenpos_fg = 1
      THEN - 1
      ELSE 1
      END AS betrag_besch_best,
     CASE
     WHEN IBBD.unterposition_typ_id = 'N'
     THEN IBBD.betrag_pos_netto_best_wrg * CASE
       WHEN IBBD.retourenpos_fg = 1
       THEN - 1
       ELSE 1
       END
     ELSE IBBD.betrag_pos_netto_best_wrg * CASE
        WHEN IBBD.retourenpos_fg = 1
        THEN - 1
        ELSE 1
        END * 0
     END AS betrag_besch_best_nt,
    COALESCE(IBBD.unterposition_typ_id, ' ') AS unterposition_typ_id,
    ikd.betrag AS betrag_ist_kosten,
    ikd.bestell_text AS bestell_text_kosten,
    op.betrag AS betrag_obligo,
     CASE
     WHEN IBBD.unterposition_typ_id = 'N'
     THEN op.betrag
     ELSE op.betrag * 0
     END AS betrag_obligo_nt,
    op.betrag_plan AS betrag_obligo_plan,
    op.bestell_text AS bestell_text_obligo,
    ikd.dat_buch,
    ikd.rech_beleg_id,
    IBBD.endrech_fg,
    SUM(CASE
      WHEN CAST(best.sonder_hauptbuch_kz AS FLOAT64) = 1
      THEN best.betrag_einbehalt
      ELSE NULL
      END) AS einbehalt_abnahme,
    SUM(CASE
      WHEN CAST(best.sonder_hauptbuch_kz AS FLOAT64) = 2
      THEN best.betrag_einbehalt
      ELSE NULL
      END) AS einbehalt_sicherheit,
    SUM(CASE
      WHEN CAST(best.sonder_hauptbuch_kz AS FLOAT64) = 3
      THEN best.betrag_einbehalt
      ELSE NULL
      END) AS einbehalt_gewaehrleistung,
    SUM(CASE
      WHEN CAST(best.sonder_hauptbuch_kz AS FLOAT64) = 4
      THEN best.betrag_einbehalt
      ELSE NULL
      END) AS einbehalt_vertragsstrafe,
    SUM(CASE
      WHEN CAST(best.sonder_hauptbuch_kz AS FLOAT64) = 5
      THEN best.betrag_einbehalt
      ELSE NULL
      END) AS einbehalt_rechnungen,
    SUM(CASE
      WHEN CAST(best.sonder_hauptbuch_kz AS FLOAT64) = 7
      THEN best.betrag_einbehalt
      ELSE NULL
      END) AS einbehalt_subunternehmer
   FROM kfl_production_dbp_view.v_in_besch_best_kontierung AS IBBK
    LEFT JOIN (SELECT FI.mandant_id,
      FI.buchungskreis_id,
      FI.in_fi_beleg_id,
      FI.in_fi_beleg_pos_id,
      FI.gj,
       FI.referenzschluessel_id / 10000 AS referenzschluessel_id_,
      FI.sonder_hauptbuch_kz,
      BF.best_beleg_id,
      BF.best_beleg_pos_id,
      MAX(FI.betrag_fi_beleg) OVER (PARTITION BY CAST(FI.mandant_id AS STRING), CAST(FI.buchungskreis_id AS STRING), FI
         .in_fi_beleg_id, CAST(FI.in_fi_beleg_pos_id AS STRING), CAST(FI.gj AS STRING), CAST(FI.referenzschluessel_id / 10000 AS STRING)
         , FI.sonder_hauptbuch_kz, BF.best_beleg_id, CAST(BF.best_beleg_pos_id AS STRING) RANGE BETWEEN
       UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS betrag_fi,
      SUM(BF.betrag_wrbtr) OVER (PARTITION BY CAST(FI.mandant_id AS STRING), CAST(FI.buchungskreis_id AS STRING), FI.in_fi_beleg_id
         , CAST(FI.in_fi_beleg_pos_id AS STRING), CAST(FI.gj AS STRING), CAST(FI.referenzschluessel_id / 10000 AS STRING)
         , FI.sonder_hauptbuch_kz, BF.best_beleg_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
      betrag_best,
      SUM(BF.betrag_wrbtr) OVER (PARTITION BY CAST(FI.mandant_id AS STRING), CAST(FI.buchungskreis_id AS STRING), FI.in_fi_beleg_id
         , CAST(FI.in_fi_beleg_pos_id AS STRING), CAST(FI.gj AS STRING), CAST(FI.referenzschluessel_id / 10000 AS STRING)
         , FI.sonder_hauptbuch_kz, BF.best_beleg_id, CAST(BF.best_beleg_pos_id AS STRING) RANGE BETWEEN
       UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS betrag_pos,
         (MAX(FI.betrag_fi_beleg) OVER (PARTITION BY CAST(FI.mandant_id AS STRING), CAST(FI.buchungskreis_id AS STRING)
            , FI.in_fi_beleg_id, CAST(FI.in_fi_beleg_pos_id AS STRING), CAST(FI.gj AS STRING), CAST(FI.referenzschluessel_id / 10000 AS STRING)
            , FI.sonder_hauptbuch_kz, BF.best_beleg_id, CAST(BF.best_beleg_pos_id AS STRING) RANGE BETWEEN
          UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * (SUM(BF.betrag_wrbtr) OVER (PARTITION BY CAST(FI.mandant_id AS STRING)
            , CAST(FI.buchungskreis_id AS STRING), FI.in_fi_beleg_id, CAST(FI.in_fi_beleg_pos_id AS STRING), CAST(FI.gj AS STRING)
            , CAST(FI.referenzschluessel_id / 10000 AS STRING), FI.sonder_hauptbuch_kz, BF.best_beleg_id, CAST(BF.best_beleg_pos_id AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / (SUM(BF.betrag_wrbtr) OVER (PARTITION BY CAST(FI.mandant_id AS STRING)
           , CAST(FI.buchungskreis_id AS STRING), FI.in_fi_beleg_id, CAST(FI.in_fi_beleg_pos_id AS STRING), CAST(FI.gj AS STRING)
           , CAST(FI.referenzschluessel_id / 10000 AS STRING), FI.sonder_hauptbuch_kz, BF.best_beleg_id RANGE BETWEEN
         UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS betrag_einbehalt
     FROM kfl_production_dbp_view.v_in_fi_beleg_det AS FI
      INNER JOIN kfl_production_dbp_view.v_in_best_belegfluss AS BF ON FI.mandant_id = BF.mandant_id AND FI.gj = BF.kj
       AND FI.referenzschluessel_id / 10000 = BF.folge_beleg_id
     WHERE FI.sonder_hauptbuch_kz IN ('1', '2', '3', '4', '5', '7')) AS best ON IBBK.mandant_id = best.mandant_id AND
       IBBK.best_beleg_id = best.best_beleg_id AND IBBK.best_beleg_pos_id = best.best_beleg_pos_id
    LEFT JOIN (SELECT IKD.mandant_id,
       CASE
       WHEN IKD.best_beleg_id = - 1 OR IKD.best_beleg_id IS NULL
       THEN ibb.best_beleg_id
       ELSE IKD.best_beleg_id
       END AS best_beleg_id,
       CASE
       WHEN IKD.best_beleg_pos_id = 0
       THEN ibb.best_beleg_pos_id
       ELSE IKD.best_beleg_pos_id
       END AS best_beleg_pos_id,
      IKD.psp_id,
      IKD.dat_buch,
      IKD.beleg_id AS rech_beleg_id,
      MAX(IKD.bestell_text) AS bestell_text,
      SUM(IKD.betrag) AS betrag
     FROM kfl_production_dbp_view.v_ist_kosten_det AS IKD
      LEFT JOIN (SELECT mandant_id,
        folge_beleg_id,
        dat_buch,
        MAX(best_beleg_id) AS best_beleg_id,
        MAX(best_beleg_pos_id) AS best_beleg_pos_id
       FROM kfl_production_dbp_view.v_in_best_belegfluss
       GROUP BY mandant_id,
        folge_beleg_id,
        dat_buch) AS ibb ON IKD.ref_beleg_id = ibb.folge_beleg_id AND IKD.dat_buch = ibb.dat_buch AND IKD.mandant_id =
        ibb.mandant_id
     WHERE IKD.hb2_fg = 1
      AND (CASE
         WHEN IKD.best_beleg_id = - 1 OR IKD.best_beleg_id IS NULL
         THEN ibb.best_beleg_id
         ELSE IKD.best_beleg_id
         END, CASE
         WHEN IKD.best_beleg_pos_id = 0
         THEN ibb.best_beleg_pos_id
         ELSE IKD.best_beleg_pos_id
         END, IKD.mandant_id) IN (SELECT (best_beleg_id, best_beleg_pos_id, mandant_id)
        FROM kfl_production_dbp_view.v_in_besch_best_kontierung)
      AND LTRIM(TRIM(COLLATE(IKD.kostenart_id, '')), '0') NOT IN ('912000', '979002', 'H912000', 'H979002', '880100',
        '940003', '991907')
     GROUP BY IKD.mandant_id,
      best_beleg_id,
      best_beleg_pos_id,
      IKD.psp_id,
      IKD.dat_buch,
      rech_beleg_id) AS ikd ON IBBK.mandant_id = ikd.mandant_id AND IBBK.best_beleg_id = ikd.best_beleg_id AND IBBK.best_beleg_pos_id
        = ikd.best_beleg_pos_id AND IBBK.psp_id = ikd.psp_id
    LEFT JOIN kfl_production_dbp_view.v_in_besch_best_det AS IBBD ON IBBK.mandant_id = IBBD.mandant_id AND IBBK.best_beleg_id
         = IBBD.best_beleg_id AND IBBK.best_beleg_pos_id = IBBD.best_beleg_pos_id AND IBBD.loesch_id = ''
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
      in_lief_id,
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
      in_lief_id,
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
      bedarf_nr) AS op ON IBBK.mandant_id = op.mandant_id AND IBBK.best_beleg_id = op.ref_beleg_id AND IBBK.best_beleg_pos_id
         = op.ref_beleg_pos_id AND op.dat_bis = PARSE_DATE('%F', '9999-12-31') AND CAST(CASE
        WHEN op.loesch_id = ''
        THEN '0'
        ELSE op.loesch_id
        END AS FLOAT64) = 0
    LEFT JOIN kfl_production_dbp_view.v_in_besch_best AS IBB ON IBBD.mandant_id = IBB.mandant_id AND IBBD.best_beleg_id
      = IBB.best_beleg_id
   GROUP BY IBBK.psp_id,
    IBBK.mandant_id,
    in_wg_id,
    IBB.in_lief_id,
    IBBK.best_beleg_id,
    IBBK.best_beleg_pos_id,
    IBBK.kontierung_pos_id,
    IBBD.menge_best_bme,
    betrag_besch_best,
    betrag_besch_best_nt,
    unterposition_typ_id,
    betrag_ist_kosten,
    bestell_text_kosten,
    betrag_obligo,
    betrag_obligo_nt,
    betrag_obligo_plan,
    bestell_text_obligo,
    ikd.dat_buch,
    ikd.rech_beleg_id,
    IBBD.endrech_fg
   UNION ALL
   SELECT ipsp.psp_id,
    ipsp.mandant_id,
    '-1' AS in_wg_id,
    - 1 AS in_lief_id,
    0 AS best_beleg_id,
    0 AS best_beleg_pos_id,
    0 AS kontierung_pos_id,
    CAST(NULL AS NUMERIC) AS menge_best_bme,
    0 AS betrag_besch_best,
    0 AS betrag_besch_best_nt,
    ' ' AS unterposition_typ_id,
    ikd.betrag AS betrag_ist_kosten,
    ikd.bestell_text AS bestell_text_kosten,
    0 AS betrag_obligo,
    0 AS betrag_obligo_nt,
    0 AS betrag_obligo_plan,
    COALESCE(ikd.bestell_text, ' ') AS bestell_text_obligo,
    ikd.dat_buch,
    ikd.rech_beleg_id,
    0 AS endrech_fg,
    CAST(NULL AS BIGNUMERIC) AS einbehalt_abnahme,
    CAST(NULL AS BIGNUMERIC) AS einbehalt_sicherheit,
    CAST(NULL AS BIGNUMERIC) AS einbehalt_gewaehrleistung,
    CAST(NULL AS BIGNUMERIC) AS einbehalt_vertragsstrafe,
    CAST(NULL AS BIGNUMERIC) AS einbehalt_rechnungen,
    CAST(NULL AS BIGNUMERIC) AS einbehalt_subunternehmer
   FROM (SELECT DISTINCT psp_id,
      mandant_id
     FROM kfl_production_dbp_view.v_in_psp_element) AS ipsp
    LEFT JOIN (SELECT psp_id,
      mandant_id,
      dat_buch,
      beleg_id AS rech_beleg_id,
      MAX(bestell_text) AS bestell_text,
      SUM(betrag) AS betrag
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
            WHEN IKD.best_beleg_id = - 1 OR IKD.best_beleg_id IS NULL
            THEN ibb.best_beleg_id
            ELSE IKD.best_beleg_id
            END, CASE
            WHEN IKD.best_beleg_pos_id = 0
            THEN ibb.best_beleg_pos_id
            ELSE IKD.best_beleg_pos_id
            END, IKD.mandant_id) IN (SELECT (best_beleg_id, best_beleg_pos_id, mandant_id)
           FROM kfl_production_dbp_view.v_in_besch_best_kontierung)
         AND LTRIM(TRIM(COLLATE(IKD.kostenart_id, '')), '0') NOT IN ('912000', '979002', 'H912000', 'H979002', '880100'
           , '940003', '991907'))
      AND LTRIM(TRIM(COLLATE(kostenart_id, '')), '0') NOT IN ('912000', '979002', 'H912000', 'H979002', '880100',
        '940003', '991907')
     GROUP BY psp_id,
      mandant_id,
      dat_buch,
      rech_beleg_id) AS ikd ON ipsp.psp_id = ikd.psp_id AND ipsp.mandant_id = ikd.mandant_id) AS fakt ON psp.psp_id =
   fakt.psp_id AND psp.mandant_id = fakt.mandant_id
 LEFT JOIN (SELECT LPWZ.mandant_id,
   LBL.psp_end_nr,
   LPWZ.in_wg_id,
   LPWZ.bvv_leist_id
  FROM kfl_production_dbp_view.v_leistung_psp_wg_zu AS LPWZ
   INNER JOIN kfl_production_dbp_view.v_l_bvv_leistung AS LBL ON LPWZ.bvv_leist_id = LBL.bvv_leist_id) AS bvv ON psp.mandant_id
     = bvv.mandant_id AND psp.psp_end_nr = bvv.psp_end_nr AND fakt.in_wg_id = bvv.in_wg_id
 LEFT JOIN kfl_production_dbp_view.v_in_besch_best_akte_zu AS IBBA ON fakt.best_beleg_id = IBBA.best_beleg_id AND fakt.mandant_id
    = IBBA.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_ivs_l_bvv_akte AS ILBA ON IBBA.bvv_akte_id = ILBA.bvv_akte_id AND IBBA.mandant_id =
   ILBA.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_ivs_bvv_akte_spr_zu AS IBASZ ON IBBA.bvv_akte_id = IBASZ.bvv_akte_id AND IBBA.mandant_id
     = IBASZ.mandant_id AND IBASZ.spr_id = 22
 LEFT JOIN kfl_production_dbp_view.v_in_besch_best AS V01 ON fakt.mandant_id = V01.mandant_id AND fakt.best_beleg_id =
   V01.best_beleg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS V99 ON psp.mandant_id = V99.mandant_id
 LEFT JOIN (SELECT mandant_id,
   psp_id,
   wrg_id,
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
   wrg_typ_id) AS pkw ON psp.mandant_id = pkw.mandant_id AND psp.psp_id = pkw.psp_id AND V99.wrg_id = pkw.wrg_id AND V99
   .wrg_typ_id = pkw.wrg_typ_id
 INNER JOIN kfl_production_dbp_msi_view_ios.mv_user_kurs AS KURS0 ON V99.mandant_id = KURS0.mandant_id AND V99.wrg_typ_id
     = KURS0.wrg_typ_id AND V99.wrg_id = KURS0.wrg_id
 LEFT JOIN kfl_production_dbp_view.v_wup AS W ON psp.wup_id = W.wup_id AND psp.mandant_id = W.mandant_id
WHERE fakt.betrag_ist_kosten <> 0
 OR fakt.betrag_obligo <> 0
 OR fakt.betrag_besch_best <> 0;