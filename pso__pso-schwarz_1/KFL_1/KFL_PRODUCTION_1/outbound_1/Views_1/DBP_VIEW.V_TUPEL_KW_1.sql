CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tupel_kw_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'), kjwo
OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'), matching_id
OPTIONS(description='Gruppierungskriterium für Artikel_1 (kann auch nur ein Artikel_1 sein), die über die GTIN zu Nielsen-Artikel_1 gematched werden'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'), anzahl_markt_wochen_kombis_abverkauf_af
OPTIONS(description='Zählung der Markt-Tag_1 Kombinationen Abverkauf AF /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'),
anzahl_markt_wochen_kombis_abverkauf_sa
OPTIONS(description='Zählung der Markt-Tag_1 Kombinationen Abverkauf SA /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'),
anzahl_markt_wochen_kombis_abverkauf_af_vj
OPTIONS(description='Zählung der Markt-Tag_1 Kombinationen Abverkauf AF VJ /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'),
anzahl_markt_wochen_kombis_abverkauf_sa_vj
OPTIONS(description='Zählung der Markt-Tag_1 Kombinationen Abverkauf SA VJ /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'),
kassenumsatz_kl_absolut_brutto OPTIONS(description='Kassenumsatz Kaufland brutto'), kassenumsatz_af_kl_absolut_brutto
OPTIONS(description='Kassenumsatz Kaufland brutto AF'), kassenumsatz_sa_kl_absolut_brutto
OPTIONS(description='Kassenumsatz Kaufland brutto SA'), kassenumsatz_kl_absolut_brutto_vj
OPTIONS(description='Kassenumsatz Kaufland brutto'), kassenumsatz_af_kl_absolut_brutto_vj
OPTIONS(description='Kassenumsatz Kaufland brutto AF VJ'), kassenumsatz_sa_kl_absolut_brutto_vj
OPTIONS(description='Kassenumsatz Kaufland brutto SA VJ'), kassenumsatz_kl_absolut_netto
OPTIONS(description='Kassenumsatz Kaufland netto'), kassenumsatz_af_kl_absolut_netto
OPTIONS(description='Kassenumsatz Kaufland netto AF'), kassenumsatz_sa_kl_absolut_netto
OPTIONS(description='Kassenumsatz Kaufland netto SA'), kassenumsatz_kl_absolut_netto_vj
OPTIONS(description='Kassenumsatz Kaufland netto VJ'), kassenumsatz_af_kl_absolut_netto_vj
OPTIONS(description='Kassenumsatz Kaufland netto AF VJ'), kassenumsatz_sa_kl_absolut_netto_vj
OPTIONS(description='Kassenumsatz Kaufland netto SA VJ'), absatz_kl OPTIONS(description='Gesamtabsatz'), absatz_af_kl
OPTIONS(description='Gesamtabsatz AF'), absatz_sa_kl OPTIONS(description='Gesamtabsatz SA'), absatz_kl_vj
OPTIONS(description='Gesamtabsatz VJ'), absatz_af_kl_vj OPTIONS(description='Gesamtabsatz AF VJ'), absatz_sa_kl_vj
OPTIONS(description='Gesamtabsatz SA VJ'), absatz_sst1 OPTIONS(description='Absatz sst1'), absatz_sst2
OPTIONS(description='Absatz sst2'), absatz_sst3 OPTIONS(description='Absatz sst3'), absatz_sst4
OPTIONS(description='Absatz sst4'), absatz_sst5 OPTIONS(description='Absatz sst5'), absatz_sst6
OPTIONS(description='Absatz sst6'), absatz_sst7 OPTIONS(description='Absatz sst7'), absatz_ksst1
OPTIONS(description='Absatz ksst1'), absatz_ksst2 OPTIONS(description='Absatz ksst2'), absatz_ksst3
OPTIONS(description='Absatz ksst3'), absatz_ksst4 OPTIONS(description='Absatz ksst4'), absatz_ksst5
OPTIONS(description='Absatz ksst5'), absatz_ksst6 OPTIONS(description='Absatz ksst6'), absatz_ksst7
OPTIONS(description='Absatz ksst7'), absatz_ost_basis OPTIONS(description='Absatz Ost Basis'), absatz_ost_gross
OPTIONS(description='Absatz Ost groß'), absatz_sued_ost OPTIONS(description='Absatz Süd-Ost'), absatz_sued_west
OPTIONS(description='Absatz Süd-West'), absatz_west OPTIONS(description='Absatz West'), absatz_nord
OPTIONS(description='Absatz Nord'), markt_wochen_sst1
OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf sst1'), markt_wochen_sst2
OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf sst2'), markt_wochen_sst3
OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf sst3'), markt_wochen_sst4
OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf sst4'), markt_wochen_sst5
OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf sst5'), markt_wochen_sst6
OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf sst6'), markt_wochen_sst7
OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf sst7'), markt_wochen_ksst1
OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf ksst1'), markt_wochen_ksst2
OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf ksst2'), markt_wochen_ksst3
OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf ksst3'), markt_wochen_ksst4
OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf ksst4'), markt_wochen_ksst5
OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf ksst5'), markt_wochen_ksst6
OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf ksst6'), markt_wochen_ksst7
OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf ksst7'), markt_wochen_ost_basis
OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf Ost Basis'), markt_wochen_ost_gross
OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf Ost groß'), markt_wochen_sued_ost
OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf Süd-Ost'), markt_wochen_sued_west
OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf Süd-West'), markt_wochen_west
OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf West'), markt_wochen_nord
OPTIONS(description='Zählung der Markt-Wochen Kombinationen Abverkauf Nord'),
anzahl_markt_wochen_kombis_abverkauf_mit_listung
OPTIONS(description='Anzahl der Markt-Wochen-Kombis mit Abverkauf, in denen es mindestens an einem Tag_1 von Mo-Sa eine_1 Listung gab'),
anzahl_markt_wochen_kombis_listung
OPTIONS(description='Anzahl der Markt-Wochen-Kombis in denen es mindestens an einem Tag_1 von Mo-Sa eine_1 Listung gab'),
rohertrag_ekmep_olk_4n OPTIONS(description='Rohertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'),
anz_bons_af
OPTIONS(description='Zähler für: Bonreichweite aktionsfreie Ware aus Shopper_1 (Verteilung über verschiedene WG hinweg)'),
anz_bons_sa
OPTIONS(description='Zähler für: Bonreichweite Sonderaktionsware aus Shopper_1 (Verteilung über verschiedene WG hinweg)'),
anz_bons_gesamt OPTIONS(description='Nenner für: Bonreichweite AF und SA'), rohertrag_ekmep_olk_4n_vj
OPTIONS(description='Rohertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'),
rohertrag_ekmep_olk_4n_af
OPTIONS(description='Rohertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'),
rohertrag_ekmep_olk_4n_sa
OPTIONS(description='Rohertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'),
rohertrag_ekmep_olk_4n_af_vj
OPTIONS(description='hertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'),
rohertrag_ekmep_olk_4n_sa_vj
OPTIONS(description='Rohertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'),
totalabschriften_wert_netto_absolut
OPTIONS(description='Abschriftensumme VK_1 netto, DE alles außer AKZ -1, KMO alle Preisänderungen/Abschriften_1'),
preisabschriften_preisanderungen_wert_netto_absolut
OPTIONS(description='Abschriften_1 VK_1 netto, nur Preisabschriften/Preisänderungen (Definition offen). Kann potenziell aus der Tabelle entfernt werden.'),
totalabschriften_wert_netto_absolut_vj
OPTIONS(description='Abschriftensumme VK_1 netto VJ, nur Totalabschriften (Definition offen)'),
preisabschriften_preisanderungen_wert_netto_absolut_vj
OPTIONS(description='Abschriften_1 VK_1 netto VJ, nur Preisabschriften/Preisänderungen (Definition offen). Kann potenziell aus der Tabelle entfernt werden.'),
totalabschriften_wert_netto_absolut_wg
OPTIONS(description='Abschriftensumme VK_1 netto, nur Totalabschriften (Definition offen), Gesamtsumme der WG'),
preisabschriften_preisanderungen_wert_netto_absolut_wg
OPTIONS(description='Abschriften_1 VK_1 netto, nur Preisabschriften/Preisänderungen (Definition offen), Gesamtsumme der WG. Kann potenziell aus der Tabelle entfernt werden.'),
anz_bons_af_markt_tag
OPTIONS(description='Anzahl Bons, die an dem gesamten Markt-Tag_1 produziert sind und auf denen der aktionsfreie (AF) Artikel_1, verkauft wurde.'),
anz_bons_sa_markt_tag
OPTIONS(description='Anzahl Bons, die an dem gesamten Markt-Tag_1 produziert sind und auf denen der in Sonderaktion (SA) Artikel_1, verkauft wurde.'),
cpq_tupel OPTIONS(description='Cherrypicker Quote aus Shopper_1'), cp_bons_af
OPTIONS(description='Cherrpicker Bons AF auf denen der Artikel_1 verkauft wurde '), cp_bons_sa
OPTIONS(description='Cherrpicker Bons SA auf denen der Artikel_1 verkauft wurde '), kassenumsatz_kl_absolut_netto_wg
OPTIONS(description='Kassenumsatz Kaufland netto WG gesamt (zur Berechnung Abschriftenindex)'), anz_bons_tupel
OPTIONS(description='Anzahl Bons, auf denen der Artikel_1 enthalten ist (AF+SA). Nenner für Restbon'), restbon_summe
OPTIONS(description='Summe Kassenumsatz netto aller Bons aller Artikel_1 des Tupels. Zähler für Restbon'),
absatz_af_kl_listungswochen
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
absatz_af_kl_vj_listungswochen
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
absatz_sa_kl_listungswochen
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
absatz_sa_kl_vj_listungswochen
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
kassenumsatz_af_kl_absolut_netto_listungswochen
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
kassenumsatz_af_kl_absolut_netto_vj_listungswochen
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
kassenumsatz_sa_kl_absolut_netto_listungswochen
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
kassenumsatz_sa_kl_absolut_netto_vj_listungswochen
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
rohertrag_ekmep_olk_4n_af_listungswochen
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
rohertrag_ekmep_olk_4n_af_vj_listungswochen
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
rohertrag_ekmep_olk_4n_sa_listungswochen
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
rohertrag_ekmep_olk_4n_sa_vj_listungswochen
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'))
OPTIONS(DESCRIPTION = `EK_SORT - AGGREGAT - TEILMENGE VON TUPEL_MAT_1 AUF EBENE KW.`) AS SELECT mandant_id,
 kjwo,
 matching_id,
 wrg_id,
 anzahl_markt_wochen_kombis_abverkauf_af,
 anzahl_markt_wochen_kombis_abverkauf_sa,
 anzahl_markt_wochen_kombis_abverkauf_af_vj,
 anzahl_markt_wochen_kombis_abverkauf_sa_vj,
 kassenumsatz_kl_absolut_brutto,
 kassenumsatz_af_kl_absolut_brutto,
 kassenumsatz_sa_kl_absolut_brutto,
 kassenumsatz_kl_absolut_brutto_vj,
 kassenumsatz_af_kl_absolut_brutto_vj,
 kassenumsatz_sa_kl_absolut_brutto_vj,
 kassenumsatz_kl_absolut_netto,
 kassenumsatz_af_kl_absolut_netto,
 kassenumsatz_sa_kl_absolut_netto,
 kassenumsatz_kl_absolut_netto_vj,
 kassenumsatz_af_kl_absolut_netto_vj,
 kassenumsatz_sa_kl_absolut_netto_vj,
 absatz_kl,
 absatz_af_kl,
 absatz_sa_kl,
 absatz_kl_vj,
 absatz_af_kl_vj,
 absatz_sa_kl_vj,
 absatz_sst1,
 absatz_sst2,
 absatz_sst3,
 absatz_sst4,
 absatz_sst5,
 absatz_sst6,
 absatz_sst7,
 absatz_ksst1,
 absatz_ksst2,
 absatz_ksst3,
 absatz_ksst4,
 absatz_ksst5,
 absatz_ksst6,
 absatz_ksst7,
 absatz_ost_basis,
 absatz_ost_gross,
 absatz_sued_ost,
 absatz_sued_west,
 absatz_west,
 absatz_nord,
 markt_wochen_sst1,
 markt_wochen_sst2,
 markt_wochen_sst3,
 markt_wochen_sst4,
 markt_wochen_sst5,
 markt_wochen_sst6,
 markt_wochen_sst7,
 markt_wochen_ksst1,
 markt_wochen_ksst2,
 markt_wochen_ksst3,
 markt_wochen_ksst4,
 markt_wochen_ksst5,
 markt_wochen_ksst6,
 markt_wochen_ksst7,
 markt_wochen_ost_basis,
 markt_wochen_ost_gross,
 markt_wochen_sued_ost,
 markt_wochen_sued_west,
 markt_wochen_west,
 markt_wochen_nord,
 anzahl_markt_wochen_kombis_abverkauf_mit_listung,
 anzahl_markt_wochen_kombis_listung,
 rohertrag_ekmep_olk_4n,
 anz_bons_af,
 anz_bons_sa,
 anz_bons_gesamt,
 rohertrag_ekmep_olk_4n_vj,
 rohertrag_ekmep_olk_4n_af,
 rohertrag_ekmep_olk_4n_sa,
 rohertrag_ekmep_olk_4n_af_vj,
 rohertrag_ekmep_olk_4n_sa_vj,
 totalabschriften_wert_netto_absolut,
 preisabschriften_preisanderungen_wert_netto_absolut,
 totalabschriften_wert_netto_absolut_vj,
 preisabschriften_preisanderungen_wert_netto_absolut_vj,
 totalabschriften_wert_netto_absolut_wg,
 preisabschriften_preisanderungen_wert_netto_absolut_wg,
 anz_bons_af_markt_tag,
 anz_bons_sa_markt_tag,
 cpq_tupel,
 cp_bons_af,
 cp_bons_sa,
 kassenumsatz_kl_absolut_netto_wg,
 anz_bons_tupel,
 restbon_summe,
 absatz_af_kl_listungswochen,
 absatz_af_kl_vj_listungswochen,
 absatz_sa_kl_listungswochen,
 absatz_sa_kl_vj_listungswochen,
 kassenumsatz_af_kl_absolut_netto_listungswochen,
 kassenumsatz_af_kl_absolut_netto_vj_listungswochen,
 kassenumsatz_sa_kl_absolut_netto_listungswochen,
 kassenumsatz_sa_kl_absolut_netto_vj_listungswochen,
 rohertrag_ekmep_olk_4n_af_listungswochen,
 rohertrag_ekmep_olk_4n_af_vj_listungswochen,
 rohertrag_ekmep_olk_4n_sa_listungswochen,
 rohertrag_ekmep_olk_4n_sa_vj_listungswochen
FROM kfl_production_dbp_data.tupel_kw_1;