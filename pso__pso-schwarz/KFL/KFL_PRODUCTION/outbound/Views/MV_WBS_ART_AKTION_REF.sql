CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_wbs_art_aktion_ref AS WITH PRICES_REF AS (SELECT DISTINCT
   aktion_id_ref,
   mandant_id,
   art_id,
   wup_id,
   wrg_id,
   vk_aktion_brutto_ref
  FROM kfl_production_dbp_view.v_wbs_art_aktion_ref), PRICE_NORMAL AS (SELECT aktion_id_ref,
   mandant_id,
   art_id,
   wrg_id,
   MAX(vk_vor_aktion_brutto_ref) AS vk_vor_aktion_brutto_ref
  FROM kfl_production_dbp_view.v_wbs_art_aktion_ref
  GROUP BY aktion_id_ref,
   mandant_id,
   art_id,
   wrg_id), TOP_DAT_BERECHNUNG AS (SELECT DISTINCT dat_beladung
  FROM kfl_production_dbp_view.v_wbs_werbeaenderungen
  ORDER BY dat_beladung DESC NULLS FIRST
  LIMIT 5), WERBEFLAECHENABSCHNITT_SPR AS (SELECT werbeflaechenabschnitt_id,
   werbeflaechenabschnitt_name,
   MAX(CASE
     WHEN spr_id = 22
     THEN werbeflaechenabschnitt_wfl_bez
     ELSE NULL
     END) AS werbeflaechenabschnitt_wfl_bez_,
   MAX(CASE
     WHEN spr_id = 22
     THEN werbeflaechenabschnitt_wfl_bez
     ELSE NULL
     END) AS werbeflaechenabschnitt_wfl_bez_de,
   MAX(CASE
     WHEN spr_id = 124
     THEN werbeflaechenabschnitt_wfl_bez
     ELSE NULL
     END) AS werbeflaechenabschnitt_wfl_bez_cz,
   MAX(CASE
     WHEN spr_id = 108
     THEN werbeflaechenabschnitt_wfl_bez
     ELSE NULL
     END) AS werbeflaechenabschnitt_wfl_bez_sk,
   MAX(CASE
     WHEN spr_id = 65
     THEN werbeflaechenabschnitt_wfl_bez
     ELSE NULL
     END) AS werbeflaechenabschnitt_wfl_bez_hr,
   MAX(CASE
     WHEN spr_id = 90
     THEN werbeflaechenabschnitt_wfl_bez
     ELSE NULL
     END) AS werbeflaechenabschnitt_wfl_bez_pl,
   MAX(CASE
     WHEN spr_id = 95
     THEN werbeflaechenabschnitt_wfl_bez
     ELSE NULL
     END) AS werbeflaechenabschnitt_wfl_bez_ro,
   MAX(CASE
     WHEN spr_id = 18
     THEN werbeflaechenabschnitt_wfl_bez
     ELSE NULL
     END) AS werbeflaechenabschnitt_wfl_bez_bg
  FROM kfl_production_dbp_view.v_werbeflaechenabschnitt_spr_zu AS V01
  GROUP BY werbeflaechenabschnitt_id,
   werbeflaechenabschnitt_name), WERBEMITTEL_SPR AS (SELECT werbemittelkanal_id,
   werbemittel_id,
   MAX(CASE
     WHEN spr_id = 22
     THEN werbemittel_wfl_bez
     ELSE NULL
     END) AS werbemittel_wfl_bez_,
   MAX(CASE
     WHEN spr_id = 22
     THEN werbemittel_wfl_bez
     ELSE NULL
     END) AS werbemittel_wfl_bez_de,
   MAX(CASE
     WHEN spr_id = 124
     THEN werbemittel_wfl_bez
     ELSE NULL
     END) AS werbemittel_wfl_bez_cz,
   MAX(CASE
     WHEN spr_id = 108
     THEN werbemittel_wfl_bez
     ELSE NULL
     END) AS werbemittel_wfl_bez_sk,
   MAX(CASE
     WHEN spr_id = 65
     THEN werbemittel_wfl_bez
     ELSE NULL
     END) AS werbemittel_wfl_bez_hr,
   MAX(CASE
     WHEN spr_id = 90
     THEN werbemittel_wfl_bez
     ELSE NULL
     END) AS werbemittel_wfl_bez_pl,
   MAX(CASE
     WHEN spr_id = 95
     THEN werbemittel_wfl_bez
     ELSE NULL
     END) AS werbemittel_wfl_bez_ro,
   MAX(CASE
     WHEN spr_id = 18
     THEN werbemittel_wfl_bez
     ELSE NULL
     END) AS werbemittel_wfl_bez_bg
  FROM kfl_production_dbp_view.v_werbemittel_spr_zu AS V01
  GROUP BY werbemittelkanal_id,
   werbemittel_id) (SELECT V01.mandant_id,
   V05.aktuell_wup_id AS wup_id_,
   V01.nb_id,
   V01.art_id,
   V01.aktion_dauer,
   MAX(V01.aktion_id_ref) AS aktion_id_ref_,
   V01.aktion_id,
   V01.kjwo_von,
   V09.kjwo_ww,
   V01.dat_von,
   V01.dat_bis,
   V01.wtag_id_von,
   V01.mutter_wb_id,
   V01.anz_akt_selbe_dauer,
   V01.aktion_reihenfolge,
   V01.dat_von_ref,
   V01.dat_bis_ref,
   MAX(V01.menge_gesamt_bme_ref) AS menge_ref,
   SUM(V01.menge_sa_bme_ref) AS menge_sa_ref,
   MAX(V01.zeitraum_korrigierte_menge_ref) AS korrigierte_menge_ref,
   MAX(COALESCE(V01.sales_fg_ref, 0)) AS sales_fg_ref,
   MAX(V01.zeitraum_menge_af_4wo_ref) AS menge_af_4wo_ref,
   MAX(COALESCE(V01.in_gruppe_fg, 0)) AS in_gruppe_fg_ref,
   MAX(COALESCE(V01.tv_fg_ref, 0)) AS tv_fg_ref,
   MAX(COALESCE(V01.titelseite_fg_ref, 0)) AS titelseite_fg_ref,
   MAX(COALESCE(V01.rueckseite_fg_ref, 0)) AS rueckseite_fg_ref,
   MAX(COALESCE(V01.multi_offer_id_fg_ref, 0)) AS multi_offer_id_fg_ref,
   MAX(COALESCE(V01.bonuskauf_fg_ref, 0)) AS bonuskauf_fg_ref,
   MAX(COALESCE(V01.gk_fg_ref, 0)) AS gk_fg_ref,
   MAX(CONCAT(CASE
      WHEN V01.multi_offer_id_fg_ref <> 0
      THEN '| MULTI-OFFER '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_fg_ref <> 0
      THEN '| FIXMENGE '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_wfl_fg_ref <> 0
      THEN '| FIXMENGE WFL '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.gk_fg_ref, 0) <> 0
      THEN '| GK '
      ELSE ''
      END, CASE
      WHEN V01.mindestplatzierung_fg_ref <> 0
      THEN '| MINDESTPLATZIERUNG '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.kundenkarte_personalisiert_fg_ref, 0) <> 0
      THEN '| KUNDENKARTE PERSONALISIERT '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.bonuskauf_fg_ref, 0) <> 0
      THEN '| BONUSKAUF '
      ELSE ''
      END, CASE
      WHEN V101.werbeflaechenabschnitt_wfl_bez_ <> ''
      THEN CONCAT('| ', V101.werbeflaechenabschnitt_wfl_bez_, ' ')
      ELSE ''
      END, CASE
      WHEN V102.werbemittel_wfl_bez_ <> ''
      THEN CONCAT('| ', V102.werbemittel_wfl_bez_, ' ')
      ELSE ''
      END, CASE
      WHEN V103.werbeflaechenthema_wfl_bez <> ''
      THEN CONCAT('| ', V103.werbeflaechenthema_wfl_bez, ' ')
      ELSE ''
      END, CASE
      WHEN V01.lokale_geschaeftsvorfall_bez_ref <> ''
      THEN CONCAT('| ', V01.lokale_geschaeftsvorfall_bez_ref, ' ')
      ELSE ''
      END)) AS compound_fg,
   MAX(CONCAT(CASE
      WHEN V01.multi_offer_id_fg_ref <> 0
      THEN '| MULTI-OFFER '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_fg_ref <> 0
      THEN '| FIXMENGE '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_wfl_fg_ref <> 0
      THEN '| FIXMENGE WFL '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.gk_fg_ref, 0) <> 0
      THEN '| GK '
      ELSE ''
      END, CASE
      WHEN V01.mindestplatzierung_fg_ref <> 0
      THEN '| MINDESTPLATZIERUNG '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.kundenkarte_personalisiert_fg_ref, 0) <> 0
      THEN '| KUNDENKARTE PERSONALISIERT '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.bonuskauf_fg_ref, 0) <> 0
      THEN '| BONUSKAUF '
      ELSE ''
      END, CASE
      WHEN V101.werbeflaechenabschnitt_wfl_bez_de <> ''
      THEN CONCAT('| ', V101.werbeflaechenabschnitt_wfl_bez_de, ' ')
      ELSE ''
      END, CASE
      WHEN V102.werbemittel_wfl_bez_de <> ''
      THEN CONCAT('| ', V102.werbemittel_wfl_bez_de, ' ')
      ELSE ''
      END, CASE
      WHEN V103.werbeflaechenthema_wfl_bez <> ''
      THEN CONCAT('| ', V103.werbeflaechenthema_wfl_bez, ' ')
      ELSE ''
      END, CASE
      WHEN V01.lokale_geschaeftsvorfall_bez_ref <> ''
      THEN CONCAT('| ', V01.lokale_geschaeftsvorfall_bez_ref, ' ')
      ELSE ''
      END)) AS compound_fg_de,
   MAX(CONCAT(CASE
      WHEN V01.multi_offer_id_fg_ref <> 0
      THEN '| MULTI-OFFER '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_fg_ref <> 0
      THEN '| FIXMENGE '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_wfl_fg_ref <> 0
      THEN '| FIXMENGE WFL '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.gk_fg_ref, 0) <> 0
      THEN '| GK '
      ELSE ''
      END, CASE
      WHEN V01.mindestplatzierung_fg_ref <> 0
      THEN '| MINDESTPLATZIERUNG '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.kundenkarte_personalisiert_fg_ref, 0) <> 0
      THEN '| KUNDENKARTE PERSONALISIERT '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.bonuskauf_fg_ref, 0) <> 0
      THEN '| BONUSKAUF '
      ELSE ''
      END, CASE
      WHEN V101.werbeflaechenabschnitt_wfl_bez_cz <> ''
      THEN CONCAT('| ', V101.werbeflaechenabschnitt_wfl_bez_cz, ' ')
      ELSE ''
      END, CASE
      WHEN V102.werbemittel_wfl_bez_cz <> ''
      THEN CONCAT('| ', V102.werbemittel_wfl_bez_cz, ' ')
      ELSE ''
      END, CASE
      WHEN V103.werbeflaechenthema_wfl_bez <> ''
      THEN CONCAT('| ', V103.werbeflaechenthema_wfl_bez, ' ')
      ELSE ''
      END, CASE
      WHEN V01.lokale_geschaeftsvorfall_bez_ref <> ''
      THEN CONCAT('| ', V01.lokale_geschaeftsvorfall_bez_ref, ' ')
      ELSE ''
      END)) AS compound_fg_cz,
   MAX(CONCAT(CASE
      WHEN V01.multi_offer_id_fg_ref <> 0
      THEN '| MULTI-OFFER '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_fg_ref <> 0
      THEN '| FIXMENGE '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_wfl_fg_ref <> 0
      THEN '| FIXMENGE WFL '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.gk_fg_ref, 0) <> 0
      THEN '| GK '
      ELSE ''
      END, CASE
      WHEN V01.mindestplatzierung_fg_ref <> 0
      THEN '| MINDESTPLATZIERUNG '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.kundenkarte_personalisiert_fg_ref, 0) <> 0
      THEN '| KUNDENKARTE PERSONALISIERT '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.bonuskauf_fg_ref, 0) <> 0
      THEN '| BONUSKAUF '
      ELSE ''
      END, CASE
      WHEN V101.werbeflaechenabschnitt_wfl_bez_sk <> ''
      THEN CONCAT('| ', V101.werbeflaechenabschnitt_wfl_bez_sk, ' ')
      ELSE ''
      END, CASE
      WHEN V102.werbemittel_wfl_bez_sk <> ''
      THEN CONCAT('| ', V102.werbemittel_wfl_bez_sk, ' ')
      ELSE ''
      END, CASE
      WHEN V103.werbeflaechenthema_wfl_bez <> ''
      THEN CONCAT('| ', V103.werbeflaechenthema_wfl_bez, ' ')
      ELSE ''
      END, CASE
      WHEN V01.lokale_geschaeftsvorfall_bez_ref <> ''
      THEN CONCAT('| ', V01.lokale_geschaeftsvorfall_bez_ref, ' ')
      ELSE ''
      END)) AS compound_fg_sk,
   MAX(CONCAT(CASE
      WHEN V01.multi_offer_id_fg_ref <> 0
      THEN '| MULTI-OFFER '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_fg_ref <> 0
      THEN '| FIXMENGE '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_wfl_fg_ref <> 0
      THEN '| FIXMENGE WFL '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.gk_fg_ref, 0) <> 0
      THEN '| GK '
      ELSE ''
      END, CASE
      WHEN V01.mindestplatzierung_fg_ref <> 0
      THEN '| MINDESTPLATZIERUNG '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.kundenkarte_personalisiert_fg_ref, 0) <> 0
      THEN '| KUNDENKARTE PERSONALISIERT '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.bonuskauf_fg_ref, 0) <> 0
      THEN '| BONUSKAUF '
      ELSE ''
      END, CASE
      WHEN V101.werbeflaechenabschnitt_wfl_bez_hr <> ''
      THEN CONCAT('| ', V101.werbeflaechenabschnitt_wfl_bez_hr, ' ')
      ELSE ''
      END, CASE
      WHEN V102.werbemittel_wfl_bez_hr <> ''
      THEN CONCAT('| ', V102.werbemittel_wfl_bez_hr, ' ')
      ELSE ''
      END, CASE
      WHEN V103.werbeflaechenthema_wfl_bez <> ''
      THEN CONCAT('| ', V103.werbeflaechenthema_wfl_bez, ' ')
      ELSE ''
      END, CASE
      WHEN V01.lokale_geschaeftsvorfall_bez_ref <> ''
      THEN CONCAT('| ', V01.lokale_geschaeftsvorfall_bez_ref, ' ')
      ELSE ''
      END)) AS compound_fg_hr,
   MAX(CONCAT(CASE
      WHEN V01.multi_offer_id_fg_ref <> 0
      THEN '| MULTI-OFFER '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_fg_ref <> 0
      THEN '| FIXMENGE '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_wfl_fg_ref <> 0
      THEN '| FIXMENGE WFL '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.gk_fg_ref, 0) <> 0
      THEN '| GK '
      ELSE ''
      END, CASE
      WHEN V01.mindestplatzierung_fg_ref <> 0
      THEN '| MINDESTPLATZIERUNG '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.kundenkarte_personalisiert_fg_ref, 0) <> 0
      THEN '| KUNDENKARTE PERSONALISIERT '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.bonuskauf_fg_ref, 0) <> 0
      THEN '| BONUSKAUF '
      ELSE ''
      END, CASE
      WHEN V101.werbeflaechenabschnitt_wfl_bez_pl <> ''
      THEN CONCAT('| ', V101.werbeflaechenabschnitt_wfl_bez_pl, ' ')
      ELSE ''
      END, CASE
      WHEN V102.werbemittel_wfl_bez_pl <> ''
      THEN CONCAT('| ', V102.werbemittel_wfl_bez_pl, ' ')
      ELSE ''
      END, CASE
      WHEN V103.werbeflaechenthema_wfl_bez <> ''
      THEN CONCAT('| ', V103.werbeflaechenthema_wfl_bez, ' ')
      ELSE ''
      END, CASE
      WHEN V01.lokale_geschaeftsvorfall_bez_ref <> ''
      THEN CONCAT('| ', V01.lokale_geschaeftsvorfall_bez_ref, ' ')
      ELSE ''
      END)) AS compound_fg_pl,
   MAX(CONCAT(CASE
      WHEN V01.multi_offer_id_fg_ref <> 0
      THEN '| MULTI-OFFER '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_fg_ref <> 0
      THEN '| FIXMENGE '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_wfl_fg_ref <> 0
      THEN '| FIXMENGE WFL '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.gk_fg_ref, 0) <> 0
      THEN '| GK '
      ELSE ''
      END, CASE
      WHEN V01.mindestplatzierung_fg_ref <> 0
      THEN '| MINDESTPLATZIERUNG '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.kundenkarte_personalisiert_fg_ref, 0) <> 0
      THEN '| KUNDENKARTE PERSONALISIERT '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.bonuskauf_fg_ref, 0) <> 0
      THEN '| BONUSKAUF '
      ELSE ''
      END, CASE
      WHEN V101.werbeflaechenabschnitt_wfl_bez_ro <> ''
      THEN CONCAT('| ', V101.werbeflaechenabschnitt_wfl_bez_ro, ' ')
      ELSE ''
      END, CASE
      WHEN V102.werbemittel_wfl_bez_ro <> ''
      THEN CONCAT('| ', V102.werbemittel_wfl_bez_ro, ' ')
      ELSE ''
      END, CASE
      WHEN V103.werbeflaechenthema_wfl_bez <> ''
      THEN CONCAT('| ', V103.werbeflaechenthema_wfl_bez, ' ')
      ELSE ''
      END, CASE
      WHEN V01.lokale_geschaeftsvorfall_bez_ref <> ''
      THEN CONCAT('| ', V01.lokale_geschaeftsvorfall_bez_ref, ' ')
      ELSE ''
      END)) AS compound_fg_ro,
   MAX(CONCAT(CASE
      WHEN V01.multi_offer_id_fg_ref <> 0
      THEN '| MULTI-OFFER '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_fg_ref <> 0
      THEN '| FIXMENGE '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_wfl_fg_ref <> 0
      THEN '| FIXMENGE WFL '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.gk_fg_ref, 0) <> 0
      THEN '| GK '
      ELSE ''
      END, CASE
      WHEN V01.mindestplatzierung_fg_ref <> 0
      THEN '| MINDESTPLATZIERUNG '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.kundenkarte_personalisiert_fg_ref, 0) <> 0
      THEN '| KUNDENKARTE PERSONALISIERT '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.bonuskauf_fg_ref, 0) <> 0
      THEN '| BONUSKAUF '
      ELSE ''
      END, CASE
      WHEN V101.werbeflaechenabschnitt_wfl_bez_bg <> ''
      THEN CONCAT('| ', V101.werbeflaechenabschnitt_wfl_bez_bg, ' ')
      ELSE ''
      END, CASE
      WHEN V102.werbemittel_wfl_bez_bg <> ''
      THEN CONCAT('| ', V102.werbemittel_wfl_bez_bg, ' ')
      ELSE ''
      END, CASE
      WHEN V103.werbeflaechenthema_wfl_bez <> ''
      THEN CONCAT('| ', V103.werbeflaechenthema_wfl_bez, ' ')
      ELSE ''
      END, CASE
      WHEN V01.lokale_geschaeftsvorfall_bez_ref <> ''
      THEN CONCAT('| ', V01.lokale_geschaeftsvorfall_bez_ref, ' ')
      ELSE ''
      END)) AS compound_fg_bg,
   MAX(COALESCE(V01.lokale_geschaeftsvorfall_bez_ref, '')) AS lokale_geschaeftsvorfall_bez_ref,
   MAX(V01.vk_aktion_brutto_ref) AS vk_aktion_brutto_ref,
   STRING_AGG(CAST(t1.vk_aktion_brutto_ref AS STRING), '|' ORDER BY t1.vk_aktion_brutto_ref IS NULL, t1.vk_aktion_brutto_ref
     ) AS vk_aktion_brutto_ref_concat,
   STRING_AGG(CONCAT(CAST(ROUND((1 - IF(t5.vk_vor_aktion_brutto_ref = 0, 0, SAFE_DIVIDE(t1.vk_aktion_brutto_ref, t5.vk_vor_aktion_brutto_ref))) * 100, 0) AS INTEGER)
     , '%'), '|' ORDER BY t1.vk_aktion_brutto_ref IS NULL, t1.vk_aktion_brutto_ref) AS preisnachlass_ref_concat,
   COUNT(V01.wup_id) OVER (PARTITION BY CAST(V01.art_id AS STRING), CAST(V01.mandant_id AS STRING), V01.dat_von, V01.dat_bis
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS anzahl_wup,
   MAX(V01.vk_vor_aktion_brutto_ref) AS vk_vor_aktion_brutto_ref,
   MAX(V01.anz_art_in_gruppe) AS anz_art_in_gruppe,
   MAX(V01.anz_art_in_gruppe_ref) AS anz_art_in_gruppe_ref,
   V02.kjwo AS kjwo_hist_aktion,
   WKW1.faktor_flaki AS faktor_flaki_hist_aktion,
         WKW1.menge_tag1 + WKW1.menge_tag2 + WKW1.menge_tag3 + WKW1.menge_tag4 + WKW1.menge_tag5 + WKW1.menge_tag6 +
    WKW1.menge_tag7 AS menge_hist_aktion,
   WKW1.menge_aktionsstart AS menge_aktionsstart_hist_aktion,
   WKW1.we_menge_zentral AS menge_we_zentrale_hist_aktion,
   WKW1.anzahl_nullbestand AS anzahl_nullbestand_hist_aktion,
   WKW1.anzahl_tage_aktion AS anzahl_tage_aktion_hist_aktion,
   WKW1.menge_historie_af AS menge_historie_af_hist_aktion,
   WKW1.sollbestand AS sollbestand_hist_aktion,
   WKW1.min_sicherh_bestand AS min_sicherh_bestand_hist_aktion,
   WKW1.menge_endbestand AS menge_endbestand_hist_aktion,
         WKW1.umsatz_netto_tag1 + WKW1.umsatz_netto_tag2 + WKW1.umsatz_netto_tag3 + WKW1.umsatz_netto_tag4 + WKW1.umsatz_netto_tag5
       + WKW1.umsatz_netto_tag6 + WKW1.umsatz_netto_tag7 AS umsatz_netto_hist_aktion,
   V011.mandant_id_vz,
   V011.dat_beladung,
   ROW_NUMBER() OVER (PARTITION BY CAST(V01.art_id AS STRING), CAST(V01.wup_id AS STRING), V01.dat_bis_ref, V01.dat_von_ref
      , CAST(V01.kjwo_von AS STRING), V011.dat_beladung ORDER BY V01.aktion_id IS NULL, V01.aktion_id) AS aktion_rank,
   COALESCE(V01.art_id_ref, - 1) AS art_id_ref,
   COALESCE(V01.wup_id_ref, - 1) AS wup_id_ref,
   COALESCE(V01.nb_id_ref, - 1) AS nb_id_ref,
   AVG(COALESCE(V01.faktor_ref, 0)) OVER (PARTITION BY CAST(V011.mandant_id_vz AS STRING), CAST(V01.art_id AS STRING),
      V01.aktion_id, V011.dat_beladung, CAST(V01.art_id_ref AS STRING), V01.dat_von_ref, V01.dat_von RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS faktor_ref_0,
   COALESCE(V01.wbs_art_wup_ref_typ_id, - 1) AS wbs_art_wup_ref_typ_id
  FROM kfl_production_dbp_view.v_wbs_art_aktion_ref AS V01
   INNER JOIN kfl_production_dbp_view.v_wup AS V05 ON V01.mandant_id = V05.mandant_id AND V01.wup_id = V05.wup_id AND (V05
        .nb_id IN (2, 0, - 111) AND V05.wup_id > 0 OR V05.nb_id = - 1 AND V05.wup_id = 0)
   LEFT JOIN PRICES_REF AS t1 ON V01.mandant_id = t1.mandant_id AND V01.art_id = t1.art_id AND V01.wup_id = t1.wup_id
     AND V01.aktion_id_ref = t1.aktion_id_ref AND V01.wrg_id = t1.wrg_id
   LEFT JOIN PRICE_NORMAL AS t5 ON V01.mandant_id = t5.mandant_id AND V01.art_id = t5.art_id AND V01.aktion_id_ref = t5
      .aktion_id_ref AND V01.wrg_id = t5.wrg_id
   LEFT JOIN kfl_production_dbp_view.v_tag AS V02 ON V01.dat_von_ref = V02.dat
   INNER JOIN (SELECT DISTINCT V00.mandant_id,
      CASE
      WHEN V00.wup_id_vz = 6140
      THEN 4
      ELSE V00.mandant_id_vz
      END AS mandant_id_vz,
     V00.art_id,
     V00.wup_id,
     V00.nb_id,
     V00.kjwo,
     V00.dat_ab,
     V00.dat_bis,
     V00.dat_beladung
    FROM kfl_production_dbp_view.v_wbs_werbeaenderungen AS V00
     INNER JOIN TOP_DAT_BERECHNUNG AS V99 ON V00.dat_beladung = V99.dat_beladung) AS V011 ON V01.mandant_id = V011.mandant_id
          AND V01.art_id = V011.art_id AND V01.dat_von = V011.dat_ab AND V01.dat_bis = V011.dat_bis AND V01.wup_id =
      V011.wup_id AND V01.nb_id = V011.nb_id
   LEFT JOIN kfl_production_dbp_view.v_werbung_kennzahlen_woche AS WKW1 ON V01.mandant_id = WKW1.mandant_id AND V01.art_id
        = WKW1.art_id AND V01.wup_id = WKW1.wup_id AND V02.kjwo = WKW1.kjwo
   LEFT JOIN kfl_production_dbp_view.v_werbewoche_kl AS V09 ON V01.mandant_id = V09.mandant_id AND V01.dat_von = V09.dat
     
   LEFT JOIN kfl_production_dbp_view.v_pmr_angebot_art_wup_zu AS V7 ON V01.mandant_id = V7.mandant_id AND V01.art_id =
        V7.art_id AND V01.wup_id = V7.wup_id AND V01.nb_id = V7.nb_id AND V01.aktion_id_ref = V7.aktion_id
   LEFT JOIN (SELECT V10.angebot_id,
     V10.mandant_id,
     STRING_AGG(DISTINCT V10A.werbeflaechenabschnitt_wfl_bez_, '| ') AS werbeflaechenabschnitt_wfl_bez_,
     STRING_AGG(DISTINCT V10A.werbeflaechenabschnitt_wfl_bez_de, '| ') AS werbeflaechenabschnitt_wfl_bez_de,
     STRING_AGG(DISTINCT V10A.werbeflaechenabschnitt_wfl_bez_cz, '| ') AS werbeflaechenabschnitt_wfl_bez_cz,
     STRING_AGG(DISTINCT V10A.werbeflaechenabschnitt_wfl_bez_sk, '| ') AS werbeflaechenabschnitt_wfl_bez_sk,
     STRING_AGG(DISTINCT V10A.werbeflaechenabschnitt_wfl_bez_hr, '| ') AS werbeflaechenabschnitt_wfl_bez_hr,
     STRING_AGG(DISTINCT V10A.werbeflaechenabschnitt_wfl_bez_pl, '| ') AS werbeflaechenabschnitt_wfl_bez_pl,
     STRING_AGG(DISTINCT V10A.werbeflaechenabschnitt_wfl_bez_ro, '| ') AS werbeflaechenabschnitt_wfl_bez_ro,
     STRING_AGG(DISTINCT V10A.werbeflaechenabschnitt_wfl_bez_bg, '| ') AS werbeflaechenabschnitt_wfl_bez_bg
    FROM kfl_production_dbp_view.v_pmr_angebot_werbemittel_werbeflaeche_zu AS V10
     INNER JOIN WERBEFLAECHENABSCHNITT_SPR AS V10A ON TRIM(REGEXP_EXTRACT(V10.werbeflaeche_abschnitt_name, '^[^\\(]+'))
      = V10A.werbeflaechenabschnitt_name
    GROUP BY V10.angebot_id,
     V10.mandant_id) AS V101 ON V7.mandant_id = V101.mandant_id AND V7.angebot_id = V101.angebot_id
   LEFT JOIN (SELECT V100.angebot_id,
     V100.mandant_id,
     STRING_AGG(DISTINCT V10B.werbemittel_wfl_bez_, '| ') AS werbemittel_wfl_bez_,
     STRING_AGG(DISTINCT V10B.werbemittel_wfl_bez_de, '| ') AS werbemittel_wfl_bez_de,
     STRING_AGG(DISTINCT V10B.werbemittel_wfl_bez_cz, '| ') AS werbemittel_wfl_bez_cz,
     STRING_AGG(DISTINCT V10B.werbemittel_wfl_bez_sk, '| ') AS werbemittel_wfl_bez_sk,
     STRING_AGG(DISTINCT V10B.werbemittel_wfl_bez_hr, '| ') AS werbemittel_wfl_bez_hr,
     STRING_AGG(DISTINCT V10B.werbemittel_wfl_bez_pl, '| ') AS werbemittel_wfl_bez_pl,
     STRING_AGG(DISTINCT V10B.werbemittel_wfl_bez_ro, '| ') AS werbemittel_wfl_bez_ro,
     STRING_AGG(DISTINCT V10B.werbemittel_wfl_bez_bg, '| ') AS werbemittel_wfl_bez_bg
    FROM kfl_production_dbp_view.v_pmr_angebot_werbemittel_werbeflaeche_zu AS V100
     INNER JOIN WERBEMITTEL_SPR AS V10B ON V100.werbemittel_art_id = V10B.werbemittelkanal_id AND V100.werbemittel_id = CAST(V10B.werbemittel_id AS FLOAT64)
       
    GROUP BY V100.angebot_id,
     V100.mandant_id) AS V102 ON V7.mandant_id = V102.mandant_id AND V7.angebot_id = V102.angebot_id
   LEFT JOIN (SELECT V101.angebot_id,
     V101.mandant_id,
     STRING_AGG(DISTINCT V10C.werbeflaechenthema_wfl_bez, '| ') AS werbeflaechenthema_wfl_bez
    FROM kfl_production_dbp_view.v_pmr_angebot_werbemittel_werbeflaeche_zu AS V101
     INNER JOIN kfl_production_dbp_view.v_l_werbeflaechenthema AS V10C ON V101.mandant_id = V10C.mandant_id AND V101.werbeflaeche_thema_id
        = V10C.werbeflaechenthema_cd
    GROUP BY V101.angebot_id,
     V101.mandant_id) AS V103 ON V7.mandant_id = V103.mandant_id AND V7.angebot_id = V103.angebot_id
  WHERE V01.aktion_reihenfolge BETWEEN 1 AND 10
  GROUP BY V01.mandant_id,
   V01.wup_id,
   wup_id_,
   V01.nb_id,
   V01.art_id,
   V01.aktion_dauer,
   V01.aktion_id,
   V01.kjwo_von,
   V09.kjwo_ww,
   V01.dat_von,
   V01.dat_bis,
   V01.wtag_id_von,
   V01.mutter_wb_id,
   V01.anz_akt_selbe_dauer,
   V01.aktion_reihenfolge,
   V01.dat_von_ref,
   V01.dat_bis_ref,
   kjwo_hist_aktion,
   faktor_flaki_hist_aktion,
   menge_hist_aktion,
   menge_aktionsstart_hist_aktion,
   menge_we_zentrale_hist_aktion,
   anzahl_nullbestand_hist_aktion,
   anzahl_tage_aktion_hist_aktion,
   menge_historie_af_hist_aktion,
   sollbestand_hist_aktion,
   min_sicherh_bestand_hist_aktion,
   menge_endbestand_hist_aktion,
   umsatz_netto_hist_aktion,
   V011.mandant_id_vz,
   V011.dat_beladung,
   V01.art_id_ref,
   V01.wup_id_ref,
   V01.nb_id_ref,
   V01.faktor_ref,
   V01.wbs_art_wup_ref_typ_id);