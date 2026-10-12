CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_wanko_beschaffungslogistik (empfaenger_tms_gp_id,
entladestelle_tms_gp_id, dat_lief, tms_auftrag_id, tms_auftragsart_id, mandant_id, versender_tms_gp_id,
beladestelle_tms_gp_id, vorholspedition_tms_gp_typ_cd, tms_auftrag_status_cd, tms_sortiment_id, gewicht_brutto_kg,
gewicht_netto_kg, anzahl_flaschen, abgeladene_paletten, anz_lt_avis, anz_stellplatz, stpf_missing_fg, stapelfaktor,
anz_stellplatz_berechnet, abgeladene_epal, aufwand, ertrag, anz_stellplatz_hauptlauf, anz_stellplatz_vorlauf,
aufwand_hauptlauf, aufwand_korrektur, aufwand_vorlauf, aufwand_fracht, aufwand_fixpreis, aufwand_wochenende,
aufwand_zeitfenster, aufwand_sonstiges, aufwand_lt, aufwand_aufsetzen, aufwand_mehraufwand, aufwand_umschlag,
aufwand_diesel, ertrag_diesel, ertrag_fracht, ertrag_zeitfenster, ertrag_sonstiges, ertrag_lt, ertrag_aufsetzen,
ertrag_mehraufwand, ertrag_maut, ertrag_wochenende, ertrag_korrektur, tms_tour_id, transportation_unit_id_ext,
tms_tour_bez, system_id, kj_transportation_unit, transportation_unit_id, tms, dat_tour, spedition_tms_gp_id,
spotauftrag_fg, manuelle_dispo_fg, ziellager_tms_gp_id, auftrag_txt_lieferstein, auftrag_txt_bemerkung_beladen,
auftrag_txt_bemerkung_entaden, temperaturgruppe_id) AS SELECT TMS_A.empfaenger_tms_gp_id,
 TMS_A.entladestelle_tms_gp_id,
 TMS_A.dat_lief,
 TMS_A.tms_auftrag_id,
 TMS_A.tms_auftragsart_id,
 TMS_A.mandant_id,
 TMS_A.versender_tms_gp_id,
 TMS_A.beladestelle_tms_gp_id,
  CASE
  WHEN TMS_A.vorholspedition_tms_gp_typ_cd = 'S'
  THEN 'Quellgebiet'
  ELSE 'Direkt'
  END AS vorholspedition_tms_gp_typ_cd,
 TMS_A.tms_auftrag_status_cd,
 TMS_A.tms_sortiment_id,
 TMS_A.gewicht_brutto_kg,
 TMS_A.gewicht_netto_kg,
 tms_ad.anzahl_flaschen,
 tms_av.abgeladene_paletten,
 tms_ad.anz_lt_avis,
 TMS_A.anz_stellplatz,
 COALESCE(tms_r.stpf_missing_fg, 1) AS stpf_missing_fg,
 COALESCE(tms_r.stapelfaktor, 1.000) AS stapelfaktor,
 tms_r.anz_stellplatz_berechnet,
 tms_av.abgeladene_epal,
 tms_r.aufwand_gesamt AS aufwand,
 tms_r.ertrag_gesamt AS ertrag,
 0 AS anz_stellplatz_hauptlauf,
 0 AS anz_stellplatz_vorlauf,
 tms_r.aufwand_hauptlauf,
 tms_r.aufwand_korrektur,
 tms_r.aufwand_vorlauf,
 tms_r.aufwand_fracht,
 tms_r.aufwand_fixpreis,
 tms_r.aufwand_wochenende,
 tms_r.aufwand_zeitfenster,
 tms_r.aufwand_sonstiges,
 tms_r.aufwand_lt,
 tms_r.aufwand_aufsetzen,
 tms_r.aufwand_mehraufwand,
 tms_r.aufwand_umschlag,
 tms_r.aufwand_diesel,
 tms_r.ertrag_diesel,
 tms_r.ertrag_fracht,
 tms_r.ertrag_zeitfenster,
 tms_r.ertrag_sonstiges,
 tms_r.ertrag_lt,
 tms_r.ertrag_aufsetzen,
 tms_r.ertrag_mehraufwand,
 tms_r.ertrag_maut,
 tms_r.ertrag_wochenende,
 tms_r.ertrag_korrektur,
 TMS_A.tms_tour_id,
 TMS_T.transportation_unit_id_ext,
 TMS_T.tms_tour_bez,
 TMS_A.system_id,
 EXTRACT(YEAR FROM TMS_A.dat_tour) AS kj_transportation_unit,
 ROUND(SAFE_CAST(FORMAT_DATE('%Y%m%d', TMS_A.dat_tour) || CAST(TMS_A.tms_tour_id AS STRING) AS BIGNUMERIC), 0) AS
 transportation_unit_id,
 'WANKO' AS tms,
 TMS_A.dat_tour,
 COALESCE(TMS_T.spedition_tms_gp_id, '-1') AS spedition_tms_gp_id,
  CASE
  WHEN CAST(TMS_T.tms_tourtyp_id AS STRING) = '5'
  THEN 1
  ELSE 0
  END AS spotauftrag_fg,
  CASE
  WHEN TMS_T.tms_tour_strategisch_id IS NULL
  THEN 1
  ELSE 0
  END AS manuelle_dispo_fg,
 TMS_T.ziellager_tms_gp_id,
 l_lieferstein.auftrag_txt_lieferstein,
 l_bemer_bel.auftrag_txt_bemerkung_beladen,
 l_bemer_ent.auftrag_txt_bemerkung_entaden,
  CASE
  WHEN TMS_A.temperaturgruppe_id = 1
  THEN 'TK'
  WHEN TMS_A.temperaturgruppe_id = 2
  THEN 'GK'
  WHEN TMS_A.temperaturgruppe_id = 3
  THEN 'TE'
  ELSE 'UK'
  END AS temperaturgruppe_id
