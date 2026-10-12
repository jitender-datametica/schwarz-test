CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_scm.mv_dt_wbs_art_wup_aktion_initial_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 60,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
WITH TOP_DAT_BERECHNUNG AS (SELECT DISTINCT dat_beladung
  FROM kfl_production_dbp_view.v_wbs_werbeaenderungen_2
  ORDER BY dat_beladung DESC NULLS FIRST
  LIMIT 5) (SELECT V00.mandant_id,
   V00.art_id,
   V05.aktuell_wup_id AS wup_id,
   V00.nb_id,
    CASE
    WHEN V00.wup_id_vz = 6140
    THEN 4
    ELSE V00.mandant_id_vz
    END AS mandant_id_vz,
   V00.wup_id_vz,
   V00.nb_id_vz,
   V00.aktion_id,
   V00.ausliefergruppe_id,
   V00.dat_ab AS dat_von,
   V00.dat_bis,
   V00.dat_beladung,
   V00.offer_id,
   ROUND(SAFE_CAST(V03.angebot_nr AS BIGNUMERIC), 0) AS angebot_id,
   V00.wbs_phase_id,
   V00.best_generiert_fg,
   V00.bestellung_lieferant_fg,
   V00.stille_aktion_fg,
   V00.tv_fg,
   V00.gk_fg,
   V00.werbeaenderung_artikelneuanlage_fg,
   V00.werbeaenderung_artikelentfernung_fg,
   V00.anteil_wup_artikel_perc,
    CASE
    WHEN ROUND(SAFE_CAST(V03.angebot_nr AS BIGNUMERIC), 0) = V00.offer_id
    THEN V00.anz_tage_werbung
    ELSE 0
    END AS anz_tage_werbung,
    CASE
    WHEN ROUND(SAFE_CAST(V03.angebot_nr AS BIGNUMERIC), 0) = V00.offer_id
    THEN V00.bedarf_bme
    ELSE 0
    END AS bedarf_bme,
    CASE
    WHEN ROUND(SAFE_CAST(V03.angebot_nr AS BIGNUMERIC), 0) = V00.offer_id
    THEN V00.bedarf_ame
    ELSE 0
    END AS bedarf_ame,
    CASE
    WHEN ROUND(SAFE_CAST(V03.angebot_nr AS BIGNUMERIC), 0) = V00.offer_id
    THEN V00.bestellung_lieferant_menge
    ELSE 0
    END AS bestellung_lieferant_menge,
    CASE
    WHEN V00.bestellung_lieferant_menge IS NULL OR V00.bestellung_lieferant_menge = 0
    THEN 0
    ELSE 1
    END AS uebertragungs_fg,
   0 AS bestellmenge_final_ame,
    CASE
    WHEN ROUND(SAFE_CAST(V03.angebot_nr AS BIGNUMERIC), 0) = V00.offer_id
    THEN V00.bestellmenge_ohne_bestand_ame
    ELSE 0
    END AS bestellmenge_ohne_bestand_ame,
    CASE
    WHEN ROUND(SAFE_CAST(V03.angebot_nr AS BIGNUMERIC), 0) = V00.offer_id
    THEN V00.menge_mindestplatzierung_bme
    ELSE 0
    END AS menge_mindestplatzierung_bme,
    CASE
    WHEN ROUND(SAFE_CAST(V03.angebot_nr AS BIGNUMERIC), 0) = V00.offer_id
    THEN V00.prognose_werbezeitraum_bme
    ELSE 0
    END AS prognose_werbezeitraum_bme,
    CASE
    WHEN ROUND(SAFE_CAST(V03.angebot_nr AS BIGNUMERIC), 0) = V00.offer_id
    THEN V00.projizierter_bestand_vor_werbung_bme
    ELSE 0
    END AS projizierter_bestand_vor_werbung_bme,
   DATE_DIFF(V00.dat_beladung, V00.dat_ab, DAY) AS werbung_in_x_tagen,
    CASE
    WHEN ROUND(SAFE_CAST(V03.angebot_nr AS BIGNUMERIC), 0) = V00.offer_id
    THEN V00.zielbestand_bme
    ELSE 0
    END AS zielbestand_bme,
    CASE
    WHEN V01.art_id IS NOT NULL
    THEN 1
    ELSE 0
    END AS init_belieferung_fg,
   V01.dat_bestandsperiode_rel,
   V01.dat_lief_split,
   V01.dat_lief_wunsch,
   V01.dat_bestandsperiode_bis,
   V01.dat_letzte_nachversorgung,
   V01.we_bearbeitungszeit,
    CASE
    WHEN ROUND(SAFE_CAST(V03.angebot_nr AS BIGNUMERIC), 0) = V00.offer_id
    THEN V01.menge_gesamt_bme
    ELSE 0
    END AS menge_gesamt_bme,
    CASE
    WHEN ROUND(SAFE_CAST(V03.angebot_nr AS BIGNUMERIC), 0) = V00.offer_id
    THEN V01.menge_min_bme
    ELSE 0
    END AS menge_min_bme,
    CASE
    WHEN ROUND(SAFE_CAST(V03.angebot_nr AS BIGNUMERIC), 0) = V00.offer_id
    THEN V01.menge_initial_bme
    ELSE 0
    END AS menge_initial_bme,
    CASE
    WHEN ROUND(SAFE_CAST(V03.angebot_nr AS BIGNUMERIC), 0) = V00.offer_id
    THEN V01.menge_initial_ame
    ELSE 0
    END AS menge_initial_ame,
    CASE
    WHEN ROUND(SAFE_CAST(V03.angebot_nr AS BIGNUMERIC), 0) = V00.offer_id
    THEN V01.menge_initial_pal
    ELSE 0
    END AS menge_initial_pal,
   V01.split_fg,
   V02.kjwo,
   V01.fair_share_fg,
   V01.order_type,
   COALESCE(V01.init_lief_modus_kz, 'S') AS init_lief_modus_kz
  FROM kfl_production_dbp_view.v_wbs_werbeaenderungen_2 AS V00
   INNER JOIN kfl_production_dbp_view.v_wup_2 AS V05 ON V00.mandant_id = V05.mandant_id AND V00.wup_id = V05.wup_id AND (V05
        .nb_id IN (2, 0, -111) AND V05.wup_id > 0 OR V05.nb_id = -1 AND V05.wup_id = 0)
   INNER JOIN kfl_production_dbp_view.v_angebot_art_wup_zu_2 AS V03 ON V00.mandant_id = V03.mandant_id AND V00.art_id =
        V03.art_id AND V00.wup_id = V03.wup_id AND V00.nb_id = V03.nb_id AND V00.offer_id = ROUND(SAFE_CAST(V03.angebot_nr
       AS BIGNUMERIC), 0)
   INNER JOIN TOP_DAT_BERECHNUNG AS v99 ON V00.dat_beladung = v99.dat_beladung
   LEFT JOIN kfl_production_dbp_view.v_wbs_art_wup_aktion_initial_2 AS V01 ON V00.mandant_id = V01.mandant_id AND V00.art_id
               = V01.art_id AND V00.wup_id = V01.wup_id AND V00.nb_id = V01.nb_id AND V00.wup_id_vz = V01.wup_id_vz AND
          V00.nb_id_vz = V01.nb_id_vz AND V00.aktion_id = V01.aktion_id AND V00.ausliefergruppe_id = V01.ausliefergruppe_id
         AND V00.dat_ab = V01.dat_von AND V00.dat_bis = V01.dat_bis AND V00.dat_beladung = V01.dat_beladung
   INNER JOIN kfl_production_dbp_view.v_tag_2 AS V02 ON V00.dat_ab = V02.dat);