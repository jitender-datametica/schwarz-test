CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.tupel_mat_quarantaene_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
a500_kjwo_update INTEGER NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
matching_id INTEGER NOT NULL
OPTIONS(description='Gruppierungskriterium für Artikel_1 (kann auch nur ein Artikel_1 sein), die über die GTIN zu Nielsen-Artikel_1 gematched werden'),
a425_kjmo INTEGER NOT NULL OPTIONS(description='Monat_1 eines Kalenderjahres, Format JJJJMM'),
a5_owg_id INTEGER OPTIONS(description='ID Kaufland Oberwarengruppe für Nielsen-Daten (Vergabe im Beladeprozess)'),
a7_wg_id INTEGER OPTIONS(description='ID Kaufland Warengruppen für Nielsen-Daten (Vergabe im Beladeprozess)'),
wug_id INTEGER OPTIONS(description='ID der Warenuntergruppe'),
art_id INTEGER
OPTIONS(description='Führende Artikelnummer: Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
kl_art_id STRING(1000) COLLATE 'und:ci'
OPTIONS(description='7-stellige Artikelnummer bestehend aus 2 Stellen: Warengruppe 4 Stellen: Artikelnummer 1 Stelle: Prüfziffer'),
a450_art_nielsen_nr INTEGER OPTIONS(description='Artikelnummer bei Nielsen'),
art_bez_deutsch STRING(50) COLLATE 'und:ci' OPTIONS(description='Artikelbezeichnung deutsch spr_id 22'),
a14_art_status_de STRING(2) COLLATE 'und:ci'
OPTIONS(description='Löschkennzeichen aus DE (L:gelöscht; R:räumen; Blank:aktiv; Null: KMO)'),
nielsen_art_bez STRING(5000) COLLATE 'und:ci' OPTIONS(description='Liste an Artikelbezeichnungen aus Nielsen.'),
nielsen_gtin STRING(5000) COLLATE 'und:ci' OPTIONS(description='Global Trade Item_1 Number (GTIN)'),
a58_rang_umsatz_owg INTEGER
OPTIONS(description='Rang matching_id innerhalb OWG auf Basis Umsatz (wird im ETL-Prozess ermittelt)'),
a2_rang_umsatz_wg INTEGER
OPTIONS(description='Rang matching_id innerhalb WG auf Basis Umsatz (wird im ETL-Prozess ermittelt)'),
a59_rang_absatz_wg INTEGER
OPTIONS(description='Rang matching_id innerhalb WG auf Basis Absatz (wird im ETL-Prozess ermittelt)'),
a16_akt_lieferant_id STRING(60) COLLATE 'und:ci'
OPTIONS(description='Aktueller Lieferant (gp_id) aus art_gp_zu_per_1 mit dat_bis 31.12.9999'),
a419_hersteller_id STRING(60) COLLATE 'und:ci'
OPTIONS(description='Nur DE: Wenn Hersteller von Lieferant abweicht wird hersteller_id abweichend von gp_id angezeigt, ansonsten leer.'),
a446_lieferant_bez_latein STRING(100) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung zur gp_id aus gp_1 (aus BG anderes Quellfeld mit lateinischen Buchstaben)'),
a447_hersteller_bez_latein STRING(100) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung zur gp_id aus gp_1 (aus BG anderes Quellfeld mit lateinischen Buchstaben)'),
lieferant_nielsen STRING(5000) COLLATE 'und:ci' OPTIONS(description='Liste an Lieferantennamen aus Nielsen.'),
a391_disc_pe INTEGER OPTIONS(description='Discount Kennzeichen PE (Herkunft noch klären!)'),
a392_disc_ohne_etikett INTEGER OPTIONS(description='Discount Kennzeichen Marke (artkz_discount_1)'),
a400_lcf STRING(1) COLLATE 'und:ci' OPTIONS(description='lactose_fg aus Tabelle art_1'),
a393_vegan STRING(1) COLLATE 'und:ci' OPTIONS(description='vegan_fg aus Tabelle art_1'),
a394_gluten STRING(1) COLLATE 'und:ci' OPTIONS(description='gluten_fg aus Tabelle art_1'),
a395_bio STRING(1) COLLATE 'und:ci' OPTIONS(description='bio_fg aus Tabelle art_1'),
a396_eigenmarke STRING(2) COLLATE 'und:ci' OPTIONS(description='eigenmarke_fg_kl aus Tabelle art_1'),
a397_tierwohl STRING(10) COLLATE 'und:ci' OPTIONS(description='tierwohl_fg aus Tabelle art_1'),
a398_posten_food STRING(2) COLLATE 'und:ci' OPTIONS(description='Flag Posten Food (abgeleitet aus artkz_posten_1)'),
a399_posten_nonfood STRING(2) COLLATE 'und:ci' OPTIONS(description='Flag Posten NonFood (abgeleitet aus artkz_posten_1)'),
a339_umsatzsteuer NUMERIC(12,2) OPTIONS(description='Mehrwertsteuersatz'),
a60_muki_vk_kz STRING(5) COLLATE 'und:ci'
OPTIONS(description='Zeigt mit W/M/K an, ob und wie Artikel_1 der Matching ID in VK_1-Muki sind'),
a61_muki_vk_kl_art_id_verkettung STRING(300) COLLATE 'und:ci'
OPTIONS(description='Liste alle VK_1-Mütter auf, die an Artikeln der Matching-ID beteiligt sind'),
anzahl_markt_wochen_kombis_abverkauf_af INTEGER
OPTIONS(description='Zählung der Markt-Tag_1 Kombinationen Abverkauf AF /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'),
anzahl_markt_wochen_kombis_abverkauf_sa INTEGER
OPTIONS(description='Zählung der Markt-Tag_1 Kombinationen Abverkauf SA /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'),
anzahl_markt_wochen_kombis_abverkauf_af_vj INTEGER
OPTIONS(description='Zählung der Markt-Tag_1 Kombinationen Abverkauf AF VJ /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'),
anzahl_markt_wochen_kombis_abverkauf_sa_vj INTEGER
OPTIONS(description='Zählung der Markt-Tag_1 Kombinationen Abverkauf SA VJ /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'),
a273_kassenumsatz_kl_absolut_brutto NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland brutto'),
kassenumsatz_af_kl_absolut_brutto NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland brutto AF'),
kassenumsatz_sa_kl_absolut_brutto NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland brutto SA'),
kassenumsatz_kl_absolut_brutto_vj NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland brutto'),
kassenumsatz_af_kl_absolut_brutto_vj NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland brutto AF VJ'),
kassenumsatz_sa_kl_absolut_brutto_vj NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland brutto SA VJ'),
a21_kassenumsatz_kl_absolut_netto NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland netto'),
kassenumsatz_af_kl_absolut_netto NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland netto AF'),
kassenumsatz_sa_kl_absolut_netto NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland netto SA'),
kassenumsatz_kl_absolut_netto_vj NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland netto VJ'),
kassenumsatz_af_kl_absolut_netto_vj NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland netto AF VJ'),
kassenumsatz_sa_kl_absolut_netto_vj NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland netto SA VJ'),
a17_absatz_kl NUMERIC(18,4) OPTIONS(description='Gesamtabsatz'),
absatz_af_kl NUMERIC(18,4) OPTIONS(description='Gesamtabsatz AF'),
absatz_sa_kl NUMERIC(18,4) OPTIONS(description='Gesamtabsatz SA'),
absatz_kl_vj NUMERIC(18,4) OPTIONS(description='Gesamtabsatz VJ'),
absatz_af_kl_vj NUMERIC(18,4) OPTIONS(description='Gesamtabsatz AF VJ'),
absatz_sa_kl_vj NUMERIC(18,4) OPTIONS(description='Gesamtabsatz SA VJ'),
a76_absatz_sst1 NUMERIC(18,4) OPTIONS(description='Absatz sst1'),
a78_absatz_sst2 NUMERIC(18,4) OPTIONS(description='Absatz sst2'),
a80_absatz_sst3 NUMERIC(18,4) OPTIONS(description='Absatz sst3'),
a82_absatz_sst4 NUMERIC(18,4) OPTIONS(description='Absatz sst4'),
a84_absatz_sst5 NUMERIC(18,4) OPTIONS(description='Absatz sst5'),
a86_absatz_sst6 NUMERIC(18,4) OPTIONS(description='Absatz sst6'),
a88_absatz_sst7 NUMERIC(18,4) OPTIONS(description='Absatz sst7'),
a62_absatz_ksst1 NUMERIC(18,4) OPTIONS(description='Absatz ksst1'),
a64_absatz_ksst2 NUMERIC(18,4) OPTIONS(description='Absatz ksst2'),
a66_absatz_ksst3 NUMERIC(18,4) OPTIONS(description='Absatz ksst3'),
a68_absatz_ksst4 NUMERIC(18,4) OPTIONS(description='Absatz ksst4'),
a70_absatz_ksst5 NUMERIC(18,4) OPTIONS(description='Absatz ksst5'),
a72_absatz_ksst6 NUMERIC(18,4) OPTIONS(description='Absatz ksst6'),
a74_absatz_ksst7 NUMERIC(18,4) OPTIONS(description='Absatz ksst7'),
a90_absatz_ost_basis NUMERIC(18,4) OPTIONS(description='Absatz Ost Basis'),
a92_absatz_ost_gross NUMERIC(18,4) OPTIONS(description='Absatz Ost groß'),
a94_absatz_sued_ost NUMERIC(18,4) OPTIONS(description='Absatz Süd-Ost'),
a96_absatz_sued_west NUMERIC(18,4) OPTIONS(description='Absatz Süd-West'),
a98_absatz_west NUMERIC(18,4) OPTIONS(description='Absatz West'),
a100_absatz_nord NUMERIC(18,4) OPTIONS(description='Absatz Nord'),
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
OPTIONS(description='Anzahl der Markt-Wochen-Kombis mit Abverkauf, in denen es mindestens an einem Tag_1 von Mo-Sa eine_1 Listung gab'),
anzahl_markt_wochen_kombis_listung INTEGER
OPTIONS(description='Anzahl der Markt-Wochen-Kombis in denen es mindestens an einem Tag_1 von Mo-Sa eine_1 Listung gab'),
a31_vk_brutto_kl_pk_1 NUMERIC(18,4)
OPTIONS(description='VK_1 Preis  brutto PM_1-ID 1 (Preiskategorie 1) aus Tabelle art_pm_vw_zu_per_1'),
a333_vk_brutto_kl_pk_2 NUMERIC(18,4)
OPTIONS(description='VK_1 Preis  brutto PM_1-ID 2 (Preiskategorie 2) aus Tabelle art_pm_vw_zu_per_1'),
a54_vk_brutto_kl_pk_3 NUMERIC(18,4)
OPTIONS(description='VK_1 Preis  brutto PM_1-ID 3 (Preiskategorie 3) aus Tabelle art_pm_vw_zu_per_1'),
a334_vk_brutto_kl_pk_4 NUMERIC(18,4)
OPTIONS(description='VK_1 Preis  brutto PM_1-ID 4 (Preiskategorie 4) aus Tabelle art_pm_vw_zu_per_1'),
a432_vk_brutto_kl_pk_5 NUMERIC(18,4)
OPTIONS(description='VK_1 Preis  brutto PM_1-ID 5 (Preiskategorie 5) aus Tabelle art_pm_vw_zu_per_1'),
a433_vk_brutto_kl_pk_6 NUMERIC(18,4)
OPTIONS(description='VK_1 Preis  brutto PM_1-ID 6 (Preiskategorie 6) aus Tabelle art_pm_vw_zu_per_1'),
a434_vk_brutto_kl_pk_7 NUMERIC(18,4)
OPTIONS(description='VK_1 Preis  brutto PM_1-ID 7 (Preiskategorie 7) aus Tabelle art_pm_vw_zu_per_1'),
a435_vk_brutto_kl_pk_8 NUMERIC(18,4)
OPTIONS(description='VK_1 Preis  brutto PM_1-ID 8 (Preiskategorie 8) aus Tabelle art_pm_vw_zu_per_1'),
a436_vk_brutto_kl_pk_9 NUMERIC(18,4)
OPTIONS(description='VK_1 Preis  brutto PM_1-ID 9 (Preiskategorie 9) aus Tabelle art_pm_vw_zu_per_1'),
a437_vk_brutto_kl_pk_10 NUMERIC(18,4)
OPTIONS(description='VK_1 Preis  brutto PM_1-ID 10 (Preiskategorie 10) aus Tabelle art_pm_vw_zu_per_1'),
a30_kb_olk_ek4ndz_stamm NUMERIC(18,4)
OPTIONS(description='Kalkulationsbasis aus Stammdaten aktuell analog SAL DE bzw. KMO EK4n DEZENTRAL aus Stammdaten aktuell'),
a23_rohertrag_ekmep_olk_4n NUMERIC(18,4)
OPTIONS(description='Rohertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'),
a51_listung_sst_pflege STRING(4) COLLATE 'und:ci'
OPTIONS(description='Sortimentsstufe (SST) gepflegt durch ZEK_1 (für KMO ohne K-Sortimentsstufe)'),
a52_listung_k_sst_pflege STRING(4) COLLATE 'und:ci'
OPTIONS(description='K-Sortimentsstufe (K_SST) gepflegt durch ZEK_1 (nur KMO)'),
a426_ost_basis_pflege STRING(4) COLLATE 'und:ci' OPTIONS(description='Listung Ost Basis gepflegt durch ZEK_1'),
a427_ost_gross_pflege STRING(4) COLLATE 'und:ci' OPTIONS(description='Listung Ost Gross gepflegt durch ZEK_1'),
a428_sued_ost_pflege STRING(4) COLLATE 'und:ci' OPTIONS(description='Listung  Süd Ost  gepflegt durch ZEK_1'),
a429_sued_west_pflege STRING(4) COLLATE 'und:ci' OPTIONS(description='Listung  Süd West  gepflegt durch ZEK_1'),
a430_west_pflege STRING(4) COLLATE 'und:ci' OPTIONS(description='Listung  West gepflegt durch ZEK_1'),
a431_nord_pflege STRING(4) COLLATE 'und:ci' OPTIONS(description='Listung  Nord gepflegt durch ZEK_1'),
a50_listungsaktion STRING(255) COLLATE 'und:ci'
OPTIONS(description='Nur befüllt, wenn ZEK_1 Eingaben tätigt. Fall 1: ZEK_1 wählt aus Optionen, werden direkt hier gespeichert. Fall 2: ZEK_1 wählt Soll-Listung, der richtige Text wird vom BE ermittelt und in das Feld geschrieben.\n            ID 0: keine Listungsaktion\n            ID 1: keine Veränderung\n            ID 2: nicht möglich\n            ID 3: SOLL-Listung = IST-Listung\n            ID 4: Neulistung KL-Artikel_1\n            ID 5: Einlistung Kauflandartikel\n            ID 6: Einlistung Potenzialartikel\n            ID 7: Auslistung\n            ID 8: Listung erweitern\n            ID 9: Listung reduzieren\n            ID 10: Listung erweitern und reduzieren\n            ID 11: Listung reduzieren und erweitern\n            ID 12: Zu weit in der Vergangenheit, Hochrechnungstabelle nicht gefüllt'),
a411_stk_rohertrag_pflege STRING(255) COLLATE 'und:ci'
OPTIONS(description='Stück Rohertrag gepflegt durch ZEK_1 für Potentialartikel'),
a415_kannibalisierungsfaktor NUMERIC(18,4)
OPTIONS(description='Gepflegt durch User um die Hochrechnungen zu multiplizieren (passiert in der View)'),
a412_umsatz_brutto_hochrechnung NUMERIC(18,4)
OPTIONS(description='Hochrechnung Umsatz (stored Procedure zur Laufzeit der Ermittlung)'),
a413_absatz_hochrechnung NUMERIC(18,4)
OPTIONS(description='Hochrechnung Absatz (stored Procedure zur Laufzeit der Ermittlung)'),
a414_rohertrag_hochrechnung NUMERIC(18,4)
OPTIONS(description='Hochrechnung Rohertrag (stored Procedure zur Laufzeit der Ermittlung)'),
a36_gewichtete_distribution_nielsen NUMERIC(18,4)
OPTIONS(description='Gewichtete Verteilung Nielsen-Artikel_1 (Pendant zu distribution_gewichtet KL-Daten)'),
a32_umsatz_anteil_wgi_nielsen NUMERIC(18,4)
OPTIONS(description='Anteil Umsatz innerhalb UWG ermittelt aus Nielsen-Daten'),
a33_umsatz_anteil_wgi_kumuliert_nielsen NUMERIC(18,4)
OPTIONS(description='Anteil Umsatz innerhalb UWG ermittelt aus Nielsen-Daten kumuliert'),
a34_vk_brutto_durchschnitt_nielsen NUMERIC(18,4)
OPTIONS(description='Durchschnittlicher VK_1 (Wenn umsatz_brutto_af>0 Dann umsatz_brutto_af/menge_af Sonst umsatz_brutto_sa/menge_sa)'),
a35_umsatz_nielsen NUMERIC(18,4) OPTIONS(description='Gesamtumsatz Nielsen-Artikel_1'),
anz_wochen_de_anz_monate_kmo_nielsen INTEGER
OPTIONS(description='Anzahl Wochen (DE) oder Monate (KMO) in denen der Nielsen-Artikel_1 Daten hat'),
absatz_nielsen NUMERIC(18,4)
OPTIONS(description='wird im Fontend nicht verwendet - Prüfung, ob im BE noch verwendet wird?'),
a376_kl_marktanteil_wg_nielsen NUMERIC(18,4) OPTIONS(description='Marktanteil Kaufland  (Nielsen Daten)'),
a380_marktanteilbewertung_nielsen NUMERIC(18,4)
OPTIONS(description='Marktanteilbewertung(wird im ETL-Prozess ermittelt)'),
a377_durchschnitt_anz_maerkte_nielsen INTEGER OPTIONS(description='Durschnittliche Anzahl Märkte (Nielsen Daten)'),
a383_sales_units_verkaufseinheiten_gl_in_1000_normiert_nielsen NUMERIC(18,4)
OPTIONS(description='Absatz Nielsen Artikel_1 normiert auf Einheit (Liter, Kg, …).'),
a384_durchschn_preis_einheit_gl_normiert_nielsen NUMERIC(18,4)
OPTIONS(description='Ø-VK_1 Nielsen-Artikel_1 normiert auf Einheit (Liter, Kg, …).'),
a385_numerische_distribution_nielsen NUMERIC(18,4) OPTIONS(description='Numerische Distribution Nielsen.'),
a386_inhaltsmengen_nielsen STRING(4000)
OPTIONS(description='Liste an Inhaltsmengen (Liter, ML, Kg, Gramm, …) des Nielsen-Artikels.'),
a387_duft_geschmack_nielsen STRING(4000) COLLATE 'und:ci'
OPTIONS(description='Duft / Geschmacksrichtung (Nielsen Daten).'),
a388_einheit_nielsen STRING(4000) COLLATE 'und:ci'
OPTIONS(description='Einheiten, auf die sich der Werte in A386_INHALTSMENGEN_NIELSEN beziehen.'),
eigenmarke_fg_nielsen INTEGER
OPTIONS(description='eigenmarke_fg ermittelt aus Nielsen-Daten (1 =\"SENSITIVE\" oder\"N/A\"'),
a39_listung_sst_mvke STRING(4) COLLATE 'und:ci'
OPTIONS(description='Listungsinformation (in KMO ohne K-Listung) - (MVKE_1 - art_sm_vw_zu_per_1)'),
a38_listung_k_sst_mvke STRING(4) COLLATE 'und:ci'
OPTIONS(description='K-Listungsinformation - (MVKE_1 - art_sm_vw_zu_per_1) nur für KMO'),
a40_ost_basis STRING(1) COLLATE 'und:ci'
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per_1)'),
a41_ost_gross STRING(1) COLLATE 'und:ci'
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per_1)'),
a42_sued_ost STRING(1) COLLATE 'und:ci'
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per_1)'),
a43_sued_west STRING(1) COLLATE 'und:ci'
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per_1)'),
a44_west STRING(1) COLLATE 'und:ci'
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per_1)'),
a45_nord STRING(1) COLLATE 'und:ci'
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per_1)'),
a37_listung_erster_markt DATE
OPTIONS(description='min datum aller Artikel_1 des Tupels aus art_list_wup_zu_per_1 where list_quelle_id <> 2'),
a59_anz_maerkte_sst INTEGER
OPTIONS(description='Marktanzahl Sortimentsstufe (in KMO ohne\"K\") und Regio-Cluster (nur DE)'),
a449_anz_maerkte_k_sst INTEGER OPTIONS(description='Marktanzahl K-Sortimentsstufe (nur KMO)'),
a46_max_anz_maerkte_sst INTEGER
OPTIONS(description='Anzahl der Märkte, die gelistet sein müssten, wenn die SST aus der MVKE_1 tatsächlich auch gelistet wurde (aus WRF6) - DWH generiert'),
a47_max_anz_maerkte_k_sst INTEGER
OPTIONS(description='Anzahl der Märkte, die gelistet sein müssten, wenn die K-SST aus der MVKE_1 tatsächlich auch gelistet wurde (aus WRF6) - DWH generiert'),
a53_anz_maerkte_listung_gesamt INTEGER
OPTIONS(description='Marktanzahl Listung gesamt (Distinct Marktzählung der gülitgen Listungseinträge aus art_list_wup_zu_per_1 ohne Listungsquelle 2 (Aktionslistung))'),
a57_anz_maerkte_listung_einzel INTEGER OPTIONS(description='Marktanzahl Einzellistung'),
anz_maerkte_baustein_sonstige INTEGER
OPTIONS(description='Marktanzahl Bausteine (ohne Duplikate) - für KMO alle Bausteine / für DE ohne Regio-Bausteine'),
anz_bons_af INTEGER
OPTIONS(description='Zähler für: Bonreichweite aktionsfreie Ware aus Shopper_1 (Verteilung über verschiedene WG hinweg)'),
anz_bons_sa INTEGER
OPTIONS(description='Zähler für: Bonreichweite Sonderaktionsware aus Shopper_1 (Verteilung über verschiedene WG hinweg)'),
anz_bons_gesamt INTEGER OPTIONS(description='Nenner für: Bonreichweite AF und SA'),
rohertrag_ekmep_olk_4n_vj NUMERIC(18,4)
OPTIONS(description='Rohertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'),
rohertrag_ekmep_olk_4n_af NUMERIC(18,4)
OPTIONS(description='Rohertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'),
rohertrag_ekmep_olk_4n_sa NUMERIC(18,4)
OPTIONS(description='Rohertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'),
rohertrag_ekmep_olk_4n_af_vj NUMERIC(18,4)
OPTIONS(description='hertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'),
rohertrag_ekmep_olk_4n_sa_vj NUMERIC(18,4)
OPTIONS(description='Rohertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'),
a381_preislagenverteilung NUMERIC(18,4) OPTIONS(description='Preislagenverteilung (wird im ETL-Prozess ermittelt)'),
a27_totalabschriften_wert_netto_absolut NUMERIC(18,4)
OPTIONS(description='Abschriftensumme VK_1 netto, DE alles außer AKZ -1, KMO alle Preisänderungen/Abschriften_1'),
a313_preisabschriften_preisanderungen_wert_netto_absolut NUMERIC(18,4)
OPTIONS(description='Abschriften_1 VK_1 netto, nur Preisabschriften/Preisänderungen (Definition offen). Kann potenziell aus der Tabelle entfernt werden.'),
totalabschriften_wert_netto_absolut_vj NUMERIC(18,4)
OPTIONS(description='Abschriftensumme VK_1 netto VJ, nur Totalabschriften (Definition offen)'),
preisabschriften_preisanderungen_wert_netto_absolut_vj NUMERIC(18,4)
OPTIONS(description='Abschriften_1 VK_1 netto VJ, nur Preisabschriften/Preisänderungen (Definition offen). Kann potenziell aus der Tabelle entfernt werden.'),
totalabschriften_wert_netto_absolut_wg NUMERIC(18,4)
OPTIONS(description='Abschriftensumme VK_1 netto, nur Totalabschriften (Definition offen), Gesamtsumme der WG'),
preisabschriften_preisanderungen_wert_netto_absolut_wg NUMERIC(18,4)
OPTIONS(description='Abschriften_1 VK_1 netto, nur Preisabschriften/Preisänderungen (Definition offen), Gesamtsumme der WG. Kann potenziell aus der Tabelle entfernt werden.'),
a402_kolli_la STRING(100) COLLATE 'und:ci' OPTIONS(description='Kolliinhalt Lagerabgangsmenge'),
a401_kolli_bst STRING(100) COLLATE 'und:ci' OPTIONS(description='Kolliinhalt Bestellmenge'),
a403_restlaufzeit_zl INTEGER OPTIONS(description='Restlaufzeit bei Anlieferung an Zentrallager'),
a404_restlaufzeit_dz INTEGER OPTIONS(description='Restlaufzeit bei dezentraler Belieferung'),
a405_basismengeneinheit STRING(100) COLLATE 'und:ci' OPTIONS(description='Entspricht Verkaufsmengeneinheit'),
a406_letzte_listungsanderung_sst_ksst DATE
OPTIONS(description='Letzte Veränderung der Sortimentsttufenlistung aus Sternchenlogik'),
a407_verhandler STRING(100) COLLATE 'und:ci' OPTIONS(description='Verhandler INTEGER oder Land_1'),
a408_display_komponente_kz STRING(100) COLLATE 'und:ci'
OPTIONS(description='Kennzeichen ob Artikel_1 Display Displaykomponente ist'),
a409_kl_art_id_display STRING(100) COLLATE 'und:ci'
OPTIONS(description='Alle Displayartikelnummern die im Tupel vorkommen'),
a416_artikelrolle_id STRING(100) COLLATE 'und:ci' OPTIONS(description='Vom EK definierte Rolle des Artikels'),
kassenumsatz_kl_absolut_netto_wg NUMERIC(18,4)
OPTIONS(description='Kassenumsatz Kaufland netto WG gesamt (zur Berechnung Abschriftenindex)'),
anz_bons_tupel INTEGER
OPTIONS(description='Anzahl Bons, auf denen der Artikel_1 enthalten ist (AF+SA). Nenner für Restbon'),
restbon_summe NUMERIC(18,4)
OPTIONS(description='Summe Kassenumsatz netto aller Bons aller Artikel_1 des Tupels. Zähler für Restbon'),
cpq_tupel NUMERIC(18,4) OPTIONS(description='Cherrypicker Quote aus Shopper_1'),
cp_bons_af INTEGER OPTIONS(description='Cherrpicker Bons AF auf denen der Artikel_1 verkauft wurde '),
cp_bons_sa INTEGER OPTIONS(description='Cherrpicker Bons SA auf denen der Artikel_1 verkauft wurde '),
umrech_faktor NUMERIC(18,4) OPTIONS(description='Gebindeberücksichtigung Flasche/Kiste'),
lagerprozent NUMERIC(18,4)
OPTIONS(description='Lagerprozentsatz, gibt an wieviel % der Restlaufzeit noch nicht abgelaufen sein darf, wenn der Artikel_1 vom Lager ausgeliefert wird'),
absatz_af_kl_listungswochen NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
absatz_af_kl_vj_listungswochen NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
absatz_sa_kl_listungswochen NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
absatz_sa_kl_vj_listungswochen NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
kassenumsatz_af_kl_absolut_netto_listungswochen NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
kassenumsatz_af_kl_absolut_netto_vj_listungswochen NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
kassenumsatz_sa_kl_absolut_netto_listungswochen NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
kassenumsatz_sa_kl_absolut_netto_vj_listungswochen NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
rohertrag_ekmep_olk_4n_af_listungswochen NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
rohertrag_ekmep_olk_4n_af_vj_listungswochen NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
rohertrag_ekmep_olk_4n_sa_listungswochen NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
rohertrag_ekmep_olk_4n_sa_vj_listungswochen NUMERIC(18,4)
OPTIONS(description='Daten werden für eine_1 Woche_1 nur gezogen wenn am Samstag dieser Woche_1 eine_1 Listung vorhanden war'),
a445_anz_tupel_listung_wgi INTEGER OPTIONS(description='Anzahl von Tupel Listung'),
sustain_concat STRING(100) DEFAULT ' ' NOT NULL
OPTIONS(description='Alle Nachhaltigkeitskennzeichen konkatiniert, mit Komma getrennt, alphabetisch sortiert.'),
check_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Check, if the data have been validated'),
tupel_typ STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Used to distinguish between tupel types like KFL, Nielsen and Custom Articles.'),
a471_marke_nielsen_bez STRING(4000) OPTIONS(description='Marken aus Quelle Nielsen.'),
a515_bio_organic_nielsen_kz STRING(4000)
OPTIONS(description='Label Bio, nicht Bio, N/A oder unbekannt, aus Quelle Nielsen.'),
a516_veggy_split_nielsen_kz STRING(50)
OPTIONS(description='Label Vegetarisch, Vegan, N/A oder normal, aus Quelle Nielsen.'),
a517_laktosefrei_nielsen_kz STRING(50) OPTIONS(description='Label laktosefrei, N/A oder normal, aus Quelle Nielsen.'),
a518_glutenfrei_nielsen_kz STRING(50) OPTIONS(description='Label mit Gluten, ohne Gluten oder N/A, aus Quelle Nielsen.'),
a510_muki_ek_kz STRING(5) OPTIONS(description='Mutter-Kind-Kennzeichen (MUKI-KZ) aus SAP.'),
a511_muki_ek_kl_art_id_verkettung STRING(300)
OPTIONS(description='Alle kl_art_ids der betroffenn Mutter-Kind-Beziehung.'),
a512_muki_wb_kz STRING(5) OPTIONS(description='Mutter-Kind-Kennzeichen (MUKI-KZ) aus Quelle SAP.'),
a513_muki_wb_kl_art_id_verkettung STRING(300)
OPTIONS(description='Alle kl_art_ids der betroffenn Mutter-Kind-Beziehung.'),
a519_umsatz_anteil_wg_nielsen NUMERIC(29,4)
OPTIONS(description='Anteil Nielsen-Umsatz des Artikels am Nielsen-Umsatz der KL-WG in Summe.'),
a520_umsatz_anteil_wg_kumuliert_nielsen NUMERIC(29,4)
OPTIONS(description='Anteil Nielsen-Umsatz des Artikels am Nielsen-Umsatz der KL-WG in Summe, Kumulation nach Rang aufsteigend.'),
a521_inhalt_menge NUMERIC(29,4) OPTIONS(description='Inhaltsmenge aus SAP.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
a389_zek_id STRING(3)
OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
anz_bons_af_markt_tag INTEGER
OPTIONS(description='Anzahl Bons, die an dem gesamten Markt-Tag_1 produziert sind und auf denen der aktionsfreie (AF) Artikel_1, verkauft wurde.'),
anz_bons_sa_markt_tag INTEGER
OPTIONS(description='Anzahl Bons, die an dem gesamten Markt-Tag_1 produziert sind und auf denen der in Sonderaktion (SA) Artikel_1, verkauft wurde.'),
PRIMARY KEY (mandant_id, a500_kjwo_update, matching_id) NOT ENFORCED
)
OPTIONS(description='EK_SORT - Faktentabelle - auf Ebene Tupel (Gruppierung aus n KL-Artikeln inkl. gematchten Artikeln vom Marktforschungsinstitut Nielsen) historisiert nach MAT (moving anual total) und KW.\n             Es ist eine_1 Zwischentabelle für BC und FB EK SORT um Daten auszusieben und zu entscheiden, was zur Analyse in die Tabelle tupel_mat_1 soll. Enhällt auch Aggregationen für Spalten aus Tabelle art_nielsen.');