FROM kfl_production_dbp_view.v_tms_auftrag AS TMS_A
 INNER JOIN kfl_production_dbp_view.v_l_system AS SYS ON TMS_A.system_id = SYS.system_id AND SYS.system_gruppe =
   'WANKO BELOG'
 LEFT JOIN kfl_production_dbp_view.v_tms_tour AS TMS_T ON TMS_A.dat_tour = TMS_T.dat_tour AND TMS_A.tms_tour_id = TMS_T
    .tms_tour_id AND TMS_A.system_id = TMS_T.system_id
 LEFT JOIN (SELECT tms_auftrag_id,
   system_id,
   SUM(CASE
     WHEN tms_transportmittel_id = 19
     THEN anz_verpackung
     ELSE NULL
     END) AS anzahl_flaschen,
   SUM(CASE
     WHEN tms_transportmittel_id IN (1, 2, 5, 8, 9, 10, 12, 15, 18)
     THEN anz_verpackung
     ELSE NULL
     END) AS abgeladene_paletten,
   SUM(CASE
     WHEN tms_transportmittel_id = 8
     THEN anz_verpackung
     ELSE NULL
     END) AS abgeladene_epal
  FROM kfl_production_dbp_view.v_tms_auftrag_verpackung AS TMS_AV
  GROUP BY tms_auftrag_id,
   system_id) AS tms_av ON TMS_A.tms_auftrag_id = tms_av.tms_auftrag_id AND TMS_A.system_id = tms_av.system_id
 LEFT JOIN (SELECT tms_auftrag_id,
   system_id,
   SUM(CASE
     WHEN art_id IS NULL AND tms_transportmittel_id IN (1, 2, 5, 8, 9, 10, 12, 15, 18)
     THEN anz_transportmittel
     ELSE NULL
     END) AS anz_lt_avis,
   SUM(CASE
     WHEN art_id IS NULL AND tms_transportmittel_id = 19
     THEN anz_transportmittel
     ELSE NULL
     END) AS anzahl_flaschen
  FROM kfl_production_dbp_view.v_tms_auftrag_det AS TMS_AD
  GROUP BY tms_auftrag_id,
   system_id) AS tms_ad ON TMS_A.tms_auftrag_id = tms_ad.tms_auftrag_id AND TMS_A.system_id = tms_ad.system_id
 LEFT JOIN (SELECT tms_ref_nr,
   system_id,
   tms_ref_unter_nr,
   stpf_missing_fg,
   stapelfaktor,
   anz_stellplatz_berechnet,
   SUM(aufwand_fracht_) AS aufwand_fracht,
   SUM(aufwand_fixpreis_) AS aufwand_fixpreis,
   SUM(aufwand_diesel_) AS aufwand_diesel,
   SUM(aufwand_vorlauf_) AS aufwand_vorlauf,
   SUM(aufwand_umschlag_) AS aufwand_umschlag,
   SUM(aufwand_hauptlauf_) AS aufwand_hauptlauf,
   SUM(aufwand_korrektur_) AS aufwand_korrektur,
   SUM(aufwand_wochenende_) AS aufwand_wochenende,
   SUM(aufwand_zeitfenster_) AS aufwand_zeitfenster,
   SUM(aufwand_sonstiges_) AS aufwand_sonstiges,
   SUM(aufwand_lt_) AS aufwand_lt,
   SUM(aufwand_aufsetzen_) AS aufwand_aufsetzen,
   SUM(aufwand_mehraufwand_) AS aufwand_mehraufwand,
   SUM(ertrag_fracht_) AS ertrag_fracht,
   SUM(ertrag_diesel_) AS ertrag_diesel,
   SUM(ertrag_zeitfenster_) AS ertrag_zeitfenster,
   SUM(ertrag_sonstiges_) AS ertrag_sonstiges,
   SUM(ertrag_lt_) AS ertrag_lt,
   SUM(ertrag_aufsetzen_) AS ertrag_aufsetzen,
   SUM(ertrag_mehraufwand_) AS ertrag_mehraufwand,
   SUM(ertrag_maut_) AS ertrag_maut,
   SUM(ertrag_wochenende_) AS ertrag_wochenende,
   SUM(ertrag_korrektur_) AS ertrag_korrektur,
               COALESCE(SUM(aufwand_fracht_), 0) + COALESCE(SUM(aufwand_fixpreis_), 0) + COALESCE(SUM(aufwand_diesel_),
               0) + COALESCE(SUM(aufwand_mehraufwand_), 0) + COALESCE(SUM(aufwand_vorlauf_), 0) + COALESCE(SUM(aufwand_umschlag_
             ), 0) + COALESCE(SUM(aufwand_hauptlauf_), 0) + COALESCE(SUM(aufwand_wochenende_), 0) + COALESCE(SUM(aufwand_zeitfenster_
          ), 0) + COALESCE(SUM(aufwand_sonstiges_), 0) + COALESCE(SUM(aufwand_lt_), 0) + COALESCE(SUM(aufwand_aufsetzen_
       ), 0) + COALESCE(SUM(aufwand_korrektur_), 0) AS aufwand_gesamt,
            COALESCE(SUM(ertrag_fracht_), 0) + COALESCE(SUM(ertrag_diesel_), 0) + COALESCE(SUM(ertrag_zeitfenster_), 0)
          + COALESCE(SUM(ertrag_sonstiges_), 0) + COALESCE(SUM(ertrag_lt_), 0) + COALESCE(SUM(ertrag_aufsetzen_), 0) +
       COALESCE(SUM(ertrag_mehraufwand_), 0) + COALESCE(SUM(ertrag_maut_), 0) + COALESCE(SUM(ertrag_wochenende_), 0) +
    COALESCE(SUM(ertrag_korrektur_), 0) AS ertrag_gesamt
  FROM (SELECT COALESCE(tms_r.tms_ref_nr, TMS_A0.tms_auftrag_id) AS tms_ref_nr,
     COALESCE(tms_r.system_id, TMS_A0.system_id) AS system_id,
     COALESCE(CAST(tms_r.tms_ref_unter_nr AS BIGNUMERIC), TMS_A0.tms_auftrag_unter_id) AS tms_ref_unter_nr,
      CASE
      WHEN STPF.anz_pal_stapelfaktor IS NULL
      THEN 1
      ELSE 0
      END AS stpf_missing_fg,
     COALESCE(CASE
       WHEN STPF.anz_pal_stapelfaktor = 0
       THEN 1
       ELSE STPF.anz_pal_stapelfaktor
       END, 1) AS stapelfaktor,
       CASE
       WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
       THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
       WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
       THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
       ELSE TMS_A0.anz_stellplatz
       END / COALESCE(CASE
        WHEN STPF.anz_pal_stapelfaktor = 0
        THEN 1
        ELSE STPF.anz_pal_stapelfaktor
        END, 1) AS anz_stellplatz_berechnet,
     tms_r.tms_rech_beleg_id,
     tms_r.tms_rech_beleg_pos_id,
     COALESCE(tms_av.abgeladene_epal_, 0) AS abgeladene_epal,
     SUM(CASE
        WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
        THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
        WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
        THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
        ELSE TMS_A0.anz_stellplatz
        END / COALESCE(CASE
         WHEN STPF.anz_pal_stapelfaktor = 0
         THEN 1
         ELSE STPF.anz_pal_stapelfaktor
         END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS stp_,
      CASE
      WHEN COALESCE(SUM(CASE
           WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
           THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
           WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
           THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
           ELSE TMS_A0.anz_stellplatz
           END / COALESCE(CASE
            WHEN STPF.anz_pal_stapelfaktor = 0
            THEN 1
            ELSE STPF.anz_pal_stapelfaktor
            END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) = 0
      THEN 1
      ELSE SUM(CASE
         WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
         THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
         WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
         THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
         ELSE TMS_A0.anz_stellplatz
         END / COALESCE(CASE
          WHEN STPF.anz_pal_stapelfaktor = 0
          THEN 1
          ELSE STPF.anz_pal_stapelfaktor
          END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
      END AS stp,
     SUM(COALESCE(tms_av.abgeladene_epal_, 0)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS epal,
      CASE
      WHEN tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id IN (1, 27)
      THEN tms_r.betrag_netto / CASE
         WHEN COALESCE(SUM(CASE
              WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
              THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
              WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
              THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
              ELSE TMS_A0.anz_stellplatz
              END / COALESCE(CASE
               WHEN STPF.anz_pal_stapelfaktor = 0
               THEN 1
               ELSE STPF.anz_pal_stapelfaktor
               END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) = 0
         THEN 1
         ELSE SUM(CASE
            WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
            THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
            WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
            THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
            ELSE TMS_A0.anz_stellplatz
            END / COALESCE(CASE
             WHEN STPF.anz_pal_stapelfaktor = 0
             THEN 1
             ELSE STPF.anz_pal_stapelfaktor
             END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
         END * (CASE
          WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
          THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
          WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
          THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
          ELSE TMS_A0.anz_stellplatz
          END / COALESCE(CASE
           WHEN STPF.anz_pal_stapelfaktor = 0
           THEN 1
           ELSE STPF.anz_pal_stapelfaktor
           END, 1))
      ELSE NULL
      END AS aufwand_fracht_,
      CASE
      WHEN tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id = 22
      THEN tms_r.betrag_netto / CASE
         WHEN COALESCE(SUM(CASE
              WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
              THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
              WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
              THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
              ELSE TMS_A0.anz_stellplatz
              END / COALESCE(CASE
               WHEN STPF.anz_pal_stapelfaktor = 0
               THEN 1
               ELSE STPF.anz_pal_stapelfaktor
               END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) = 0
         THEN 1
         ELSE SUM(CASE
            WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
            THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
            WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
            THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
            ELSE TMS_A0.anz_stellplatz
            END / COALESCE(CASE
             WHEN STPF.anz_pal_stapelfaktor = 0
             THEN 1
             ELSE STPF.anz_pal_stapelfaktor
             END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
         END * (CASE
          WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
          THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
          WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
          THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
          ELSE TMS_A0.anz_stellplatz
          END / COALESCE(CASE
           WHEN STPF.anz_pal_stapelfaktor = 0
           THEN 1
           ELSE STPF.anz_pal_stapelfaktor
           END, 1))
      ELSE NULL
      END AS aufwand_fixpreis_,
      CASE
      WHEN tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id = 7
      THEN tms_r.betrag_netto / CASE
         WHEN COALESCE(SUM(CASE
              WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
              THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
              WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
              THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
              ELSE TMS_A0.anz_stellplatz
              END / COALESCE(CASE
               WHEN STPF.anz_pal_stapelfaktor = 0
               THEN 1
               ELSE STPF.anz_pal_stapelfaktor
               END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) = 0
         THEN 1
         ELSE SUM(CASE
            WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
            THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
            WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
            THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
            ELSE TMS_A0.anz_stellplatz
            END / COALESCE(CASE
             WHEN STPF.anz_pal_stapelfaktor = 0
             THEN 1
             ELSE STPF.anz_pal_stapelfaktor
             END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
         END * (CASE
          WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
          THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
          WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
          THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
          ELSE TMS_A0.anz_stellplatz
          END / COALESCE(CASE
           WHEN STPF.anz_pal_stapelfaktor = 0
           THEN 1
           ELSE STPF.anz_pal_stapelfaktor
           END, 1))
      ELSE NULL
      END AS aufwand_diesel_,
      CASE
      WHEN tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id = 9
      THEN tms_r.betrag_netto / CASE
         WHEN COALESCE(SUM(CASE
              WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
              THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
              WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
              THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
              ELSE TMS_A0.anz_stellplatz
              END / COALESCE(CASE
               WHEN STPF.anz_pal_stapelfaktor = 0
               THEN 1
               ELSE STPF.anz_pal_stapelfaktor
               END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) = 0
         THEN 1
         ELSE SUM(CASE
            WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
            THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
            WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
            THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
            ELSE TMS_A0.anz_stellplatz
            END / COALESCE(CASE
             WHEN STPF.anz_pal_stapelfaktor = 0
             THEN 1
             ELSE STPF.anz_pal_stapelfaktor
             END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
         END * (CASE
          WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
          THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
          WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
          THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
          ELSE TMS_A0.anz_stellplatz
          END / COALESCE(CASE
           WHEN STPF.anz_pal_stapelfaktor = 0
           THEN 1
           ELSE STPF.anz_pal_stapelfaktor
           END, 1))
      ELSE NULL
      END AS aufwand_vorlauf_,
      CASE
      WHEN tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id = 10
      THEN tms_r.betrag_netto / CASE
         WHEN COALESCE(SUM(CASE
              WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
              THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
              WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
              THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
              ELSE TMS_A0.anz_stellplatz
              END / COALESCE(CASE
               WHEN STPF.anz_pal_stapelfaktor = 0
               THEN 1
               ELSE STPF.anz_pal_stapelfaktor
               END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) = 0
         THEN 1
         ELSE SUM(CASE
            WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
            THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
            WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
            THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
            ELSE TMS_A0.anz_stellplatz
            END / COALESCE(CASE
             WHEN STPF.anz_pal_stapelfaktor = 0
             THEN 1
             ELSE STPF.anz_pal_stapelfaktor
             END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
         END * (CASE
          WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
          THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
          WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
          THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
          ELSE TMS_A0.anz_stellplatz
          END / COALESCE(CASE
           WHEN STPF.anz_pal_stapelfaktor = 0
           THEN 1
           ELSE STPF.anz_pal_stapelfaktor
           END, 1))
      ELSE NULL
      END AS aufwand_umschlag_,
      CASE
      WHEN tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id = 11
      THEN tms_r.betrag_netto / CASE
         WHEN COALESCE(SUM(CASE
              WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
              THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
              WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
              THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
              ELSE TMS_A0.anz_stellplatz
              END / COALESCE(CASE
               WHEN STPF.anz_pal_stapelfaktor = 0
               THEN 1
               ELSE STPF.anz_pal_stapelfaktor
               END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) = 0
         THEN 1
         ELSE SUM(CASE
            WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
            THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
            WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
            THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
            ELSE TMS_A0.anz_stellplatz
            END / COALESCE(CASE
             WHEN STPF.anz_pal_stapelfaktor = 0
             THEN 1
             ELSE STPF.anz_pal_stapelfaktor
             END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
         END * (CASE
          WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
          THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
          WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
          THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
          ELSE TMS_A0.anz_stellplatz
          END / COALESCE(CASE
           WHEN STPF.anz_pal_stapelfaktor = 0
           THEN 1
           ELSE STPF.anz_pal_stapelfaktor
           END, 1))
      ELSE NULL
      END AS aufwand_hauptlauf_,
      CASE
      WHEN tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id = 13
      THEN tms_r.betrag_netto / CASE
         WHEN COALESCE(SUM(CASE
              WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
              THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
              WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
              THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
              ELSE TMS_A0.anz_stellplatz
              END / COALESCE(CASE
               WHEN STPF.anz_pal_stapelfaktor = 0
               THEN 1
               ELSE STPF.anz_pal_stapelfaktor
               END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) = 0
         THEN 1
         ELSE SUM(CASE
            WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
            THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
            WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
            THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
            ELSE TMS_A0.anz_stellplatz
            END / COALESCE(CASE
             WHEN STPF.anz_pal_stapelfaktor = 0
             THEN 1
             ELSE STPF.anz_pal_stapelfaktor
             END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
         END * (CASE
          WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
          THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
          WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
          THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
          ELSE TMS_A0.anz_stellplatz
          END / COALESCE(CASE
           WHEN STPF.anz_pal_stapelfaktor = 0
           THEN 1
           ELSE STPF.anz_pal_stapelfaktor
           END, 1))
      ELSE NULL
      END AS aufwand_korrektur_,
      CASE
      WHEN tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id IN (3, 26)
      THEN tms_r.betrag_netto / tms_r.anz
      ELSE NULL
      END AS aufwand_wochenende_,
      CASE
      WHEN tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id = 5
      THEN tms_r.betrag_netto / tms_r.anz
      ELSE NULL
      END AS aufwand_zeitfenster_,
      CASE
      WHEN tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id IN (15, 16, 17, 18, 19, 20, 21, 23)
      THEN tms_r.betrag_netto / CASE
         WHEN COALESCE(SUM(CASE
              WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
              THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
              WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
              THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
              ELSE TMS_A0.anz_stellplatz
              END / COALESCE(CASE
               WHEN STPF.anz_pal_stapelfaktor = 0
               THEN 1
               ELSE STPF.anz_pal_stapelfaktor
               END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) = 0
         THEN 1
         ELSE SUM(CASE
            WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
            THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
            WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
            THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
            ELSE TMS_A0.anz_stellplatz
            END / COALESCE(CASE
             WHEN STPF.anz_pal_stapelfaktor = 0
             THEN 1
             ELSE STPF.anz_pal_stapelfaktor
             END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
         END * (CASE
          WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
          THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
          WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
          THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
          ELSE TMS_A0.anz_stellplatz
          END / COALESCE(CASE
           WHEN STPF.anz_pal_stapelfaktor = 0
           THEN 1
           ELSE STPF.anz_pal_stapelfaktor
           END, 1))
      ELSE NULL
      END AS aufwand_sonstiges_,
      CASE
      WHEN tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id IN (2, 24)
      THEN tms_r.betrag_netto / CASE
         WHEN COALESCE(SUM(CASE
              WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
              THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
              WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
              THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
              ELSE TMS_A0.anz_stellplatz
              END / COALESCE(CASE
               WHEN STPF.anz_pal_stapelfaktor = 0
               THEN 1
               ELSE STPF.anz_pal_stapelfaktor
               END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) = 0
         THEN 1
         ELSE SUM(CASE
            WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
            THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
            WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
            THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
            ELSE TMS_A0.anz_stellplatz
            END / COALESCE(CASE
             WHEN STPF.anz_pal_stapelfaktor = 0
             THEN 1
             ELSE STPF.anz_pal_stapelfaktor
             END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
         END * (CASE
          WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
          THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
          WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
          THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
          ELSE TMS_A0.anz_stellplatz
          END / COALESCE(CASE
           WHEN STPF.anz_pal_stapelfaktor = 0
           THEN 1
           ELSE STPF.anz_pal_stapelfaktor
           END, 1))
      ELSE NULL
      END AS aufwand_lt_,
      CASE
      WHEN tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id = 4
      THEN tms_r.betrag_netto / CASE
         WHEN COALESCE(SUM(CASE
              WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
              THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
              WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
              THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
              ELSE TMS_A0.anz_stellplatz
              END / COALESCE(CASE
               WHEN STPF.anz_pal_stapelfaktor = 0
               THEN 1
               ELSE STPF.anz_pal_stapelfaktor
               END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) = 0
         THEN 1
         ELSE SUM(CASE
            WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
            THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
            WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
            THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
            ELSE TMS_A0.anz_stellplatz
            END / COALESCE(CASE
             WHEN STPF.anz_pal_stapelfaktor = 0
             THEN 1
             ELSE STPF.anz_pal_stapelfaktor
             END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
         END * (CASE
          WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
          THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
          WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
          THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
          ELSE TMS_A0.anz_stellplatz
          END / COALESCE(CASE
           WHEN STPF.anz_pal_stapelfaktor = 0
           THEN 1
           ELSE STPF.anz_pal_stapelfaktor
           END, 1))
      ELSE NULL
      END AS aufwand_aufsetzen_,
      CASE
      WHEN tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id = 8
      THEN tms_r.betrag_netto / CASE
         WHEN COALESCE(SUM(CASE
              WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
              THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
              WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
              THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
              ELSE TMS_A0.anz_stellplatz
              END / COALESCE(CASE
               WHEN STPF.anz_pal_stapelfaktor = 0
               THEN 1
               ELSE STPF.anz_pal_stapelfaktor
               END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) = 0
         THEN 1
         ELSE SUM(CASE
            WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
            THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
            WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
            THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
            ELSE TMS_A0.anz_stellplatz
            END / COALESCE(CASE
             WHEN STPF.anz_pal_stapelfaktor = 0
             THEN 1
             ELSE STPF.anz_pal_stapelfaktor
             END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
         END * (CASE
          WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
          THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
          WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
          THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
          ELSE TMS_A0.anz_stellplatz
          END / COALESCE(CASE
           WHEN STPF.anz_pal_stapelfaktor = 0
           THEN 1
           ELSE STPF.anz_pal_stapelfaktor
           END, 1))
      ELSE NULL
      END AS aufwand_mehraufwand_,
      CASE
      WHEN tms_r.tms_rech_beleg_typ_id = 0 AND tms_r.tms_konto_id IN (1, 27)
      THEN tms_r.betrag_netto / CASE
         WHEN COALESCE(SUM(CASE
              WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
              THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
              WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
              THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
              ELSE TMS_A0.anz_stellplatz
              END / COALESCE(CASE
               WHEN STPF.anz_pal_stapelfaktor = 0
               THEN 1
               ELSE STPF.anz_pal_stapelfaktor
               END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) = 0
         THEN 1
         ELSE SUM(CASE
            WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
            THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
            WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
            THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
            ELSE TMS_A0.anz_stellplatz
            END / COALESCE(CASE
             WHEN STPF.anz_pal_stapelfaktor = 0
             THEN 1
             ELSE STPF.anz_pal_stapelfaktor
             END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
         END * (CASE
          WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
          THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
          WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
          THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
          ELSE TMS_A0.anz_stellplatz
          END / COALESCE(CASE
           WHEN STPF.anz_pal_stapelfaktor = 0
           THEN 1
           ELSE STPF.anz_pal_stapelfaktor
           END, 1))
      ELSE NULL
      END AS ertrag_fracht_,
      CASE
      WHEN tms_r.tms_rech_beleg_typ_id = 0 AND tms_r.tms_konto_id = 7
      THEN tms_r.betrag_netto / CASE
         WHEN COALESCE(SUM(CASE
              WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
              THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
              WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
              THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
              ELSE TMS_A0.anz_stellplatz
              END / COALESCE(CASE
               WHEN STPF.anz_pal_stapelfaktor = 0
               THEN 1
               ELSE STPF.anz_pal_stapelfaktor
               END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) = 0
         THEN 1
         ELSE SUM(CASE
            WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
            THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
            WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
            THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
            ELSE TMS_A0.anz_stellplatz
            END / COALESCE(CASE
             WHEN STPF.anz_pal_stapelfaktor = 0
             THEN 1
             ELSE STPF.anz_pal_stapelfaktor
             END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
         END * (CASE
          WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
          THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
          WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
          THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
          ELSE TMS_A0.anz_stellplatz
          END / COALESCE(CASE
           WHEN STPF.anz_pal_stapelfaktor = 0
           THEN 1
           ELSE STPF.anz_pal_stapelfaktor
           END, 1))
      ELSE NULL
      END AS ertrag_diesel_,
      CASE
      WHEN tms_r.tms_rech_beleg_typ_id = 0 AND tms_r.tms_konto_id IN (5, 25)
      THEN tms_r.betrag_netto / tms_r.anz
      ELSE NULL
      END AS ertrag_zeitfenster_,
      CASE
      WHEN tms_r.tms_rech_beleg_typ_id = 0 AND tms_r.tms_konto_id IN (15, 16, 17, 18, 19, 20, 21, 23)
      THEN tms_r.betrag_netto / CASE
         WHEN COALESCE(SUM(CASE
              WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
              THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
              WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
              THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
              ELSE TMS_A0.anz_stellplatz
              END / COALESCE(CASE
               WHEN STPF.anz_pal_stapelfaktor = 0
               THEN 1
               ELSE STPF.anz_pal_stapelfaktor
               END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) = 0
         THEN 1
         ELSE SUM(CASE
            WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
            THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
            WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
            THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
            ELSE TMS_A0.anz_stellplatz
            END / COALESCE(CASE
             WHEN STPF.anz_pal_stapelfaktor = 0
             THEN 1
             ELSE STPF.anz_pal_stapelfaktor
             END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
         END * (CASE
          WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
          THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
          WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
          THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
          ELSE TMS_A0.anz_stellplatz
          END / COALESCE(CASE
           WHEN STPF.anz_pal_stapelfaktor = 0
           THEN 1
           ELSE STPF.anz_pal_stapelfaktor
           END, 1))
      ELSE NULL
      END AS ertrag_sonstiges_,
      CASE
      WHEN tms_r.tms_rech_beleg_typ_id = 0 AND tms_r.tms_konto_id IN (2, 24)
      THEN tms_r.betrag_netto / CASE
         WHEN COALESCE(SUM(CASE
              WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
              THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
              WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
              THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
              ELSE TMS_A0.anz_stellplatz
              END / COALESCE(CASE
               WHEN STPF.anz_pal_stapelfaktor = 0
               THEN 1
               ELSE STPF.anz_pal_stapelfaktor
               END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) = 0
         THEN 1
         ELSE SUM(CASE
            WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
            THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
            WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
            THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
            ELSE TMS_A0.anz_stellplatz
            END / COALESCE(CASE
             WHEN STPF.anz_pal_stapelfaktor = 0
             THEN 1
             ELSE STPF.anz_pal_stapelfaktor
             END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
         END * (CASE
          WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
          THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
          WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
          THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
          ELSE TMS_A0.anz_stellplatz
          END / COALESCE(CASE
           WHEN STPF.anz_pal_stapelfaktor = 0
           THEN 1
           ELSE STPF.anz_pal_stapelfaktor
           END, 1))
      ELSE NULL
      END AS ertrag_lt_,
      CASE
      WHEN tms_r.tms_rech_beleg_typ_id = 0 AND tms_r.tms_konto_id = 4
      THEN tms_r.betrag_netto / CASE
         WHEN COALESCE(SUM(CASE
              WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
              THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
              WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
              THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
              ELSE TMS_A0.anz_stellplatz
              END / COALESCE(CASE
               WHEN STPF.anz_pal_stapelfaktor = 0
               THEN 1
               ELSE STPF.anz_pal_stapelfaktor
               END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) = 0
         THEN 1
         ELSE SUM(CASE
            WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
            THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
            WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
            THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
            ELSE TMS_A0.anz_stellplatz
            END / COALESCE(CASE
             WHEN STPF.anz_pal_stapelfaktor = 0
             THEN 1
             ELSE STPF.anz_pal_stapelfaktor
             END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
         END * (CASE
          WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
          THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
          WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
          THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
          ELSE TMS_A0.anz_stellplatz
          END / COALESCE(CASE
           WHEN STPF.anz_pal_stapelfaktor = 0
           THEN 1
           ELSE STPF.anz_pal_stapelfaktor
           END, 1))
      ELSE NULL
      END AS ertrag_aufsetzen_,
      CASE
      WHEN tms_r.tms_rech_beleg_typ_id = 0 AND tms_r.tms_konto_id = 8
      THEN tms_r.betrag_netto / CASE
         WHEN COALESCE(SUM(CASE
              WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
              THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
              WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
              THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
              ELSE TMS_A0.anz_stellplatz
              END / COALESCE(CASE
               WHEN STPF.anz_pal_stapelfaktor = 0
               THEN 1
               ELSE STPF.anz_pal_stapelfaktor
               END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) = 0
         THEN 1
         ELSE SUM(CASE
            WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
            THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
            WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
            THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
            ELSE TMS_A0.anz_stellplatz
            END / COALESCE(CASE
             WHEN STPF.anz_pal_stapelfaktor = 0
             THEN 1
             ELSE STPF.anz_pal_stapelfaktor
             END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
         END * (CASE
          WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
          THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
          WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
          THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
          ELSE TMS_A0.anz_stellplatz
          END / COALESCE(CASE
           WHEN STPF.anz_pal_stapelfaktor = 0
           THEN 1
           ELSE STPF.anz_pal_stapelfaktor
           END, 1))
      ELSE NULL
      END AS ertrag_mehraufwand_,
      CASE
      WHEN tms_r.tms_rech_beleg_typ_id = 0 AND tms_r.tms_konto_id = 6
      THEN tms_r.betrag_netto / CASE
         WHEN COALESCE(SUM(CASE
              WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
              THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
              WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
              THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
              ELSE TMS_A0.anz_stellplatz
              END / COALESCE(CASE
               WHEN STPF.anz_pal_stapelfaktor = 0
               THEN 1
               ELSE STPF.anz_pal_stapelfaktor
               END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) = 0
         THEN 1
         ELSE SUM(CASE
            WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
            THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
            WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
            THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
            ELSE TMS_A0.anz_stellplatz
            END / COALESCE(CASE
             WHEN STPF.anz_pal_stapelfaktor = 0
             THEN 1
             ELSE STPF.anz_pal_stapelfaktor
             END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
         END * (CASE
          WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
          THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
          WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
          THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
          ELSE TMS_A0.anz_stellplatz
          END / COALESCE(CASE
           WHEN STPF.anz_pal_stapelfaktor = 0
           THEN 1
           ELSE STPF.anz_pal_stapelfaktor
           END, 1))
      ELSE NULL
      END AS ertrag_maut_,
      CASE
      WHEN tms_r.tms_rech_beleg_typ_id = 0 AND tms_r.tms_konto_id IN (3, 26)
      THEN tms_r.betrag_netto / tms_r.anz
      ELSE NULL
      END AS ertrag_wochenende_,
      CASE
      WHEN tms_r.tms_rech_beleg_typ_id = 0 AND tms_r.tms_konto_id = 12
      THEN tms_r.betrag_netto / CASE
         WHEN COALESCE(SUM(CASE
              WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
              THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
              WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
              THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
              ELSE TMS_A0.anz_stellplatz
              END / COALESCE(CASE
               WHEN STPF.anz_pal_stapelfaktor = 0
               THEN 1
               ELSE STPF.anz_pal_stapelfaktor
               END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) = 0
         THEN 1
         ELSE SUM(CASE
            WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
            THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
            WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
            THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
            ELSE TMS_A0.anz_stellplatz
            END / COALESCE(CASE
             WHEN STPF.anz_pal_stapelfaktor = 0
             THEN 1
             ELSE STPF.anz_pal_stapelfaktor
             END, 1)) OVER (PARTITION BY tms_r.system_id, tms_r.tms_rech_beleg_id, tms_r.tms_rech_beleg_pos_id
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
         END * (CASE
          WHEN IFNULL(tms_av.abgeladene_paletten_, 0) > IFNULL(tms_ad.anz_lt_avis_, 0)
          THEN CAST(tms_av.abgeladene_paletten_ AS BIGNUMERIC)
          WHEN IFNULL(tms_ad.anz_lt_avis_, 0) > 0
          THEN CAST(tms_ad.anz_lt_avis_ AS BIGNUMERIC)
          ELSE TMS_A0.anz_stellplatz
          END / COALESCE(CASE
           WHEN STPF.anz_pal_stapelfaktor = 0
           THEN 1
           ELSE STPF.anz_pal_stapelfaktor
           END, 1))
      ELSE NULL
      END AS ertrag_korrektur_
    FROM kfl_production_dbp_view.v_tms_auftrag AS TMS_A0
     LEFT JOIN (SELECT DZ.tms_ref_nr,
       DZ.tms_ref_unter_nr,
       R.system_id,
       R.tms_rech_beleg_id,
       RD.tms_rech_beleg_pos_id,
       R.tms_rech_beleg_typ_id,
         CAST(R.tms_rech_beleg_id AS STRING) || '_' || CAST(RD.tms_rech_org_pos_id AS STRING),
       COUNT(*) OVER (PARTITION BY R.system_id, R.tms_rech_beleg_id, RD.tms_rech_beleg_pos_id RANGE BETWEEN
        UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS anz,
       RD.tms_konto_id,
       RD.betrag_netto,
       RD.menge_frachtpflichtig
      FROM kfl_production_dbp_view.v_tms_rechnung_det_zu AS DZ
       LEFT JOIN kfl_production_dbp_view.v_tms_rechnung AS R ON DZ.tms_rech_beleg_id = R.tms_rech_beleg_id AND DZ.system_id
           = R.system_id AND R.storno_fg = 0
       LEFT JOIN kfl_production_dbp_view.v_tms_rechnung_det AS RD ON DZ.tms_rech_beleg_id = RD.tms_rech_beleg_id AND DZ
          .tms_rech_beleg_pos_id = RD.tms_rech_beleg_pos_id AND DZ.system_id = RD.system_id) AS tms_r ON TMS_A0.tms_auftrag_id
         = tms_r.tms_ref_nr AND TMS_A0.tms_auftrag_unter_id = CAST(tms_r.tms_ref_unter_nr AS FLOAT64) AND TMS_A0.system_id
        = tms_r.system_id
     LEFT JOIN kfl_production_dbp_view.v_tms_gp AS TMS_B ON TMS_A0.mandant_id = TMS_B.mandant_id AND TMS_A0.system_id =
         TMS_B.system_id AND TMS_A0.beladestelle_tms_gp_id = TMS_B.tms_gp_id AND TMS_A0.beladestelle_tms_gp_typ_cd =
       TMS_B.tms_gp_typ_cd
     LEFT JOIN (SELECT tms_auftrag_id,
       system_id,
       SUM(CASE
         WHEN tms_transportmittel_id = 8
         THEN anz_verpackung
         ELSE NULL
         END) AS abgeladene_epal_,
       SUM(CASE
         WHEN tms_transportmittel_id IN (1, 2, 5, 8, 9, 10, 12, 15, 18)
         THEN anz_verpackung
         ELSE NULL
         END) AS abgeladene_paletten_
      FROM kfl_production_dbp_view.v_tms_auftrag_verpackung AS TMS_AV
      GROUP BY tms_auftrag_id,
       system_id) AS tms_av ON TMS_A0.tms_auftrag_id = tms_av.tms_auftrag_id AND TMS_A0.system_id = tms_av.system_id
     LEFT JOIN (SELECT tms_auftrag_id,
       system_id,
       SUM(CASE
         WHEN art_id IS NULL AND tms_transportmittel_id IN (1, 2, 5, 8, 9, 10, 12, 15, 18)
         THEN anz_transportmittel
         ELSE NULL
         END) AS anz_lt_avis_
      FROM kfl_production_dbp_view.v_tms_auftrag_det AS TMS_AD
      GROUP BY tms_auftrag_id,
       system_id) AS tms_ad ON TMS_A0.tms_auftrag_id = tms_ad.tms_auftrag_id AND TMS_A0.system_id = tms_ad.system_id
     LEFT JOIN kfl_production_dbp_view.v_gp_plz_besch_region_zu_per AS STPF ON TMS_B.mandant_id = STPF.mandant_id AND
         STPF.gp_id = ROUND(SAFE_CAST(TMS_A0.versender_tms_gp_id AS BIGNUMERIC), 0) AND TMS_B.tms_gp_plz = STPF.abholung_plz
         AND TMS_A0.dat_lief BETWEEN STPF.dat_von AND STPF.dat_bis) AS tms_r_sum
  GROUP BY tms_ref_nr,
   system_id,
   tms_ref_unter_nr,
   stpf_missing_fg,
   stapelfaktor,
   anz_stellplatz_berechnet) AS tms_r ON TMS_A.tms_auftrag_id = tms_r.tms_ref_nr AND TMS_A.tms_auftrag_unter_id = tms_r
    .tms_ref_unter_nr AND TMS_A.system_id = tms_r.system_id
 LEFT JOIN (SELECT tms_auftrag_id,
   system_id,
   STRING_AGG(auftrag_txt, '; ') AS auftrag_txt_lieferstein
  FROM kfl_production_dbp_view.v_tms_auftrag_text AS TMS_AT
  WHERE tms_text_typ_cd = 'L'
  GROUP BY tms_auftrag_id,
   system_id) AS l_lieferstein ON TMS_A.tms_auftrag_id = l_lieferstein.tms_auftrag_id AND TMS_A.system_id =
   l_lieferstein.system_id
 LEFT JOIN (SELECT tms_auftrag_id,
   system_id,
   STRING_AGG(auftrag_txt, '; ') AS auftrag_txt_bemerkung_beladen
  FROM kfl_production_dbp_view.v_tms_auftrag_text AS TMS_AT
  WHERE tms_satzart_id = 135
  GROUP BY tms_auftrag_id,
   system_id) AS l_bemer_bel ON TMS_A.tms_auftrag_id = l_bemer_bel.tms_auftrag_id AND TMS_A.system_id = l_bemer_bel.system_id
   
 LEFT JOIN (SELECT tms_auftrag_id,
   system_id,
   STRING_AGG(auftrag_txt, '; ') AS auftrag_txt_bemerkung_entaden
  FROM kfl_production_dbp_view.v_tms_auftrag_text AS TMS_AT
  WHERE tms_satzart_id = 136
  GROUP BY tms_auftrag_id,
   system_id) AS l_bemer_ent ON TMS_A.tms_auftrag_id = l_bemer_ent.tms_auftrag_id AND TMS_A.system_id = l_bemer_ent.system_id;