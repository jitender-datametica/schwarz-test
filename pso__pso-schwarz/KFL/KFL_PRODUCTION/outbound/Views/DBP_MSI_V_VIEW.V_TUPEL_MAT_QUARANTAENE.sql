CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_tupel_mat_quarantaene (mandant_id
OPTIONS(description='Mandant im DWH'), a500_kjwo_update OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
matching_id
OPTIONS(description='Gruppierungskriterium für Artikel (kann auch nur ein Artikel sein), die über die GTIN zu Nielsen-Artikel gematched werden'),
a425_kjmo OPTIONS(description='Monat eines Kalenderjahres, Format JJJJMM'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'), a5_owg_id
OPTIONS(description='ID Kaufland Oberwarengruppe für Nielsen-Daten (Vergabe im Beladeprozess)'), a7_wg_id
OPTIONS(description='ID Kaufland Warengruppen für Nielsen-Daten (Vergabe im Beladeprozess)'), wug_id
OPTIONS(description='ID der Warenuntergruppe'), art_id
OPTIONS(description='Führende Artikelnummer: Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
kl_art_id
OPTIONS(description='7-stellige Artikelnummer bestehend aus 2 Stellen: Warengruppe 4 Stellen: Artikelnummer 1 Stelle: Prüfziffer'),
a450_art_nielsen_nr OPTIONS(description='Artikelnummer bei Nielsen'), art_bez_deutsch
OPTIONS(description='Artikelbezeichnung deutsch spr_id 22'), a14_art_status_de
OPTIONS(description='Löschkennzeichen aus DE (L:gelöscht; R:räumen; Blank:aktiv; Null: KMO)'), nielsen_art_bez
OPTIONS(description='Liste an Artikelbezeichnungen aus Nielsen.'), nielsen_gtin
OPTIONS(description='Global Trade Item Number (GTIN)'), a58_rang_umsatz_owg
OPTIONS(description='Rang matching_id innerhalb OWG auf Basis Umsatz (wird im ETL-Prozess ermittelt)'),
a2_rang_umsatz_wg OPTIONS(description='Rang matching_id innerhalb WG auf Basis Umsatz (wird im ETL-Prozess ermittelt)'),
a59_rang_absatz_wg OPTIONS(description='Rang matching_id innerhalb WG auf Basis Absatz (wird im ETL-Prozess ermittelt)'),
a16_akt_lieferant_id OPTIONS(description='Aktueller Lieferant (gp_id) aus art_gp_zu_per mit dat_bis 31.12.9999'),
a419_hersteller_id
OPTIONS(description='Nur DE: Wenn Hersteller von Lieferant abweicht wird hersteller_id abweichend von gp_id angezeigt, ansonsten leer.'),
a446_lieferant_bez_latein
OPTIONS(description='Bezeichnung zur gp_id aus gp (aus BG anderes Quellfeld mit lateinischen Buchstaben)'),
a447_hersteller_bez_latein
OPTIONS(description='Bezeichnung zur gp_id aus gp (aus BG anderes Quellfeld mit lateinischen Buchstaben)'),
lieferant_nielsen OPTIONS(description='Liste an Lieferantennamen aus Nielsen.'), a389_zek_id
OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'), a391_disc_pe
OPTIONS(description='Discount Kennzeichen PE (Herkunft noch klären!)'), a392_disc_ohne_etikett
OPTIONS(description='Discount Kennzeichen Marke (artkz_discount)'), a400_lcf
OPTIONS(description='lactose_fg aus Tabelle art'), a393_vegan OPTIONS(description='vegan_fg aus Tabelle art'),
a394_gluten OPTIONS(description='gluten_fg aus Tabelle art'), a395_bio OPTIONS(description='bio_fg aus Tabelle art'),
a396_eigenmarke OPTIONS(description='eigenmarke_fg_kl aus Tabelle art'), a397_tierwohl
OPTIONS(description='tierwohl_fg aus Tabelle art'), a398_posten_food
OPTIONS(description='Flag Posten Food (abgeleitet aus artkz_posten)'), a399_posten_nonfood
OPTIONS(description='Flag Posten NonFood (abgeleitet aus artkz_posten)'), a339_umsatzsteuer
OPTIONS(description='Mehrwertsteuersatz'), a60_muki_vk_kz
OPTIONS(description='Zeigt mit W/M/K an, ob und wie Artikel der Matching ID in VK-Muki sind'),
a61_muki_vk_kl_art_id_verkettung
OPTIONS(description='Liste alle VK-Mütter auf, die an Artikeln der Matching-ID beteiligt sind'),
anzahl_markt_wochen_kombis_abverkauf_af
OPTIONS(description='Zählung der Markt-Tag Kombinationen Abverkauf AF /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'),
anzahl_markt_wochen_kombis_abverkauf_sa
OPTIONS(description='Zählung der Markt-Tag Kombinationen Abverkauf SA /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'),
anzahl_markt_wochen_kombis_abverkauf_af_vj
OPTIONS(description='Zählung der Markt-Tag Kombinationen Abverkauf AF VJ /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'),
anzahl_markt_wochen_kombis_abverkauf_sa_vj
OPTIONS(description='Zählung der Markt-Tag Kombinationen Abverkauf SA VJ /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'),
a273_kassenumsatz_kl_absolut_brutto OPTIONS(description='Kassenumsatz Kaufland brutto'),
kassenumsatz_af_kl_absolut_brutto OPTIONS(description='Kassenumsatz Kaufland brutto AF'),
kassenumsatz_sa_kl_absolut_brutto OPTIONS(description='Kassenumsatz Kaufland brutto SA'),
kassenumsatz_kl_absolut_brutto_vj OPTIONS(description='Kassenumsatz Kaufland brutto'),
kassenumsatz_af_kl_absolut_brutto_vj OPTIONS(description='Kassenumsatz Kaufland brutto AF VJ'),
kassenumsatz_sa_kl_absolut_brutto_vj OPTIONS(description='Kassenumsatz Kaufland brutto SA VJ'),
a21_kassenumsatz_kl_absolut_netto OPTIONS(description='Kassenumsatz Kaufland netto'), kassenumsatz_af_kl_absolut_netto
OPTIONS(description='Kassenumsatz Kaufland netto AF'), kassenumsatz_sa_kl_absolut_netto
OPTIONS(description='Kassenumsatz Kaufland netto SA'), kassenumsatz_kl_absolut_netto_vj
OPTIONS(description='Kassenumsatz Kaufland netto VJ'), kassenumsatz_af_kl_absolut_netto_vj
OPTIONS(description='Kassenumsatz Kaufland netto AF VJ'), kassenumsatz_sa_kl_absolut_netto_vj
OPTIONS(description='Kassenumsatz Kaufland netto SA VJ'), a17_absatz_kl OPTIONS(description='Gesamtabsatz'),
absatz_af_kl OPTIONS(description='Gesamtabsatz AF'), absatz_sa_kl OPTIONS(description='Gesamtabsatz SA'), absatz_kl_vj
OPTIONS(description='Gesamtabsatz VJ'), absatz_af_kl_vj OPTIONS(description='Gesamtabsatz AF VJ'), absatz_sa_kl_vj
OPTIONS(description='Gesamtabsatz SA VJ'), a76_absatz_sst1 OPTIONS(description='Absatz sst1'), a78_absatz_sst2
OPTIONS(description='Absatz sst2'), a80_absatz_sst3 OPTIONS(description='Absatz sst3'), a82_absatz_sst4
OPTIONS(description='Absatz sst4'), a84_absatz_sst5 OPTIONS(description='Absatz sst5'), a86_absatz_sst6
OPTIONS(description='Absatz sst6'), a88_absatz_sst7 OPTIONS(description='Absatz sst7'), a62_absatz_ksst1
OPTIONS(description='Absatz ksst1'), a64_absatz_ksst2 OPTIONS(description='Absatz ksst2'), a66_absatz_ksst3
OPTIONS(description='Absatz ksst3'), a68_absatz_ksst4 OPTIONS(description='Absatz ksst4'), a70_absatz_ksst5
OPTIONS(description='Absatz ksst5'), a72_absatz_ksst6 OPTIONS(description='Absatz ksst6'), a74_absatz_ksst7
OPTIONS(description='Absatz ksst7'), a90_absatz_ost_basis OPTIONS(description='Absatz Ost Basis'), a92_absatz_ost_gross
OPTIONS(description='Absatz Ost groß'), a94_absatz_sued_ost OPTIONS(description='Absatz Süd-Ost'), a96_absatz_sued_west
OPTIONS(description='Absatz Süd-West'), a98_absatz_west OPTIONS(description='Absatz West'), a100_absatz_nord
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
OPTIONS(description='Anzahl der Markt-Wochen-Kombis mit Abverkauf, in denen es mindestens an einem Tag von Mo-Sa eine Listung gab'),
anzahl_markt_wochen_kombis_listung
OPTIONS(description='Anzahl der Markt-Wochen-Kombis in denen es mindestens an einem Tag von Mo-Sa eine Listung gab'),
a31_vk_brutto_kl_pk_1 OPTIONS(description='VK Preis  brutto PM-ID 1 (Preiskategorie 1) aus Tabelle art_pm_vw_zu_per'),
a333_vk_brutto_kl_pk_2 OPTIONS(description='VK Preis  brutto PM-ID 2 (Preiskategorie 2) aus Tabelle art_pm_vw_zu_per'),
a54_vk_brutto_kl_pk_3 OPTIONS(description='VK Preis  brutto PM-ID 3 (Preiskategorie 3) aus Tabelle art_pm_vw_zu_per'),
a334_vk_brutto_kl_pk_4 OPTIONS(description='VK Preis  brutto PM-ID 4 (Preiskategorie 4) aus Tabelle art_pm_vw_zu_per'),
a432_vk_brutto_kl_pk_5 OPTIONS(description='VK Preis  brutto PM-ID 5 (Preiskategorie 5) aus Tabelle art_pm_vw_zu_per'),
a433_vk_brutto_kl_pk_6 OPTIONS(description='VK Preis  brutto PM-ID 6 (Preiskategorie 6) aus Tabelle art_pm_vw_zu_per'),
a434_vk_brutto_kl_pk_7 OPTIONS(description='VK Preis  brutto PM-ID 7 (Preiskategorie 7) aus Tabelle art_pm_vw_zu_per'),
a435_vk_brutto_kl_pk_8 OPTIONS(description='VK Preis  brutto PM-ID 8 (Preiskategorie 8) aus Tabelle art_pm_vw_zu_per'),
a436_vk_brutto_kl_pk_9 OPTIONS(description='VK Preis  brutto PM-ID 9 (Preiskategorie 9) aus Tabelle art_pm_vw_zu_per'),
a437_vk_brutto_kl_pk_10
OPTIONS(description='VK Preis  brutto PM-ID 10 (Preiskategorie 10) aus Tabelle art_pm_vw_zu_per'),
a30_kb_olk_ek4ndz_stamm
OPTIONS(description='Kalkulationsbasis aus Stammdaten aktuell analog SAL DE bzw. KMO EK4n DEZENTRAL aus Stammdaten aktuell'),
a23_rohertrag_ekmep_olk_4n
OPTIONS(description='Rohertrag berechnet aus artbew (umsatz_netto - ekmep + logkostenzuschlag)'), a51_listung_sst_pflege
OPTIONS(description='Sortimentsstufe (SST) gepflegt durch ZEK (für KMO ohne K-Sortimentsstufe)'),
a52_listung_k_sst_pflege OPTIONS(description='K-Sortimentsstufe (K_SST) gepflegt durch ZEK (nur KMO)'),
a426_ost_basis_pflege OPTIONS(description='Listung Ost Basis gepflegt durch ZEK'), a427_ost_gross_pflege
OPTIONS(description='Listung Ost Gross gepflegt durch ZEK'), a428_sued_ost_pflege
OPTIONS(description='Listung  Süd Ost  gepflegt durch ZEK'), a429_sued_west_pflege
OPTIONS(description='Listung  Süd West  gepflegt durch ZEK'), a430_west_pflege
OPTIONS(description='Listung  West gepflegt durch ZEK'), a431_nord_pflege
OPTIONS(description='Listung  Nord gepflegt durch ZEK'), a50_listungsaktion
OPTIONS(description='Nur befüllt, wenn ZEK Eingaben tätigt. Fall 1: ZEK wählt aus Optionen, werden direkt hier gespeichert. Fall 2: ZEK wählt Soll-Listung, der richtige Text wird vom BE ermittelt und in das Feld geschrieben.ID 0: keine ListungsaktionID 1: keine VeränderungID 2: nicht möglichID 3: SOLL-Listung = IST-ListungID 4: Neulistung KL-ArtikelID 5: Einlistung KauflandartikelID 6: Einlistung PotenzialartikelID 7: AuslistungID 8: Listung erweiternID 9: Listung reduzierenID 10: Listung erweitern und reduzierenID 11: Listung reduzieren und erweiternID 12: Zu weit in der Vergangenheit, Hochrechnungstabelle nicht gefüllt'),
a411_stk_rohertrag_pflege OPTIONS(description='Stück Rohertrag gepflegt durch ZEK für Potentialartikel'),
a415_kannibalisierungsfaktor
OPTIONS(description='Gepflegt durch User um die Hochrechnungen zu multiplizieren (passiert in der View)'),
a412_umsatz_brutto_hochrechnung
OPTIONS(description='Hochrechnung Umsatz (stored Procedure zur Laufzeit der Ermittlung)'), a413_absatz_hochrechnung
OPTIONS(description='Hochrechnung Absatz (stored Procedure zur Laufzeit der Ermittlung)'), a414_rohertrag_hochrechnung
OPTIONS(description='Hochrechnung Rohertrag (stored Procedure zur Laufzeit der Ermittlung)'),
a36_gewichtete_distribution_nielsen
OPTIONS(description='Gewichtete Verteilung Nielsen-Artikel (Pendant zu distribution_gewichtet KL-Daten)'),
a32_umsatz_anteil_wgi_nielsen OPTIONS(description='Anteil Umsatz innerhalb UWG ermittelt aus Nielsen-Daten'),
a33_umsatz_anteil_wgi_kumuliert_nielsen
OPTIONS(description='Anteil Umsatz innerhalb UWG ermittelt aus Nielsen-Daten kumuliert'),
a34_vk_brutto_durchschnitt_nielsen
OPTIONS(description='Durchschnittlicher VK (Wenn umsatz_brutto_af>0 Dann umsatz_brutto_af/menge_af Sonst umsatz_brutto_sa/menge_sa)'),
a35_umsatz_nielsen OPTIONS(description='Gesamtumsatz Nielsen-Artikel'), anz_wochen_de_anz_monate_kmo_nielsen
OPTIONS(description='Anzahl Wochen (DE) oder Monate (KMO) in denen der Nielsen-Artikel Daten hat'), absatz_nielsen
OPTIONS(description='wird im Fontend nicht verwendet - Prüfung, ob im BE noch verwendet wird?'),
a376_kl_marktanteil_wg_nielsen OPTIONS(description='Marktanteil Kaufland  (Nielsen Daten)'),
a380_marktanteilbewertung_nielsen OPTIONS(description='Marktanteilbewertung(wird im ETL-Prozess ermittelt)'),
a377_durchschnitt_anz_maerkte_nielsen OPTIONS(description='Durschnittliche Anzahl Märkte (Nielsen Daten)'),
a383_sales_units_verkaufseinheiten_gl_in_1000_normiert_nielsen
OPTIONS(description='Absatz Nielsen Artikel normiert auf Einheit (Liter, Kg, …).'),
a384_durchschn_preis_einheit_gl_normiert_nielsen
OPTIONS(description='Ø-VK Nielsen-Artikel normiert auf Einheit (Liter, Kg, …).'), a385_numerische_distribution_nielsen
OPTIONS(description='Numerische Distribution Nielsen.'), a386_inhaltsmengen_nielsen
OPTIONS(description='Liste an Inhaltsmengen (Liter, ML, Kg, Gramm, …) des Nielsen-Artikels.'),
a387_duft_geschmack_nielsen OPTIONS(description='Duft / Geschmacksrichtung (Nielsen Daten).'), a388_einheit_nielsen
OPTIONS(description='Einheiten, auf die sich der Werte in A386_INHALTSMENGEN_NIELSEN beziehen.'), eigenmarke_fg_nielsen
OPTIONS(description='eigenmarke_fg ermittelt aus Nielsen-Daten (1 = "SENSITIVE" oder "N/A "'), a39_listung_sst_mvke
OPTIONS(description='Listungsinformation (in KMO ohne K-Listung) - (MVKE - art_sm_vw_zu_per)'), a38_listung_k_sst_mvke
OPTIONS(description='K-Listungsinformation - (MVKE - art_sm_vw_zu_per) nur für KMO'), a40_ost_basis
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per)'),
a41_ost_gross
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per)'),
a42_sued_ost
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per)'),
a43_sued_west
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per)'),
a44_west
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per)'),
a45_nord
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per)'),
a37_listung_erster_markt
OPTIONS(description='min datum aller Artikel des Tupels aus art_list_wup_zu_per where list_quelle_id <> 2'),
a59_anz_maerkte_sst OPTIONS(description='Marktanzahl Sortimentsstufe (in KMO ohne "K") und Regio-Cluster (nur DE)'),
a449_anz_maerkte_k_sst OPTIONS(description='Marktanzahl K-Sortimentsstufe (nur KMO)'), a46_max_anz_maerkte_sst
OPTIONS(description='Anzahl der Märkte, die gelistet sein müssten, wenn die SST aus der MVKE tatsächlich auch gelistet wurde (aus WRF6) - DWH generiert'),
a47_max_anz_maerkte_k_sst
OPTIONS(description='Anzahl der Märkte, die gelistet sein müssten, wenn die K-SST aus der MVKE tatsächlich auch gelistet wurde (aus WRF6) - DWH generiert'),
a53_anz_maerkte_listung_gesamt
OPTIONS(description='Marktanzahl Listung gesamt (Distinct Marktzählung der gülitgen Listungseinträge aus art_list_wup_zu_per ohne Listungsquelle 2 (Aktionslistung))'),
a57_anz_maerkte_listung_einzel OPTIONS(description='Marktanzahl Einzellistung'), anz_maerkte_baustein_sonstige
OPTIONS(description='Marktanzahl Bausteine (ohne Duplikate) - für KMO alle Bausteine / für DE ohne Regio-Bausteine'),
anz_bons_af
OPTIONS(description='Zähler für: Bonreichweite aktionsfreie Ware aus Shopper (Verteilung über verschiedene WG hinweg)'),
anz_bons_sa
OPTIONS(description='Zähler für: Bonreichweite Sonderaktionsware aus Shopper (Verteilung über verschiedene WG hinweg)'),
anz_bons_gesamt OPTIONS(description='Nenner für: Bonreichweite AF und SA'), rohertrag_ekmep_olk_4n_vj
OPTIONS(description='Rohertrag berechnet aus artbew (umsatz_netto - ekmep + logkostenzuschlag)'),
rohertrag_ekmep_olk_4n_af
OPTIONS(description='Rohertrag berechnet aus artbew (umsatz_netto - ekmep + logkostenzuschlag)'),
rohertrag_ekmep_olk_4n_sa
OPTIONS(description='Rohertrag berechnet aus artbew (umsatz_netto - ekmep + logkostenzuschlag)'),
rohertrag_ekmep_olk_4n_af_vj
OPTIONS(description='hertrag berechnet aus artbew (umsatz_netto - ekmep + logkostenzuschlag)'),
rohertrag_ekmep_olk_4n_sa_vj
OPTIONS(description='Rohertrag berechnet aus artbew (umsatz_netto - ekmep + logkostenzuschlag)'),
a381_preislagenverteilung OPTIONS(description='Preislagenverteilung (wird im ETL-Prozess ermittelt)'),
a27_totalabschriften_wert_netto_absolut
OPTIONS(description='Abschriftensumme VK netto, DE alles außer AKZ -1, KMO alle Preisänderungen/Abschriften'),
a313_preisabschriften_preisanderungen_wert_netto_absolut
OPTIONS(description='Abschriften VK netto, nur Preisabschriften/Preisänderungen (Definition offen). Kann potenziell aus der Tabelle entfernt werden.'),
totalabschriften_wert_netto_absolut_vj
OPTIONS(description='Abschriftensumme VK netto VJ, nur Totalabschriften (Definition offen)'),
preisabschriften_preisanderungen_wert_netto_absolut_vj
OPTIONS(description='Abschriften VK netto VJ, nur Preisabschriften/Preisänderungen (Definition offen). Kann potenziell aus der Tabelle entfernt werden.'),
totalabschriften_wert_netto_absolut_wg
OPTIONS(description='Abschriftensumme VK netto, nur Totalabschriften (Definition offen), Gesamtsumme der WG'),
preisabschriften_preisanderungen_wert_netto_absolut_wg
OPTIONS(description='Abschriften VK netto, nur Preisabschriften/Preisänderungen (Definition offen), Gesamtsumme der WG. Kann potenziell aus der Tabelle entfernt werden.'),
a402_kolli_la OPTIONS(description='Kolliinhalt Lagerabgangsmenge'), a401_kolli_bst
OPTIONS(description='Kolliinhalt Bestellmenge'), a403_restlaufzeit_zl
OPTIONS(description='Restlaufzeit bei Anlieferung an Zentrallager'), a404_restlaufzeit_dz
OPTIONS(description='Restlaufzeit bei dezentraler Belieferung'), a405_basismengeneinheit
OPTIONS(description='Entspricht Verkaufsmengeneinheit'), a406_letzte_listungsanderung_sst_ksst
OPTIONS(description='Letzte Veränderung der Sortimentsttufenlistung aus Sternchenlogik'), a407_verhandler
OPTIONS(description='Verhandler INTEGER oder Land'), a408_display_komponente_kz
OPTIONS(description='Kennzeichen ob Artikel Display Displaykomponente ist'), a409_kl_art_id_display
OPTIONS(description='Alle Displayartikelnummern die im Tupel vorkommen'), a416_artikelrolle_id
OPTIONS(description='Vom EK definierte Rolle des Artikels'), kassenumsatz_kl_absolut_netto_wg
OPTIONS(description='Kassenumsatz Kaufland netto WG gesamt (zur Berechnung Abschriftenindex)'), anz_bons_tupel
OPTIONS(description='Anzahl Bons, auf denen der Artikel enthalten ist (AF+SA). Nenner für Restbon'), restbon_summe
OPTIONS(description='Summe Kassenumsatz netto aller Bons aller Artikel des Tupels. Zähler für Restbon'),
anz_bons_af_markt_tag
OPTIONS(description='Anzahl Bons, die an dem gesamten Markt-Tag produziert sind und auf denen der aktionsfreie (AF) Artikel, verkauft wurde.'),
anz_bons_sa_markt_tag
OPTIONS(description='Anzahl Bons, die an dem gesamten Markt-Tag produziert sind und auf denen der in Sonderaktion (SA) Artikel, verkauft wurde.'),
cpq_tupel OPTIONS(description='Cherrypicker Quote aus Shopper'), cp_bons_af
OPTIONS(description='Cherrpicker Bons AF auf denen der Artikel verkauft wurde '), cp_bons_sa
OPTIONS(description='Cherrpicker Bons SA auf denen der Artikel verkauft wurde '), umrech_faktor
OPTIONS(description='Gebindeberücksichtigung Flasche/Kiste'), lagerprozent
OPTIONS(description='Lagerprozentsatz, gibt an wieviel % der Restlaufzeit noch nicht abgelaufen sein darf, wenn der Artikel vom Lager ausgeliefert wird'),
absatz_af_kl_listungswochen
OPTIONS(description='Daten werden für eine Woche nur gezogen wenn am Samstag dieser Woche eine Listung vorhanden war'),
absatz_af_kl_vj_listungswochen
OPTIONS(description='Daten werden für eine Woche nur gezogen wenn am Samstag dieser Woche eine Listung vorhanden war'),
absatz_sa_kl_listungswochen
OPTIONS(description='Daten werden für eine Woche nur gezogen wenn am Samstag dieser Woche eine Listung vorhanden war'),
absatz_sa_kl_vj_listungswochen
OPTIONS(description='Daten werden für eine Woche nur gezogen wenn am Samstag dieser Woche eine Listung vorhanden war'),
kassenumsatz_af_kl_absolut_netto_listungswochen
OPTIONS(description='Daten werden für eine Woche nur gezogen wenn am Samstag dieser Woche eine Listung vorhanden war'),
kassenumsatz_af_kl_absolut_netto_vj_listungswochen
OPTIONS(description='Daten werden für eine Woche nur gezogen wenn am Samstag dieser Woche eine Listung vorhanden war'),
kassenumsatz_sa_kl_absolut_netto_listungswochen
OPTIONS(description='Daten werden für eine Woche nur gezogen wenn am Samstag dieser Woche eine Listung vorhanden war'),
kassenumsatz_sa_kl_absolut_netto_vj_listungswochen
OPTIONS(description='Daten werden für eine Woche nur gezogen wenn am Samstag dieser Woche eine Listung vorhanden war'),
rohertrag_ekmep_olk_4n_af_listungswochen
OPTIONS(description='Daten werden für eine Woche nur gezogen wenn am Samstag dieser Woche eine Listung vorhanden war'),
rohertrag_ekmep_olk_4n_af_vj_listungswochen
OPTIONS(description='Daten werden für eine Woche nur gezogen wenn am Samstag dieser Woche eine Listung vorhanden war'),
rohertrag_ekmep_olk_4n_sa_listungswochen
OPTIONS(description='Daten werden für eine Woche nur gezogen wenn am Samstag dieser Woche eine Listung vorhanden war'),
rohertrag_ekmep_olk_4n_sa_vj_listungswochen
OPTIONS(description='Daten werden für eine Woche nur gezogen wenn am Samstag dieser Woche eine Listung vorhanden war'),
a445_anz_tupel_listung_wgi OPTIONS(description='Anzahl von Tupel Listung'), sustain_concat
OPTIONS(description='Alle Nachhaltigkeitskennzeichen konkatiniert, mit Komma getrennt, alphabetisch sortiert.'),
check_fg OPTIONS(description='Check, if the data have been validated'), tupel_typ
OPTIONS(description='Used to distinguish between tupel types like KFL, Nielsen and Custom Articles.'),
a471_marke_nielsen_bez OPTIONS(description='Marken aus Quelle Nielsen.'), a515_bio_organic_nielsen_kz
OPTIONS(description='Label Bio, nicht Bio, N/A oder unbekannt, aus Quelle Nielsen.'), a516_veggy_split_nielsen_kz
OPTIONS(description='Label Vegetarisch, Vegan, N/A oder normal, aus Quelle Nielsen.'), a517_laktosefrei_nielsen_kz
OPTIONS(description='Label laktosefrei, N/A oder normal, aus Quelle Nielsen.'), a518_glutenfrei_nielsen_kz
OPTIONS(description='Label mit Gluten, ohne Gluten oder N/A, aus Quelle Nielsen.'), a510_muki_ek_kz
OPTIONS(description='Mutter-Kind-Kennzeichen (MUKI-KZ) aus SAP.'), a511_muki_ek_kl_art_id_verkettung
OPTIONS(description='Alle kl_art_ids der betroffenn Mutter-Kind-Beziehung.'), a512_muki_wb_kz
OPTIONS(description='Mutter-Kind-Kennzeichen (MUKI-KZ) aus Quelle SAP.'), a513_muki_wb_kl_art_id_verkettung
OPTIONS(description='Alle kl_art_ids der betroffenn Mutter-Kind-Beziehung.'), a519_umsatz_anteil_wg_nielsen
OPTIONS(description='Anteil Nielsen-Umsatz des Artikels am Nielsen-Umsatz der KL-WG in Summe.'),
a520_umsatz_anteil_wg_kumuliert_nielsen
OPTIONS(description='Anteil Nielsen-Umsatz des Artikels am Nielsen-Umsatz der KL-WG in Summe, Kumulation nach Rang aufsteigend.'),
a521_inhalt_menge OPTIONS(description='Inhaltsmenge aus SAP.'))
OPTIONS(DESCRIPTION = `EK_SORT - Faktentabelle - auf Ebene Tupel (Gruppierung aus n KL-Artikeln inkl. gematchten Artikeln vom Marktforschungsinstitut Nielsen) historisiert nach MAT (moving anual total) und KW. Es ist eine Zwischentabelle für BC und FB EK SORT um Daten auszusieben und zu entscheiden, was zur Analyse in die Tabelle tupel_mat soll. Enhällt auch Aggregationen für Spalten aus Tabelle art_nielsen.`)
AS SELECT mandant_id,
 a500_kjwo_update,
 matching_id,
 a425_kjmo,
 wrg_id,
 a5_owg_id,
 a7_wg_id,
 wug_id,
 art_id,
 kl_art_id,
 a450_art_nielsen_nr,
 art_bez_deutsch,
 a14_art_status_de,
 nielsen_art_bez,
 nielsen_gtin,
 a58_rang_umsatz_owg,
 a2_rang_umsatz_wg,
 a59_rang_absatz_wg,
 a16_akt_lieferant_id,
 a419_hersteller_id,
 a446_lieferant_bez_latein,
 a447_hersteller_bez_latein,
 lieferant_nielsen,
 a389_zek_id,
 a391_disc_pe,
 a392_disc_ohne_etikett,
 a400_lcf,
 a393_vegan,
 a394_gluten,
 a395_bio,
 a396_eigenmarke,
 a397_tierwohl,
 a398_posten_food,
 a399_posten_nonfood,
 a339_umsatzsteuer,
 a60_muki_vk_kz,
 a61_muki_vk_kl_art_id_verkettung,
 anzahl_markt_wochen_kombis_abverkauf_af,
 anzahl_markt_wochen_kombis_abverkauf_sa,
 anzahl_markt_wochen_kombis_abverkauf_af_vj,
 anzahl_markt_wochen_kombis_abverkauf_sa_vj,
 a273_kassenumsatz_kl_absolut_brutto,
 kassenumsatz_af_kl_absolut_brutto,
 kassenumsatz_sa_kl_absolut_brutto,
 kassenumsatz_kl_absolut_brutto_vj,
 kassenumsatz_af_kl_absolut_brutto_vj,
 kassenumsatz_sa_kl_absolut_brutto_vj,
 a21_kassenumsatz_kl_absolut_netto,
 kassenumsatz_af_kl_absolut_netto,
 kassenumsatz_sa_kl_absolut_netto,
 kassenumsatz_kl_absolut_netto_vj,
 kassenumsatz_af_kl_absolut_netto_vj,
 kassenumsatz_sa_kl_absolut_netto_vj,
 a17_absatz_kl,
 absatz_af_kl,
 absatz_sa_kl,
 absatz_kl_vj,
 absatz_af_kl_vj,
 absatz_sa_kl_vj,
 a76_absatz_sst1,
 a78_absatz_sst2,
 a80_absatz_sst3,
 a82_absatz_sst4,
 a84_absatz_sst5,
 a86_absatz_sst6,
 a88_absatz_sst7,
 a62_absatz_ksst1,
 a64_absatz_ksst2,
 a66_absatz_ksst3,
 a68_absatz_ksst4,
 a70_absatz_ksst5,
 a72_absatz_ksst6,
 a74_absatz_ksst7,
 a90_absatz_ost_basis,
 a92_absatz_ost_gross,
 a94_absatz_sued_ost,
 a96_absatz_sued_west,
 a98_absatz_west,
 a100_absatz_nord,
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
 a31_vk_brutto_kl_pk_1,
 a333_vk_brutto_kl_pk_2,
 a54_vk_brutto_kl_pk_3,
 a334_vk_brutto_kl_pk_4,
 a432_vk_brutto_kl_pk_5,
 a433_vk_brutto_kl_pk_6,
 a434_vk_brutto_kl_pk_7,
 a435_vk_brutto_kl_pk_8,
 a436_vk_brutto_kl_pk_9,
 a437_vk_brutto_kl_pk_10,
 a30_kb_olk_ek4ndz_stamm,
 a23_rohertrag_ekmep_olk_4n,
 a51_listung_sst_pflege,
 a52_listung_k_sst_pflege,
 a426_ost_basis_pflege,
 a427_ost_gross_pflege,
 a428_sued_ost_pflege,
 a429_sued_west_pflege,
 a430_west_pflege,
 a431_nord_pflege,
 a50_listungsaktion,
 a411_stk_rohertrag_pflege,
 a415_kannibalisierungsfaktor,
 a412_umsatz_brutto_hochrechnung,
 a413_absatz_hochrechnung,
 a414_rohertrag_hochrechnung,
 a36_gewichtete_distribution_nielsen,
 a32_umsatz_anteil_wgi_nielsen,
 a33_umsatz_anteil_wgi_kumuliert_nielsen,
 a34_vk_brutto_durchschnitt_nielsen,
 a35_umsatz_nielsen,
 anz_wochen_de_anz_monate_kmo_nielsen,
 absatz_nielsen,
 a376_kl_marktanteil_wg_nielsen,
 a380_marktanteilbewertung_nielsen,
 a377_durchschnitt_anz_maerkte_nielsen,
 a383_sales_units_verkaufseinheiten_gl_in_1000_normiert_nielsen,
 a384_durchschn_preis_einheit_gl_normiert_nielsen,
 a385_numerische_distribution_nielsen,
 a386_inhaltsmengen_nielsen,
 a387_duft_geschmack_nielsen,
 a388_einheit_nielsen,
 eigenmarke_fg_nielsen,
 a39_listung_sst_mvke,
 a38_listung_k_sst_mvke,
 a40_ost_basis,
 a41_ost_gross,
 a42_sued_ost,
 a43_sued_west,
 a44_west,
 a45_nord,
 a37_listung_erster_markt,
 a59_anz_maerkte_sst,
 a449_anz_maerkte_k_sst,
 a46_max_anz_maerkte_sst,
 a47_max_anz_maerkte_k_sst,
 a53_anz_maerkte_listung_gesamt,
 a57_anz_maerkte_listung_einzel,
 anz_maerkte_baustein_sonstige,
 anz_bons_af,
 anz_bons_sa,
 anz_bons_gesamt,
 rohertrag_ekmep_olk_4n_vj,
 rohertrag_ekmep_olk_4n_af,
 rohertrag_ekmep_olk_4n_sa,
 rohertrag_ekmep_olk_4n_af_vj,
 rohertrag_ekmep_olk_4n_sa_vj,
 a381_preislagenverteilung,
 a27_totalabschriften_wert_netto_absolut,
 a313_preisabschriften_preisanderungen_wert_netto_absolut,
 totalabschriften_wert_netto_absolut_vj,
 preisabschriften_preisanderungen_wert_netto_absolut_vj,
 totalabschriften_wert_netto_absolut_wg,
 preisabschriften_preisanderungen_wert_netto_absolut_wg,
 a402_kolli_la,
 a401_kolli_bst,
 a403_restlaufzeit_zl,
 a404_restlaufzeit_dz,
 a405_basismengeneinheit,
 a406_letzte_listungsanderung_sst_ksst,
 a407_verhandler,
 a408_display_komponente_kz,
 a409_kl_art_id_display,
 a416_artikelrolle_id,
 kassenumsatz_kl_absolut_netto_wg,
 anz_bons_tupel,
 restbon_summe,
 anz_bons_af_markt_tag,
 anz_bons_sa_markt_tag,
 cpq_tupel,
 cp_bons_af,
 cp_bons_sa,
 umrech_faktor,
 lagerprozent,
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
 rohertrag_ekmep_olk_4n_sa_vj_listungswochen,
 a445_anz_tupel_listung_wgi,
 sustain_concat,
 check_fg,
 tupel_typ,
 a471_marke_nielsen_bez,
 a515_bio_organic_nielsen_kz,
 a516_veggy_split_nielsen_kz,
 a517_laktosefrei_nielsen_kz,
 a518_glutenfrei_nielsen_kz,
 a510_muki_ek_kz,
 a511_muki_ek_kl_art_id_verkettung,
 a512_muki_wb_kz,
 a513_muki_wb_kl_art_id_verkettung,
 a519_umsatz_anteil_wg_nielsen,
 a520_umsatz_anteil_wg_kumuliert_nielsen,
 a521_inhalt_menge
FROM kfl_production_dbp_msi_data.tupel_mat_quarantaene;