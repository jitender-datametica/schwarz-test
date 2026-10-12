CREATE OR REPLACE TABLE kfl_production_dbp_data.aktionsmanagement_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
kjwo_ww INTEGER NOT NULL OPTIONS(description='Werbewoche, Format JJJJWW.'),
kjwo INTEGER NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW.'),
mutter_wb_id INTEGER NOT NULL
OPTIONS(description='Bei einer Serie von Artikeln mit gleicher Werbung ist hier die Artikel_2-ID des führenden Artikels (auch: Mutterartikel) hinterlegt.'),
konkat_kind_art_id STRING(500) COLLATE 'und:ci'
OPTIONS(description='Enthält alle Artikel_2-IDs der Kinder konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'),
konkat_aktion_thema_gruppe_id STRING(500) COLLATE 'und:ci'
OPTIONS(description='Enthält alle Aktionsthemen konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'),
konkat_werbe_kat_id STRING(500) COLLATE 'und:ci'
OPTIONS(description='Enthält alle Werbekategorien konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'),
gp_id INTEGER NOT NULL OPTIONS(description='Geschäftspartner-ID (auch Lieferanten-ID).'),
konkat_wg_id STRING(500) COLLATE 'und:ci'
OPTIONS(description='Enthält alle WG-IDs der Kinder konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'),
umsatz_netto_sa_west NUMERIC(29,4)
OPTIONS(description='Nettoumsatz / Kassenumsatz SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'),
absatz_sa_west NUMERIC(29,4)
OPTIONS(description='Absatz SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'),
ek_mep_sa_west NUMERIC(29,4)
OPTIONS(description='EK MEP SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'),
rohertrag_ek_mep_olk_sa_west NUMERIC(29,4)
OPTIONS(description='Rohertrag EK MEP oLK SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'),
spanne_ek_mep_olk_sa_west NUMERIC(29,4)
OPTIONS(description='Spanne EK MEP oLK SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'),
preisvorteil_west NUMERIC(29,4)
OPTIONS(description='Preisvorteil der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'),
umsatz_netto_sa_ost NUMERIC(29,4)
OPTIONS(description='Nettoumsatz/Kassenumsatz SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'),
absatz_sa_ost NUMERIC(29,4)
OPTIONS(description='Absatz SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'),
ek_mep_sa_ost NUMERIC(29,4)
OPTIONS(description='EK MEP SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'),
rohertrag_ek_mep_olk_sa_ost NUMERIC(29,4)
OPTIONS(description='Rohertrag EK MEP oLK SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'),
spanne_ek_mep_olk_sa_ost NUMERIC(29,4)
OPTIONS(description='Spanne EK MEP oLK SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'),
preisvorteil_ost NUMERIC(29,4)
OPTIONS(description='Preisvorteil der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'),
umsatz_netto_sa_sued NUMERIC(29,4)
OPTIONS(description='Nettoumsatz/Kassenumsatz SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'),
absatz_sa_sued NUMERIC(29,4)
OPTIONS(description='Absatz SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'),
ek_mep_sa_sued NUMERIC(29,4)
OPTIONS(description='EK MEP SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'),
rohertrag_ek_mep_olk_sa_sued NUMERIC(29,4)
OPTIONS(description='Rohertrag EK MEP oLK SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'),
spanne_ek_mep_olk_sa_sued NUMERIC(29,4)
OPTIONS(description='Spanne EK MEP oLK SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'),
preisvorteil_sued NUMERIC(29,4)
OPTIONS(description='Preisvorteil der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'),
umsatz_netto_sa NUMERIC(29,4) OPTIONS(description='Nettoumsatz/Kassenumsatz SA gesamt.'),
absatz_sa NUMERIC(29,4) OPTIONS(description='Absatz SA gesamt.'),
ek_mep_sa NUMERIC(29,4) OPTIONS(description='EK MEP SA gesamt.'),
rohertrag_sa NUMERIC(29,4) OPTIONS(description='Rohertrag EK MEP oLK SA gesamt.'),
spanne_sa NUMERIC(29,4) OPTIONS(description='Spanne EK MEP oLK SA gesamt.'),
preisvorteil NUMERIC(29,4) OPTIONS(description='Preisvorteil gesamt.'),
avq_1 NUMERIC(29,4) OPTIONS(description='Abverkaufsquote (1. Tag_2).'),
avq_3 NUMERIC(29,4) OPTIONS(description='Abverkaufsquote (1.-3. Tag_2).'),
avq NUMERIC(29,4) OPTIONS(description='Abverkaufsquote gesamt (Woche_2).'),
wareneingang_zl NUMERIC(29,4) OPTIONS(description='Wareneingang (ZL).'),
abverkaufte_menge_bestand NUMERIC(29,4) OPTIONS(description='Abverkaufte Menge (WE+Bestand).'),
abverkaufte_menge NUMERIC(29,4) OPTIONS(description='Abverkaufte Menge.'),
durchschnitt_menge_pro_filiale NUMERIC(29,4) OPTIONS(description='Ø-Menge pro Artikel_2 pro Filiale.'),
einheit_wb STRING(2) COLLATE 'und:ci' OPTIONS(description='Einheit WB: Stk/kg.'),
umsatz_netto NUMERIC(29,4) OPTIONS(description='Umsatz netto/Kassenumsatz.'),
durchschnitt_umsatz_pro_artike NUMERIC(29,4)
OPTIONS(description='Ø-Umsatz pro Artikel_2 pro Filiale. (ACHTUNG: Die Spalte sollte eigentlich\"durchschnitt_umsatz_pro_artikel_pro_filiale\" heißen, wurde aber bei der Migration abgeschnitten und übersehen. Der Aufwand für eine_2 Anpassung ist möglicherweise zu groß aufgrund der Berichte die daran hängen.)'),
anz_nullbestand INTEGER OPTIONS(description='Anzahl Nullbestände.'),
nullbestandsquote NUMERIC(29,4) OPTIONS(description='Nullbestandsquote Werbung.'),
endbestand NUMERIC(29,4) OPTIONS(description='Endbestand.'),
umschlagsquote NUMERIC(29,4) OPTIONS(description='Umschlagsdauer (Tage).'),
anz_artikel INTEGER OPTIONS(description='Anzahl Artikel.'),
anz_filialen INTEGER OPTIONS(description='Anzahl Filialen.'),
umsatz_baseline NUMERIC(29,4) OPTIONS(description='Umsatz Baseline.'),
umsatz_werbewoche NUMERIC(29,4) OPTIONS(description='Umsatz Werbewoche.'),
umsatz_uplift NUMERIC(29,4) OPTIONS(description='Umsatz Uplift.'),
umsatz_aktivierter_normalpreis NUMERIC(29,2) OPTIONS(description='Umsatz aktivierter Normalpreis.'),
absatz_baseline NUMERIC(29,4) OPTIONS(description='Absatz Baseline.'),
absatz_werbewoche NUMERIC(29,4) OPTIONS(description='Absatz Werbewoche.'),
absatz_uplift NUMERIC(29,4) OPTIONS(description='Absatz Uplift.'),
ertrag_baseline NUMERIC(29,4) OPTIONS(description='Ertrag Baseline.'),
ertrag_werbewoche NUMERIC(29,4) OPTIONS(description='Ertrag Werbewoche.'),
ertrag_uplift NUMERIC(29,4) OPTIONS(description='Ertrag Uplift.'),
kaeufer_baseline INTEGER OPTIONS(description='Kaeufer Baseline.'),
kaeufer_werbewoche INTEGER OPTIONS(description='Kaeufer Werbewoche.'),
kaeufer_uplift INTEGER OPTIONS(description='Kaeufer Uplift.'),
kaeufer_reichweite_baseline NUMERIC(29,4) OPTIONS(description='Kaeufer Reichweite Baseline.'),
kaeufer_reichweite_werbewoche NUMERIC(29,4) OPTIONS(description='Kaeufer Reichweite Werbewoche.'),
kaeufer_reichweite_uplift NUMERIC(29,4) OPTIONS(description='Kaeufer Reichweite Uplift.'),
cherrypicker_pp NUMERIC(29,4) OPTIONS(description='Cherrypicker Quote.'),
restbon_normalware NUMERIC(29,4) OPTIONS(description='Restbon Normalware.'),
restbon_gesamt NUMERIC(29,4) OPTIONS(description='Restbon gesamt.'),
restbon_tip NUMERIC(29,4) OPTIONS(description='Restbon TIP.'),
anz_tage_sa INTEGER OPTIONS(description='Anzahl Tage SA. Aus Aggregat shopper.anz_tage_sa.'),
anz_markt_sa INTEGER OPTIONS(description='Anzahl Markt SA.'),
baseline_wochen INTEGER OPTIONS(description='Baseline Wochen.'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
wa_kalk_nach_pv_sa NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_sued NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion der Vertriebsregion Süd ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_ost NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_west NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_sued NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_ost NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_west NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_loy NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion Loyalty, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_aktion_loy NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion Loyalty Standard Aktion_2, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_bby_loy NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion Loyalty Standard Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_kdn_bby_loy NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion Loyalty Kundenkarten Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_kdp_bby_loy NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion Loyalty Kundenkarten Coupons Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_non_loy NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion nicht-Loyalty, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_aktion_non_loy NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion nicht-Loyalty Standard Aktion_2, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
wa_kalk_nach_pv_sa_bby_non_loy NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion nicht-Loyalty Standard Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_loy NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_aktion_loy NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty Standard Aktion_2, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_bby_loy NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty Standard Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_kdn_bby_loy NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty Kundenkarten Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_kdp_bby_loy NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty Kundenkarten Coupons Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_non_loy NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion nicht-Loyalty, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_aktion_non_loy NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion nicht-Loyalty Standard Aktion_2, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
spanne_wa_kalk_nach_pv_sa_bby_non_loy NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion nicht-Loyalty Standard Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
umsatz_netto_sa_aktion_non_loy NUMERIC(29,4)
OPTIONS(description='Kassenumsatz netto Sonderaktion nicht-Loyalty Standard Aktion. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
umsatz_netto_sa_bby_non_loy NUMERIC(29,4)
OPTIONS(description='Kassenumsatz netto Sonderaktion nicht-Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
umsatz_netto_sa_aktion_loy NUMERIC(29,4)
OPTIONS(description='Kassenumsatz netto Sonderaktion Loyalty Standard Aktion. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
umsatz_netto_sa_bby_loy NUMERIC(29,4)
OPTIONS(description='Kassenumsatz netto Sonderaktion Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
umsatz_netto_sa_kdn_bby_loy NUMERIC(29,4)
OPTIONS(description='Kassenumsatz netto Sonderaktion Loyalty Kundenkarten Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
umsatz_netto_sa_kdp_bby_loy NUMERIC(29,4)
OPTIONS(description='Kassenumsatz netto Sonderaktion Loyalty Kundenkarten Coupons Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
menge_sa_aktion_non_loy NUMERIC(29,4)
OPTIONS(description='Absatz Sonderaktion nicht-Loyalty Standard Aktion. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
menge_sa_bby_non_loy NUMERIC(29,4)
OPTIONS(description='Absatz Sonderaktion nicht-Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
menge_sa_aktion_loy NUMERIC(29,4)
OPTIONS(description='Absatz Sonderaktion Loyalty Standard Aktion. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
menge_sa_bby_loy NUMERIC(29,4)
OPTIONS(description='Absatz Sonderaktion Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
menge_sa_kdn_bby_loy NUMERIC(29,4)
OPTIONS(description='Absatz Sonderaktion Loyalty Kundenkarten Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
menge_sa_kdp_bby_loy NUMERIC(29,4)
OPTIONS(description='Absatz Sonderaktion Loyalty Kundenkarten Coupons Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
pv_aktion_loy NUMERIC(29,4)
OPTIONS(description='Preisveränderung Loyalty Standardaktion. Quelltabelle für die Kalkulation: dbp_data.marktabschriften_2'),
pv_bby_loy NUMERIC(29,4)
OPTIONS(description='Preisveränderung Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.marktabschriften_2'),
pv_kdn_bby NUMERIC(29,4)
OPTIONS(description='Preisveränderung Loyalty Kundenkarten Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.marktabschriften_2'),
pv_kdp_bby NUMERIC(29,4)
OPTIONS(description='Preisveränderung Loyalty Kundenkarten Coupons Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.marktabschriften_2'),
pv_aktion_non_loy NUMERIC(29,4)
OPTIONS(description='Preisveränderung nicht Loyalty Standardaktion. Quelltabelle für die Kalkulation: dbp_data.marktabschriften_2'),
pv_bby_non_loy NUMERIC(29,4)
OPTIONS(description='Preisveränderung nicht Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.marktabschriften_2'),
konkat_werbeteam_cd STRING(3000)
OPTIONS(description='Enthält alle Werbeteams der Kinder konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'),
konkat_werbeteam_bez STRING(3000)
OPTIONS(description='Enthält alle Werbeteams Bezeichnung der Kinder konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'),
werbebereich_cd STRING(100) OPTIONS(description='Code des Werbebereichs.'),
PRIMARY KEY (mandant_id, kjwo_ww, kjwo, mutter_wb_id) NOT ENFORCED
)
OPTIONS(description='Die Tabelle enthält Aggregate welche Daten aus dbp_data.artbew_2, dbp_data.werbung_kennzahlen_woche_2, dbp_data.shopper_2, dbp_data.marktabschriften_2 und dbp_data.artbew_dat_ek_cp_sum_2 vereinen. Fuehrende Quelle ist die artbew. Enthaelt nur DE.');