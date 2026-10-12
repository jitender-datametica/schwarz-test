DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.SORTIMENT_LEISTUNG;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.SORTIMENT_LEISTUNG (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
KJMO INTEGER NOT NULL OPTIONS(description='Monat eines Kalenderjahres, Format JJJJMM'),
MATCHING_ID INTEGER NOT NULL
OPTIONS(description='Gruppierungskriterium für Artikel (kann auch nur ein Artikel sein), die über die GTIN zu Nielsen-Artikel gematched werden'),
KJWO_UPDATE INTEGER NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
KL_WG_ID INTEGER OPTIONS(description='ID Kaufland Warengruppen für Nielsen-Daten (Vergabe im Beladeprozess)'),
KL_OWG_ID INTEGER OPTIONS(description='ID Kaufland Oberwarengruppe für Nielsen-Daten (Vergabe im Beladeprozess)'),
KL_UWG_ID INTEGER OPTIONS(description='ID Kaufland Unterwarengruppen für Nielsen-Daten (Vergabe im Beladeprozess)'),
OWG_ID INTEGER OPTIONS(description='ID der Oberwarengruppe'),
WG_ID INTEGER OPTIONS(description='ID der Warengruppe'),
WUG_ID INTEGER OPTIONS(description='ID der Warenuntergruppe'),
RANG_UMSATZ_WG INTEGER
OPTIONS(description='Rang matching_id innerhalb WG auf Basis Umsatz (wird im ETL-Prozess ermittelt)'),
RANG_UMSATZ_UWG INTEGER
OPTIONS(description='Rang matching_id innerhalb UWG auf Basis Umsatz (wird im ETL-Prozess ermittelt)'),
RANG_ABSATZ_UWG INTEGER
OPTIONS(description='Rang matching_id innerhalb UWG auf Basis Absatz (wird im ETL-Prozess ermittelt)'),
ART_ID INTEGER
OPTIONS(description='Führende Artikelnummer: Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
KL_ART_ID STRING(2400)
OPTIONS(description='7-stellige Artikelnummer bestehend aus 2 Stellen: Warengruppe 4 Stellen: Artikelnummer 1 Stelle: Prüfziffer'),
ART_BEZ STRING(400) OPTIONS(description='Artikelbezeichnung'),
ART_STATUS STRING(8) OPTIONS(description='Löschkennzeichen aus DE (L:gelöscht; R:räumen; Blank:aktiv; Null: KMO)'),
GP_ID INTEGER OPTIONS(description='Artikel Lieferant aus artbew'),
AKT_LIEFERANT STRING(480) OPTIONS(description='Aktueller Lieferant (gp_id) aus art_gp_zu_per mit dat_bis 31.12.9999'),
DISC_PE INTEGER OPTIONS(description='Discount Kennzeichen PE (Herkunft noch klären!)'),
DISC_MARKE INTEGER OPTIONS(description='Discount Kennzeichen Marke (artkz_discount)'),
LCF STRING(4) OPTIONS(description='lactose_fg aus Tabelle art'),
VEGAN STRING(4) OPTIONS(description='vegan_fg aus Tabelle art'),
GLUTEN STRING(4) OPTIONS(description='gluten_fg aus Tabelle art'),
BIO STRING(4) OPTIONS(description='bio_fg aus Tabelle art'),
EIGENMARKE STRING(8) OPTIONS(description='eigenmarke_fg_kl aus Tabelle art'),
TIERWOHL STRING(80) OPTIONS(description='tierwohl_fg aus Tabelle art'),
POSTEN_FOOD STRING(4) OPTIONS(description='Flag Posten Food (abgeleitet aus artkz_posten)'),
POSTEN_NONFOOD STRING(4) OPTIONS(description='Flag Posten NonFood (abgeleitet aus artkz_posten)'),
MWST NUMERIC(12,2) OPTIONS(description='Mehrwertsteuersatz'),
LISTUNG_K_SST_MVKE STRING(32) OPTIONS(description='K-Listungsinformation - (MVKE - art_sm_vw_zu_per) nur für KMO'),
GEWICHTETE_DISTRIBUTION NUMERIC(18,4)
OPTIONS(description='Gewichtete Verteilung KL-Artikel (Pendant zu distr_gew aus Nielsen-Daten)'),
INDEX_AF_ID INTEGER OPTIONS(description='Index für Aktionsfreie Ware (Ampel)'),
UMSATZ_AF_PRO_MARKT_WOCHE NUMERIC(29,5) OPTIONS(description='Umsatz aktionsfrei pro Markt und Woche'),
ABSATZ_AF_PRO_MARKT_WOCHE NUMERIC(29,5) OPTIONS(description='Absatz aktionsfrei pro Markt und Woche'),
ERTRAG_AF_PRO_MARKT_WOCHE NUMERIC(29,5) OPTIONS(description='Rohertrag (ek_mep) aktionsfrei pro Markt und Woche'),
BONREICHWEITE_AF NUMERIC(29,5)
OPTIONS(description='Bonreichweite aktionsfreie Ware aus Shopper (Verteilung über verschiedene WG hinweg)'),
SPANNE_AF NUMERIC(29,5) OPTIONS(description='Rohertragsspanne aktionsfreie Ware'),
INDEX_SA_ID INTEGER OPTIONS(description='Index für Sonderaktion Ware (Ampel)'),
UMSATZ_SA_PRO_MARKT_WOCHE NUMERIC(29,5) OPTIONS(description='Umsatz Sonderaktionpro Markt und Woche'),
ABSATZ_SA_PRO_MARKT_WOCHE NUMERIC(29,5) OPTIONS(description='Absatz Sonderaktion pro Markt und Woche'),
ERTRAG_SA_PRO_MARKT_WOCHE NUMERIC(29,5) OPTIONS(description='Rohertrag (ek_mep) Sonderaktionpro Markt und Woche'),
BONREICHWEITE_SA NUMERIC(29,5)
OPTIONS(description='Bonreichweite Sonderaktionsware aus Shopper (Verteilung über verschiedene WG hinweg)'),
SPANNE_SA NUMERIC(29,5) OPTIONS(description='Rohertragsspanne Sonderaktionsware'),
AKTIONSANTEIL_ABSATZ NUMERIC(29,5) OPTIONS(description='Anteil Absatz in Aktion zum Gesamtabsatz'),
ABSATZ_TOTAL NUMERIC(29,5) OPTIONS(description='Gesamtabsatz'),
SCHNELLDREHERQUOTE NUMERIC(29,5) OPTIONS(description='Schnelldreherquote aus SAL'),
SCHNELLDREHERQUOTE_WG NUMERIC(29,5) OPTIONS(description='Schnelldreherquote aus SAL auf Ebene WG'),
SCHNELLDREHERQUOTE_OWG NUMERIC(29,5) OPTIONS(description='Schnelldreherquote aus SAL auf Ebene OWG'),
KOLLIABVERKAUFSQUOTE NUMERIC(29,5) OPTIONS(description='Kolli-Abverkaufsquote aus SAL '),
KOLLIABVERKAUFSQUOTE_WG NUMERIC(29,5) OPTIONS(description='Kolli-Abverkaufsquote aus SAL auf Ebene WG'),
KOLLIABVERKAUFSQUOTE_OWG NUMERIC(29,5) OPTIONS(description='Kolli-Abverkaufsquote aus SAL auf Ebene OWG'),
ABSCHRIFTSANTEIL NUMERIC(29,5) OPTIONS(description='Anteil Abschriften aus definierten Abschriftenkennzeichen'),
ABSCHRIFTSANTEIL_WG NUMERIC(29,5)
OPTIONS(description='Anteil Abschriften aus definierten Abschriftenkennzeichen innerhalb WG'),
ABSCHRIFTSANTEIL_OWG NUMERIC(29,5)
OPTIONS(description='Anteil Abschriften aus definierten Abschriftenkennzeichen  innerhalb OWG'),
CHERRYPICKER_QUOTE NUMERIC(29,5) OPTIONS(description='Cherrypicker Quote aus Shopper'),
CHERRYPICKER_QUOTE_WG NUMERIC(29,5) OPTIONS(description='Cherrypicker Quote aus Shopper innerhalb WG'),
CHERRYPICKER_QUOTE_OWG NUMERIC(29,5) OPTIONS(description='Cherrypicker Quote aus Shopper innerhalb OWG'),
RESTBON NUMERIC(18,4) OPTIONS(description='Restbon aus Shopper'),
RESTBON_WG NUMERIC(18,4) OPTIONS(description='Restbon aus Shopper innerhalb WG'),
RESTBON_OWG NUMERIC(18,4) OPTIONS(description='Restbon aus Shopper innerhalb OWG'),
VK_PREIS NUMERIC(29,5) OPTIONS(description='VK Preis  brutto PM-ID 1 (Preiskategorie 1) aus Tabelle art_pm_vw_zu_per'),
DURCHSCHNITTSPREIS NUMERIC(29,5)
OPTIONS(description='Durchschnittspreis für KL-Artikel (Pendant Nielsen: durchschnitt_preis)'),
PREISLAGENVERTEILUNG NUMERIC(29,5) OPTIONS(description='Preislagenverteilung (wird im ETL-Prozess ermittelt)'),
MARKTANTEILBEWERTUNG NUMERIC(29,5) OPTIONS(description='Marktanteilbewertung(wird im ETL-Prozess ermittelt)'),
PRODUKTWISSEN_VP STRING(2040) OPTIONS(description='Produktwissen gepflegt durch ZEK Vorperiode (VJ)'),
LIEFERANTENWISSEN_VP STRING(2040) OPTIONS(description='Lieferantenwissen gepflegt durch ZEK Vorperiode (VJ)'),
PRODUKTWISSEN_PFLEGE STRING(2040) OPTIONS(description='Produktwissen gepflegt durch ZEK'),
LIEFERANTENWISSEN_PFLEGE STRING(2040) OPTIONS(description='Lieferantenwissen gepflegt durch ZEK'),
LISTUNG_SST_PFLEGE STRING(32)
OPTIONS(description='Sortimentsstufe (SST) gepflegt durch ZEK (für KMO ohne K-Sortimentsstufe)'),
OST_BASIS_PFLEGE STRING(8) OPTIONS(description='Listung Ost Basis gepflegt durch ZEK'),
OST_GROSS_PFLEGE STRING(8) OPTIONS(description='ost_gross_pflege'),
SUED_OST_PFLEGE STRING(8) OPTIONS(description='sued_ost_pflege'),
SUED_WEST_PFLEGE STRING(8) OPTIONS(description='sued_west_pflege'),
WEST_PFLEGE STRING(8) OPTIONS(description='west_pflege'),
NORD_PFLEGE STRING(8) OPTIONS(description='nord_pflege'),
VORSCHLAG STRING(2040)
OPTIONS(description='Vorschlag gepflegt durch ZEK, ob Listung reduziert oder erweitert werden soll'),
STK_RE_PFLEGE STRING(2040) OPTIONS(description='Stück Rohertrag gepflegt durch ZEK für Potentialartikel'),
UMSATZ_HR NUMERIC(18,4) OPTIONS(description='Hochrechnung Umsatz (stored Procedure zur Laufzeit der Ermittlung)'),
ABSATZ_HR NUMERIC(18,4) OPTIONS(description='Hochrechnung Absatz (stored Procedure zur Laufzeit der Ermittlung)'),
ROHERTRAG_HR NUMERIC(18,4) OPTIONS(description='Hochrechnung Rohertrag (stored Procedure zur Laufzeit der Ermittlung)'),
NIELSEN_ART_BEZ STRING(2400) OPTIONS(description='Artikelbezeichnung aus Nielsen '),
GTIN STRING(1200) OPTIONS(description='Global Trade Item Number (GTIN)'),
DISTR_GEW NUMERIC(18,4)
OPTIONS(description='Gewichtete Verteilung Nielsen-Artikel (Pendant zu distribution_gewichtet KL-Daten)'),
UMSATZ_ANTEIL_UWG NUMERIC(18,4) OPTIONS(description='Anteil Umsatz innerhalb UWG ermittelt aus Nielsen-Daten'),
UMSATZ_ANTEIL_UWG_KUMULIERT NUMERIC(18,4)
OPTIONS(description='Anteil Umsatz innerhalb UWG ermittelt aus Nielsen-Daten kumuliert'),
DURCHSCHNITT_ANZ_MAERKTE INTEGER OPTIONS(description='Durschnittliche Anzahl Märkte (Nielsen Daten)'),
DURCHSCHNITT_PREIS NUMERIC(18,4)
OPTIONS(description='Durchschnittlicher VK (Wenn umsatz_brutto_af>0 Dann umsatz_brutto_af/menge_af Sonst umsatz_brutto_sa/menge_sa)'),
KL_MARKT_ANTEIL_OWG NUMERIC(18,4) OPTIONS(description='Marktanteil Kaufland  (Nielsen Daten)'),
UMSATZ_ARTIKEL NUMERIC(18,4) OPTIONS(description='Gesamtumsatz'),
ABSATZ_ARTIKEL NUMERIC(18,4)
OPTIONS(description='wird im Fontend nicht verwendet - Prüfung, ob im BE noch verwendet wird?'),
ANZ_MONATE INTEGER OPTIONS(description='Anzahl Monate'),
ANZ_WOCHEN INTEGER OPTIONS(description='Anzahl Wochen'),
EIGENMARKE_FG INTEGER OPTIONS(description='eigenmarke_fg ermittelt aus Nielsen-Daten (1 =\"SENSITIVE\" oder\"N/A\"'),
LISTUNG_SST_MVKE STRING(32)
OPTIONS(description='Listungsinformation (in KMO ohne K-Listung) - (MVKE - art_sm_vw_zu_per)'),
OST_BASIS STRING(4)
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per)'),
OST_GROSS STRING(4)
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per)'),
SUED_OST STRING(4)
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per)'),
SUED_WEST STRING(4)
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per)'),
WEST STRING(4)
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per)'),
NORD STRING(4)
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per)'),
ANZ_MAERKTE_SST INTEGER
OPTIONS(description='Marktanzahl Sortimentsstufe (in KMO ohne\"K\") und Regio-Cluster (nur DE)'),
ANZ_MAERKTE_BAUSTEIN_SONSTIGE INTEGER
OPTIONS(description='Marktanzahl Bausteine (ohne Duplikate) - für KMO alle Bausteine / für DE ohne Regio-Bausteine'),
ANZ_MAERKTE_LISTUNG_EINZEL INTEGER OPTIONS(description='Marktanzahl Einzellistung'),
ANZ_MAERKTE_LISTUNG_GESAMT INTEGER
OPTIONS(description='Marktanzahl Listung gesamt (Distinct Marktzählung der gülitgen Listungseinträge aus art_list_wup_zu_per ohne Listungsquelle 2 (Aktionslistung))'),
LISTUNGSAKTION STRING(1020)
OPTIONS(description='Nur befüllt, wenn ZEK Eingaben tätigt. Fall 1: ZEK wählt aus Optionen, werden direkt hier gespeichert. Fall 2: ZEK wählt Soll-Listung, der richtige Text wird vom BE ermittelt und in das Feld geschrieben.'),
ANZ_MAERKTE_K_SST INTEGER OPTIONS(description='Marktanzahl K-Sortimentsstufe (nur KMO)'),
LISTUNG_K_SST_PFLEGE STRING(16) OPTIONS(description='K-Sortimentsstufe (K_SST) gepflegt durch ZEK (nur KMO)'),
MUKI_WB_KZ STRING(20) OPTIONS(description='Zeigt mit W/M/K an, ob und wie Artikel der Matching ID in Werbe-Muki sind'),
MUKI_WB_KL_ART_ID_VERKETTUNG STRING(1200)
OPTIONS(description='Liste alle WB-Mütter auf, die an Artikeln der Matching-ID beteiligt sind'),
MUKI_VK_KZ STRING(20) OPTIONS(description='Zeigt mit W/M/K an, ob und wie Artikel der Matching ID in VK-Muki sind'),
MUKI_VK_KL_ART_ID_VERKETTUNG STRING(1200)
OPTIONS(description='Liste alle VK-Mütter auf, die an Artikeln der Matching-ID beteiligt sind'),
MUKI_EK_KZ STRING(20) OPTIONS(description='Zeigt mit W/M/K an, ob und wie Artikel der Matching ID in EK-Muki sind'),
MUKI_EK_KL_ART_ID_VERKETTUNG STRING(1200)
OPTIONS(description='Liste alle EK-Mütter auf, die an Artikeln der Matching-ID beteiligt sind'),
ABSATZ_TOTAL_VJ NUMERIC(29,5) OPTIONS(description='Gesamtabsatz VJ'),
MAX_ANZ_MAERKTE_SST INTEGER
OPTIONS(description='Anzahl der Märkte, die gelistet sein müssten, wenn die SST aus der MVKE tatsächlich auch gelistet wurde (aus WRF6) - DWH generiert'),
MAX_ANZ_MAERKTE_K_SST INTEGER
OPTIONS(description='Anzahl der Märkte, die gelistet sein müssten, wenn die K-SST aus der MVKE tatsächlich auch gelistet wurde (aus WRF6) - DWH generiert'),
KASSENUMSATZ_KL_ABSOLUT_BRUTTO NUMERIC(29,5) OPTIONS(description='Kassenumsatz Kaufland brutto'),
KASSENUMSATZ_KL_ABSOLUT_NETTO NUMERIC(29,5) OPTIONS(description='Kassenumsatz Kaufland netto'),
ABSCHRIFTEN_WERT_NETTO_ABSOLUT NUMERIC(29,5)
OPTIONS(description='Abschriftensumme VK netto, DE alles außer AKZ -1, KMO alle Preisänderungen/Abschriften'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
ZEK_ID STRING(3) OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
WRG_ID STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
PRIMARY KEY (MANDANT_ID, KJMO, MATCHING_ID, KJWO_UPDATE) NOT ENFORCED
) CLUSTER BY MANDANT_ID, KJMO, KJWO_UPDATE, ART_ID
OPTIONS(description='EK-INTEGER -  Sortimentstool - Aggregat für den Leistungs- und Potentialbericht');