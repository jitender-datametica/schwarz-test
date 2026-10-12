CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_MSI_DATA.TUPEL_MAT_1 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
A500_KJWO_UPDATE INTEGER NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
MATCHING_ID INTEGER NOT NULL
OPTIONS(description='Gruppierungskriterium für Artikel_1 (kann auch nur ein Artikel_1 sein), die über die GTIN zu Nielsen-Artikel_1 gematched werden'),
A425_KJMO INTEGER NOT NULL OPTIONS(description='Monat_1 eines Kalenderjahres, Format JJJJMM'),
A5_OWG_ID INTEGER OPTIONS(description='ID Kaufland Oberwarengruppe für Nielsen-Daten (Vergabe im Beladeprozess)'),
A7_WG_ID INTEGER OPTIONS(description='ID Kaufland Warengruppen für Nielsen-Daten (Vergabe im Beladeprozess)'),
WUG_ID INTEGER OPTIONS(description='ID der Warenuntergruppe'),
ART_ID INTEGER
OPTIONS(description='Führende Artikelnummer: Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
KL_ART_ID STRING(1000) COLLATE 'und:ci'
OPTIONS(description='7-stellige Artikelnummer bestehend aus 2 Stellen: Warengruppe 4 Stellen: Artikelnummer 1 Stelle: Prüfziffer'),
A450_ART_NIELSEN_NR INTEGER OPTIONS(description='Artikelnummer bei Nielsen'),
ART_BEZ_DEUTSCH STRING(50) COLLATE 'und:ci' OPTIONS(description='Artikelbezeichnung deutsch spr_id 22'),
A14_ART_STATUS_DE STRING(2) COLLATE 'und:ci'
OPTIONS(description='Löschkennzeichen aus DE (L:gelöscht; R:räumen; Blank:aktiv; Null: KMO)'),
NIELSEN_ART_BEZ STRING(5000) COLLATE 'und:ci' OPTIONS(description='Liste an Artikelbezeichnungen aus Nielsen.'),
NIELSEN_GTIN STRING(5000) COLLATE 'und:ci' OPTIONS(description='Global Trade Item_1 Number (GTIN)'),
A58_RANG_UMSATZ_OWG INTEGER
OPTIONS(description='Rang matching_id innerhalb OWG auf Basis Umsatz (wird im ETL-Prozess ermittelt)'),
A2_RANG_UMSATZ_WG INTEGER
OPTIONS(description='Rang matching_id innerhalb WG auf Basis Umsatz (wird im ETL-Prozess ermittelt)'),
A59_RANG_ABSATZ_WG INTEGER
OPTIONS(description='Rang matching_id innerhalb WG auf Basis Absatz (wird im ETL-Prozess ermittelt)'),
A16_AKT_LIEFERANT_ID STRING(60) COLLATE 'und:ci'
OPTIONS(description='Aktueller Lieferant (gp_id) aus art_gp_zu_per_1 mit dat_bis 31.12.9999'),
A419_HERSTELLER_ID STRING(60) COLLATE 'und:ci'
OPTIONS(description='Nur DE: Wenn Hersteller von Lieferant abweicht wird hersteller_id abweichend von gp_id angezeigt, ansonsten leer.'),
A446_LIEFERANT_BEZ_LATEIN STRING(100) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung zur gp_id aus gp_1 (aus BG anderes Quellfeld mit lateinischen Buchstaben)'),
A447_HERSTELLER_BEZ_LATEIN STRING(100) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung zur gp_id aus gp_1 (aus BG anderes Quellfeld mit lateinischen Buchstaben)'),
LIEFERANT_NIELSEN STRING(5000) COLLATE 'und:ci' OPTIONS(description='Liste an Lieferantennamen aus Nielsen.'),
A391_DISC_PE INTEGER OPTIONS(description='Discount Kennzeichen PE (Herkunft noch klären!)'),
A392_DISC_OHNE_ETIKETT INTEGER OPTIONS(description='Discount Kennzeichen Marke (artkz_discount_1)'),
A400_LCF STRING(1) COLLATE 'und:ci' OPTIONS(description='lactose_fg aus Tabelle art_1'),
A393_VEGAN STRING(1) COLLATE 'und:ci' OPTIONS(description='vegan_fg aus Tabelle art_1'),
A394_GLUTEN STRING(1) COLLATE 'und:ci' OPTIONS(description='gluten_fg aus Tabelle art_1'),
A395_BIO STRING(1) COLLATE 'und:ci' OPTIONS(description='bio_fg aus Tabelle art_1'),
A396_EIGENMARKE STRING(2) COLLATE 'und:ci' OPTIONS(description='eigenmarke_fg_kl aus Tabelle art_1'),
A397_TIERWOHL STRING(10) COLLATE 'und:ci' OPTIONS(description='tierwohl_fg aus Tabelle art_1'),
A398_POSTEN_FOOD STRING(2) COLLATE 'und:ci' OPTIONS(description='Flag Posten Food (abgeleitet aus artkz_posten_1)'),
A399_POSTEN_NONFOOD STRING(2) COLLATE 'und:ci' OPTIONS(description='Flag Posten NonFood (abgeleitet aus artkz_posten_1)'),
A339_UMSATZSTEUER NUMERIC(12,2) OPTIONS(description='Mehrwertsteuersatz'),
A60_MUKI_VK_KZ STRING(5) COLLATE 'und:ci'
OPTIONS(description='Zeigt mit W/M/K an, ob und wie Artikel_1 der Matching ID in VK_1-Muki sind'),
A61_MUKI_VK_KL_ART_ID_VERKETTUNG STRING(300) COLLATE 'und:ci'
OPTIONS(description='Liste alle VK_1-Mütter auf, die an Artikeln der Matching-ID beteiligt sind'),
ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_AF INTEGER
OPTIONS(description='Zählung der Markt-Tag_1 Kombinationen Abverkauf AF /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'),
ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_SA INTEGER
OPTIONS(description='Zählung der Markt-Tag_1 Kombinationen Abverkauf SA /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'),
ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_AF_VJ INTEGER
OPTIONS(description='Zählung der Markt-Tag_1 Kombinationen Abverkauf AF VJ /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'),
ANZAHL_MARKT_WOCHEN_KOMBIS_ABVERKAUF_SA_VJ INTEGER
OPTIONS(description='Zählung der Markt-Tag_1 Kombinationen Abverkauf SA VJ /7 (nicht Anzahl Wochen da es AF/SA Mischwochen gibt)'),
A273_KASSENUMSATZ_KL_ABSOLUT_BRUTTO NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland brutto'),
KASSENUMSATZ_AF_KL_ABSOLUT_BRUTTO NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland brutto AF'),
KASSENUMSATZ_SA_KL_ABSOLUT_BRUTTO NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland brutto SA'),
KASSENUMSATZ_KL_ABSOLUT_BRUTTO_VJ NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland brutto'),
KASSENUMSATZ_AF_KL_ABSOLUT_BRUTTO_VJ NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland brutto AF VJ'),
KASSENUMSATZ_SA_KL_ABSOLUT_BRUTTO_VJ NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland brutto SA VJ'),
A21_KASSENUMSATZ_KL_ABSOLUT_NETTO NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland netto'),
KASSENUMSATZ_AF_KL_ABSOLUT_NETTO NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland netto AF'),
KASSENUMSATZ_SA_KL_ABSOLUT_NETTO NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland netto SA'),
KASSENUMSATZ_KL_ABSOLUT_NETTO_VJ NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland netto VJ'),
KASSENUMSATZ_AF_KL_ABSOLUT_NETTO_VJ NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland netto AF VJ'),
KASSENUMSATZ_SA_KL_ABSOLUT_NETTO_VJ NUMERIC(18,4) OPTIONS(description='Kassenumsatz Kaufland netto SA VJ'),
A17_ABSATZ_KL NUMERIC(18,4) OPTIONS(description='Gesamtabsatz'),
ABSATZ_AF_KL NUMERIC(18,4) OPTIONS(description='Gesamtabsatz AF'),
ABSATZ_SA_KL NUMERIC(18,4) OPTIONS(description='Gesamtabsatz SA'),
ABSATZ_KL_VJ NUMERIC(18,4) OPTIONS(description='Gesamtabsatz VJ'),
ABSATZ_AF_KL_VJ NUMERIC(18,4) OPTIONS(description='Gesamtabsatz AF VJ'),
ABSATZ_SA_KL_VJ NUMERIC(18,4) OPTIONS(description='Gesamtabsatz SA VJ'),
A76_ABSATZ_SST1 NUMERIC(18,4) OPTIONS(description='Absatz sst1'),
A78_ABSATZ_SST2 NUMERIC(18,4) OPTIONS(description='Absatz sst2'),
A80_ABSATZ_SST3 NUMERIC(18,4) OPTIONS(description='Absatz sst3'),
A82_ABSATZ_SST4 NUMERIC(18,4) OPTIONS(description='Absatz sst4'),
A84_ABSATZ_SST5 NUMERIC(18,4) OPTIONS(description='Absatz sst5'),
A86_ABSATZ_SST6 NUMERIC(18,4) OPTIONS(description='Absatz sst6'),
A88_ABSATZ_SST7 NUMERIC(18,4) OPTIONS(description='Absatz sst7'),
A62_ABSATZ_KSST1 NUMERIC(18,4) OPTIONS(description='Absatz ksst1'),
A64_ABSATZ_KSST2 NUMERIC(18,4) OPTIONS(description='Absatz ksst2'),
A66_ABSATZ_KSST3 NUMERIC(18,4) OPTIONS(description='Absatz ksst3'),
A68_ABSATZ_KSST4 NUMERIC(18,4) OPTIONS(description='Absatz ksst4'),
A70_ABSATZ_KSST5 NUMERIC(18,4) OPTIONS(description='Absatz ksst5'),
A72_ABSATZ_KSST6 NUMERIC(18,4) OPTIONS(description='Absatz ksst6'),
A74_ABSATZ_KSST7 NUMERIC(18,4) OPTIONS(description='Absatz ksst7'),
A90_ABSATZ_OST_BASIS NUMERIC(18,4) OPTIONS(description='Absatz Ost Basis'),
A92_ABSATZ_OST_GROSS NUMERIC(18,4) OPTIONS(description='Absatz Ost groß'),
A94_ABSATZ_SUED_OST NUMERIC(18,4) OPTIONS(description='Absatz Süd-Ost'),
A96_ABSATZ_SUED_WEST NUMERIC(18,4) OPTIONS(description='Absatz Süd-West'),
A98_ABSATZ_WEST NUMERIC(18,4) OPTIONS(description='Absatz West'),
A100_ABSATZ_NORD NUMERIC(18,4) OPTIONS(description='Absatz Nord'),
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
A31_VK_BRUTTO_KL_PK_1 NUMERIC(18,4)
OPTIONS(description='VK_1 Preis  brutto PM_1-ID 1 (Preiskategorie 1) aus Tabelle art_pm_vw_zu_per_1'),
A333_VK_BRUTTO_KL_PK_2 NUMERIC(18,4)
OPTIONS(description='VK_1 Preis  brutto PM_1-ID 2 (Preiskategorie 2) aus Tabelle art_pm_vw_zu_per_1'),
A54_VK_BRUTTO_KL_PK_3 NUMERIC(18,4)
OPTIONS(description='VK_1 Preis  brutto PM_1-ID 3 (Preiskategorie 3) aus Tabelle art_pm_vw_zu_per_1'),
A334_VK_BRUTTO_KL_PK_4 NUMERIC(18,4)
OPTIONS(description='VK_1 Preis  brutto PM_1-ID 4 (Preiskategorie 4) aus Tabelle art_pm_vw_zu_per_1'),
A432_VK_BRUTTO_KL_PK_5 NUMERIC(18,4)
OPTIONS(description='VK_1 Preis  brutto PM_1-ID 5 (Preiskategorie 5) aus Tabelle art_pm_vw_zu_per_1'),
A433_VK_BRUTTO_KL_PK_6 NUMERIC(18,4)
OPTIONS(description='VK_1 Preis  brutto PM_1-ID 6 (Preiskategorie 6) aus Tabelle art_pm_vw_zu_per_1'),
A434_VK_BRUTTO_KL_PK_7 NUMERIC(18,4)
OPTIONS(description='VK_1 Preis  brutto PM_1-ID 7 (Preiskategorie 7) aus Tabelle art_pm_vw_zu_per_1'),
A435_VK_BRUTTO_KL_PK_8 NUMERIC(18,4)
OPTIONS(description='VK_1 Preis  brutto PM_1-ID 8 (Preiskategorie 8) aus Tabelle art_pm_vw_zu_per_1'),
A436_VK_BRUTTO_KL_PK_9 NUMERIC(18,4)
OPTIONS(description='VK_1 Preis  brutto PM_1-ID 9 (Preiskategorie 9) aus Tabelle art_pm_vw_zu_per_1'),
A437_VK_BRUTTO_KL_PK_10 NUMERIC(18,4)
OPTIONS(description='VK_1 Preis  brutto PM_1-ID 10 (Preiskategorie 10) aus Tabelle art_pm_vw_zu_per_1'),
A30_KB_OLK_EK4NDZ_STAMM NUMERIC(18,4)
OPTIONS(description='Kalkulationsbasis aus Stammdaten aktuell analog SAL DE bzw. KMO EK4n DEZENTRAL aus Stammdaten aktuell'),
A23_ROHERTRAG_EKMEP_OLK_4N NUMERIC(18,4)
OPTIONS(description='Rohertrag berechnet aus artbew_1 (umsatz_netto - ekmep + logkostenzuschlag)'),
A51_LISTUNG_SST_PFLEGE STRING(4) COLLATE 'und:ci'
OPTIONS(description='Sortimentsstufe (SST) gepflegt durch ZEK_1 (für KMO ohne K-Sortimentsstufe)'),
A52_LISTUNG_K_SST_PFLEGE STRING(4) COLLATE 'und:ci'
OPTIONS(description='K-Sortimentsstufe (K_SST) gepflegt durch ZEK_1 (nur KMO)'),
A426_OST_BASIS_PFLEGE STRING(4) COLLATE 'und:ci' OPTIONS(description='Listung Ost Basis gepflegt durch ZEK_1'),
A427_OST_GROSS_PFLEGE STRING(4) COLLATE 'und:ci' OPTIONS(description='Listung Ost Gross gepflegt durch ZEK_1'),
A428_SUED_OST_PFLEGE STRING(4) COLLATE 'und:ci' OPTIONS(description='Listung  Süd Ost  gepflegt durch ZEK_1'),
A429_SUED_WEST_PFLEGE STRING(4) COLLATE 'und:ci' OPTIONS(description='Listung  Süd West  gepflegt durch ZEK_1'),
A430_WEST_PFLEGE STRING(4) COLLATE 'und:ci' OPTIONS(description='Listung  West gepflegt durch ZEK_1'),
A431_NORD_PFLEGE STRING(4) COLLATE 'und:ci' OPTIONS(description='Listung  Nord gepflegt durch ZEK_1'),
A50_LISTUNGSAKTION STRING(255) COLLATE 'und:ci'
OPTIONS(description='Nur befüllt, wenn ZEK_1 Eingaben tätigt. Fall 1: ZEK_1 wählt aus Optionen, werden direkt hier gespeichert. Fall 2: ZEK_1 wählt Soll-Listung, der richtige Text wird vom BE ermittelt und in das Feld geschrieben.\n            ID 0: keine Listungsaktion\n            ID 1: keine Veränderung\n            ID 2: nicht möglich\n            ID 3: SOLL-Listung = IST-Listung\n            ID 4: Neulistung KL-Artikel_1\n            ID 5: Einlistung Kauflandartikel\n            ID 6: Einlistung Potenzialartikel\n            ID 7: Auslistung\n            ID 8: Listung erweitern\n            ID 9: Listung reduzieren\n            ID 10: Listung erweitern und reduzieren\n            ID 11: Listung reduzieren und erweitern\n            ID 12: Zu weit in der Vergangenheit, Hochrechnungstabelle nicht gefüllt'),
A411_STK_ROHERTRAG_PFLEGE STRING(255) COLLATE 'und:ci'
OPTIONS(description='Stück Rohertrag gepflegt durch ZEK_1 für Potentialartikel'),
A415_KANNIBALISIERUNGSFAKTOR NUMERIC(18,4)
OPTIONS(description='Gepflegt durch User um die Hochrechnungen zu multiplizieren (passiert in der View)'),
A412_UMSATZ_BRUTTO_HOCHRECHNUNG NUMERIC(18,4)
OPTIONS(description='Hochrechnung Umsatz (stored Procedure zur Laufzeit der Ermittlung)'),
A413_ABSATZ_HOCHRECHNUNG NUMERIC(18,4)
OPTIONS(description='Hochrechnung Absatz (stored Procedure zur Laufzeit der Ermittlung)'),
A414_ROHERTRAG_HOCHRECHNUNG NUMERIC(18,4)
OPTIONS(description='Hochrechnung Rohertrag (stored Procedure zur Laufzeit der Ermittlung)'),
A36_GEWICHTETE_DISTRIBUTION_NIELSEN NUMERIC(18,4)
OPTIONS(description='Gewichtete Verteilung Nielsen-Artikel_1 (Pendant zu distribution_gewichtet KL-Daten)'),
A32_UMSATZ_ANTEIL_WGI_NIELSEN NUMERIC(18,4)
OPTIONS(description='Anteil Umsatz innerhalb UWG ermittelt aus Nielsen-Daten'),
A33_UMSATZ_ANTEIL_WGI_KUMULIERT_NIELSEN NUMERIC(18,4)
OPTIONS(description='Anteil Umsatz innerhalb UWG ermittelt aus Nielsen-Daten kumuliert'),
A34_VK_BRUTTO_DURCHSCHNITT_NIELSEN NUMERIC(18,4)
OPTIONS(description='Durchschnittlicher VK_1 (Wenn umsatz_brutto_af>0 Dann umsatz_brutto_af/menge_af Sonst umsatz_brutto_sa/menge_sa)'),
A35_UMSATZ_NIELSEN NUMERIC(18,4) OPTIONS(description='Gesamtumsatz Nielsen-Artikel_1'),
ANZ_WOCHEN_DE_ANZ_MONATE_KMO_NIELSEN INTEGER
OPTIONS(description='Anzahl Wochen (DE) oder Monate (KMO) in denen der Nielsen-Artikel_1 Daten hat'),
ABSATZ_NIELSEN NUMERIC(18,4)
OPTIONS(description='wird im Fontend nicht verwendet - Prüfung, ob im BE noch verwendet wird?'),
A376_KL_MARKTANTEIL_WG_NIELSEN NUMERIC(18,4) OPTIONS(description='Marktanteil Kaufland  (Nielsen Daten)'),
A380_MARKTANTEILBEWERTUNG_NIELSEN NUMERIC(18,4)
OPTIONS(description='Marktanteilbewertung(wird im ETL-Prozess ermittelt)'),
A377_DURCHSCHNITT_ANZ_MAERKTE_NIELSEN INTEGER OPTIONS(description='Durschnittliche Anzahl Märkte (Nielsen Daten)'),
A383_SALES_UNITS_VERKAUFSEINHEITEN_GL_IN_1000_NORMIERT_NIELSEN NUMERIC(18,4)
OPTIONS(description='Absatz Nielsen Artikel_1 normiert auf Einheit (Liter, Kg, …).'),
A384_DURCHSCHN_PREIS_EINHEIT_GL_NORMIERT_NIELSEN NUMERIC(18,4)
OPTIONS(description='Ø-VK_1 Nielsen-Artikel_1 normiert auf Einheit (Liter, Kg, …).'),
A385_NUMERISCHE_DISTRIBUTION_NIELSEN NUMERIC(18,4) OPTIONS(description='Numerische Distribution Nielsen.'),
A386_INHALTSMENGEN_NIELSEN STRING(4000)
OPTIONS(description='Liste an Inhaltsmengen (Liter, ML, Kg, Gramm, …) des Nielsen-Artikels.'),
A387_DUFT_GESCHMACK_NIELSEN STRING(4000) COLLATE 'und:ci'
OPTIONS(description='Duft / Geschmacksrichtung (Nielsen Daten).'),
A388_EINHEIT_NIELSEN STRING(4000) COLLATE 'und:ci'
OPTIONS(description='Einheit, auf die sich die Werte in A386_INHALTSMENGEN_NIELSEN beziehen.'),
EIGENMARKE_FG_NIELSEN INTEGER
OPTIONS(description='eigenmarke_fg ermittelt aus Nielsen-Daten (1 =\"SENSITIVE\" oder\"N/A\"'),
A39_LISTUNG_SST_MVKE STRING(4) COLLATE 'und:ci'
OPTIONS(description='Listungsinformation (in KMO ohne K-Listung) - (MVKE_1 - art_sm_vw_zu_per_1)'),
A38_LISTUNG_K_SST_MVKE STRING(4) COLLATE 'und:ci'
OPTIONS(description='K-Listungsinformation - (MVKE_1 - art_sm_vw_zu_per_1) nur für KMO'),
A40_OST_BASIS STRING(1) COLLATE 'und:ci'
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per_1)'),
A41_OST_GROSS STRING(1) COLLATE 'und:ci'
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per_1)'),
A42_SUED_OST STRING(1) COLLATE 'und:ci'
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per_1)'),
A43_SUED_WEST STRING(1) COLLATE 'und:ci'
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per_1)'),
A44_WEST STRING(1) COLLATE 'und:ci'
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per_1)'),
A45_NORD STRING(1) COLLATE 'und:ci'
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per_1)'),
A37_LISTUNG_ERSTER_MARKT DATE
OPTIONS(description='min datum aller Artikel_1 des Tupels aus art_list_wup_zu_per_1 where list_quelle_id <> 2'),
A59_ANZ_MAERKTE_SST INTEGER
OPTIONS(description='Marktanzahl Sortimentsstufe (in KMO ohne\"K\") und Regio-Cluster (nur DE)'),
A449_ANZ_MAERKTE_K_SST INTEGER OPTIONS(description='Marktanzahl K-Sortimentsstufe (nur KMO)'),
A46_MAX_ANZ_MAERKTE_SST INTEGER
OPTIONS(description='Anzahl der Märkte, die gelistet sein müssten, wenn die SST aus der MVKE_1 tatsächlich auch gelistet wurde (aus WRF6) - DWH generiert'),
A47_MAX_ANZ_MAERKTE_K_SST INTEGER
OPTIONS(description='Anzahl der Märkte, die gelistet sein müssten, wenn die K-SST aus der MVKE_1 tatsächlich auch gelistet wurde (aus WRF6) - DWH generiert'),
A53_ANZ_MAERKTE_LISTUNG_GESAMT INTEGER
OPTIONS(description='Marktanzahl Listung gesamt (Distinct Marktzählung der gülitgen Listungseinträge aus art_list_wup_zu_per_1 ohne Listungsquelle 2 (Aktionslistung))'),
A57_ANZ_MAERKTE_LISTUNG_EINZEL INTEGER OPTIONS(description='Marktanzahl Einzellistung'),
ANZ_MAERKTE_BAUSTEIN_SONSTIGE INTEGER
OPTIONS(description='Marktanzahl Bausteine (ohne Duplikate) - für KMO alle Bausteine / für DE ohne Regio-Bausteine'),
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
A381_PREISLAGENVERTEILUNG NUMERIC(18,4) OPTIONS(description='Preislagenverteilung (wird im ETL-Prozess ermittelt)'),
A27_TOTALABSCHRIFTEN_WERT_NETTO_ABSOLUT NUMERIC(18,4)
OPTIONS(description='Abschriftensumme VK_1 netto, DE alles außer AKZ -1, KMO alle Preisänderungen/Abschriften_1'),
A313_PREISABSCHRIFTEN_PREISANDERUNGEN_WERT_NETTO_ABSOLUT NUMERIC(18,4)
OPTIONS(description='Abschriften_1 VK_1 netto, nur Preisabschriften/Preisänderungen (Definition offen). Kann potenziell aus der Tabelle entfernt werden.'),
TOTALABSCHRIFTEN_WERT_NETTO_ABSOLUT_VJ NUMERIC(18,4)
OPTIONS(description='Abschriftensumme VK_1 netto VJ, nur Totalabschriften (Definition offen)'),
PREISABSCHRIFTEN_PREISANDERUNGEN_WERT_NETTO_ABSOLUT_VJ NUMERIC(18,4)
OPTIONS(description='Abschriften_1 VK_1 netto VJ, nur Preisabschriften/Preisänderungen (Definition offen). Kann potenziell aus der Tabelle entfernt werden.'),
TOTALABSCHRIFTEN_WERT_NETTO_ABSOLUT_WG NUMERIC(18,4)
OPTIONS(description='Abschriftensumme VK_1 netto, nur Totalabschriften (Definition offen), Gesamtsumme der WG'),
PREISABSCHRIFTEN_PREISANDERUNGEN_WERT_NETTO_ABSOLUT_WG NUMERIC(18,4)
OPTIONS(description='Abschriften_1 VK_1 netto, nur Preisabschriften/Preisänderungen (Definition offen), Gesamtsumme der WG. Kann potenziell aus der Tabelle entfernt werden.'),
A402_KOLLI_LA STRING(100) COLLATE 'und:ci' OPTIONS(description='Kolliinhalt Lagerabgangsmenge'),
A401_KOLLI_BST STRING(100) COLLATE 'und:ci' OPTIONS(description='Kolliinhalt Bestellmenge'),
A403_RESTLAUFZEIT_ZL INTEGER OPTIONS(description='Restlaufzeit bei Anlieferung an Zentrallager'),
A404_RESTLAUFZEIT_DZ INTEGER OPTIONS(description='Restlaufzeit bei dezentraler Belieferung'),
A405_BASISMENGENEINHEIT STRING(100) COLLATE 'und:ci' OPTIONS(description='Entspricht Verkaufsmengeneinheit'),
A406_LETZTE_LISTUNGSANDERUNG_SST_KSST DATE
OPTIONS(description='Letzte Veränderung der Sortimentsttufenlistung aus Sternchenlogik'),
A407_VERHANDLER STRING(100) COLLATE 'und:ci' OPTIONS(description='Verhandler INTEGERoder Land_1'),
A408_DISPLAY_KOMPONENTE_KZ STRING(100) COLLATE 'und:ci'
OPTIONS(description='Kennzeichen ob Artikel_1 Display Displaykomponente ist'),
A409_KL_ART_ID_DISPLAY STRING(100) COLLATE 'und:ci'
OPTIONS(description='Alle Displayartikelnummern die im Tupel vorkommen'),
A416_ARTIKELROLLE_ID STRING(100) COLLATE 'und:ci' OPTIONS(description='Vom EK definierte Rolle des Artikels'),
KASSENUMSATZ_KL_ABSOLUT_NETTO_WG NUMERIC(18,4)
OPTIONS(description='Kassenumsatz Kaufland netto WG gesamt (zur Berechnung Abschriftenindex)'),
ANZ_BONS_TUPEL INTEGER
OPTIONS(description='Anzahl Bons, auf denen der Artikel_1 enthalten ist (AF+SA). Nenner für Restbon'),
RESTBON_SUMME NUMERIC(18,4)
OPTIONS(description='Summe Kassenumsatz netto aller Bons aller Artikel_1 des Tupels. Zähler für Restbon'),
CPQ_TUPEL NUMERIC(18,4) OPTIONS(description='Cherrypicker Quote aus Shopper_1'),
CP_BONS_AF INTEGER OPTIONS(description='Cherrpicker Bons AF auf denen der Artikel_1 verkauft wurde '),
CP_BONS_SA INTEGER OPTIONS(description='Cherrpicker Bons SA auf denen der Artikel_1 verkauft wurde '),
UMRECH_FAKTOR NUMERIC(18,4) OPTIONS(description='Gebindeberücksichtigung Flasche/Kiste'),
LAGERPROZENT NUMERIC(18,4)
OPTIONS(description='Lagerprozentsatz, gibt an wieviel % der Restlaufzeit noch nicht abgelaufen sein darf, wenn der Artikel_1 vom Lager ausgeliefert wird'),
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
A445_ANZ_TUPEL_LISTUNG_WGI INTEGER OPTIONS(description='Anzahl von Tupel Listung'),
SUSTAIN_CONCAT STRING(100) DEFAULT ' ' NOT NULL
OPTIONS(description='Alle Nachhaltigkeitskennzeichen konkatiniert, mit Komma getrennt, alphabetisch sortiert.'),
CHECK_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Check, if the data have been validated'),
TUPEL_TYP STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Used to distinguish between tupel types like KFL, Nielsen and Custom Articles.'),
A471_MARKE_NIELSEN_BEZ STRING(4000) OPTIONS(description='Marken aus Quelle Nielsen.'),
A515_BIO_ORGANIC_NIELSEN_KZ STRING(4000)
OPTIONS(description='Label Bio, nicht Bio, unbekannt oder N/A, aus Quelle Nielsen.'),
A516_VEGGY_SPLIT_NIELSEN_KZ STRING(50)
OPTIONS(description='Label Vegan, Vegetarisch, normal oder N/A, aus Quelle Nielsen.'),
A517_LAKTOSEFREI_NIELSEN_KZ STRING(50) OPTIONS(description='Label laktosefrei, normal oder N/A, aus Quelle Nielsen.'),
A518_GLUTENFREI_NIELSEN_KZ STRING(50) OPTIONS(description='Label mit Gluten, ohne Gluten oder N/A, aus Quelle Nielsen.'),
A510_MUKI_EK_KZ STRING(5) OPTIONS(description='Mutter-Kind-Kennzeichen (MUKI-KZ) aus SAP.'),
A511_MUKI_EK_KL_ART_ID_VERKETTUNG STRING(300)
OPTIONS(description='Alle kl_art_ids der betroffenn Mutter-Kind-Beziehung.'),
A512_MUKI_WB_KZ STRING(5) OPTIONS(description='Mutter-Kind-Kennzeichen (MUKI-KZ) aus Quelle SAP.'),
A513_MUKI_WB_KL_ART_ID_VERKETTUNG STRING(300)
OPTIONS(description='Alle kl_art_ids der betroffenn Mutter-Kind-Beziehung.'),
A519_UMSATZ_ANTEIL_WG_NIELSEN NUMERIC(29,4)
OPTIONS(description='Anteil Nielsen-Umsatz des Artikels am Nielsen-Umsatz der KL-WG in Summe.'),
A520_UMSATZ_ANTEIL_WG_KUMULIERT_NIELSEN NUMERIC(29,4)
OPTIONS(description='Anteil Nielsen-Umsatz des Artikels am Nielsen-Umsatz der KL-WG in Summe, Kumulation nach Rang aufsteigend.'),
A521_INHALT_MENGE NUMERIC(29,4) OPTIONS(description='Inhaltsmenge aus SAP.'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
A389_ZEK_ID STRING(3)
OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
WRG_ID STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
ANZ_BONS_AF_MARKT_TAG INTEGER
OPTIONS(description='Anzahl Bons, die an dem gesamten Markt-Tag_1 produziert sind und auf denen der aktionsfreie (AF) Artikel_1, verkauft wurde.'),
ANZ_BONS_SA_MARKT_TAG INTEGER
OPTIONS(description='Anzahl Bons, die an dem gesamten Markt-Tag_1 produziert sind und auf denen der in Sonderaktion (SA) Artikel_1, verkauft wurde.'),
PRIMARY KEY (MANDANT_ID, A500_KJWO_UPDATE, MATCHING_ID) NOT ENFORCED
)
OPTIONS(description='EK_SORT - Faktentabelle - auf Ebene Tupel (Gruppierung aus n KL-Artikeln inkl. gematchten Artikeln vom Marktforschungsinstitut Nielsen) historisiert nach MAT (moving anual total) und KW.\n             Enhällt auch Aggregationen für Spalten aus Tabelle art_nielsen.');