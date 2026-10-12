CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_MSI_DATA.WUP_DENORM_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Marktnummer aus t001w.werks'),
BED_FLEISCH_FG INTEGER NOT NULL OPTIONS(description='Bedienkonzept Fleisch Flag'),
BED_FLEISCH_DAT DATE OPTIONS(description='Datum, ab dem das aktuelle Bedienkonzept gültig ist'),
BED_WURST_FG INTEGER NOT NULL OPTIONS(description='Bedienkonzept Wurst Flag'),
BED_WURST_DAT DATE OPTIONS(description='Bedienkonzept Wurst Datum'),
BED_GEFL_FG INTEGER NOT NULL OPTIONS(description='Bedienkonzept Geflügel Flag'),
BED_GEFL_DAT DATE OPTIONS(description='Bedienkonzept Geflügel Datum'),
BED_KAESE_FG INTEGER NOT NULL OPTIONS(description='Bedienkonzept  Käse Flag'),
BED_KAESE_DAT DATE OPTIONS(description='Bedienkonzept  Käse Datum'),
BED_FISCH_ID INTEGER NOT NULL
OPTIONS(description='Bedienkonzept Fisch. ID verweist auf SB, Bedienung oder Bedienung/SB'),
BED_FISCH_DAT DATE OPTIONS(description='Bedienkonzept Fisch Datum'),
BED_FEINK_FG INTEGER NOT NULL OPTIONS(description='Bedienkonzept Feinkost Flag'),
BED_FEINK_DAT DATE OPTIONS(description='Bedienkonzept Feinkost Datum'),
BED_BULK_FG INTEGER NOT NULL OPTIONS(description='Bedienkonzept  Bulkfood Flag'),
BED_BULK_DAT DATE OPTIONS(description='Bedienkonzept  Bulkfood Datum'),
BED_BEDINS_FG INTEGER NOT NULL OPTIONS(description='Bedienkonzept Bedieninsel Flag'),
BED_BEDINS_DAT DATE OPTIONS(description='Bedienkonzept Bedieninsel Datum'),
BED_IMBISS_FG INTEGER NOT NULL OPTIONS(description='Bedienkonzept Imbiss Flag'),
BED_IMBISS_DAT DATE OPTIONS(description='Bedienkonzept Imbiss Datum'),
BED_BACKSHOP_FG INTEGER NOT NULL OPTIONS(description='Bedienungskonzept Backshop Flag'),
BED_BACKSHOP_DAT DATE OPTIONS(description='Bedienungskonzept Backshop Datum'),
BACKSHOP_SYSTEM STRING(40) COLLATE 'und:ci' OPTIONS(description='Backshop System, z.Bsp. Discount'),
LEERGUT_SYSTEM STRING(40) COLLATE 'und:ci' OPTIONS(description='Leergut System, z.Bsp. Leergutautomat'),
ANZ_LEERGUTAUTOMATEN INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Anzahl der Leergutautomaten'),
GLV_LAND_ID INTEGER NOT NULL OPTIONS(description='Mitarbeiter ID des GLV Land_2'),
STV_GLV_LAND_ID INTEGER NOT NULL OPTIONS(description='Mitarbeiter ID des stellvertretenden GLV Land_2'),
GL_VERTRIEB_ID INTEGER NOT NULL OPTIONS(description='Mitarbeiter_id der/des GL Vertrieb'),
GF_GBL_VERTRIEB_ID INTEGER NOT NULL OPTIONS(description='Mitarbeiter ID der/des GF_2/GBL Vertrieb'),
VKL_ID INTEGER NOT NULL
OPTIONS(description='Mitarbeiter ID der/des Verkaufsleiters. Achtung: abweichend von der bisher im DWH generierten VKL_2-ID'),
HAUSLEITER_ID INTEGER NOT NULL OPTIONS(description='Mitarbeiter ID des Hausleiters'),
WBL_FOOD_ID INTEGER NOT NULL OPTIONS(description='Mitarbeiter ID der Warenbereichsleitung Food'),
WBL_FRISCHE_ID INTEGER NOT NULL OPTIONS(description='Mitarbeiter Id der Warenbereichsleitung Frische'),
WBL_NONFOOD_ID INTEGER NOT NULL OPTIONS(description='Mitarbeiter ID der Warenbereichsleitung Nonfood'),
WBL_KASSE_ID INTEGER NOT NULL OPTIONS(description='Mitarbeiter ID der Warenbereichsleitung Kasse'),
FRISCHE_MANAGER_ID INTEGER NOT NULL OPTIONS(description='Mitarbeiter ID des Frischemanagements'),
REGIONALE_PSB_ID INTEGER NOT NULL OPTIONS(description='Mitarbeiter ID der regionalen Personalsachbearbeitung'),
TANKSTELLE_VORH_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag ist gesetzt, wenn eine_2 Tankstelle vorhanden ist. Kommt aus techn_platz_ebene_2'),
TANKSTELLE_EIGEN_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag, ob eine_2 Tankstelle in Eigenverwendung. 1 = eigen'),
MA_VERMIETUNG_ID INTEGER OPTIONS(description='Mitarbeiter Vermietung. Referenz zur Tabelle l_ma.'),
EIGENTUM_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Eigentum Flag. Wenn = 1, dann Eigentum, 0 = Miete'),
DAT_LETZTE_REORGA DATE
OPTIONS(description='Datum der letzten großen Umbaumaßnahme. Wird aus cpr_cl_punkt_termin_2 ermittelt.'),
PARKHAUS_KZ INTEGER NOT NULL
OPTIONS(description='Parkhaus Kennzeichen. Kann die Werte 0= kein Parkhaus, 1 = Parkhaus, -1 = unbekannt annehmen. Die Information wird aus der Spalte betreiberart_bez der Tabelle l_ginfo_betreiberart_2 ermittelt'),
GETRAENKEMARKT_KZ INTEGER NOT NULL
OPTIONS(description='Kennzeichen für einen separaten Getränkemarkt. Kann die Werte 0= kein Getränkemarkt. 1 = Getränkemarkt. -1 = unbekannt annehmen. Die Information wird aus der Spalte betreiberart_bez der Tabelle l_ginfo_betreiberart_2 ermittelt'),
ANZ_AUFZUEGE INTEGER NOT NULL
OPTIONS(description='Anzahl Aufzüge (gesamt) pro Markt. Wird berechnet aus der IOS-Versorgung (598 VAUS) der EQUI-Schnittstelle.'),
ANZ_ROLLSTEIGE INTEGER NOT NULL
OPTIONS(description='Anzahl Rollsteige (gesamt) pro Markt. Wird berechnet aus der IOS-Versorgung (598 VAUS) der EQUI-Schnittstelle.'),
ANZ_AUFZUEGE_INTERN INTEGER NOT NULL
OPTIONS(description='Anzahl Aufzüge (nur innerhalb der Verkaufsfläche) pro Markt. Wird berechnet aus der IOS-Versorgung (598 VAUS) der EQUI-Schnittstelle.'),
ANZ_ROLLSTEIGE_INTERN INTEGER NOT NULL
OPTIONS(description='Anzahl Rollsteige (nur innerhalb der Verkaufsfläche) pro Markt. Wird berechnet aus der IOS-Versorgung (598 VAUS) der EQUI-Schnittstelle.'),
UNTERVERMIETUNG_KZ STRING(20) COLLATE 'und:ci'
OPTIONS(description='Quelle sind interne Mietverträge(mehrere Angaben zur Filiale möglich) - sonst an keiner Stelle im DWH vorhanden'),
UNTERVERMIETUNG_TEXT STRING(160) COLLATE 'und:ci'
OPTIONS(description='Quelle sind interne Mietverträge(mehrere Angaben zur Filiale möglich) - sonst an keiner Stelle im DWH vorhanden'),
UNTERVERMIETUNG_FREITEXT STRING(160) COLLATE 'und:ci'
OPTIONS(description='Quelle sind interne Mietverträge(mehrere Angaben zur Filiale möglich) - sonst an keiner Stelle im DWH vorhanden'),
HAUSLEITER_SPERR_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag zeigt an, ob TEKU-Berichte für den Hausleiter gesperrt sind (1 = gesperrt)'),
VKL_SPERR_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag zeigt an, ob TEKU-Berichte für den VKL_2 gesperrt sind (1 = gesperrt)'),
GF_GBL_VERTRIEB_SPERR_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag zeigt an, ob TEKU-Berichte für den GF_2 gesperrt sind (1 = gesperrt)'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
ANZ_EINKAUFSWAGEN_BOXEN INTEGER
OPTIONS(description='Anzahl der Einkaufswagen Boxen. Wird manuell von VT INTEGERerhoben.'),
ANZ_HEISSGETRAENKE_AUTOMATEN INTEGER
OPTIONS(description='Anzahl der Heißgetränkeautomaten. Wird manuell von VT INTEGERerhoben.'),
ANZ_T_ZELLEN_BACKSHOP INTEGER
OPTIONS(description='Anzahl der Tiefkühlplätze beim Backshop. Wird manuell von VT INTEGERerhoben.'),
HAEUFIGSTE_ULTRA_FRISCHE_LISTUNGSSTUFE_KZ STRING(50)
OPTIONS(description='Gibt die häufigste Listungsstufe der SOK Abteilung Ultra Frische in der Filiale an.'),
HAEUFIGSTE_MOPRO_LISTUNGSSTUFE_KZ STRING(50)
OPTIONS(description='Gibt die häufigste Listungsstufe des SOK Fima Bausteins Mopro in der FIliale an.'),
HAEUFIGSTE_TIKO_LISTUNGSSTUFE_KZ STRING(50)
OPTIONS(description='Gibt die häufigste Listungsstufe des SOK Fima Bausteins Tiko in der Filiale an.'),
HAEUFIGSTE_TROCKEN_LISTUNGSSTUFE_KZ STRING(50)
OPTIONS(description='Gibt die häufigste Listungsstufe der SOK Kategorie Trockenachsen Food in der Filiale an.'),
HAEUFIGSTE_NONFOOD_LISTUNGSSTUFE_KZ STRING(50)
OPTIONS(description='Gibt die häufigste Listungsstufe der Food / Non Food Kategorie Non Food in der Filiale an.'),
PRIMARY KEY (MANDANT_ID, WUP_ID) NOT ENFORCED
) OPTIONS(description='VIS - denormalisierte Stammdaten der Märkte zur Performancesteigerung');