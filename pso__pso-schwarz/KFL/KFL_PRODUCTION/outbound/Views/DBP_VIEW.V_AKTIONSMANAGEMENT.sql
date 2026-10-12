CREATE OR REPLACE VIEW kfl_production_dbp_view.v_aktionsmanagement (mandant_id OPTIONS(description='Mandant im DWH.'),
kjwo_ww OPTIONS(description='Werbewoche, Format JJJJWW.'), kjwo
OPTIONS(description='Kalenderjahreswoche. Format JJJJWW.'), mutter_wb_id
OPTIONS(description='Bei einer Serie von Artikeln mit gleicher Werbung ist hier die Artikel-ID des führenden Artikels (auch: Mutterartikel) hinterlegt.'),
konkat_kind_art_id
OPTIONS(description='Enthält alle Artikel-IDs der Kinder konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'),
konkat_aktion_thema_gruppe_id
OPTIONS(description='Enthält alle Aktionsthemen konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'),
konkat_werbe_kat_id
OPTIONS(description='Enthält alle Werbekategorien konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'),
konkat_werbeteam_cd
OPTIONS(description='Enthält alle Werbeteams der Kinder konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'),
konkat_werbeteam_bez
OPTIONS(description='Enthält alle Werbeteams Bezeichnung der Kinder konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'),
gp_id OPTIONS(description='Geschäftspartner-ID (auch Lieferanten-ID).'), werbebereich_cd
OPTIONS(description='Code des Werbebereichs.'), konkat_wg_id
OPTIONS(description='Enthält alle WG-IDs der Kinder konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'),
umsatz_netto_sa_west
OPTIONS(description='Nettoumsatz / Kassenumsatz SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'),
absatz_sa_west
OPTIONS(description='Absatz SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'),
ek_mep_sa_west
OPTIONS(description='EK MEP SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'),
rohertrag_ek_mep_olk_sa_west
OPTIONS(description='Rohertrag EK MEP oLK SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'),
spanne_ek_mep_olk_sa_west
OPTIONS(description='Spanne EK MEP oLK SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'),
preisvorteil_west
OPTIONS(description='Preisvorteil der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'),
umsatz_netto_sa_ost
OPTIONS(description='Nettoumsatz/Kassenumsatz SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'),
absatz_sa_ost
OPTIONS(description='Absatz SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'),
ek_mep_sa_ost
OPTIONS(description='EK MEP SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'),
rohertrag_ek_mep_olk_sa_ost
OPTIONS(description='Rohertrag EK MEP oLK SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'),
spanne_ek_mep_olk_sa_ost
OPTIONS(description='Spanne EK MEP oLK SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'),
preisvorteil_ost
OPTIONS(description='Preisvorteil der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'),
umsatz_netto_sa_sued
OPTIONS(description='Nettoumsatz/Kassenumsatz SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'),
absatz_sa_sued
OPTIONS(description='Absatz SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'),
ek_mep_sa_sued
OPTIONS(description='EK MEP SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'),
rohertrag_ek_mep_olk_sa_sued
OPTIONS(description='Rohertrag EK MEP oLK SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'),
spanne_ek_mep_olk_sa_sued
OPTIONS(description='Spanne EK MEP oLK SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'),
preisvorteil_sued
OPTIONS(description='Preisvorteil der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'),
umsatz_netto_sa OPTIONS(description='Nettoumsatz/Kassenumsatz SA gesamt.'), absatz_sa
OPTIONS(description='Absatz SA gesamt.'), ek_mep_sa OPTIONS(description='EK MEP SA gesamt.'), rohertrag_sa
OPTIONS(description='Rohertrag EK MEP oLK SA gesamt.'), spanne_sa OPTIONS(description='Spanne EK MEP oLK SA gesamt.'),
preisvorteil OPTIONS(description='Preisvorteil gesamt.'), avq_1 OPTIONS(description='Abverkaufsquote (1. Tag).'), avq_3
OPTIONS(description='Abverkaufsquote (1.-3. Tag).'), avq OPTIONS(description='Abverkaufsquote gesamt (Woche).'),
wareneingang_zl OPTIONS(description='Wareneingang (ZL).'), abverkaufte_menge_bestand
OPTIONS(description='Abverkaufte Menge (WE+Bestand).'), abverkaufte_menge OPTIONS(description='Abverkaufte Menge.'),
durchschnitt_menge_pro_filiale OPTIONS(description='Ø-Menge pro Artikel pro Filiale.'), einheit_wb
OPTIONS(description='Einheit WB: Stk/kg.'), umsatz_netto OPTIONS(description='Umsatz netto/Kassenumsatz.'),
durchschnitt_umsatz_pro_artike
OPTIONS(description='Ø-Umsatz pro Artikel pro Filiale. (ACHTUNG: Die Spalte sollte eigentlich "durchschnitt_umsatz_pro_artikel_pro_filiale" heißen, wurde aber bei der Migration abgeschnitten und übersehen. Der Aufwand für eine Anpassung ist möglicherweise zu groß aufgrund der Berichte die daran hängen.)'),
anz_nullbestand OPTIONS(description='Anzahl Nullbestände.'), nullbestandsquote
OPTIONS(description='Nullbestandsquote Werbung.'), endbestand OPTIONS(description='Endbestand.'), umschlagsquote
OPTIONS(description='Umschlagsdauer (Tage).'), anz_artikel OPTIONS(description='Anzahl Artikel.'), anz_filialen
OPTIONS(description='Anzahl Filialen.'), umsatz_baseline OPTIONS(description='Umsatz Baseline.'), umsatz_werbewoche
OPTIONS(description='Umsatz Werbewoche.'), umsatz_uplift OPTIONS(description='Umsatz Uplift.'),
umsatz_aktivierter_normalpreis OPTIONS(description='Umsatz aktivierter Normalpreis.'), absatz_baseline
OPTIONS(description='Absatz Baseline.'), absatz_werbewoche OPTIONS(description='Absatz Werbewoche.'), absatz_uplift
OPTIONS(description='Absatz Uplift.'), ertrag_baseline OPTIONS(description='Ertrag Baseline.'), ertrag_werbewoche
OPTIONS(description='Ertrag Werbewoche.'), ertrag_uplift OPTIONS(description='Ertrag Uplift.'), kaeufer_baseline
OPTIONS(description='Kaeufer Baseline.'), kaeufer_werbewoche OPTIONS(description='Kaeufer Werbewoche.'), kaeufer_uplift
OPTIONS(description='Kaeufer Uplift.'), kaeufer_reichweite_baseline OPTIONS(description='Kaeufer Reichweite Baseline.'),
kaeufer_reichweite_werbewoche OPTIONS(description='Kaeufer Reichweite Werbewoche.'), kaeufer_reichweite_uplift
OPTIONS(description='Kaeufer Reichweite Uplift.'), cherrypicker_pp OPTIONS(description='Cherrypicker Quote.'),
restbon_normalware OPTIONS(description='Restbon Normalware.'), restbon_gesamt OPTIONS(description='Restbon gesamt.'),
restbon_tip OPTIONS(description='Restbon TIP.'), anz_tage_sa
OPTIONS(description='Anzahl Tage SA. Aus Aggregat shopper.anz_tage_sa.'), anz_markt_sa
OPTIONS(description='Anzahl Markt SA.'), baseline_wochen OPTIONS(description='Baseline Wochen.'), wa_kalk_nach_pv_sa
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften) nach Preisveränderung Sonderaktion, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_sued
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften) nach Preisveränderung Sonderaktion der Vertriebsregion Süd ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_ost
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften) nach Preisveränderung Sonderaktion der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_west
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften) nach Preisveränderung Sonderaktion der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_sued
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_ost
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_west
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_loy
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften) nach Preisveränderung Sonderaktion Loyalty, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_aktion_loy
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften) nach Preisveränderung Sonderaktion Loyalty Standard Aktion, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_bby_loy
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften) nach Preisveränderung Sonderaktion Loyalty Standard Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_kdn_bby_loy
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften) nach Preisveränderung Sonderaktion Loyalty Kundenkarten Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_kdp_bby_loy
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften) nach Preisveränderung Sonderaktion Loyalty Kundenkarten Coupons Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_non_loy
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften) nach Preisveränderung Sonderaktion nicht-Loyalty, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_aktion_non_loy
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften) nach Preisveränderung Sonderaktion nicht-Loyalty Standard Aktion, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_bby_non_loy
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften) nach Preisveränderung Sonderaktion nicht-Loyalty Standard Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_loy
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_aktion_loy
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty Standard Aktion, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_bby_loy
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty Standard Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_kdn_bby_loy
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty Kundenkarten Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_kdp_bby_loy
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty Kundenkarten Coupons Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_non_loy
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion nicht-Loyalty, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_aktion_non_loy
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion nicht-Loyalty Standard Aktion, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_bby_non_loy
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion nicht-Loyalty Standard Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew und dbp_data.artbew_dat_ek_cp_sum.'),
umsatz_netto_sa_aktion_loy
OPTIONS(description='Kassenumsatz netto Sonderaktion Loyalty Standard Aktion. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
umsatz_netto_sa_bby_loy
OPTIONS(description='Kassenumsatz netto Sonderaktion Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
umsatz_netto_sa_kdn_bby_loy
OPTIONS(description='Kassenumsatz netto Sonderaktion Loyalty Kundenkarten Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
umsatz_netto_sa_kdp_bby_loy
OPTIONS(description='Kassenumsatz netto Sonderaktion Loyalty Kundenkarten Coupons Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
umsatz_netto_sa_aktion_non_loy
OPTIONS(description='Kassenumsatz netto Sonderaktion nicht-Loyalty Standard Aktion. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
umsatz_netto_sa_bby_non_loy
OPTIONS(description='Kassenumsatz netto Sonderaktion nicht-Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
menge_sa_aktion_loy
OPTIONS(description='Absatz Sonderaktion Loyalty Standard Aktion. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
menge_sa_bby_loy
OPTIONS(description='Absatz Sonderaktion Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
menge_sa_kdn_bby_loy
OPTIONS(description='Absatz Sonderaktion Loyalty Kundenkarten Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
menge_sa_kdp_bby_loy
OPTIONS(description='Absatz Sonderaktion Loyalty Kundenkarten Coupons Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
menge_sa_aktion_non_loy
OPTIONS(description='Absatz Sonderaktion nicht-Loyalty Standard Aktion. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
menge_sa_bby_non_loy
OPTIONS(description='Absatz Sonderaktion nicht-Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
pv_aktion_loy
OPTIONS(description='Preisveränderung Loyalty Standardaktion. Quelltabelle für die Kalkulation: dbp_data.marktabschriften'),
pv_bby_loy
OPTIONS(description='Preisveränderung Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.marktabschriften'),
pv_kdn_bby
OPTIONS(description='Preisveränderung Loyalty Kundenkarten Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.marktabschriften'),
pv_kdp_bby
OPTIONS(description='Preisveränderung Loyalty Kundenkarten Coupons Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.marktabschriften'),
pv_aktion_non_loy
OPTIONS(description='Preisveränderung nicht Loyalty Standardaktion. Quelltabelle für die Kalkulation: dbp_data.marktabschriften'),
pv_bby_non_loy
OPTIONS(description='Preisveränderung nicht Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.marktabschriften'))
OPTIONS(DESCRIPTION = `DIE TABELLE ENTHÄLT AGGREGATE WELCHE DATEN AUS DBP_DATA.ARTBEW, DBP_DATA.WERBUNG_KENNZAHLEN_WOCHE, DBP_DATA.SHOPPER, DBP_DATA.MARKTABSCHRIFTEN UND DBP_DATA.ARTBEW_DAT_EK_CP_SUM VEREINEN. FUEHRENDE QUELLE IST DIE ARTBEW. ENTHAELT NUR DE.`)
AS SELECT mandant_id,
 kjwo_ww,
 kjwo,
 mutter_wb_id,
 konkat_kind_art_id,
 konkat_aktion_thema_gruppe_id,
 konkat_werbe_kat_id,
 konkat_werbeteam_cd,
 konkat_werbeteam_bez,
 gp_id,
 werbebereich_cd,
 konkat_wg_id,
 umsatz_netto_sa_west,
 absatz_sa_west,
 ek_mep_sa_west,
 rohertrag_ek_mep_olk_sa_west,
 spanne_ek_mep_olk_sa_west,
 preisvorteil_west,
 umsatz_netto_sa_ost,
 absatz_sa_ost,
 ek_mep_sa_ost,
 rohertrag_ek_mep_olk_sa_ost,
 spanne_ek_mep_olk_sa_ost,
 preisvorteil_ost,
 umsatz_netto_sa_sued,
 absatz_sa_sued,
 ek_mep_sa_sued,
 rohertrag_ek_mep_olk_sa_sued,
 spanne_ek_mep_olk_sa_sued,
 preisvorteil_sued,
 umsatz_netto_sa,
 absatz_sa,
 ek_mep_sa,
 rohertrag_sa,
 spanne_sa,
 preisvorteil,
 avq_1,
 avq_3,
 avq,
 wareneingang_zl,
 abverkaufte_menge_bestand,
 abverkaufte_menge,
 durchschnitt_menge_pro_filiale,
 einheit_wb,
 umsatz_netto,
 durchschnitt_umsatz_pro_artike,
 anz_nullbestand,
 nullbestandsquote,
 endbestand,
 umschlagsquote,
 anz_artikel,
 anz_filialen,
 umsatz_baseline,
 umsatz_werbewoche,
 umsatz_uplift,
 umsatz_aktivierter_normalpreis,
 absatz_baseline,
 absatz_werbewoche,
 absatz_uplift,
 ertrag_baseline,
 ertrag_werbewoche,
 ertrag_uplift,
 kaeufer_baseline,
 kaeufer_werbewoche,
 kaeufer_uplift,
 kaeufer_reichweite_baseline,
 kaeufer_reichweite_werbewoche,
 kaeufer_reichweite_uplift,
 cherrypicker_pp,
 restbon_normalware,
 restbon_gesamt,
 restbon_tip,
 anz_tage_sa,
 anz_markt_sa,
 baseline_wochen,
 wa_kalk_nach_pv_sa,
 wa_kalk_nach_pv_sa_sued,
 wa_kalk_nach_pv_sa_ost,
 wa_kalk_nach_pv_sa_west,
 spanne_wa_kalk_nach_pv_sa,
 spanne_wa_kalk_nach_pv_sa_sued,
 spanne_wa_kalk_nach_pv_sa_ost,
 spanne_wa_kalk_nach_pv_sa_west,
 wa_kalk_nach_pv_sa_loy,
 wa_kalk_nach_pv_sa_aktion_loy,
 wa_kalk_nach_pv_sa_bby_loy,
 wa_kalk_nach_pv_sa_kdn_bby_loy,
 wa_kalk_nach_pv_sa_kdp_bby_loy,
 wa_kalk_nach_pv_sa_non_loy,
 wa_kalk_nach_pv_sa_aktion_non_loy,
 wa_kalk_nach_pv_sa_bby_non_loy,
 spanne_wa_kalk_nach_pv_sa_loy,
 spanne_wa_kalk_nach_pv_sa_aktion_loy,
 spanne_wa_kalk_nach_pv_sa_bby_loy,
 spanne_wa_kalk_nach_pv_sa_kdn_bby_loy,
 spanne_wa_kalk_nach_pv_sa_kdp_bby_loy,
 spanne_wa_kalk_nach_pv_sa_non_loy,
 spanne_wa_kalk_nach_pv_sa_aktion_non_loy,
 spanne_wa_kalk_nach_pv_sa_bby_non_loy,
 umsatz_netto_sa_aktion_loy,
 umsatz_netto_sa_bby_loy,
 umsatz_netto_sa_kdn_bby_loy,
 umsatz_netto_sa_kdp_bby_loy,
 umsatz_netto_sa_aktion_non_loy,
 umsatz_netto_sa_bby_non_loy,
 menge_sa_aktion_loy,
 menge_sa_bby_loy,
 menge_sa_kdn_bby_loy,
 menge_sa_kdp_bby_loy,
 menge_sa_aktion_non_loy,
 menge_sa_bby_non_loy,
 pv_aktion_loy,
 pv_bby_loy,
 pv_kdn_bby,
 pv_kdp_bby,
 pv_aktion_non_loy,
 pv_bby_non_loy
FROM kfl_production_dbp_data.aktionsmanagement;