CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.AKTIONSMANAGEMENT_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
KJWO_WW INTEGER NOT NULL OPTIONS(description='Werbewoche, Format JJJJWW.'),
KJWO INTEGER NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW.'),
MUTTER_WB_ID INTEGER NOT NULL
OPTIONS(description='Bei einer Serie von Artikeln mit gleicher Werbung ist hier die Artikel_2-ID des führenden Artikels (auch: Mutterartikel) hinterlegt.'),
KONKAT_KIND_ART_ID STRING(500) COLLATE 'und:ci'
OPTIONS(description='Enthält alle Artikel_2-IDs der Kinder konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'),
KONKAT_AKTION_THEMA_GRUPPE_ID STRING(500) COLLATE 'und:ci'
OPTIONS(description='Enthält alle Aktionsthemen konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'),
KONKAT_WERBE_KAT_ID STRING(500) COLLATE 'und:ci'
OPTIONS(description='Enthält alle Werbekategorien konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'),
GP_ID INTEGER NOT NULL OPTIONS(description='Geschäftspartner-ID (auch Lieferanten-ID).'),
KONKAT_WG_ID STRING(500) COLLATE 'und:ci'
OPTIONS(description='Enthält alle WG-IDs der Kinder konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'),
UMSATZ_NETTO_SA_WEST NUMERIC(29,4)
OPTIONS(description='Nettoumsatz / Kassenumsatz SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'),
ABSATZ_SA_WEST NUMERIC(29,4)
OPTIONS(description='Absatz SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'),
EK_MEP_SA_WEST NUMERIC(29,4)
OPTIONS(description='EK MEP SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'),
ROHERTRAG_EK_MEP_OLK_SA_WEST NUMERIC(29,4)
OPTIONS(description='Rohertrag EK MEP oLK SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'),
SPANNE_EK_MEP_OLK_SA_WEST NUMERIC(29,4)
OPTIONS(description='Spanne EK MEP oLK SA der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'),
PREISVORTEIL_WEST NUMERIC(29,4)
OPTIONS(description='Preisvorteil der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W).'),
UMSATZ_NETTO_SA_OST NUMERIC(29,4)
OPTIONS(description='Nettoumsatz/Kassenumsatz SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'),
ABSATZ_SA_OST NUMERIC(29,4)
OPTIONS(description='Absatz SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'),
EK_MEP_SA_OST NUMERIC(29,4)
OPTIONS(description='EK MEP SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'),
ROHERTRAG_EK_MEP_OLK_SA_OST NUMERIC(29,4)
OPTIONS(description='Rohertrag EK MEP oLK SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'),
SPANNE_EK_MEP_OLK_SA_OST NUMERIC(29,4)
OPTIONS(description='Spanne EK MEP oLK SA der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'),
PREISVORTEIL_OST NUMERIC(29,4)
OPTIONS(description='Preisvorteil der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M).'),
UMSATZ_NETTO_SA_SUED NUMERIC(29,4)
OPTIONS(description='Nettoumsatz/Kassenumsatz SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'),
ABSATZ_SA_SUED NUMERIC(29,4)
OPTIONS(description='Absatz SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'),
EK_MEP_SA_SUED NUMERIC(29,4)
OPTIONS(description='EK MEP SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'),
ROHERTRAG_EK_MEP_OLK_SA_SUED NUMERIC(29,4)
OPTIONS(description='Rohertrag EK MEP oLK SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'),
SPANNE_EK_MEP_OLK_SA_SUED NUMERIC(29,4)
OPTIONS(description='Spanne EK MEP oLK SA der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'),
PREISVORTEIL_SUED NUMERIC(29,4)
OPTIONS(description='Preisvorteil der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO).'),
UMSATZ_NETTO_SA NUMERIC(29,4) OPTIONS(description='Nettoumsatz/Kassenumsatz SA gesamt.'),
ABSATZ_SA NUMERIC(29,4) OPTIONS(description='Absatz SA gesamt.'),
EK_MEP_SA NUMERIC(29,4) OPTIONS(description='EK MEP SA gesamt.'),
ROHERTRAG_SA NUMERIC(29,4) OPTIONS(description='Rohertrag EK MEP oLK SA gesamt.'),
SPANNE_SA NUMERIC(29,4) OPTIONS(description='Spanne EK MEP oLK SA gesamt.'),
PREISVORTEIL NUMERIC(29,4) OPTIONS(description='Preisvorteil gesamt.'),
AVQ_1 NUMERIC(29,4) OPTIONS(description='Abverkaufsquote (1. Tag_2).'),
AVQ_3 NUMERIC(29,4) OPTIONS(description='Abverkaufsquote (1.-3. Tag_2).'),
AVQ NUMERIC(29,4) OPTIONS(description='Abverkaufsquote gesamt (Woche_2).'),
WARENEINGANG_ZL NUMERIC(29,4) OPTIONS(description='Wareneingang (ZL).'),
ABVERKAUFTE_MENGE_BESTAND NUMERIC(29,4) OPTIONS(description='Abverkaufte Menge (WE+Bestand).'),
ABVERKAUFTE_MENGE NUMERIC(29,4) OPTIONS(description='Abverkaufte Menge.'),
DURCHSCHNITT_MENGE_PRO_FILIALE NUMERIC(29,4) OPTIONS(description='Ø-Menge pro Artikel_2 pro Filiale.'),
EINHEIT_WB STRING(2) COLLATE 'und:ci' OPTIONS(description='Einheit WB: Stk/kg.'),
UMSATZ_NETTO NUMERIC(29,4) OPTIONS(description='Umsatz netto/Kassenumsatz.'),
DURCHSCHNITT_UMSATZ_PRO_ARTIKE NUMERIC(29,4)
OPTIONS(description='Ø-Umsatz pro Artikel_2 pro Filiale. (ACHTUNG: Die Spalte sollte eigentlich\"durchschnitt_umsatz_pro_artikel_pro_filiale\" heißen, wurde aber bei der Migration abgeschnitten und übersehen. Der Aufwand für eine_2 Anpassung ist möglicherweise zu groß aufgrund der Berichte die daran hängen.)'),
ANZ_NULLBESTAND INTEGER OPTIONS(description='Anzahl Nullbestände.'),
NULLBESTANDSQUOTE NUMERIC(29,4) OPTIONS(description='Nullbestandsquote Werbung.'),
ENDBESTAND NUMERIC(29,4) OPTIONS(description='Endbestand.'),
UMSCHLAGSQUOTE NUMERIC(29,4) OPTIONS(description='Umschlagsdauer (Tage).'),
ANZ_ARTIKEL INTEGER OPTIONS(description='Anzahl Artikel.'),
ANZ_FILIALEN INTEGER OPTIONS(description='Anzahl Filialen.'),
UMSATZ_BASELINE NUMERIC(29,4) OPTIONS(description='Umsatz Baseline.'),
UMSATZ_WERBEWOCHE NUMERIC(29,4) OPTIONS(description='Umsatz Werbewoche.'),
UMSATZ_UPLIFT NUMERIC(29,4) OPTIONS(description='Umsatz Uplift.'),
UMSATZ_AKTIVIERTER_NORMALPREIS NUMERIC(29,2) OPTIONS(description='Umsatz aktivierter Normalpreis.'),
ABSATZ_BASELINE NUMERIC(29,4) OPTIONS(description='Absatz Baseline.'),
ABSATZ_WERBEWOCHE NUMERIC(29,4) OPTIONS(description='Absatz Werbewoche.'),
ABSATZ_UPLIFT NUMERIC(29,4) OPTIONS(description='Absatz Uplift.'),
ERTRAG_BASELINE NUMERIC(29,4) OPTIONS(description='Ertrag Baseline.'),
ERTRAG_WERBEWOCHE NUMERIC(29,4) OPTIONS(description='Ertrag Werbewoche.'),
ERTRAG_UPLIFT NUMERIC(29,4) OPTIONS(description='Ertrag Uplift.'),
KAEUFER_BASELINE INTEGER OPTIONS(description='Kaeufer Baseline.'),
KAEUFER_WERBEWOCHE INTEGER OPTIONS(description='Kaeufer Werbewoche.'),
KAEUFER_UPLIFT INTEGER OPTIONS(description='Kaeufer Uplift.'),
KAEUFER_REICHWEITE_BASELINE NUMERIC(29,4) OPTIONS(description='Kaeufer Reichweite Baseline.'),
KAEUFER_REICHWEITE_WERBEWOCHE NUMERIC(29,4) OPTIONS(description='Kaeufer Reichweite Werbewoche.'),
KAEUFER_REICHWEITE_UPLIFT NUMERIC(29,4) OPTIONS(description='Kaeufer Reichweite Uplift.'),
CHERRYPICKER_PP NUMERIC(29,4) OPTIONS(description='Cherrypicker Quote.'),
RESTBON_NORMALWARE NUMERIC(29,4) OPTIONS(description='Restbon Normalware.'),
RESTBON_GESAMT NUMERIC(29,4) OPTIONS(description='Restbon gesamt.'),
RESTBON_TIP NUMERIC(29,4) OPTIONS(description='Restbon TIP.'),
ANZ_TAGE_SA INTEGER OPTIONS(description='Anzahl Tage SA. Aus Aggregat shopper.anz_tage_sa.'),
ANZ_MARKT_SA INTEGER OPTIONS(description='Anzahl Markt SA.'),
BASELINE_WOCHEN INTEGER OPTIONS(description='Baseline Wochen.'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
WA_KALK_NACH_PV_SA NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
WA_KALK_NACH_PV_SA_SUED NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion der Vertriebsregion Süd ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
WA_KALK_NACH_PV_SA_OST NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
WA_KALK_NACH_PV_SA_WEST NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
SPANNE_WA_KALK_NACH_PV_SA NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
SPANNE_WA_KALK_NACH_PV_SA_SUED NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion der Vertriebsregion Sued ( = Regionalgesellschaften Möckmuehl/SW, Geisenfeld/SO), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
SPANNE_WA_KALK_NACH_PV_SA_OST NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion der Vertriebsregion Ost ( = Regionalgesellschaften Lübbenau/O, Osterfeld/M), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
SPANNE_WA_KALK_NACH_PV_SA_WEST NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion der Vertriebsregion West ( = Regionalgesellschaften Barsinghausen/N, Dortumund/W), berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
WA_KALK_NACH_PV_SA_LOY NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion Loyalty, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
WA_KALK_NACH_PV_SA_AKTION_LOY NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion Loyalty Standard Aktion_2, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
WA_KALK_NACH_PV_SA_BBY_LOY NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion Loyalty Standard Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
WA_KALK_NACH_PV_SA_KDN_BBY_LOY NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion Loyalty Kundenkarten Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
WA_KALK_NACH_PV_SA_KDP_BBY_LOY NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion Loyalty Kundenkarten Coupons Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
WA_KALK_NACH_PV_SA_NON_LOY NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion nicht-Loyalty, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
WA_KALK_NACH_PV_SA_AKTION_NON_LOY NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion nicht-Loyalty Standard Aktion_2, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
WA_KALK_NACH_PV_SA_BBY_NON_LOY NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation (Rohertrag abzüglich Abschriften_2) nach Preisveränderung Sonderaktion nicht-Loyalty Standard Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
SPANNE_WA_KALK_NACH_PV_SA_LOY NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
SPANNE_WA_KALK_NACH_PV_SA_AKTION_LOY NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty Standard Aktion_2, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
SPANNE_WA_KALK_NACH_PV_SA_BBY_LOY NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty Standard Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
SPANNE_WA_KALK_NACH_PV_SA_KDN_BBY_LOY NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty Kundenkarten Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
SPANNE_WA_KALK_NACH_PV_SA_KDP_BBY_LOY NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion Loyalty Kundenkarten Coupons Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
SPANNE_WA_KALK_NACH_PV_SA_NON_LOY NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion nicht-Loyalty, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
SPANNE_WA_KALK_NACH_PV_SA_AKTION_NON_LOY NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion nicht-Loyalty Standard Aktion_2, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
SPANNE_WA_KALK_NACH_PV_SA_BBY_NON_LOY NUMERIC(29,4)
OPTIONS(description='Warenausgang-Kalkulation nach prozentualer Preisveränderung Sonderaktion nicht-Loyalty Standard Bonus Buy, berechnet wie die gleichnamige Metrik im AIS DE, Stand Juni 2022. Quelltabellen für die Kalkulation: dbp_data.artbew_2 und dbp_data.artbew_dat_ek_cp_sum.'),
UMSATZ_NETTO_SA_AKTION_NON_LOY NUMERIC(29,4)
OPTIONS(description='Kassenumsatz netto Sonderaktion nicht-Loyalty Standard Aktion. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
UMSATZ_NETTO_SA_BBY_NON_LOY NUMERIC(29,4)
OPTIONS(description='Kassenumsatz netto Sonderaktion nicht-Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
UMSATZ_NETTO_SA_AKTION_LOY NUMERIC(29,4)
OPTIONS(description='Kassenumsatz netto Sonderaktion Loyalty Standard Aktion. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
UMSATZ_NETTO_SA_BBY_LOY NUMERIC(29,4)
OPTIONS(description='Kassenumsatz netto Sonderaktion Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
UMSATZ_NETTO_SA_KDN_BBY_LOY NUMERIC(29,4)
OPTIONS(description='Kassenumsatz netto Sonderaktion Loyalty Kundenkarten Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
UMSATZ_NETTO_SA_KDP_BBY_LOY NUMERIC(29,4)
OPTIONS(description='Kassenumsatz netto Sonderaktion Loyalty Kundenkarten Coupons Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
MENGE_SA_AKTION_NON_LOY NUMERIC(29,4)
OPTIONS(description='Absatz Sonderaktion nicht-Loyalty Standard Aktion. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
MENGE_SA_BBY_NON_LOY NUMERIC(29,4)
OPTIONS(description='Absatz Sonderaktion nicht-Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
MENGE_SA_AKTION_LOY NUMERIC(29,4)
OPTIONS(description='Absatz Sonderaktion Loyalty Standard Aktion. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
MENGE_SA_BBY_LOY NUMERIC(29,4)
OPTIONS(description='Absatz Sonderaktion Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
MENGE_SA_KDN_BBY_LOY NUMERIC(29,4)
OPTIONS(description='Absatz Sonderaktion Loyalty Kundenkarten Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
MENGE_SA_KDP_BBY_LOY NUMERIC(29,4)
OPTIONS(description='Absatz Sonderaktion Loyalty Kundenkarten Coupons Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.artbew.'),
PV_AKTION_LOY NUMERIC(29,4)
OPTIONS(description='Preisveränderung Loyalty Standardaktion. Quelltabelle für die Kalkulation: dbp_data.marktabschriften_2'),
PV_BBY_LOY NUMERIC(29,4)
OPTIONS(description='Preisveränderung Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.marktabschriften_2'),
PV_KDN_BBY NUMERIC(29,4)
OPTIONS(description='Preisveränderung Loyalty Kundenkarten Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.marktabschriften_2'),
PV_KDP_BBY NUMERIC(29,4)
OPTIONS(description='Preisveränderung Loyalty Kundenkarten Coupons Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.marktabschriften_2'),
PV_AKTION_NON_LOY NUMERIC(29,4)
OPTIONS(description='Preisveränderung nicht Loyalty Standardaktion. Quelltabelle für die Kalkulation: dbp_data.marktabschriften_2'),
PV_BBY_NON_LOY NUMERIC(29,4)
OPTIONS(description='Preisveränderung nicht Loyalty Standard Bonus Buy. Quelltabelle für die Kalkulation: dbp_data.marktabschriften_2'),
KONKAT_WERBETEAM_CD STRING(3000)
OPTIONS(description='Enthält alle Werbeteams der Kinder konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'),
KONKAT_WERBETEAM_BEZ STRING(3000)
OPTIONS(description='Enthält alle Werbeteams Bezeichnung der Kinder konkateniert, die dem Mutterwerbeartikel zum Werbezeitpunkt zugeordnet waren.'),
WERBEBEREICH_CD STRING(100) OPTIONS(description='Code des Werbebereichs.'),
PRIMARY KEY (MANDANT_ID, KJWO_WW, KJWO, MUTTER_WB_ID) NOT ENFORCED
)
OPTIONS(description='Die Tabelle enthält Aggregate welche Daten aus dbp_data.artbew_2, dbp_data.werbung_kennzahlen_woche_2, dbp_data.shopper_2, dbp_data.marktabschriften_2 und dbp_data.artbew_dat_ek_cp_sum_2 vereinen. Fuehrende Quelle ist die artbew. Enthaelt nur DE.');