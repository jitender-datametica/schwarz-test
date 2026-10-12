CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_gp_dispo_tag_2 (mandant_id OPTIONS(description='Mandant_2 im DWH.'),
gp_dispo_id
OPTIONS(description='Lieferant ID Dispo (Surrogate Key). Die gp_id entspricht der Lieferantennummer aus SAP, ist Business key, während gp_dispo_id von SAP täglich neu generiert wird. Gp_dispo_id ändert sich mit jedem Planungslauf. Gp_dispo_id benötigt man um eine_2 Beziehung zwischen SAP und nicht-SAP Daten herstellen zu können und mit anderen Tabellen joinen zu können. '),
art_dispo_id
OPTIONS(description='Artikel_2 ID DIspo (Surrogate Key). Die art_id entspricht der Artikelnummer aus SAP, ist Business key, während art_dispo_id von SAP täglich neu generiert wird. Art_dispo_id ändert sich mit jedem Planungslauf. Art_dispo_id benötigt man um eine_2 Beziehung zwischen SAP und nicht-SAP Daten herstellen zu können und mit anderen Tabellen joinen zu können. '),
art_id OPTIONS(description='Artikelnummer.'), dat_plan OPTIONS(description='Planungsdatum.'), vz_dispo_artikelstatus_id
OPTIONS(description='Artikelstatus im VZ in Bezug auf Disposition.'), dispo_arttyp_id OPTIONS(description='Typ.'),
palettenfaktor OPTIONS(description='Palettenfaktor.'), dat_lief OPTIONS(description='Liefertag.'), menge_gesamt
OPTIONS(description='Menge Gesamt.'), menge_normal OPTIONS(description='Menge Normal.'), menge_bevorratung
OPTIONS(description='Menge Bevorratung.'), menge_iwt OPTIONS(description='Menge IWT.'), menge_werbung
OPTIONS(description='Menge Werbung.'), menge_einh_id OPTIONS(description='Basismengeneinheit.'), lagefaktor
OPTIONS(description='Lage Faktor.'), artikelstatus_betrieb OPTIONS(description='Betriebsspezifischer Artikelstatus.'),
dat_listung_vz_bis OPTIONS(description='VZ Listung bis.'), dat_listung_vz_von OPTIONS(description='VZ Listung ab.'),
dat_raeumen_ab OPTIONS(description='Räumen ab (R).'), werbung_fg OPTIONS(description='Werbung Kennzeichen.'), saison_fg
OPTIONS(description='Saison Kennzeichen.'), saison_id OPTIONS(description='Saison Nummer.'), posten_kz_sap
OPTIONS(description='Postenkennzeichen SAP.'), posten_fg OPTIONS(description='Postenkennzeichen.'), auspackware_fg
OPTIONS(description='Flag: Auspackware.'), einkaeufer_grp_id OPTIONS(description='Einkäufergruppe.'), rlz_vz
OPTIONS(description='RLZ VZ.'), menge_best_min OPTIONS(description='Mindestbestellmenge.'), menge_einh_lam_id
OPTIONS(description='Lagerabgangsmenge (L/A).'), min_sicherh_bestand OPTIONS(description='Mindestsicherheitsbestand.'),
menge_best_max OPTIONS(description='Maximale Bestellmenge.'), umrech_faktor_bme_lam
OPTIONS(description='Faktor BME in L/A.'), umrech_faktor_best_bme
OPTIONS(description='Faktor Bestellmenge in Basis-ME.'), rundungsprofil OPTIONS(description='Rundungsprofil.'), wg_id
OPTIONS(description='Warengruppe.'), anz_wup_dis OPTIONS(description='DiS Anzahl Märkte.'), anz_wup_kdis
OPTIONS(description='KDiS Anzahl Märkte.'), dat_listung_markt_von OPTIONS(description='Marktlistung ab.'),
dat_listung_markt_bis OPTIONS(description='Marktlistung bis.'), gewicht_brutto_bme
OPTIONS(description='Bruttogewicht BME.'), reichweite OPTIONS(description='Reichweite.'), reichweite_neu
OPTIONS(description='Reichweite neu.'), we_bearbeitungszeit OPTIONS(description='WE-BearbZeit (WEBAZ).'), dat_aktion_1
OPTIONS(description='Werbung 1 Datum.'), dat_aktion_2 OPTIONS(description='Werbung 2 Datum.'), dat_aktion_3
OPTIONS(description='Werbung 3 Datum.'), neuer_artikel_fg OPTIONS(description='Kennzeichen für neuer Artikel.'),
gewicht_pal OPTIONS(description='Gewicht volle PAL.'), gewicht_gesamt OPTIONS(description='Gesamtgewicht Position.'),
faktor_display OPTIONS(description='Display Faktor.'), display_fg OPTIONS(description='Display Kennzeichen.'),
faktor_halbpalette OPTIONS(description='Halbpalettenfaktor.'), halbpalette_fg
OPTIONS(description='Halbpalette-Kennzeichen'), augeblendet_fg OPTIONS(description='Ausgeblendet.'), dat_bevorratung_von
OPTIONS(description='Bev Date From.'), dat_bevorratung_bis OPTIONS(description='Bev Date End.'),
dat_bevorratung_reichw_bis OPTIONS(description='Bev RW Ende.'), menge_bevorratung_gesamt
OPTIONS(description='Bev Menge.'), menge_bevorratung_offen OPTIONS(description='Bev Offene Menge.'),
bevorratung_schleichend_fg OPTIONS(description='Schleichend.'), bevorratung_grund_id OPTIONS(description='Bev Grund.'),
reichweitenbevorratung_fg OPTIONS(description='1 = Reichtweite, 0 = Fix Amount.'), iwt_id
OPTIONS(description='Kennzeichen für import / export Artikel.'), iwt_fg OPTIONS(description='Feld zum Ankreuzen.'),
bv_quelle_id OPTIONS(description='BV-Quelle.'), bedarfsnummer OPTIONS(description='Bedarfsnummer.'), kontrakt_beleg_id
OPTIONS(description='Kontrakt.'), kontrakt_beleg_pos_id OPTIONS(description='Kontrakt Pos.'), kontrakt_gueltigkeit_id
OPTIONS(description='Gültigkeit des Vertrages in Bezug auf den Zeitraum.'), ratio OPTIONS(description='1:N Quote.'),
gp_dispo_multi_id OPTIONS(description='MultiSupplier ID.'), gp_sub_id
OPTIONS(description='Nummer des untergeordneten Lieferanten.'), ratio_fehler_fg OPTIONS(description='Ratio Fehler.'),
stapel_faktor OPTIONS(description='Stapelbar.'), best_vor_dispo_id
OPTIONS(description='ID des Bestellvorschlags (VZ -> Lieferant). Anmerkung: Dies unterscheidet sich von BEST_VOR_ID (Markt -> VZ).'))
OPTIONS(DESCRIPTION = `Stammdaten für Artikel_2-Lieferanten-Kombinationen zum Plantag. Master Data for Product-Supplier_2-Combination at Planning Date.`)
AS SELECT mandant_id,
 gp_dispo_id,
 art_dispo_id,
 art_id,
 dat_plan,
 vz_dispo_artikelstatus_id,
 dispo_arttyp_id,
 palettenfaktor,
 dat_lief,
 menge_gesamt,
 menge_normal,
 menge_bevorratung,
 menge_iwt,
 menge_werbung,
 menge_einh_id,
 lagefaktor,
 artikelstatus_betrieb,
 dat_listung_vz_bis,
 dat_listung_vz_von,
 dat_raeumen_ab,
 werbung_fg,
 saison_fg,
 saison_id,
 posten_kz_sap,
 posten_fg,
 auspackware_fg,
 einkaeufer_grp_id,
 rlz_vz,
 menge_best_min,
 menge_einh_lam_id,
 min_sicherh_bestand,
 menge_best_max,
 umrech_faktor_bme_lam,
 umrech_faktor_best_bme,
 rundungsprofil,
 wg_id,
 anz_wup_dis,
 anz_wup_kdis,
 dat_listung_markt_von,
 dat_listung_markt_bis,
 gewicht_brutto_bme,
 reichweite,
 reichweite_neu,
 we_bearbeitungszeit,
 dat_aktion_1,
 dat_aktion_2,
 dat_aktion_3,
 neuer_artikel_fg,
 gewicht_pal,
 gewicht_gesamt,
 faktor_display,
 display_fg,
 faktor_halbpalette,
 halbpalette_fg,
 augeblendet_fg,
 dat_bevorratung_von,
 dat_bevorratung_bis,
 dat_bevorratung_reichw_bis,
 menge_bevorratung_gesamt,
 menge_bevorratung_offen,
 bevorratung_schleichend_fg,
 bevorratung_grund_id,
 reichweitenbevorratung_fg,
 iwt_id,
 iwt_fg,
 bv_quelle_id,
 bedarfsnummer,
 kontrakt_beleg_id,
 kontrakt_beleg_pos_id,
 kontrakt_gueltigkeit_id,
 ratio,
 gp_dispo_multi_id,
 gp_sub_id,
 ratio_fehler_fg,
 stapel_faktor,
 best_vor_dispo_id
FROM kfl_production_dbp_data.art_gp_dispo_tag_2;