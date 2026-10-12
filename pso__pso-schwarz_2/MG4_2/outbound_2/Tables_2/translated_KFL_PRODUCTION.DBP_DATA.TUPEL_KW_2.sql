CREATE OR REPLACE TABLE kfl_production_dbp_data.tupel_kw_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
kjwo INTEGER NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
matching_id INTEGER NOT NULL
OPTIONS(description='Gruppierungskriterium für Artikel_2 (kann auch nur ein Artikel_2 sein), die über die GTIN zu Nielsen-Artikel_2 gematched werden'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
anzahl_markt_wochen_kombis_abverkauf_af INTEGER
OPTIONS(description='Zählung der Markt-Tag_2 Kombinationen Abverkauf AF /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'),
anzahl_markt_wochen_kombis_abverkauf_sa INTEGER
OPTIONS(description='Zählung der Markt-Tag_2 Kombinationen Abverkauf SA /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'),
anzahl_markt_wochen_kombis_abverkauf_af_vj INTEGER
OPTIONS(description='Zählung der Markt-Tag_2 Kombinationen Abverkauf AF VJ /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'),
anzahl_markt_wochen_kombis_abverkauf_sa_vj INTEGER
OPTIONS(description='Zählung der Markt-Tag_2 Kombinationen Abverkauf SA VJ /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'),
kassenumsatz_kl_absolut_brutto NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland brutto'),
kassenumsatz_af_kl_absolut_brutto NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland brutto AF'),
kassenumsatz_sa_kl_absolut_brutto NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland brutto SA'),
kassenumsatz_kl_absolut_brutto_vj NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland brutto'),
kassenumsatz_af_kl_absolut_brutto_vj NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland brutto AF VJ'),
kassenumsatz_sa_kl_absolut_brutto_vj NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland brutto SA VJ'),
kassenumsatz_kl_absolut_netto NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland netto'),
kassenumsatz_af_kl_absolut_netto NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland netto AF'),
kassenumsatz_sa_kl_absolut_netto NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland netto SA'),
kassenumsatz_kl_absolut_netto_vj NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland netto VJ'),
kassenumsatz_af_kl_absolut_netto_vj NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland netto AF VJ'),
kassenumsatz_sa_kl_absolut_netto_vj NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland netto SA VJ'),
absatz_kl NUMERIC(18,4) OPTIONS(description='Gesamtabsatz'),
absatz_af_kl NUMERIC(18,4) OPTIONS(description='Gesamtabsatz AF'),
absatz_sa_kl NUMERIC(18,4) OPTIONS(description='Gesamtabsatz SA'),
absatz_kl_vj NUMERIC(18,4) OPTIONS(description='Gesamtabsatz VJ'),
absatz_af_kl_vj NUMERIC(18,4) OPTIONS(description='Gesamtabsatz AF VJ'),
absatz_sa_kl_vj NUMERIC(18,4) OPTIONS(description='Gesamtabsatz SA VJ'),
absatz_sst1 NUMERIC(18,4) OPTIONS(description='Absatz sst1'),
absatz_sst2 NUMERIC(18,4) OPTIONS(description='Absatz sst2'),
absatz_sst3 NUMERIC(18,4) OPTIONS(description='Absatz sst3'),
absatz_sst4 NUMERIC(18,4) OPTIONS(description='Absatz sst4'),
absatz_sst5 NUMERIC(18,4) OPTIONS(description='Absatz sst5'),
absatz_sst6 NUMERIC(18,4) OPTIONS(description='Absatz sst6'),
absatz_sst7 NUMERIC(18,4) OPTIONS(description='Absatz sst7'),
absatz_ksst1 NUMERIC(18,4) OPTIONS(description='Absatz ksst1'),
absatz_ksst2 NUMERIC(18,4) OPTIONS(description='Absatz ksst2'),
absatz_ksst3 NUMERIC(18,4) OPTIONS(description='Absatz ksst3'),
absatz_ksst4 NUMERIC(18,4) OPTIONS(description='Absatz ksst4'),
absatz_ksst5 NUMERIC(18,4) OPTIONS(description='Absatz ksst5'),
absatz_ksst6 NUMERIC(18,4) OPTIONS(description='Absatz ksst6'),
absatz_ksst7 NUMERIC(18,4) OPTIONS(description='Absatz ksst7'),
absatz_ost_basis NUMERIC(18,4) OPTIONS(description='Absatz Ost Basis'),
absatz_ost_gross NUMERIC(18,4) OPTIONS(description='Absatz Ost groß'),
absatz_sued_ost NUMERIC(18,4) OPTIONS(description='Absatz Süd-Ost'),
absatz_sued_west NUMERIC(18,4) OPTIONS(description='Absatz Süd-West'),
absatz_west NUMERIC(18,4) OPTIONS(description='Absatz West'),
absatz_nord NUMERIC(18,4) OPTIONS(description='Absatz Nord'),
markt_wochen_sst1 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf sst1'),
markt_wochen_sst2 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf sst2'),
markt_wochen_sst3 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf sst3'),
markt_wochen_sst4 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf sst4'),
markt_wochen_sst5 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf sst5'),
markt_wochen_sst6 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf sst6'),
markt_wochen_sst7 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf sst7'),
markt_wochen_ksst1 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf ksst1'),
markt_wochen_ksst2 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf ksst2'),
markt_wochen_ksst3 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf ksst3'),
markt_wochen_ksst4 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf ksst4'),
markt_wochen_ksst5 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf ksst5'),
markt_wochen_ksst6 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf ksst6'),
markt_wochen_ksst7 INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf ksst7'),
markt_wochen_ost_basis INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf Ost Basis'),
markt_wochen_ost_gross INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf Ost groß'),
markt_wochen_sued_ost INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf Süd-Ost'),
markt_wochen_sued_west INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf Süd-West'),
markt_wochen_west INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf West'),
markt_wochen_nord INTEGER OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf Nord'),
anzahl_markt_wochen_kombis_abverkauf_mit_listung INTEGER
OPTIONS(description='Anzahl der Markt-Wochen-Kombis mit Abverkauf, in denen es mindestens an einem Tag_2 von Mo-Sa eine_2 Listung gab'),
anzahl_markt_wochen_kombis_listung INTEGER
OPTIONS(description='Anzahl der Markt-Wochen-Kombis in denen es mindestens an einem Tag_2 von Mo-Sa eine_2 Listung gab'),
rohertrag_ekmep_olk_4n NUMERIC(18,4)
OPTIONS(description='Rohertrag berechnet aus artbew_2 (umsatz_netto - ekmep + logkostenzuschlag)'),
anz_bons_af INTEGER
OPTIONS(description='Zähler für: Bonreichweite aktionsfreie Ware aus Shopper_2 (Verteilung über verschiedene WG hinweg)'),
anz_bons_sa INTEGER
OPTIONS(description='Zähler für: Bonreichweite Sonderaktionsware aus Shopper_2 (Verteilung über verschiedene WG hinweg)'),
anz_bons_gesamt INTEGER OPTIONS(description='Nenner für: Bonreichweite AF und SA'),
rohertrag_ekmep_olk_4n_vj NUMERIC(18,4)
OPTIONS(description='Rohertrag berechnet aus artbew_2 (umsatz_netto - ekmep + logkostenzuschlag)'),
rohertrag_ekmep_olk_4n_af NUMERIC(18,4)
OPTIONS(description='Rohertrag berechnet aus artbew_2 (umsatz_netto - ekmep + logkostenzuschlag)'),
rohertrag_ekmep_olk_4n_sa NUMERIC(18,4)
OPTIONS(description='Rohertrag berechnet aus artbew_2 (umsatz_netto - ekmep + logkostenzuschlag)'),
rohertrag_ekmep_olk_4n_af_vj NUMERIC(18,4)
OPTIONS(description='hertrag berechnet aus artbew_2 (umsatz_netto - ekmep + logkostenzuschlag)'),
rohertrag_ekmep_olk_4n_sa_vj NUMERIC(18,4)
OPTIONS(description='Rohertrag berechnet aus artbew_2 (umsatz_netto - ekmep + logkostenzuschlag)'),
totalabschriften_wert_netto_absolut NUMERIC(18,4)
OPTIONS(description='Abschriftensumme VK_2 netto, DE alles außer AKZ -1, KMO alle Preisänderungen/Abschriften_2'),
preisabschriften_preisanderungen_wert_netto_absolut NUMERIC(18,4)
OPTIONS(description='Abschriften_2 VK_2 netto, nur Preisabschriften/Preisänderungen (Definition offen). Kann potenziell aus der Tabelle entfernt werden.'),
totalabschriften_wert_netto_absolut_vj NUMERIC(18,4)
OPTIONS(description='Abschriftensumme VK_2 netto VJ, nur Totalabschriften (Definition offen)'),
preisabschriften_preisanderungen_wert_netto_absolut_vj NUMERIC(18,4)
OPTIONS(description='Abschriften_2 VK_2 netto VJ, nur Preisabschriften/Preisänderungen (Definition offen). Kann potenziell aus der Tabelle entfernt werden.'),
cpq_tupel NUMERIC(18,4) OPTIONS(description='Cherrypicker Quote aus Shopper_2'),
cp_bons_af INTEGER OPTIONS(description='Cherrpicker Bons AF auf denen der Artikel_2 verkauft wurde '),
cp_bons_sa INTEGER OPTIONS(description='Cherrpicker Bons SA auf denen der Artikel_2 verkauft wurde '),
kassenumsatz_kl_absolut_netto_wg NUMERIC(18,4)
OPTIONS(description='Kassenumsatz Kaufland netto WG gesamt (zur Berechnung Abschriftenindex)'),
anz_bons_tupel INTEGER
OPTIONS(description='Anzahl Bons, auf denen der Artikel_2 enthalten ist (AF+SA). Nenner für Restbon'),
restbon_summe NUMERIC(18,4)
OPTIONS(description='Summe Kassenumsatz netto aller Bons aller Artikel_2 des Tupels. Zähler für Restbon'),
totalabschriften_wert_netto_absolut_wg NUMERIC(18,4)
OPTIONS(description='Abschriftensumme VK_2 netto, nur Totalabschriften (Definition offen), Gesamtsumme der WG'),
preisabschriften_preisanderungen_wert_netto_absolut_wg NUMERIC(18,4)
OPTIONS(description='Abschriften_2 VK_2 netto, nur Preisabschriften/Preisänderungen (Definition offen), Gesamtsumme der WG. Kann potenziell aus der Tabelle entfernt werden.'),
absatz_af_kl_listungswochen NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_2 Woche_2 nur gezogen wenn am Samstag dieser Woche_2 eine_2 Listung vorhanden war'),
absatz_af_kl_vj_listungswochen NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_2 Woche_2 nur gezogen wenn am Samstag dieser Woche_2 eine_2 Listung vorhanden war'),
absatz_sa_kl_listungswochen NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_2 Woche_2 nur gezogen wenn am Samstag dieser Woche_2 eine_2 Listung vorhanden war'),
absatz_sa_kl_vj_listungswochen NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_2 Woche_2 nur gezogen wenn am Samstag dieser Woche_2 eine_2 Listung vorhanden war'),
kassenumsatz_af_kl_absolut_netto_listungswochen NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_2 Woche_2 nur gezogen wenn am Samstag dieser Woche_2 eine_2 Listung vorhanden war'),
kassenumsatz_af_kl_absolut_netto_vj_listungswochen NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_2 Woche_2 nur gezogen wenn am Samstag dieser Woche_2 eine_2 Listung vorhanden war'),
kassenumsatz_sa_kl_absolut_netto_listungswochen NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_2 Woche_2 nur gezogen wenn am Samstag dieser Woche_2 eine_2 Listung vorhanden war'),
kassenumsatz_sa_kl_absolut_netto_vj_listungswochen NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_2 Woche_2 nur gezogen wenn am Samstag dieser Woche_2 eine_2 Listung vorhanden war'),
rohertrag_ekmep_olk_4n_af_listungswochen NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_2 Woche_2 nur gezogen wenn am Samstag dieser Woche_2 eine_2 Listung vorhanden war'),
rohertrag_ekmep_olk_4n_af_vj_listungswochen NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_2 Woche_2 nur gezogen wenn am Samstag dieser Woche_2 eine_2 Listung vorhanden war'),
rohertrag_ekmep_olk_4n_sa_listungswochen NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_2 Woche_2 nur gezogen wenn am Samstag dieser Woche_2 eine_2 Listung vorhanden war'),
rohertrag_ekmep_olk_4n_sa_vj_listungswochen NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_2 Woche_2 nur gezogen wenn am Samstag dieser Woche_2 eine_2 Listung vorhanden war'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
anz_bons_af_markt_tag INTEGER
OPTIONS(description='Anzahl Bons, die an dem gesamten Markt-Tag_2 produziert sind und auf denen der aktionsfreie (AF) Artikel_2, verkauft wurde.'),
anz_bons_sa_markt_tag INTEGER
OPTIONS(description='Anzahl Bons, die an dem gesamten Markt-Tag_2 produziert sind und auf denen der in Sonderaktion (SA) Artikel_2, verkauft wurde.'),
PRIMARY KEY (mandant_id, kjwo, matching_id) NOT ENFORCED
) OPTIONS(description='EK_SORT - Aggregat - Teilmenge von tupel_mat_2 auf Ebene KW.');