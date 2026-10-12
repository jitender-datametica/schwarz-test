CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_wbs_werbeaenderungen_2 (mandant_id, aktion_id, offer_id, wup_id
, art_id, art_id_display, art_id_vkset, dat_beladung, mandant_id_vz, wup_id_vz, nb_id, nb_id_vz, dat_ab, dat_bis, kjwo,
kjwo_ww, ausliefergruppe_id, wbs_phase_id, gp_id, gk_fg, fachboden_fg, titel_fg, rueckseite_fg, erste_seite_fg, kasse_fg
, tv_fg, neuer_artikel_fg, preis_normal, preis_aktion, anz_tage_werbung, tage_bis_bestellung_lieferant,
tage_bis_deadline_print, tage_bis_initiale_belieferung, anz_werbeaenderungen_aufg, anz_werbeaenderungen_nach_print,
werbeaenderung_angebotspreisreduktion_fg, werbeaenderung_angebotspreiserhoehung_fg,
werbeaenderung_normalpreisreduktion_fg, werbeaenderung_normalpreiserhoehung_fg, werbeaenderung_artikelneuanlage_fg,
werbeaenderung_artikelentfernung_fg, werbeaenderung_marktanzahlerhoehung_fg, werbeaenderung_marktanzahlreduktion_fg,
werbeaenderung_abbildungsaenderung_fg, werbeaenderung_radio_tv_billboard_fg, werbeaenderung_kolliinhaltsaenderung_fg,
werbeaenderung_werbethema_fg, werbeaenderung_sonstiges_fg, werbeaenderung_bonuskauf_promotionstyp_fg,
mindestplatzierung_fg, best_generiert_fg, hohe_mengenaenderung_fg, geringe_mengenaenderung_fg, gesteuerte_prognose_fg,
menge_mindestplatzierung_bme, fixmenge_fg, fixmenge_bme, mindestmenge_fg, mindestmenge_bme, maximalmenge_fg,
maximalmenge_bme, bestand_wup_bme, offene_bestellungen_bme, order_forecast_bme, projizierter_bestand_vor_werbung_bme,
durchschnittlicher_abverkauf_bme, prognose_werbezeitraum_bme, anteil_wup_artikel_perc, bedarf_bme, bedarf_ame,
bedarf_pal, zielbestand_bme, bestellmenge_final_ame, bestellmenge_final_pal, bestellmenge_ohne_bestand_ame,
bestellmenge_ohne_bestand_pal, bestellmenge_mit_bestand_ame, bestellmenge_mit_bestand_pal, preis_nachlass_perc,
werbung_in_x_tagen, multi_offer_id_fg, werbeaenderung_menge_vorlauf, mhd_zeitraum, lager_prozent, fixmenge_wfl_fg,
fixmenge_wfl_bme, preis_normal_vorlauf, preis_aktion_vorlauf, top_gk_fg, bestand_vz, blockierter_bestand_vz,
final_verfuegbarer_bestand_vz, bestellung_lieferant_menge, bestellung_lieferant_fg, stille_aktion_fg,
prognose_ungesteuert, menge_zuletzt_dc_promo, werbelistung_fg, werbelistung_aenderung_fg,
aktion_reihenfolge_aenderung_fg, aktion_reihenfolge_zukunft_nr, referenzmarkt_fallback_fg, listung_dat_von,
listung_dat_bis, listung_dat_bis_vz, gp_id_aenderung_fg, konditionsart_zar5_gueltigkeit_aenderung_fg,
posten_kz_sap_aenderung_fg, saison_id, saison_id_aenderung_fg, best_menge_einh_id_aenderung_fg, rabattaenderung_fg,
abbildung_vortag_id, werbethema_vortag_bez, dispomerkmal, rank_aktion_beladung, anzahl_artikelentfernung,
anzahl_artikelneuanlage, anzahl_wup, artikelentfernung_art_fg, artikelneuanlage_art_fg, compound_fg, compound_fg_de,
compound_fg_cz, compound_fg_sk, compound_fg_hr, compound_fg_pl, compound_fg_ro, compound_fg_bg,
werbeaenderung_kundenkarte_personalisiert_fg, outlier_fg, z_score, art_id_ref, wup_id_ref, nb_id_ref, faktor_ref,
anz_angebote_zeitraum, anz_angebote_zeitraum_aenderung_fg, fixmenge_wfl_aenderung_fg, fixmenge_ek_aenderung_fg,
wfl_geprueft_fg, wfl_nutzer_kommentar_txt, min_sicherh_bestand, estimation_id, estimation_id_aenderung_fg,
menge_kolliinhalt_vortag_bme, fixmenge_ek_vortag_bme, fixmenge_wfl_vortag_bme, vortag_aktion_reihenfolge_zukunft_nr,
utp_relevant_aenderung_fg, utp_relevant_fg, dat_gueltig_von_konditionsart_zar5, dat_gueltig_bis_konditionsart_zar5,
utp_lieferant_bestaetigt_fg, wfl_menge_geprueft_reset_fg, kundenkarte_personalisiert_fg, pmr_werbethema_id,
bedarf_estimation_2_bme, bestellmenge_estimation_2_ohne_bestand_ame, bestellmenge_estimation_2_mit_bestand_ame,
kollifaktor, bonuskauf_promotionstyp_liste_txt) AS WITH GESCHAEFTSVORFALL_SPR AS (SELECT mandant_id,
   geschaeftsvorfall_id,
   MAX(CASE
     WHEN spr_id = 22
     THEN geschaeftsvorfall_bez
     ELSE NULL
     END) AS geschaeftsvorfall_bez_,
   MAX(CASE
     WHEN spr_id = 22
     THEN geschaeftsvorfall_bez
     ELSE NULL
     END) AS geschaeftsvorfall_bez_de,
   COALESCE(MAX(CASE
      WHEN spr_id = 124
      THEN geschaeftsvorfall_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN geschaeftsvorfall_bez
      ELSE NULL
      END)) AS geschaeftsvorfall_bez_cz,
   COALESCE(MAX(CASE
      WHEN spr_id = 108
      THEN geschaeftsvorfall_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN geschaeftsvorfall_bez
      ELSE NULL
      END)) AS geschaeftsvorfall_bez_sk,
   COALESCE(MAX(CASE
      WHEN spr_id = 65
      THEN geschaeftsvorfall_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN geschaeftsvorfall_bez
      ELSE NULL
      END)) AS geschaeftsvorfall_bez_hr,
   COALESCE(MAX(CASE
      WHEN spr_id = 90
      THEN geschaeftsvorfall_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN geschaeftsvorfall_bez
      ELSE NULL
      END)) AS geschaeftsvorfall_bez_pl,
   COALESCE(MAX(CASE
      WHEN spr_id = 95
      THEN geschaeftsvorfall_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN geschaeftsvorfall_bez
      ELSE NULL
      END)) AS geschaeftsvorfall_bez_ro,
   COALESCE(MAX(CASE
      WHEN spr_id = 18
      THEN geschaeftsvorfall_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN geschaeftsvorfall_bez
      ELSE NULL
      END)) AS geschaeftsvorfall_bez_bg
  FROM kfl_production_dbp_view.v_geschaeftsvorfall_spr_zu_2 AS V01
  GROUP BY geschaeftsvorfall_id,
   mandant_id), WERBEFLAECHENABSCHNITT_SPR AS (SELECT werbeflaechenabschnitt_id,
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
  FROM kfl_production_dbp_view.v_werbeflaechenabschnitt_spr_zu_2 AS V01
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
  FROM kfl_production_dbp_view.v_werbemittel_spr_zu_2 AS V01
  GROUP BY werbemittelkanal_id,
   werbemittel_id) (-- Dispomerkmal Markt wg. MD/RO Problematik

  -- INC4967674 Bestimmen welcher der letzte Datensatz ist

  -- INC5107687 Nur auf ART_2 & Mandant_2 -> Letzte Eintrag pro Artikel_2 finden

  -- Auf Artikelebene Berechnen ob Artikel_2 komplett neu/entfernt wird

  -- , COUNT(v1.wup_id) OVER (PARTITION BY v1.mandant_id_vz, v1.ART_ID, v1.aktion_id, v1.dat_beladung) AS Anzahl_WUP

  SELECT V1.mandant_id,
   V1.aktion_id,
   V1.offer_id,
   V05.aktuell_wup_id AS wup_id,
   V1.art_id,
    CASE
    WHEN V2.artikeltyp_id = 12
    THEN V1.art_id
    ELSE CASE
     WHEN V3.artikeltyp_id = 12
     THEN V1.art_id_mutter
     ELSE NULL
     END
    END AS art_id_display,
    CASE
    WHEN V2.artikeltyp_id = 10
    THEN V1.art_id
    ELSE CASE
     WHEN V3.artikeltyp_id = 10
     THEN V1.art_id_mutter
     ELSE NULL
     END
    END AS art_id_vkset,
   V1.dat_beladung,
    CASE
    WHEN V1.wup_id_vz = 6140
    THEN 4
    ELSE V1.mandant_id_vz
    END AS mandant_id_vz,
   V1.wup_id_vz,
   V1.nb_id,
   V1.nb_id_vz,
   V1.dat_ab,
   V1.dat_bis,
   V1.kjwo,
   V9.kjwo_ww,
   COALESCE(V1.ausliefergruppe_id, ' ') AS ausliefergruppe_id,
   V1.wbs_phase_id,
   COALESCE(CASE
     WHEN V1.gp_id = 0
     THEN CAST(- 1 AS BIGNUMERIC)
     ELSE V1.gp_id
     END, - 1) AS gp_id_,
   V1.gk_fg,
   V1.fachboden_fg,
   V1.titel_fg,
   V1.rueckseite_fg,
   V1.erste_seite_fg,
   V1.kasse_fg,
   V1.tv_fg,
   V1.neuer_artikel_fg,
   V1.preis_normal,
   V1.preis_aktion,
   V1.anz_tage_werbung,
   V1.tage_bis_bestellung_lieferant,
   V1.tage_bis_deadline_print,
   V1.tage_bis_initiale_belieferung,
   V1.anz_werbeaenderungen_aufg,
   V1.anz_werbeaenderungen_nach_print,
   V1.werbeaenderung_angebotspreisreduktion_fg,
   V1.werbeaenderung_angebotspreiserhoehung_fg,
   V1.werbeaenderung_normalpreisreduktion_fg,
   V1.werbeaenderung_normalpreiserhoehung_fg,
   V1.werbeaenderung_artikelneuanlage_fg,
   V1.werbeaenderung_artikelentfernung_fg,
   V1.werbeaenderung_marktanzahlerhoehung_fg,
   V1.werbeaenderung_marktanzahlreduktion_fg,
   V1.werbeaenderung_abbildungsaenderung_fg,
   V1.werbeaenderung_radio_tv_billboard_fg,
   V1.werbeaenderung_kolliinhaltsaenderung_fg,
   V1.werbeaenderung_werbethema_fg,
   V1.werbeaenderung_sonstiges_fg,
   COALESCE(V1.werbeaenderung_bonuskauf_promotionstyp_fg, 0),
   V1.mindestplatzierung_fg,
   V1.best_generiert_fg,
   V1.hohe_mengenaenderung_fg,
   V1.geringe_mengenaenderung_fg,
   V1.gesteuerte_prognose_fg,
   V1.menge_mindestplatzierung_bme,
   V1.fixmenge_fg,
   V1.fixmenge_bme,
   V1.mindestmenge_fg,
   V1.mindestmenge_bme,
   V1.maximalmenge_fg,
   V1.maximalmenge_bme,
   V1.bestand_wup_bme,
   V1.offene_bestellungen_bme,
   V1.order_forecast_bme,
   V1.projizierter_bestand_vor_werbung_bme,
   V1.durchschnittlicher_abverkauf_bme,
   V1.prognose_werbezeitraum_bme,
   V1.anteil_wup_artikel_perc,
   V1.bedarf_bme,
   V1.bedarf_ame,
   V1.bedarf_pal,
   V1.zielbestand_bme,
   0 AS bestellmenge_final_ame,
   0 AS bestellmenge_final_pal,
   V1.bestellmenge_ohne_bestand_ame,
   V1.bestellmenge_ohne_bestand_pal,
   V1.bestellmenge_mit_bestand_ame,
   V1.bestellmenge_mit_bestand_pal,
   V1.preis_nachlass_perc,
   DATE_DIFF(V1.dat_beladung, V1.dat_ab, DAY) AS werbung_in_x_tagen,
   V1.multi_offer_id_fg,
   V1.werbeaenderung_menge_vorlauf,
   V2.mhd_zeitraum,
   V2.lager_prozent,
   V1.fixmenge_wfl_fg,
   V1.fixmenge_wfl_bme,
   V1.preis_normal_vorlauf,
   V1.preis_aktion_vorlauf,
   V1.top_gk_fg,
   V1.bestand_vz,
   V1.blockierter_bestand_vz,
   V1.final_verfuegbarer_bestand_vz,
   V1.bestellung_lieferant_menge,
   V1.bestellung_lieferant_fg,
   V1.stille_aktion_fg,
   V1.prognose_ungesteuert,
   V1.menge_zuletzt_dc_promo,
   V1.werbelistung_fg,
   V1.werbelistung_aenderung_fg,
   COALESCE(V1.aktion_reihenfolge_aenderung_fg, 0) AS aktion_reihenfolge_aenderung_fg,
   V1.aktion_reihenfolge_zukunft_nr -- Neu, Tabelle noch nicht aktuell auf Q+P, MSI Objekte noch zu bauen

   -- ,v1.pmr_werbethema_id
,
   V1.referenzmarkt_fallback_fg,
   v4.listung_dat_von,
   v4.listung_dat_bis,
   v4a.listung_dat_bis AS listung_dat_bis_vz,
   COALESCE(V1.gp_id_aenderung_fg, 0),
   COALESCE(V1.konditionsart_zar5_gueltigkeit_aenderung_fg, 0),
   COALESCE(V1.posten_kz_sap_aenderung_fg, 0),
   V1.saison_id,
   COALESCE(V1.saison_id_aenderung_fg, 0),
   COALESCE(V1.best_menge_einh_id_aenderung_fg, 0),
   COALESCE(V1.rabattaenderung_fg, 0) AS rabattaenderung_fg,
   COALESCE(V1.abbildung_vortag_id, ' ') AS abbildung_vortag_id,
   COALESCE(V1.werbethema_vortag_bez, ' ') AS werbethema_vortag_bez,
   COALESCE(V5.dispomerkmal, ' ') AS dispomerkmal,
   DENSE_RANK() OVER (PARTITION BY CAST(V1.art_id AS STRING), CAST(V1.mandant_id_vz AS STRING) ORDER BY V1.dat_beladung
      IS NULL, V1.dat_beladung) AS rank_aktion_beladung,
   SUM(V1.werbeaenderung_artikelentfernung_fg) OVER (PARTITION BY CAST(V1.mandant_id_vz AS STRING), CAST(V1.art_id AS STRING)
      , V1.aktion_id, V1.dat_beladung ) AS
   anzahl_artikelentfernung,
   SUM(V1.werbeaenderung_artikelneuanlage_fg) OVER (PARTITION BY CAST(V1.mandant_id_vz AS STRING), CAST(V1.art_id AS STRING)
      , V1.aktion_id, V1.dat_beladung ) AS
   anzahl_artikelneuanlage,
   COUNT(V1.wup_id) OVER (PARTITION BY CAST(V1.art_id AS STRING), CAST(V1.mandant_id AS STRING), V1.dat_ab, V1.dat_bis, CAST(V1.offer_id AS STRING)
      , V1.dat_beladung ) AS anzahl_wup,
   IF((SUM(V1.werbeaenderung_artikelentfernung_fg) OVER (PARTITION BY CAST(V1.mandant_id_vz AS STRING), CAST(V1.art_id AS STRING)
         , V1.aktion_id, V1.dat_beladung )) = (COUNT(V1.wup_id
       ) OVER (PARTITION BY CAST(V1.art_id AS STRING), CAST(V1.mandant_id AS STRING), V1.dat_ab, V1.dat_bis, CAST(V1.offer_id AS STRING)
         , V1.dat_beladung )), 1, 0) AS
   artikelentfernung_art_fg,
   IF((SUM(V1.werbeaenderung_artikelneuanlage_fg) OVER (PARTITION BY CAST(V1.mandant_id_vz AS STRING), CAST(V1.art_id AS STRING)
         , V1.aktion_id, V1.dat_beladung )) = (COUNT(V1.wup_id
       ) OVER (PARTITION BY CAST(V1.art_id AS STRING), CAST(V1.mandant_id AS STRING), V1.dat_ab, V1.dat_bis, CAST(V1.offer_id AS STRING)
         , V1.dat_beladung )), 1, 0) AS artikelneuanlage_art_fg
   ,
   CONCAT(CASE
     WHEN V1.multi_offer_id_fg <> 0
     THEN '| Multi-offer '
     ELSE ''
     END, CASE
     WHEN V1.fixmenge_fg <> 0
     THEN '| Fixmenge '
     ELSE ''
     END, CASE
     WHEN V1.fixmenge_wfl_fg <> 0
     THEN '| Fixmenge WFL '
     ELSE ''
     END, CASE
     WHEN V1.gk_fg <> 0
     THEN '| GK '
     ELSE ''
     END, CASE
     WHEN V1.mindestplatzierung_fg <> 0
     THEN '| Mindestplatzierung '
     ELSE ''
     END, CASE
     WHEN V1.kundenkarte_personalisiert_fg <> 0
     THEN '| Kundenkarte Personalisiert '
     ELSE ''
     END, CASE
     WHEN V7.bonuskauf_fg <> 0
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
     WHEN v7a.geschaeftsvorfall_bez_ <> ''
     THEN CONCAT('| ', v7a.geschaeftsvorfall_bez_, ' ')
     ELSE ''
     END) AS compound_fg,
   CONCAT(CASE
     WHEN V1.multi_offer_id_fg <> 0
     THEN '| Multi-offer '
     ELSE ''
     END, CASE
     WHEN V1.fixmenge_fg <> 0
     THEN '| Fixmenge '
     ELSE ''
     END, CASE
     WHEN V1.fixmenge_wfl_fg <> 0
     THEN '| Fixmenge WFL '
     ELSE ''
     END, CASE
     WHEN V1.gk_fg <> 0
     THEN '| GK '
     ELSE ''
     END, CASE
     WHEN V1.mindestplatzierung_fg <> 0
     THEN '| Mindestplatzierung '
     ELSE ''
     END, CASE
     WHEN V1.kundenkarte_personalisiert_fg <> 0
     THEN '| Kundenkarte Personalisiert '
     ELSE ''
     END, CASE
     WHEN V7.bonuskauf_fg <> 0
     THEN '| Bonuskauf '
     ELSE ''
     END, CASE
     WHEN v101.werbeflaechenabschnitt_wfl_bez_de <> ''
     THEN CONCAT('| ', v101.werbeflaechenabschnitt_wfl_bez_de, ' ')
     ELSE ''
     END, CASE
     WHEN v102.werbemittel_wfl_bez_de <> ''
     THEN CONCAT('| ', v102.werbemittel_wfl_bez_de, ' ')
     ELSE ''
     END, CASE
     WHEN v103.werbeflaechenthema_wfl_bez <> ''
     THEN CONCAT('| ', v103.werbeflaechenthema_wfl_bez, ' ')
     ELSE ''
     END, CASE
     WHEN v7a.geschaeftsvorfall_bez_de <> ''
     THEN CONCAT('| ', v7a.geschaeftsvorfall_bez_de, ' ')
     ELSE ''
     END) AS compound_fg_de,
   CONCAT(CASE
     WHEN V1.multi_offer_id_fg <> 0
     THEN '| Multi-offer '
     ELSE ''
     END, CASE
     WHEN V1.fixmenge_fg <> 0
     THEN '| Fixmenge '
     ELSE ''
     END, CASE
     WHEN V1.fixmenge_wfl_fg <> 0
     THEN '| Fixmenge WFL '
     ELSE ''
     END, CASE
     WHEN V1.gk_fg <> 0
     THEN '| GK '
     ELSE ''
     END, CASE
     WHEN V1.mindestplatzierung_fg <> 0
     THEN '| Mindestplatzierung '
     ELSE ''
     END, CASE
     WHEN V1.kundenkarte_personalisiert_fg <> 0
     THEN '| Kundenkarte Personalisiert '
     ELSE ''
     END, CASE
     WHEN V7.bonuskauf_fg <> 0
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
     WHEN v7a.geschaeftsvorfall_bez_cz <> ''
     THEN CONCAT('| ', v7a.geschaeftsvorfall_bez_cz, ' ')
     ELSE ''
     END) AS compound_fg_cz,
   CONCAT(CASE
     WHEN V1.multi_offer_id_fg <> 0
     THEN '| Multi-offer '
     ELSE ''
     END, CASE
     WHEN V1.fixmenge_fg <> 0
     THEN '| Fixmenge '
     ELSE ''
     END, CASE
     WHEN V1.fixmenge_wfl_fg <> 0
     THEN '| Fixmenge WFL '
     ELSE ''
     END, CASE
     WHEN V1.gk_fg <> 0
     THEN '| GK '
     ELSE ''
     END, CASE
     WHEN V1.mindestplatzierung_fg <> 0
     THEN '| Mindestplatzierung '
     ELSE ''
     END, CASE
     WHEN V1.kundenkarte_personalisiert_fg <> 0
     THEN '| Kundenkarte Personalisiert '
     ELSE ''
     END, CASE
     WHEN V7.bonuskauf_fg <> 0
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
     WHEN v7a.geschaeftsvorfall_bez_sk <> ''
     THEN CONCAT('| ', v7a.geschaeftsvorfall_bez_sk, ' ')
     ELSE ''
     END) AS compound_fg_sk,
   CONCAT(CASE
     WHEN V1.multi_offer_id_fg <> 0
     THEN '| Multi-offer '
     ELSE ''
     END, CASE
     WHEN V1.fixmenge_fg <> 0
     THEN '| Fixmenge '
     ELSE ''
     END, CASE
     WHEN V1.fixmenge_wfl_fg <> 0
     THEN '| Fixmenge WFL '
     ELSE ''
     END, CASE
     WHEN V1.gk_fg <> 0
     THEN '| GK '
     ELSE ''
     END, CASE
     WHEN V1.mindestplatzierung_fg <> 0
     THEN '| Mindestplatzierung '
     ELSE ''
     END, CASE
     WHEN V1.kundenkarte_personalisiert_fg <> 0
     THEN '| Kundenkarte Personalisiert '
     ELSE ''
     END, CASE
     WHEN V7.bonuskauf_fg <> 0
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
     WHEN v7a.geschaeftsvorfall_bez_hr <> ''
     THEN CONCAT('| ', v7a.geschaeftsvorfall_bez_hr, ' ')
     ELSE ''
     END) AS compound_fg_hr,
   CONCAT(CASE
     WHEN V1.multi_offer_id_fg <> 0
     THEN '| Multi-offer '
     ELSE ''
     END, CASE
     WHEN V1.fixmenge_fg <> 0
     THEN '| Fixmenge '
     ELSE ''
     END, CASE
     WHEN V1.fixmenge_wfl_fg <> 0
     THEN '| Fixmenge WFL '
     ELSE ''
     END, CASE
     WHEN V1.gk_fg <> 0
     THEN '| GK '
     ELSE ''
     END, CASE
     WHEN V1.mindestplatzierung_fg <> 0
     THEN '| Mindestplatzierung '
     ELSE ''
     END, CASE
     WHEN V1.kundenkarte_personalisiert_fg <> 0
     THEN '| Kundenkarte Personalisiert '
     ELSE ''
     END, CASE
     WHEN V7.bonuskauf_fg <> 0
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
     WHEN v7a.geschaeftsvorfall_bez_pl <> ''
     THEN CONCAT('| ', v7a.geschaeftsvorfall_bez_pl, ' ')
     ELSE ''
     END) AS compound_fg_pl,
   CONCAT(CASE
     WHEN V1.multi_offer_id_fg <> 0
     THEN '| Multi-offer '
     ELSE ''
     END, CASE
     WHEN V1.fixmenge_fg <> 0
     THEN '| Fixmenge '
     ELSE ''
     END, CASE
     WHEN V1.fixmenge_wfl_fg <> 0
     THEN '| Fixmenge WFL '
     ELSE ''
     END, CASE
     WHEN V1.gk_fg <> 0
     THEN '| GK '
     ELSE ''
     END, CASE
     WHEN V1.mindestplatzierung_fg <> 0
     THEN '| Mindestplatzierung '
     ELSE ''
     END, CASE
     WHEN V1.kundenkarte_personalisiert_fg <> 0
     THEN '| Kundenkarte Personalisiert '
     ELSE ''
     END, CASE
     WHEN V7.bonuskauf_fg <> 0
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
     WHEN v7a.geschaeftsvorfall_bez_ro <> ''
     THEN CONCAT('| ', v7a.geschaeftsvorfall_bez_ro, ' ')
     ELSE ''
     END) AS compound_fg_ro,
   CONCAT(CASE
     WHEN V1.multi_offer_id_fg <> 0
     THEN '| Multi-offer '
     ELSE ''
     END, CASE
     WHEN V1.fixmenge_fg <> 0
     THEN '| Fixmenge '
     ELSE ''
     END, CASE
     WHEN V1.fixmenge_wfl_fg <> 0
     THEN '| Fixmenge WFL '
     ELSE ''
     END, CASE
     WHEN V1.gk_fg <> 0
     THEN '| GK '
     ELSE ''
     END, CASE
     WHEN V1.mindestplatzierung_fg <> 0
     THEN '| Mindestplatzierung '
     ELSE ''
     END, CASE
     WHEN V1.kundenkarte_personalisiert_fg <> 0
     THEN '| Kundenkarte Personalisiert '
     ELSE ''
     END, CASE
     WHEN V7.bonuskauf_fg <> 0
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
     WHEN v7a.geschaeftsvorfall_bez_bg <> ''
     THEN CONCAT('| ', v7a.geschaeftsvorfall_bez_bg, ' ')
     ELSE ''
     END) AS compound_fg_bg,
   COALESCE(V1.werbeaenderung_kundenkarte_personalisiert_fg, 0),
    CASE
    WHEN v8.z_score > 8
    THEN 1
    ELSE 0
    END AS outlier_fg,
   v8.z_score,
   COALESCE(V1.art_id_ref, - 1) AS art_id_ref,
   COALESCE(V1.wup_id_ref, - 1) AS wup_id_ref,
   COALESCE(V1.nb_id_ref, - 1) AS nb_id_ref,
   AVG(COALESCE(V1.faktor_ref, 0)) OVER (PARTITION BY CAST(V1.mandant_id_vz AS STRING), CAST(V1.art_id AS STRING), V1.aktion_id
      , V1.dat_beladung, CAST(V1.art_id_ref AS STRING) ) AS
   faktor_ref,
   V1.anz_angebote_zeitraum,
   COALESCE(V1.anz_angebote_zeitraum_aenderung_fg, - 1),
   COALESCE(V1.fixmenge_wfl_aenderung_fg, - 1),
   COALESCE(V1.fixmenge_ek_aenderung_fg, - 1),
   COALESCE(V1.wfl_menge_geprueft_fg, 0),
    CASE
    WHEN V1.wfl_nutzer_kommentar_txt = '-'
    THEN NULL
    ELSE V1.wfl_nutzer_kommentar_txt
    END,
   V5.min_sicherh_bestand,
   COALESCE(V1.estimation_id, - 1),
   COALESCE(V1.estimation_id_aenderung_fg, - 1),
   COALESCE(V1.menge_kolliinhalt_vortag_bme, - 1),
   V1.fixmenge_ek_vortag_bme,
   V1.fixmenge_wfl_vortag_bme,
   COALESCE(V1.vortag_aktion_reihenfolge_zukunft_nr, - 1),
   COALESCE(V1.utp_relevant_aenderung_fg, - 1),
   COALESCE(V1.utp_relevant_fg, - 1),
   COALESCE(V1.dat_gueltig_von_konditionsart_zar5, DATE '1900-01-01'),
   COALESCE(V1.dat_gueltig_bis_konditionsart_zar5, DATE '1900-01-01'),
   COALESCE(V1.utp_lieferant_bestaetigt_fg, - 1),
   COALESCE(V1.wfl_menge_geprueft_reset_fg, - 1),
   V1.kundenkarte_personalisiert_fg,
   V1.pmr_werbethema_id,
   V1.bedarf_estimation_id_2_bme,
   V1.bestellmenge_estimation_id_2_ohne_bestand_ame,
   V1.bestellmenge_estimation_id_2_mit_bestand_ame,
   V1.kollifaktor,
   V1.bonuskauf_promotionstyp_liste_txt
  FROM kfl_production_dbp_view.v_wbs_werbeaenderungen_2 AS V1
   INNER JOIN kfl_production_dbp_view.v_wup_2 AS V05 ON V1.mandant_id = V05.mandant_id AND V1.wup_id = V05.wup_id AND (V05
        .nb_id IN (2, 0, - 111) AND V05.wup_id > 0 OR V05.nb_id = - 1 AND V05.wup_id = 0)
   LEFT JOIN kfl_production_dbp_view.v_art_2 AS V2 ON V1.mandant_id = V2.mandant_id AND V1.art_id = V2.art_id
   LEFT JOIN kfl_production_dbp_view.v_art_2 AS V3 ON V1.mandant_id = V3.mandant_id AND V1.art_id_mutter = V3.art_id
   LEFT JOIN kfl_production_dbp_view.v_art_wup_status_per_2 AS V5 ON V1.mandant_id = V5.mandant_id AND V1.art_id = V5.art_id
         AND V1.wup_id = V5.wup_id AND V1.nb_id = V5.nb_id AND V1.dat_beladung BETWEEN V5.dat_von AND V5.dat_bis
   LEFT JOIN (SELECT S1.mandant_id,
     S1.art_id,
     S1.wup_id,
     S1.nb_id,
     S1.dat_ab,
     MIN(S2.dat_von) AS listung_dat_von,
     MAX(S2.dat_bis) AS listung_dat_bis
    FROM kfl_production_dbp_view.v_wbs_werbeaenderungen_2 AS S1
     INNER JOIN kfl_production_dbp_view.v_art_list_wup_zu_per_2 AS S2 ON S1.mandant_id = S2.mandant_id AND S1.art_id = S2
           .art_id AND S1.wup_id = S2.wup_id AND S1.nb_id = S2.nb_id AND S1.dat_ab >= S2.dat_von AND S1.dat_bis <= S2.dat_bis
       
    GROUP BY S1.mandant_id,
     S1.wup_id,
     S1.art_id,
     S1.nb_id,
     S1.dat_ab) AS v4 ON V1.mandant_id = v4.mandant_id AND V1.art_id = v4.art_id AND V1.wup_id = v4.wup_id AND V1.nb_id
      = v4.nb_id AND V1.dat_ab = v4.dat_ab
   LEFT JOIN (SELECT CASE
      WHEN S10.wup_id_vz = 6140
      THEN 4
      ELSE S10.mandant_id_vz
      END AS mandant_id_vz_,
     S10.art_id,
     S10.wup_id_vz,
     S10.nb_id_vz,
     S10.dat_ab,
     MIN(S20.dat_von) AS listung_dat_von,
     MAX(S20.dat_bis) AS listung_dat_bis
    FROM kfl_production_dbp_view.v_wbs_werbeaenderungen_2 AS S10
     INNER JOIN kfl_production_dbp_view.v_art_list_wup_zu_per_2 AS S20 ON CASE
            WHEN S10.wup_id_vz = 6140
            THEN 4
            ELSE S10.mandant_id_vz
            END = S20.mandant_id AND S10.art_id = S20.art_id AND S10.wup_id_vz = S20.wup_id AND S10.nb_id_vz = S20.nb_id
          AND S10.dat_ab >= S20.dat_von AND S10.dat_bis <= S20.dat_bis
    GROUP BY mandant_id_vz_,
     S10.art_id,
     S10.wup_id_vz,
     S10.nb_id_vz,
     S10.dat_ab) AS v4a ON CASE
         WHEN V1.wup_id_vz = 6140
         THEN 4
         ELSE V1.mandant_id_vz
         END = v4a.mandant_id_vz_ AND V1.art_id = v4a.art_id AND V1.wup_id_vz = v4a.wup_id_vz AND V1.nb_id_vz = v4a.nb_id_vz
       AND V1.dat_ab = v4a.dat_ab
   LEFT JOIN kfl_production_dbp_view.v_pmr_angebot_art_wup_zu_2 AS V7 ON V1.mandant_id = V7.mandant_id AND V1.art_id = V7
        .art_id AND V1.wup_id = V7.wup_id AND V1.nb_id = V7.nb_id AND V1.offer_id = V7.angebot_id
   LEFT JOIN GESCHAEFTSVORFALL_SPR AS v7a ON V7.mandant_id = v7a.mandant_id AND V7.bonuskauf_geschaeftsvorfall_id = v7a
     .geschaeftsvorfall_id
   LEFT JOIN (SELECT V10.angebot_id,
     V10.mandant_id,
     STRING_AGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_, '| ') AS werbeflaechenabschnitt_wfl_bez_,
     STRING_AGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_de, '| ') AS werbeflaechenabschnitt_wfl_bez_de,
     STRING_AGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_cz, '| ') AS werbeflaechenabschnitt_wfl_bez_cz,
     STRING_AGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_sk, '| ') AS werbeflaechenabschnitt_wfl_bez_sk,
     STRING_AGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_hr, '| ') AS werbeflaechenabschnitt_wfl_bez_hr,
     STRING_AGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_pl, '| ') AS werbeflaechenabschnitt_wfl_bez_pl,
     STRING_AGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_ro, '| ') AS werbeflaechenabschnitt_wfl_bez_ro,
     STRING_AGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_bg, '| ') AS werbeflaechenabschnitt_wfl_bez_bg
    FROM kfl_production_dbp_view.v_pmr_angebot_werbemittel_werbeflaeche_zu_2 AS V10
     INNER JOIN WERBEFLAECHENABSCHNITT_SPR AS v10a ON TRIM(REGEXP_EXTRACT(V10.werbeflaeche_abschnitt_name, '^[^\\(]+'))
      = v10a.werbeflaechenabschnitt_name
    GROUP BY V10.angebot_id,
     V10.mandant_id) AS v101 ON V1.mandant_id = v101.mandant_id AND V1.offer_id = v101.angebot_id
   LEFT JOIN (SELECT V100.angebot_id,
     V100.mandant_id,
     STRING_AGG(DISTINCT v10b.werbemittel_wfl_bez_, '| ') AS werbemittel_wfl_bez_,
     STRING_AGG(DISTINCT v10b.werbemittel_wfl_bez_de, '| ') AS werbemittel_wfl_bez_de,
     STRING_AGG(DISTINCT v10b.werbemittel_wfl_bez_cz, '| ') AS werbemittel_wfl_bez_cz,
     STRING_AGG(DISTINCT v10b.werbemittel_wfl_bez_sk, '| ') AS werbemittel_wfl_bez_sk,
     STRING_AGG(DISTINCT v10b.werbemittel_wfl_bez_hr, '| ') AS werbemittel_wfl_bez_hr,
     STRING_AGG(DISTINCT v10b.werbemittel_wfl_bez_pl, '| ') AS werbemittel_wfl_bez_pl,
     STRING_AGG(DISTINCT v10b.werbemittel_wfl_bez_ro, '| ') AS werbemittel_wfl_bez_ro,
     STRING_AGG(DISTINCT v10b.werbemittel_wfl_bez_bg, '| ') AS werbemittel_wfl_bez_bg
    FROM kfl_production_dbp_view.v_pmr_angebot_werbemittel_werbeflaeche_zu_2 AS V100
     INNER JOIN WERBEMITTEL_SPR AS v10b ON V100.werbemittel_art_id = v10b.werbemittelkanal_id AND V100.werbemittel_id = CAST(v10b.werbemittel_id AS FLOAT64)
       
    GROUP BY V100.angebot_id,
     V100.mandant_id) AS v102 ON V1.mandant_id = v102.mandant_id AND V1.offer_id = v102.angebot_id
   LEFT JOIN (SELECT V101.angebot_id,
     V101.mandant_id,
     STRING_AGG(DISTINCT V10C.werbeflaechenthema_wfl_bez, '| ') AS werbeflaechenthema_wfl_bez
    FROM kfl_production_dbp_view.v_pmr_angebot_werbemittel_werbeflaeche_zu_2 AS V101
     INNER JOIN kfl_production_dbp_view.v_l_werbeflaechenthema_2 AS V10C ON V101.mandant_id = V10C.mandant_id AND V101.werbeflaeche_thema_id
        = V10C.werbeflaechenthema_cd
    GROUP BY V101.angebot_id,
     V101.mandant_id) AS v103 ON V1.mandant_id = v103.mandant_id AND V1.offer_id = v103.angebot_id
   LEFT JOIN (SELECT kjwo,
     dat_ab,
     dat_bis,
     dat_beladung,
     wup_id,
     nb_id,
     art_id,
     mandant_id,
     IF((PERCENTILE_CONT(diff_1,0.5) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(art_id AS STRING), CAST(kjwo AS STRING),
           dat_beladung )) = 0, NULL, PERCENTILE_CONT(diff_1,0.5) OVER (PARTITION BY CAST(mandant_id AS STRING)
         , CAST(art_id AS STRING), CAST(kjwo AS STRING), dat_beladung )) AS median_2,
      0.6745 * diff_1 AS zaehler,
       0.6745 * diff_1 / IF((PERCENTILE_CONT(diff_1,0.5) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(art_id AS STRING), CAST(kjwo AS STRING)
            , dat_beladung )) = 0, NULL, PERCENTILE_CONT(diff_1,0.5) OVER (PARTITION BY CAST(mandant_id AS STRING)
          , CAST(art_id AS STRING), CAST(kjwo AS STRING), dat_beladung )) AS z_score
    FROM (SELECT kjwo,
       wup_id,
       mandant_id,
       nb_id,
       art_id,
       dat_beladung,
       dat_ab,
       dat_bis,
       prognose_werbezeitraum_bme,
       PERCENTILE_CONT(prognose_werbezeitraum_bme,0.5) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(art_id AS STRING), CAST(kjwo AS STRING)
          , dat_beladung ) AS median_1,
       ABS(prognose_werbezeitraum_bme - (PERCENTILE_CONT(prognose_werbezeitraum_bme,0.5) OVER (PARTITION BY CAST(mandant_id AS STRING)
             , CAST(art_id AS STRING), CAST(kjwo AS STRING), dat_beladung ))) AS diff_1
      FROM kfl_production_dbp_view.v_wbs_werbeaenderungen_2
      WHERE prognose_werbezeitraum_bme > 0) AS v8a) AS v8 ON V1.kjwo = v8.kjwo AND V1.dat_ab = v8.dat_ab AND V1.dat_bis
          = v8.dat_bis AND V1.wup_id = v8.wup_id AND V1.nb_id = v8.nb_id AND V1.art_id = v8.art_id AND V1.mandant_id =
      v8.mandant_id AND V1.dat_beladung = v8.dat_beladung
   LEFT JOIN kfl_production_dbp_view.v_werbewoche_kl_2 AS V9 ON V1.mandant_id = V9.mandant_id AND V1.dat_ab = V9.dat
     -- WHERE v1.dat_beladung >= CURRENT_DATE - 140

  WHERE V1.dat_beladung >= DATE_SUB(CURRENT_DATE, INTERVAL 140 DAY) AND V1.mandant_id = 6
   OR V1.dat_beladung >= DATE_SUB(CURRENT_DATE, INTERVAL 60 DAY) AND V1.mandant_id <> 6);


