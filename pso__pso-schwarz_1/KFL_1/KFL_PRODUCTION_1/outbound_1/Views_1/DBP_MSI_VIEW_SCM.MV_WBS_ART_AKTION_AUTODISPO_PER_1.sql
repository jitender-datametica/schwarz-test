CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_wbs_art_aktion_autodispo_per_1 AS WITH PRICES_REF AS (SELECT
   aktion_id,
   mandant_id,
   art_id,
   wup_id,
   MAX(vk_aktion_brutto) AS vk_aktion_brutto_ref,
   MAX(vk_vor_aktion_brutto) AS vk_vor_aktion_brutto
  FROM kfl_production_dbp_view.v_wbs_art_aktion_per_1
  GROUP BY aktion_id,
   mandant_id,
   art_id,
   wup_id), PRICE_NORMAL AS (SELECT aktion_id,
   mandant_id,
   art_id,
   wup_id,
   MAX(vk_vor_aktion_brutto) AS vk_vor_aktion_brutto
  FROM kfl_production_dbp_view.v_wbs_art_aktion_per_1
  GROUP BY aktion_id,
   mandant_id,
   art_id,
   wup_id), TOP_DAT_BERECHNUNG AS (SELECT DISTINCT dat_beladung
  FROM kfl_production_dbp_view.v_wbs_werbeaenderungen_1
  ORDER BY dat_beladung DESC NULLS FIRST
  LIMIT 5), ACT_PROM AS (SELECT DISTINCT V00.mandant_id,
   V00.art_id
  FROM kfl_production_dbp_view.v_wbs_werbeaenderungen_1 AS V00
   INNER JOIN TOP_DAT_BERECHNUNG AS v99 ON V00.dat_beladung = v99.dat_beladung), ACT_PROM_ART_REF_COUNT AS (SELECT V010
   .mandant_id,
   V010.art_id,
   V010.art_id_ref,
   COUNT(V010.wup_id) AS wup_id_count
  FROM kfl_production_dbp_view.v_art_wup_status_referenz_1 AS V010
   INNER JOIN ACT_PROM AS v00 ON V010.mandant_id = v00.mandant_id AND V010.art_id = v00.art_id
  WHERE V010.dat_bis_ref >= DATE_SUB(DATE(CURRENT_DATE), INTERVAL 365 DAY)
   AND V010.art_id <> V010.art_id_ref
  GROUP BY V010.mandant_id,
   V010.art_id,
   V010.art_id_ref), ACT_PROM_ART_REF_RANK AS (SELECT mandant_id,
   art_id,
   art_id_ref,
   ROW_NUMBER() OVER (PARTITION BY art_id, mandant_id ORDER BY wup_id_count DESC NULLS FIRST) AS rk
  FROM ACT_PROM_ART_REF_COUNT AS v01
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY art_id, mandant_id ORDER BY wup_id_count DESC NULLS FIRST)) = 1),
 ACT_PROM_ART_REF AS (SELECT mandant_id,
   art_id,
   art_id_ref
  FROM ACT_PROM_ART_REF_RANK AS v01), WERBEFLAECHENABSCHNITT_SPR AS (SELECT werbeflaechenabschnitt_id,
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
  FROM kfl_production_dbp_view.v_werbeflaechenabschnitt_spr_zu_1 AS V01
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
  FROM kfl_production_dbp_view.v_werbemittel_spr_zu_1 AS V01
  GROUP BY werbemittelkanal_id,
   werbemittel_id) (SELECT V01.mandant_id,
   V05.aktuell_wup_id AS wup_id_,
   V01.nb_id,
   V01.art_id,
   STRING_AGG(CAST(A.kl_art_id AS STRING), '|') OVER (PARTITION BY v011.art_id, V01.mandant_id ORDER BY A.kl_art_id NULLS LAST
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS art_id_concat,
   v011.art_id AS wbs_art_id,
   V01.aktion_dauer,
   V01.aktion_id,
   V01.kjwo_von,
   V09.kjwo_ww,
   V01.dat_von,
   V01.dat_bis,
   V01.wtag_id_von,
   V01.mutter_wb_id,
   MAX(V01.menge_gesamt_bme) AS menge,
   MAX(V01.menge_sa_bme) AS menge_sa,
   MAX(V01.zeitraum_korrigierte_menge) AS korrigierte_menge,
   MAX(COALESCE(V01.sales_fg, 0)) AS sales_fg,
   MAX(V01.zeitraum_menge_af_4wo) AS menge_af_4wo,
   MAX(COALESCE(V01.in_gruppe_fg, 0)) AS in_gruppe_fg,
   MAX(COALESCE(V01.tv_fg, 0)) AS tv_fg,
   MAX(COALESCE(V01.titelseite_fg, 0)) AS titelseite_fg,
   MAX(COALESCE(V01.rueckseite_fg, 0)) AS rueckseite_fg,
   MAX(COALESCE(V01.multi_offer_id_fg, 0)) AS multi_offer_id_fg,
   MAX(COALESCE(V01.bonuskauf_fg, 0)) AS bonuskauf_fg,
   MAX(COALESCE(V01.gk_fg, 0)) AS gk_fg,
   MAX(CONCAT(CASE
      WHEN V01.multi_offer_id_fg <> 0
      THEN '| Multi-offer '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_fg <> 0
      THEN '| Fixmenge '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_wfl_fg <> 0
      THEN '| Fixmenge WFL '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.gk_fg, 0) <> 0
      THEN '| GK '
      ELSE ''
      END, CASE
      WHEN V01.mindestplatzierung_fg <> 0
      THEN '| Mindestplatzierung '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.kundenkarte_personalisiert_fg, 0) <> 0
      THEN '| Kundenkarte Personalisiert '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.bonuskauf_fg, 0) <> 0
      THEN '| Bonuskauf '
      ELSE ''
      END, CASE
      WHEN v101.werbeflaechenabschnitt_wfl_bez_ <> ''
      THEN CONCAT('| ', v101.werbeflaechenabschnitt_wfl_bez_, ' ')
      ELSE ''
      END, CASE
      WHEN v102.werbemittel_wfl_bez_ <> ''
      THEN CONCAT('| ', v102.werbemittel_wfl_bez_, ' ')
      ELSE ''
      END, CASE
      WHEN v103.werbeflaechenthema_wfl_bez <> ''
      THEN CONCAT('| ', v103.werbeflaechenthema_wfl_bez, ' ')
      ELSE ''
      END, CASE
      WHEN V01.lokale_geschaeftsvorfall_bez <> ''
      THEN CONCAT('| ', V01.lokale_geschaeftsvorfall_bez, ' ')
      ELSE ''
      END)) AS compound_fg,
   MAX(CONCAT(CASE
      WHEN V01.multi_offer_id_fg <> 0
      THEN '| Multi-offer '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_fg <> 0
      THEN '| Fixmenge '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_wfl_fg <> 0
      THEN '| Fixmenge WFL '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.gk_fg, 0) <> 0
      THEN '| GK '
      ELSE ''
      END, CASE
      WHEN V01.mindestplatzierung_fg <> 0
      THEN '| Mindestplatzierung '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.kundenkarte_personalisiert_fg, 0) <> 0
      THEN '| Kundenkarte Personalisiert '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.bonuskauf_fg, 0) <> 0
      THEN '| Bonuskauf '
      ELSE ''
      END, CASE
      WHEN v101.werbeflaechenabschnitt_wfl_bez_ <> ''
      THEN CONCAT('| ', v101.werbeflaechenabschnitt_wfl_bez_, ' ')
      ELSE ''
      END, CASE
      WHEN v102.werbemittel_wfl_bez_ <> ''
      THEN CONCAT('| ', v102.werbemittel_wfl_bez_, ' ')
      ELSE ''
      END, CASE
      WHEN v103.werbeflaechenthema_wfl_bez <> ''
      THEN CONCAT('| ', v103.werbeflaechenthema_wfl_bez, ' ')
      ELSE ''
      END, CASE
      WHEN V01.lokale_geschaeftsvorfall_bez <> ''
      THEN CONCAT('| ', V01.lokale_geschaeftsvorfall_bez, ' ')
      ELSE ''
      END)) AS compound_fg_de,
   MAX(CONCAT(CASE
      WHEN V01.multi_offer_id_fg <> 0
      THEN '| Multi-offer '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_fg <> 0
      THEN '| Fixmenge '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_wfl_fg <> 0
      THEN '| Fixmenge WFL '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.gk_fg, 0) <> 0
      THEN '| GK '
      ELSE ''
      END, CASE
      WHEN V01.mindestplatzierung_fg <> 0
      THEN '| Mindestplatzierung '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.kundenkarte_personalisiert_fg, 0) <> 0
      THEN '| Kundenkarte Personalisiert '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.bonuskauf_fg, 0) <> 0
      THEN '| Bonuskauf '
      ELSE ''
      END, CASE
      WHEN v101.werbeflaechenabschnitt_wfl_bez_cz <> ''
      THEN CONCAT('| ', v101.werbeflaechenabschnitt_wfl_bez_cz, ' ')
      ELSE ''
      END, CASE
      WHEN v102.werbemittel_wfl_bez_cz <> ''
      THEN CONCAT('| ', v102.werbemittel_wfl_bez_cz, ' ')
      ELSE ''
      END, CASE
      WHEN v103.werbeflaechenthema_wfl_bez <> ''
      THEN CONCAT('| ', v103.werbeflaechenthema_wfl_bez, ' ')
      ELSE ''
      END, CASE
      WHEN V01.lokale_geschaeftsvorfall_bez <> ''
      THEN CONCAT('| ', V01.lokale_geschaeftsvorfall_bez, ' ')
      ELSE ''
      END)) AS compound_fg_cz,
   MAX(CONCAT(CASE
      WHEN V01.multi_offer_id_fg <> 0
      THEN '| Multi-offer '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_fg <> 0
      THEN '| Fixmenge '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_wfl_fg <> 0
      THEN '| Fixmenge WFL '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.gk_fg, 0) <> 0
      THEN '| GK '
      ELSE ''
      END, CASE
      WHEN V01.mindestplatzierung_fg <> 0
      THEN '| Mindestplatzierung '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.kundenkarte_personalisiert_fg, 0) <> 0
      THEN '| Kundenkarte Personalisiert '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.bonuskauf_fg, 0) <> 0
      THEN '| Bonuskauf '
      ELSE ''
      END, CASE
      WHEN v101.werbeflaechenabschnitt_wfl_bez_sk <> ''
      THEN CONCAT('| ', v101.werbeflaechenabschnitt_wfl_bez_sk, ' ')
      ELSE ''
      END, CASE
      WHEN v102.werbemittel_wfl_bez_sk <> ''
      THEN CONCAT('| ', v102.werbemittel_wfl_bez_sk, ' ')
      ELSE ''
      END, CASE
      WHEN v103.werbeflaechenthema_wfl_bez <> ''
      THEN CONCAT('| ', v103.werbeflaechenthema_wfl_bez, ' ')
      ELSE ''
      END, CASE
      WHEN V01.lokale_geschaeftsvorfall_bez <> ''
      THEN CONCAT('| ', V01.lokale_geschaeftsvorfall_bez, ' ')
      ELSE ''
      END)) AS compound_fg_sk,
   MAX(CONCAT(CASE
      WHEN V01.multi_offer_id_fg <> 0
      THEN '| Multi-offer '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_fg <> 0
      THEN '| Fixmenge '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_wfl_fg <> 0
      THEN '| Fixmenge WFL '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.gk_fg, 0) <> 0
      THEN '| GK '
      ELSE ''
      END, CASE
      WHEN V01.mindestplatzierung_fg <> 0
      THEN '| Mindestplatzierung '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.kundenkarte_personalisiert_fg, 0) <> 0
      THEN '| Kundenkarte Personalisiert '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.bonuskauf_fg, 0) <> 0
      THEN '| Bonuskauf '
      ELSE ''
      END, CASE
      WHEN v101.werbeflaechenabschnitt_wfl_bez_hr <> ''
      THEN CONCAT('| ', v101.werbeflaechenabschnitt_wfl_bez_hr, ' ')
      ELSE ''
      END, CASE
      WHEN v102.werbemittel_wfl_bez_hr <> ''
      THEN CONCAT('| ', v102.werbemittel_wfl_bez_hr, ' ')
      ELSE ''
      END, CASE
      WHEN v103.werbeflaechenthema_wfl_bez <> ''
      THEN CONCAT('| ', v103.werbeflaechenthema_wfl_bez, ' ')
      ELSE ''
      END, CASE
      WHEN V01.lokale_geschaeftsvorfall_bez <> ''
      THEN CONCAT('| ', V01.lokale_geschaeftsvorfall_bez, ' ')
      ELSE ''
      END)) AS compound_fg_hr,
   MAX(CONCAT(CASE
      WHEN V01.multi_offer_id_fg <> 0
      THEN '| Multi-offer '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_fg <> 0
      THEN '| Fixmenge '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_wfl_fg <> 0
      THEN '| Fixmenge WFL '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.gk_fg, 0) <> 0
      THEN '| GK '
      ELSE ''
      END, CASE
      WHEN V01.mindestplatzierung_fg <> 0
      THEN '| Mindestplatzierung '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.kundenkarte_personalisiert_fg, 0) <> 0
      THEN '| Kundenkarte Personalisiert '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.bonuskauf_fg, 0) <> 0
      THEN '| Bonuskauf '
      ELSE ''
      END, CASE
      WHEN v101.werbeflaechenabschnitt_wfl_bez_pl <> ''
      THEN CONCAT('| ', v101.werbeflaechenabschnitt_wfl_bez_pl, ' ')
      ELSE ''
      END, CASE
      WHEN v102.werbemittel_wfl_bez_pl <> ''
      THEN CONCAT('| ', v102.werbemittel_wfl_bez_pl, ' ')
      ELSE ''
      END, CASE
      WHEN v103.werbeflaechenthema_wfl_bez <> ''
      THEN CONCAT('| ', v103.werbeflaechenthema_wfl_bez, ' ')
      ELSE ''
      END, CASE
      WHEN V01.lokale_geschaeftsvorfall_bez <> ''
      THEN CONCAT('| ', V01.lokale_geschaeftsvorfall_bez, ' ')
      ELSE ''
      END)) AS compound_fg_pl,
   MAX(CONCAT(CASE
      WHEN V01.multi_offer_id_fg <> 0
      THEN '| Multi-offer '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_fg <> 0
      THEN '| Fixmenge '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_wfl_fg <> 0
      THEN '| Fixmenge WFL '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.gk_fg, 0) <> 0
      THEN '| GK '
      ELSE ''
      END, CASE
      WHEN V01.mindestplatzierung_fg <> 0
      THEN '| Mindestplatzierung '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.kundenkarte_personalisiert_fg, 0) <> 0
      THEN '| Kundenkarte Personalisiert '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.bonuskauf_fg, 0) <> 0
      THEN '| Bonuskauf '
      ELSE ''
      END, CASE
      WHEN v101.werbeflaechenabschnitt_wfl_bez_ro <> ''
      THEN CONCAT('| ', v101.werbeflaechenabschnitt_wfl_bez_ro, ' ')
      ELSE ''
      END, CASE
      WHEN v102.werbemittel_wfl_bez_ro <> ''
      THEN CONCAT('| ', v102.werbemittel_wfl_bez_ro, ' ')
      ELSE ''
      END, CASE
      WHEN v103.werbeflaechenthema_wfl_bez <> ''
      THEN CONCAT('| ', v103.werbeflaechenthema_wfl_bez, ' ')
      ELSE ''
      END, CASE
      WHEN V01.lokale_geschaeftsvorfall_bez <> ''
      THEN CONCAT('| ', V01.lokale_geschaeftsvorfall_bez, ' ')
      ELSE ''
      END)) AS compound_fg_ro,
   MAX(CONCAT(CASE
      WHEN V01.multi_offer_id_fg <> 0
      THEN '| Multi-offer '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_fg <> 0
      THEN '| Fixmenge '
      ELSE ''
      END, CASE
      WHEN V01.fixmenge_wfl_fg <> 0
      THEN '| Fixmenge WFL '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.gk_fg, 0) <> 0
      THEN '| GK '
      ELSE ''
      END, CASE
      WHEN V01.mindestplatzierung_fg <> 0
      THEN '| Mindestplatzierung '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.kundenkarte_personalisiert_fg, 0) <> 0
      THEN '| Kundenkarte Personalisiert '
      ELSE ''
      END, CASE
      WHEN COALESCE(V01.bonuskauf_fg, 0) <> 0
      THEN '| Bonuskauf '
      ELSE ''
      END, CASE
      WHEN v101.werbeflaechenabschnitt_wfl_bez_bg <> ''
      THEN CONCAT('| ', v101.werbeflaechenabschnitt_wfl_bez_bg, ' ')
      ELSE ''
      END, CASE
      WHEN v102.werbemittel_wfl_bez_bg <> ''
      THEN CONCAT('| ', v102.werbemittel_wfl_bez_bg, ' ')
      ELSE ''
      END, CASE
      WHEN v103.werbeflaechenthema_wfl_bez <> ''
      THEN CONCAT('| ', v103.werbeflaechenthema_wfl_bez, ' ')
      ELSE ''
      END, CASE
      WHEN V01.lokale_geschaeftsvorfall_bez <> ''
      THEN CONCAT('| ', V01.lokale_geschaeftsvorfall_bez, ' ')
      ELSE ''
      END)) AS compound_fg_bg,
   MAX(COALESCE(V01.lokale_geschaeftsvorfall_bez, '')) AS lokale_geschaeftsvorfall_bez,
   MAX(V01.vk_aktion_brutto) AS vk_aktion_brutto,
   MAX(prices_ref.vk_aktion_brutto_ref_concat) AS vk_aktion_brutto_ref_concat,
   MAX(prices_ref.preisnachlass_ref_concat) AS preisnachlass_ref_concat,
   MAX(V01.vk_vor_aktion_brutto) AS vk_vor_aktion_brutto,
   MAX(V01.anz_art_in_gruppe) AS anz_art_in_gruppe,
   COUNT(DISTINCT V01.wup_id) AS count_maerkte_vergleich,
   V01.kjwo_von AS kjwo_hist_aktion,
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
   ROW_NUMBER() OVER (PARTITION BY V01.art_id, V01.wup_id, V01.dat_von, V01.kjwo_von ORDER BY V01.aktion_id NULLS LAST)
   AS aktion_rank
  FROM kfl_production_dbp_view.v_wbs_art_aktion_per_1 AS V01
   INNER JOIN kfl_production_dbp_view.v_wup_1 AS V05 ON V01.mandant_id = V05.mandant_id AND V01.wup_id = V05.wup_id AND (V05
        .nb_id IN (2, 0, -111) AND V05.wup_id > 0 OR V05.nb_id = -1 AND V05.wup_id = 0)
   INNER JOIN kfl_production_dbp_view.v_art_1 AS A ON V01.art_id = A.art_id AND V01.mandant_id = A.mandant_id
   LEFT JOIN (SELECT mandant_id,
     art_id,
     aktion_id,
     ARRAY_TO_STRING(ARRAY_AGG(DISTINCT CAST(vk_aktion_brutto_ref AS STRING) ORDER BY CAST(vk_aktion_brutto_ref AS STRING)
        ), '|') AS vk_aktion_brutto_ref_concat,
     ARRAY_TO_STRING(ARRAY_AGG(DISTINCT CONCAT(ROUND((1 - IF(vk_vor_aktion_brutto = 0, 0, SAFE_DIVIDE(vk_aktion_brutto_ref
              , vk_vor_aktion_brutto))) * 100, 2), '%') ORDER BY CONCAT(ROUND((1 - IF(vk_vor_aktion_brutto = 0, 0,
              SAFE_DIVIDE(vk_aktion_brutto_ref, vk_vor_aktion_brutto))) * 100, 2), '%')), '|') AS
     preisnachlass_ref_concat
    FROM PRICES_REF
    GROUP BY mandant_id,
     art_id,
     aktion_id) AS prices_ref ON V01.mandant_id = prices_ref.mandant_id AND V01.art_id = prices_ref.art_id AND V01.aktion_id
      = prices_ref.aktion_id
   LEFT JOIN PRICE_NORMAL AS t11 ON V01.mandant_id = t11.mandant_id AND V01.art_id = t11.art_id AND V01.aktion_id = t11
     .aktion_id
   INNER JOIN ACT_PROM_ART_REF AS v011 ON V01.mandant_id = v011.mandant_id AND V01.art_id = v011.art_id_ref
   LEFT JOIN kfl_production_dbp_view.v_werbung_kennzahlen_woche_1 AS WKW1 ON V01.mandant_id = WKW1.mandant_id AND V01.art_id
        = WKW1.art_id AND V01.wup_id = WKW1.wup_id AND V01.kjwo_von = WKW1.kjwo
   LEFT JOIN kfl_production_dbp_view.v_werbewoche_kl_1 AS V09 ON V01.mandant_id = V09.mandant_id AND V01.dat_von = V09.dat
     
   LEFT JOIN (SELECT DISTINCT V7.mandant_id,
     V7.art_id,
     V7.wup_id,
     V7.nb_id,
     V7.angebot_nr,
     V7A.aktion_id
    FROM kfl_production_dbp_view.v_angebot_art_wup_zu_1 AS V7
     INNER JOIN kfl_production_dbp_view.v_angebot_1 AS V7A ON V7.mandant_id = V7A.mandant_id AND V7.angebot_nr = V7A.angebot_nr
       ) AS v7 ON V01.mandant_id = v7.mandant_id AND V01.art_id = v7.art_id AND V01.wup_id = v7.wup_id AND V01.nb_id =
      v7.nb_id AND V01.aktion_id = v7.aktion_id
   LEFT JOIN (SELECT ROUND(SAFE_CAST(V10.angebot_nr AS BIGNUMERIC), 0) AS angebot_id,
     V10.mandant_id,
     STRING_AGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_, '| ') AS werbeflaechenabschnitt_wfl_bez_,
     STRING_AGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_de, '| ') AS werbeflaechenabschnitt_wfl_bez_de,
     STRING_AGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_cz, '| ') AS werbeflaechenabschnitt_wfl_bez_cz,
     STRING_AGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_sk, '| ') AS werbeflaechenabschnitt_wfl_bez_sk,
     STRING_AGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_hr, '| ') AS werbeflaechenabschnitt_wfl_bez_hr,
     STRING_AGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_pl, '| ') AS werbeflaechenabschnitt_wfl_bez_pl,
     STRING_AGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_ro, '| ') AS werbeflaechenabschnitt_wfl_bez_ro,
     STRING_AGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_bg, '| ') AS werbeflaechenabschnitt_wfl_bez_bg
    FROM kfl_production_dbp_view.v_angebot_werbemittel_promotion_event_zu_1 AS V10
     INNER JOIN WERBEFLAECHENABSCHNITT_SPR AS v10a ON TRIM(REGEXP_EXTRACT(V10.werbeflaechenabschnitt_name, '^[^\\(]+'))
      = v10a.werbeflaechenabschnitt_name
    GROUP BY V10.angebot_nr,
     V10.mandant_id) AS v101 ON V01.mandant_id = v101.mandant_id AND ROUND(SAFE_CAST(v7.angebot_nr AS BIGNUMERIC), 0) =
     v101.angebot_id
   LEFT JOIN (SELECT ROUND(SAFE_CAST(V100.angebot_nr AS BIGNUMERIC), 0) AS angebot_id,
     V100.mandant_id,
     STRING_AGG(DISTINCT v10b.werbemittel_wfl_bez_, '| ') AS werbemittel_wfl_bez_,
     STRING_AGG(DISTINCT v10b.werbemittel_wfl_bez_de, '| ') AS werbemittel_wfl_bez_de,
     STRING_AGG(DISTINCT v10b.werbemittel_wfl_bez_cz, '| ') AS werbemittel_wfl_bez_cz,
     STRING_AGG(DISTINCT v10b.werbemittel_wfl_bez_sk, '| ') AS werbemittel_wfl_bez_sk,
     STRING_AGG(DISTINCT v10b.werbemittel_wfl_bez_hr, '| ') AS werbemittel_wfl_bez_hr,
     STRING_AGG(DISTINCT v10b.werbemittel_wfl_bez_pl, '| ') AS werbemittel_wfl_bez_pl,
     STRING_AGG(DISTINCT v10b.werbemittel_wfl_bez_ro, '| ') AS werbemittel_wfl_bez_ro,
     STRING_AGG(DISTINCT v10b.werbemittel_wfl_bez_bg, '| ') AS werbemittel_wfl_bez_bg
    FROM kfl_production_dbp_view.v_angebot_werbemittel_promotion_event_zu_1 AS V100
     INNER JOIN WERBEMITTEL_SPR AS v10b ON V100.werbemittelkanal_id = CAST(v10b.werbemittelkanal_id AS FLOAT64) AND V100
       .werbemittel_id = CAST(v10b.werbemittel_id AS FLOAT64)
    GROUP BY V100.angebot_nr,
     V100.mandant_id) AS v102 ON V01.mandant_id = v102.mandant_id AND ROUND(SAFE_CAST(v7.angebot_nr AS BIGNUMERIC), 0) =
     v102.angebot_id
   LEFT JOIN (SELECT ROUND(SAFE_CAST(V101.angebot_nr AS BIGNUMERIC), 0) AS angebot_id,
     V101.mandant_id,
     STRING_AGG(DISTINCT V10C.werbeflaechenthema_wfl_bez, '| ') AS werbeflaechenthema_wfl_bez
    FROM kfl_production_dbp_view.v_angebot_werbemittel_promotion_event_zu_1 AS V101
     INNER JOIN kfl_production_dbp_view.v_l_werbeflaechenthema_1 AS V10C ON V101.mandant_id = V10C.mandant_id AND V101.werbeflaechenthema_cd
        = V10C.werbeflaechenthema_cd
    GROUP BY V101.angebot_nr,
     V101.mandant_id) AS v103 ON V01.mandant_id = v103.mandant_id AND ROUND(SAFE_CAST(v7.angebot_nr AS BIGNUMERIC), 0) =
     v103.angebot_id
   LEFT JOIN kfl_production_dbp_view.v_tag_1 AS V02 ON V01.dat_von = V02.dat
  WHERE V02.akt_kj >= -2
  GROUP BY V01.mandant_id,
   V01.wup_id,
   wup_id_,
   V01.nb_id,
   V01.art_id,
   A.kl_art_id,
   V01.aktion_dauer,
   V01.aktion_id,
   kjwo_hist_aktion,
   V09.kjwo_ww,
   V01.dat_von,
   V01.dat_bis,
   V01.wtag_id_von,
   V01.mutter_wb_id,
   V02.kjwo,
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
   wbs_art_id);

