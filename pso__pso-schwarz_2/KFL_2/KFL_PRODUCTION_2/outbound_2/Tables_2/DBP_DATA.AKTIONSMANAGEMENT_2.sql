--==============================================================
-- Table: aktionsmanagement_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aktionsmanagement_2
   generated from Powerdesigner on Freitag, 18. Oktober 2024 13:54:56
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aktionsmanagement_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
kjwo_ww BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Werbewoche, Format JJJJWW.'),
kjwo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW.'),
mutter_wb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bei einer Serie von Artikeln mit gleicher Werbung ist hier die Artikel_2-ID des führenden Artikels (auch: Mutterartikel) hinterlegt.'),
konkat_kind_art_id STRING(500) COLLATE 'und:ci'
OPTIONS(description='Enthält alle Artikel_2-IDs der Kinder konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'),
konkat_aktion_thema_gruppe_id STRING(500) COLLATE 'und:ci'
OPTIONS(description='Enthält alle Aktionsthemen konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'),
konkat_werbe_kat_id STRING(500) COLLATE 'und:ci'
OPTIONS(description='Enthält alle Werbekategorien konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'),
konkat_werbeteam_cd STRING(3000)
OPTIONS(description='Enthält alle Werbeteams der Kinder konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'),
konkat_werbeteam_bez STRING(3000)
OPTIONS(description='Enthält alle Werbeteams Bezeichnung der Kinder konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner-ID (auch Lieferanten-ID).'),
werbebereich_cd STRING(100) OPTIONS(description='Code des Werbebereichs.'),
konkat_wg_id STRING(500) COLLATE 'und:ci'
OPTIONS(description='Enthält alle WG-IDs der Kinder konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'),
umsatz_netto_sa_west BIGNUMERIC(38,4)
OPTIONS(description='Nettoumsatz / Kassenumsatz SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'),
absatz_sa_west BIGNUMERIC(38,4)
OPTIONS(description='Absatz SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'),
ek_mep_sa_west BIGNUMERIC(38,4)
OPTIONS(description='EK MEP SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'),
rohertrag_ek_mep_olk_sa_west BIGNUMERIC(38,4)
OPTIONS(description='Rohertrag EK MEP oLK SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'),
spanne_ek_mep_olk_sa_west BIGNUMERIC(38,4)
OPTIONS(description='Spanne EK MEP oLK SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'),
preisvorteil_west BIGNUMERIC(38,4)
OPTIONS(description='Preisvorteil der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'),
umsatz_netto_sa_ost BIGNUMERIC(38,4)
OPTIONS(description='Nettoumsatz/Kassenumsatz SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'),
absatz_sa_ost BIGNUMERIC(38,4)
OPTIONS(description='Absatz SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'),
ek_mep_sa_ost BIGNUMERIC(38,4)
OPTIONS(description='EK MEP SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'),
rohertrag_ek_mep_olk_sa_ost BIGNUMERIC(38,4)
OPTIONS(description='Rohertrag EK MEP oLK SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'),
spanne_ek_mep_olk_sa_ost BIGNUMERIC(38,4)
OPTIONS(description='Spanne EK MEP oLK SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'),
preisvorteil_ost BIGNUMERIC(38,4)
OPTIONS(description='Preisvorteil der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'),
umsatz_netto_sa_sued BIGNUMERIC(38,4)
OPTIONS(description='Nettoumsatz/Kassenumsatz SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'),
absatz_sa_sued BIGNUMERIC(38,4)
OPTIONS(description='Absatz SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'),
ek_mep_sa_sued BIGNUMERIC(38,4)
OPTIONS(description='EK MEP SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'),
rohertrag_ek_mep_olk_sa_sued BIGNUMERIC(38,4)
OPTIONS(description='Rohertrag EK MEP oLK SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'),
spanne_ek_mep_olk_sa_sued BIGNUMERIC(38,4)
OPTIONS(description='Spanne EK MEP oLK SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'),
preisvorteil_sued BIGNUMERIC(38,4)
OPTIONS(description='Preisvorteil der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'),
umsatz_netto_sa BIGNUMERIC(38,4) OPTIONS(description='Nettoumsatz/Kassenumsatz SA gesamt.'),
absatz_sa BIGNUMERIC(38,4) OPTIONS(description='Absatz SA gesamt.'),
ek_mep_sa BIGNUMERIC(38,4) OPTIONS(description='EK MEP SA gesamt.'),
rohertrag_sa BIGNUMERIC(38,4) OPTIONS(description='Rohertrag EK MEP oLK SA gesamt.'),
spanne_sa BIGNUMERIC(38,4) OPTIONS(description='Spanne EK MEP oLK SA gesamt.'),
preisvorteil BIGNUMERIC(38,4) OPTIONS(description='Preisvorteil gesamt.'),
avq_1 BIGNUMERIC(38,4) OPTIONS(description='Abverkaufsquote (1. Tag_2).'),
avq_3 BIGNUMERIC(38,4) OPTIONS(description='Abverkaufsquote (1.-3. Tag_2).'),
avq BIGNUMERIC(38,4) OPTIONS(description='Abverkaufsquote gesamt (Woche_2).'),
wareneingang_zl BIGNUMERIC(38,4) OPTIONS(description='Wareneingang (ZL).'),
abverkaufte_menge_bestand BIGNUMERIC(38,4) OPTIONS(description='Abverkaufte Menge (WE+Bestand).'),
abverkaufte_menge BIGNUMERIC(38,4) OPTIONS(description='Abverkaufte Menge.'),
durchschnitt_menge_pro_filiale BIGNUMERIC(38,4) OPTIONS(description='Ø-Menge pro Artikel_2 pro Filiale.'),
einheit_wb STRING(2) COLLATE 'und:ci' OPTIONS(description='Einheit WB: Stk/kg.'),
umsatz_netto BIGNUMERIC(38,4) OPTIONS(description='Umsatz netto/Kassenumsatz.'),
durchschnitt_umsatz_pro_artike BIGNUMERIC(38,4)
OPTIONS(description='Ø-Umsatz pro Artikel_2 pro Filiale. (ACHTUNG: Die Spalte sollte eigentlich "durchschnitt_umsatz_pro_artikel_pro_filiale" heißen, wurde aber bei der Migration abgeschnitten und übersehen. Der Aufwand für eine_2 Anpassung ist möglicherweise zu groß aufgrund der Berichte die daran hängen.)'),
anz_nullbestand BIGNUMERIC(38,0) OPTIONS(description='Anzahl Nullbestände.'),
nullbestandsquote BIGNUMERIC(38,4) OPTIONS(description='Nullbestandsquote Werbung.'),
endbestand BIGNUMERIC(38,4) OPTIONS(description='Endbestand.'),
umschlagsquote BIGNUMERIC(38,4) OPTIONS(description='Umschlagsdauer (Tage).'),
anz_artikel BIGNUMERIC(38,0) OPTIONS(description='Anzahl Artikel.'),
anz_filialen BIGNUMERIC(38,0) OPTIONS(description='Anzahl Filialen.'),
umsatz_baseline BIGNUMERIC(38,4) OPTIONS(description='Umsatz Baseline.'),
umsatz_werbewoche BIGNUMERIC(38,4) OPTIONS(description='Umsatz Werbewoche.'),
umsatz_uplift BIGNUMERIC(38,4) OPTIONS(description='Umsatz Uplift.'),
umsatz_aktivierter_normalpreis BIGNUMERIC(38,2) OPTIONS(description='Umsatz aktivierter Normalpreis.'),
absatz_baseline BIGNUMERIC(38,4) OPTIONS(description='Absatz Baseline.'),
absatz_werbewoche BIGNUMERIC(38,4) OPTIONS(description='Absatz Werbewoche.'),
absatz_uplift BIGNUMERIC(38,4) OPTIONS(description='Absatz Uplift.'),
ertrag_baseline BIGNUMERIC(38,4) OPTIONS(description='Ertrag Baseline.'),
ertrag_werbewoche BIGNUMERIC(38,4) OPTIONS(description='Ertrag Werbewoche.'),
ertrag_uplift BIGNUMERIC(38,4) OPTIONS(description='Ertrag Uplift.'),
kaeufer_baseline BIGNUMERIC(38,0) OPTIONS(description='Kaeufer Baseline.'),
kaeufer_werbewoche BIGNUMERIC(38,0) OPTIONS(description='Kaeufer Werbewoche.'),
kaeufer_uplift BIGNUMERIC(38,0) OPTIONS(description='Kaeufer Uplift.'),
kaeufer_reichweite_baseline BIGNUMERIC(38,4) OPTIONS(description='Kaeufer Reichweite Baseline.'),
kaeufer_reichweite_werbewoche BIGNUMERIC(38,4) OPTIONS(description='Kaeufer Reichweite Werbewoche.'),
kaeufer_reichweite_uplift BIGNUMERIC(38,4) OPTIONS(description='Kaeufer Reichweite Uplift.'),
cherrypicker_pp BIGNUMERIC(38,4) OPTIONS(description='Cherrypicker Quote.'),
restbon_normalware BIGNUMERIC(38,4) OPTIONS(description='Restbon Normalware.'),
restbon_gesamt BIGNUMERIC(38,4) OPTIONS(description='Restbon gesamt.'),
restbon_tip BIGNUMERIC(38,4) OPTIONS(description='Restbon TIP.'),
anz_tage_sa BIGNUMERIC(38,0) OPTIONS(description='Anzahl Tage SA. Aus Aggregat shopper.anz_tage_sa.'),
anz_markt_sa BIGNUMERIC(38,0) OPTIONS(description='Anzahl Markt SA.'),
baseline_wochen BIGNUMERIC(38,0) OPTIONS(description='Baseline Wochen.'),
wa_kalk_nach_pv_sa BIGNUMERIC(38,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_sued BIGNUMERIC(38,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion der Vertriebsregion Süd ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_ost BIGNUMERIC(38,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_west BIGNUMERIC(38,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa BIGNUMERIC(38,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_sued BIGNUMERIC(38,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_ost BIGNUMERIC(38,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_west BIGNUMERIC(38,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_loy BIGNUMERIC(38,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion Loyalty, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_aktion_loy BIGNUMERIC(38,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion Loyalty Standard Aktion_2, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_bby_loy BIGNUMERIC(38,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion Loyalty Standard Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_kdn_bby_loy BIGNUMERIC(38,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion Loyalty Kundenkarten Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_kdp_bby_loy BIGNUMERIC(38,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion Loyalty Kundenkarten Coupons Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_non_loy BIGNUMERIC(38,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion nicht-Loyalty, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_aktion_non_loy BIGNUMERIC(38,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion nicht-Loyalty Standard Aktion_2, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_bby_non_loy BIGNUMERIC(38,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion nicht-Loyalty Standard Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_loy BIGNUMERIC(38,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_aktion_loy BIGNUMERIC(38,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty Standard Aktion_2, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_bby_loy BIGNUMERIC(38,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty Standard Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_kdn_bby_loy BIGNUMERIC(38,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty Kundenkarten Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_kdp_bby_loy BIGNUMERIC(38,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty Kundenkarten Coupons Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_non_loy BIGNUMERIC(38,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion nicht-Loyalty, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_aktion_non_loy BIGNUMERIC(38,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion nicht-Loyalty Standard Aktion_2, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_bby_non_loy BIGNUMERIC(38,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion nicht-Loyalty Standard Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
umsatz_netto_sa_aktion_loy BIGNUMERIC(38,4)
OPTIONS(description='Kassenumsatz netto Sonderaktion Loyalty Standard Aktion. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
umsatz_netto_sa_bby_loy BIGNUMERIC(38,4)
OPTIONS(description='Kassenumsatz netto Sonderaktion Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
umsatz_netto_sa_kdn_bby_loy BIGNUMERIC(38,4)
OPTIONS(description='Kassenumsatz netto Sonderaktion Loyalty Kundenkarten Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
umsatz_netto_sa_kdp_bby_loy BIGNUMERIC(38,4)
OPTIONS(description='Kassenumsatz netto Sonderaktion Loyalty Kundenkarten Coupons Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
umsatz_netto_sa_aktion_non_loy BIGNUMERIC(38,4)
OPTIONS(description='Kassenumsatz netto Sonderaktion nicht-Loyalty Standard Aktion. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
umsatz_netto_sa_bby_non_loy BIGNUMERIC(38,4)
OPTIONS(description='Kassenumsatz netto Sonderaktion nicht-Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
menge_sa_aktion_loy BIGNUMERIC(38,4)
OPTIONS(description='Absatz Sonderaktion Loyalty Standard Aktion. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
menge_sa_bby_loy BIGNUMERIC(38,4)
OPTIONS(description='Absatz Sonderaktion Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
menge_sa_kdn_bby_loy BIGNUMERIC(38,4)
OPTIONS(description='Absatz Sonderaktion Loyalty Kundenkarten Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
menge_sa_kdp_bby_loy BIGNUMERIC(38,4)
OPTIONS(description='Absatz Sonderaktion Loyalty Kundenkarten Coupons Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
menge_sa_aktion_non_loy BIGNUMERIC(38,4)
OPTIONS(description='Absatz Sonderaktion nicht-Loyalty Standard Aktion. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
menge_sa_bby_non_loy BIGNUMERIC(38,4)
OPTIONS(description='Absatz Sonderaktion nicht-Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
pv_aktion_loy BIGNUMERIC(38,4)
OPTIONS(description='Preisveränderung Loyalty Standardaktion. Quelltabelle für die Kalkulation: dbp_data.marktabschriften_2'),
pv_bby_loy BIGNUMERIC(38,4)
OPTIONS(description='Preisveränderung Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.marktabschriften_2'),
pv_kdn_bby BIGNUMERIC(38,4)
OPTIONS(description='Preisveränderung Loyalty Kundenkarten Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.marktabschriften_2'),
pv_kdp_bby BIGNUMERIC(38,4)
OPTIONS(description='Preisveränderung Loyalty Kundenkarten Coupons Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.marktabschriften_2'),
pv_aktion_non_loy BIGNUMERIC(38,4)
OPTIONS(description='Preisveränderung nicht Loyalty Standardaktion. Quelltabelle für die Kalkulation: dbp_data.marktabschriften_2'),
pv_bby_non_loy BIGNUMERIC(38,4)
OPTIONS(description='Preisveränderung nicht Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.marktabschriften_2'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kjwo_ww, kjwo, mutter_wb_id) NOT ENFORCED
)
OPTIONS(description='Die Tabelle enthält Aggregate welche Daten aus dbp_data.artbew_2, dbp_data.werbung_kennzahlen_woche_2, dbp_data.shopper_2, dbp_data.marktabschriften_2 und dbp_data.artbew_dat_ek_cp_sum_2 vereinen. Fuehrende Quelle ist die artbew. Enthaelt nur DE.');