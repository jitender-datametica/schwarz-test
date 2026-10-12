CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.TUPEL_KW_1 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
KJWO INTEGER NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
MATCHING_ID INTEGER NOT NULL
OPTIONS(description='Gruppierungskriterium für Artikel_1 (kann auch nur ein Artikel_1 sein), die über die GTIN zu Nielsen-Artikel_1 gematched werden'),
WRG_ID STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_AF INTEGER
OPTIONS(description='Zählung der Markt-Tag_1 Kombinationen Abverkauf AF /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'),
ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_SA INTEGER
OPTIONS(description='Zählung der Markt-Tag_1 Kombinationen Abverkauf SA /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'),
ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_AF_VJ INTEGER
OPTIONS(description='Zählung der Markt-Tag_1 Kombinationen Abverkauf AF VJ /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'),
ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_SA_VJ INTEGER
OPTIONS(description='Zählung der Markt-Tag_1 Kombinationen Abverkauf SA VJ /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'),
KASSENUMSATZ_KL_ABSOLUT_BRUTTO NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland brutto'),
KASSENUMSATZ_AF_KL_ABSOLUT_BRUTTO NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland brutto AF'),
KASSENUMSATZ_SA_KL_ABSOLUT_BRUTTO NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland brutto SA'),
KASSENUMSATZ_KL_ABSOLUT_BRUTTO_VJ NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland brutto'),
KASSENUMSATZ_AF_KL_ABSOLUT_BRUTTO_VJ NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland brutto AF VJ'),
KASSENUMSATZ_SA_KL_ABSOLUT_BRUTTO_VJ NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland brutto SA VJ'),
KASSENUMSATZ_KL_ABSOLUT_NETTO NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland netto'),
KASSENUMSATZ_AF_KL_ABSOLUT_NETTO NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland netto AF'),
KASSENUMSATZ_SA_KL_ABSOLUT_NETTO NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland netto SA'),
KASSENUMSATZ_KL_ABSOLUT_NETTO_VJ NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland netto VJ'),
KASSENUMSATZ_AF_KL_ABSOLUT_NETTO_VJ NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland netto AF VJ'),
KASSENUMSATZ_SA_KL_ABSOLUT_NETTO_VJ NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland netto SA VJ'),
ABSATZ_KL NUMERIC(18,4) OPTIONS(description='Gesamtabsatz'),
ABSATZ_AF_KL NUMERIC(18,4) OPTIONS(description='Gesamtabsatz AF'),
ABSATZ_SA_KL NUMERIC(18,4) OPTIONS(description='Gesamtabsatz SA'),
ABSATZ_KL_VJ NUMERIC(18,4) OPTIONS(description='Gesamtabsatz VJ'),
ABSATZ_AF_KL_VJ NUMERIC(18,4) OPTIONS(description='Gesamtabsatz AF VJ'),
ABSATZ_SA_KL_VJ NUMERIC(18,4) OPTIONS(description='Gesamtabsatz SA VJ'),
ABSATZ_SST1 NUMERIC(18,4) OPTIONS(description='Absatz sst1'),
ABSATZ_SST2 NUMERIC(18,4) OPTIONS(description='Absatz sst2'),
ABSATZ_SST3 NUMERIC(18,4) OPTIONS(description='Absatz sst3'),
ABSATZ_SST4 NUMERIC(18,4) OPTIONS(description='Absatz sst4'),
ABSATZ_SST5 NUMERIC(18,4) OPTIONS(description='Absatz sst5'),
ABSATZ_SST6 NUMERIC(18,4) OPTIONS(description='Absatz sst6'),
ABSATZ_SST7 NUMERIC(18,4) OPTIONS(description='Absatz sst7'),
ABSATZ_KSST1 NUMERIC(18,4) OPTIONS(description='Absatz ksst1'),
ABSATZ_KSST2 NUMERIC(18,4) OPTIONS(description='Absatz ksst2'),
ABSATZ_KSST3 NUMERIC(18,4) OPTIONS(description='Absatz ksst3'),
ABSATZ_KSST4 NUMERIC(18,4) OPTIONS(description='Absatz ksst4'),
ABSATZ_KSST5 NUMERIC(18,4) OPTIONS(description='Absatz ksst5'),
ABSATZ_KSST6 NUMERIC(18,4) OPTIONS(description='Absatz ksst6'),
ABSATZ_KSST7 NUMERIC(18,4) OPTIONS(description='Absatz ksst7'),
ABSATZ_OST_BASIS NUMERIC(18,4) OPTIONS(description='Absatz Ost Basis'),
ABSATZ_OST_GROSS NUMERIC(18,4) OPTIONS(description='Absatz Ost groß'),
ABSATZ_SUED_OST NUMERIC(18,4) OPTIONS(description='Absatz Süd-Ost'),
ABSATZ_SUED_WEST NUMERIC(18,4) OPTIONS(description='Absatz Süd-West'),
ABSATZ_WEST NUMERIC(18,4) OPTIONS(description='Absatz West'),
ABSATZ_NORD NUMERIC(18,4) OPTIONS(description='Absatz Nord'),
MARKT_WOCHEN_SST1 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf sst1'),
MARKT_WOCHEN_SST2 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf sst2'),
MARKT_WOCHEN_SST3 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf sst3'),
MARKT_WOCHEN_SST4 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf sst4'),
MARKT_WOCHEN_SST5 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf sst5'),
MARKT_WOCHEN_SST6 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf sst6'),
MARKT_WOCHEN_SST7 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf sst7'),
MARKT_WOCHEN_KSST1 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf ksst1'),
MARKT_WOCHEN_KSST2 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf ksst2'),
MARKT_WOCHEN_KSST3 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf ksst3'),
MARKT_WOCHEN_KSST4 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf ksst4'),
MARKT_WOCHEN_KSST5 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf ksst5'),
MARKT_WOCHEN_KSST6 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf ksst6'),
MARKT_WOCHEN_KSST7 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf ksst7'),
MARKT_WOCHEN_OST_BASIS INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf Ost Basis'),
MARKT_WOCHEN_OST_GROSS INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf Ost groß'),
MARKT_WOCHEN_SUED_OST INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf Süd-Ost'),
MARKT_WOCHEN_SUED_WEST INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf Süd-West'),
MARKT_WOCHEN_WEST INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf West'),
MARKT_WOCHEN_NORD INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf Nord'),
ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_MIT_LISTUNG INTEGER
OPTIONS(description='Anzahl der Markt-Wochen-Kombis mit Abverkauf, in denen es mindestens an einem Tag_1 von Mo-Sa eine_1 Listung gab'),
ANZAHL_MARKT_WOCHEN_KOMBIS_LISTUNG INTEGER
OPTIONS(description='Anzahl der Markt-Wochen-Kombis in denen es mindestens an einem Tag_1 von Mo-Sa eine_1 Listung gab'),
ROHERTRAG_EKMEP_OLK_4N NUMERIC(18,4)
OPTIONS(description='Rohertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'),
ANZ_BONS_AF INTEGER
OPTIONS(description='Zähler für: Bonreichweite aktionsfreie Ware aus Shopper_1 (Verteilung über verschiedene WG hinweg)'),
ANZ_BONS_SA INTEGER
OPTIONS(description='Zähler für: Bonreichweite Sonderaktionsware aus Shopper_1 (Verteilung über verschiedene WG hinweg)'),
ANZ_BONS_GESAMT INTEGER OPTIONS(description='Nenner für: Bonreichweite AF und SA'),
ROHERTRAG_EKMEP_OLK_4N_VJ NUMERIC(18,4)
OPTIONS(description='Rohertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'),
ROHERTRAG_EKMEP_OLK_4N_AF NUMERIC(18,4)
OPTIONS(description='Rohertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'),
ROHERTRAG_EKMEP_OLK_4N_SA NUMERIC(18,4)
OPTIONS(description='Rohertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'),
ROHERTRAG_EKMEP_OLK_4N_AF_VJ NUMERIC(18,4)
OPTIONS(description='hertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'),
ROHERTRAG_EKMEP_OLK_4N_SA_VJ NUMERIC(18,4)
OPTIONS(description='Rohertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'),
TOTALABSCHRIFTEN_WERT_NETTO_ABSOLUT NUMERIC(18,4)
OPTIONS(description='Abschriftensumme VK_1 netto, DE alles außer AKZ -1, KMO alle Preisänderungen/Abschriften_1'),
PREISABSCHRIFTEN_PREISANDERUNGEN_WERT_NETTO_ABSOLUT NUMERIC(18,4)
OPTIONS(description='Abschriften_1 VK_1 netto, nur Preisabschriften/Preisänderungen (Definition offen). Kann potenziell aus der Tabelle entfernt werden.'),
TOTALABSCHRIFTEN_WERT_NETTO_ABSOLUT_VJ NUMERIC(18,4)
OPTIONS(description='Abschriftensumme VK_1 netto VJ, nur Totalabschriften (Definition offen)'),
PREISABSCHRIFTEN_PREISANDERUNGEN_WERT_NETTO_ABSOLUT_VJ NUMERIC(18,4)
OPTIONS(description='Abschriften_1 VK_1 netto VJ, nur Preisabschriften/Preisänderungen (Definition offen). Kann potenziell aus der Tabelle entfernt werden.'),
CPQ_TUPEL NUMERIC(18,4) OPTIONS(description='Cherrypicker Quote aus Shopper_1'),
CP_BONS_AF INTEGER OPTIONS(description='Cherrpicker Bons AF auf denen der Artikel_1 verkauft wurde '),
CP_BONS_SA INTEGER OPTIONS(description='Cherrpicker Bons SA auf denen der Artikel_1 verkauft wurde '),
KASSENUMSATZ_KL_ABSOLUT_NETTO_WG NUMERIC(18,4)
OPTIONS(description='Kassenumsatz Kaufland netto WG gesamt (zur Berechnung Abschriftenindex)'),
ANZ_BONS_TUPEL INTEGER
OPTIONS(description='Anzahl Bons, auf denen der Artikel_1 enthalten ist (AF+SA). Nenner für Restbon'),
RESTBON_SUMME NUMERIC(18,4)
OPTIONS(description='Summe Kassenumsatz netto aller Bons aller Artikel_1 des Tupels. Zähler für Restbon'),
TOTALABSCHRIFTEN_WERT_NETTO_ABSOLUT_WG NUMERIC(18,4)
OPTIONS(description='Abschriftensumme VK_1 netto, nur Totalabschriften (Definition offen), Gesamtsumme der WG'),
PREISABSCHRIFTEN_PREISANDERUNGEN_WERT_NETTO_ABSOLUT_WG NUMERIC(18,4)
OPTIONS(description='Abschriften_1 VK_1 netto, nur Preisabschriften/Preisänderungen (Definition offen), Gesamtsumme der WG. Kann potenziell aus der Tabelle entfernt werden.'),
ABSATZ_AF_KL_LISTUNGSWOCHEN NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
ABSATZ_AF_KL_VJ_LISTUNGSWOCHEN NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
ABSATZ_SA_KL_LISTUNGSWOCHEN NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
ABSATZ_SA_KL_VJ_LISTUNGSWOCHEN NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
KASSENUMSATZ_AF_KL_ABSOLUT_NETTO_LISTUNGSWOCHEN NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
KASSENUMSATZ_AF_KL_ABSOLUT_NETTO_VJ_LISTUNGSWOCHEN NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
KASSENUMSATZ_SA_KL_ABSOLUT_NETTO_LISTUNGSWOCHEN NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
KASSENUMSATZ_SA_KL_ABSOLUT_NETTO_VJ_LISTUNGSWOCHEN NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
ROHERTRAG_EKMEP_OLK_4N_AF_LISTUNGSWOCHEN NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
ROHERTRAG_EKMEP_OLK_4N_AF_VJ_LISTUNGSWOCHEN NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
ROHERTRAG_EKMEP_OLK_4N_SA_LISTUNGSWOCHEN NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
ROHERTRAG_EKMEP_OLK_4N_SA_VJ_LISTUNGSWOCHEN NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
ANZ_BONS_AF_MARKT_TAG INTEGER
OPTIONS(description='Anzahl Bons, die an dem gesamten Markt-Tag_1 produziert sind und auf denen der aktionsfreie (AF) Artikel_1, verkauft wurde.'),
ANZ_BONS_SA_MARKT_TAG INTEGER
OPTIONS(description='Anzahl Bons, die an dem gesamten Markt-Tag_1 produziert sind und auf denen der in Sonderaktion (SA) Artikel_1, verkauft wurde.'),
PRIMARY KEY (MANDANT_ID, KJWO, MATCHING_ID) NOT ENFORCED
) OPTIONS(description='EK_SORT - Aggregat - Teilmenge von tupel_mat_1 auf Ebene KW.');