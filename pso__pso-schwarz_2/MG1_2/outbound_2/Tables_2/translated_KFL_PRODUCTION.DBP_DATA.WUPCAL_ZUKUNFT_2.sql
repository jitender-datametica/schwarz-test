CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.WUPCAL_ZUKUNFT_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='PK Mandant_2 im DWH'),
WUP_ID INTEGER NOT NULL OPTIONS(description='PK Warenumschlagsplatz'),
NB_ID INTEGER NOT NULL
OPTIONS(description='PK - Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
DAT DATE NOT NULL OPTIONS(description='PK - Datum im Format JJJJ-MM_2-TT'),
OFFEN INTEGER OPTIONS(description='kennzeichnet, ob ein Markt zu einem Datum geoeffnet war. 1 offen, 0 geschlossen'),
WERBEWOCHE INTEGER OPTIONS(description='wird z.Zt. nicht benutzt'),
DATENLIEFERUNG_ARTBEW_WG_SUM INTEGER
OPTIONS(description='Datenlieferungs-Stati:\t\n            0\tnicht geliefert\n            1\tgeliefert\n            2\tkalkuliert\n            3\tgesplittet\n            4\tnicht mehr lieferbar\n            5\tkumuliert (über n Tage)\n            6\tkalkuliert und nicht mehr lieferbar'),
BONANZAHL INTEGER OPTIONS(description='Anzahl der Kassenbons'),
DATENLIEFERUNG_BONANZAHL INTEGER
OPTIONS(description='Datenlieferungs-Stati\t\n            0\tnicht geliefert\n            1\tgeliefert\n            2\tkalkuliert\n            3\tgesplittet\n            4\tnicht mehr lieferbar\n            5\tkumuliert (über n Tage)\n            6\tkalkuliert und nicht mehr lieferbar'),
BONANZAHL_MISVIER INTEGER OPTIONS(description='Anzahl Bons'),
DATENLIEFERUNG_MISVIER INTEGER
OPTIONS(description='Daten aus der Schnittstelle misvier wurden geliefert\n            Datenlieferungs-Stati\t\n            0\tnicht geliefert\n            1\tgeliefert\n            2\tkalkuliert\n            3\tgesplittet\n            4\tnicht mehr lieferbar\n            5\tkumuliert (über n Tage)\n            6\tkalkuliert und nicht mehr lieferbar'),
DATENLIEFERUNG_ARTBEW INTEGER
OPTIONS(description='Lieferung der Artikelbewegungsdaten aus dem Markt\n            Datenlieferungs-Stati\t\n            0\tnicht geliefert\n            1\tgeliefert\n            2\tkalkuliert\n            3\tgesplittet\n            4\tnicht mehr lieferbar\n            5\tkumuliert (über n Tage)\n            6\tkalkuliert und nicht mehr lieferbar'),
DATENLIEFERUNG_QBM_STATUS INTEGER
OPTIONS(description='Lieferung der QBM-Daten (Reklamationen) aus dem Markt\n            Datenlieferungs-Stati:\t\n            0   nicht geliefert\n            1   geliefert\n            weitere Stati können zu einem späteren Zeitpunkt festgelegt werden'),
BONANZAHL_IMBISS INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Kunden im Imbiss des Marktes. Gehoert logisch nicht hierher, da abhaengig von einer Warengruppe bzw. bestimmten Kassierer-Nummern.'),
PRUEF_STATUS_ID_UMSATZ INTEGER
OPTIONS(description='Status_2 der Pruefung des Umsatzes. Der Umsatz wird auf Plausibilitaet geprueft'),
PRUEF_STATUS_ID_KUNDE INTEGER
OPTIONS(description='Status_2 der Pruefung der Kundenzahl. Die Kundenzahl wird auf Plausibilität geprueft'),
PRUEF_GRUND_ID_UMSATZ STRING(3) COLLATE 'und:ci' OPTIONS(description='Grund der Pruefung des Umsatzes'),
PRUEF_GRUND_ID_KUNDE STRING(3) COLLATE 'und:ci' OPTIONS(description='Grund der Pruefung der Kundenzahl'),
DAT_EXTRAKT_UMSATZ DATE OPTIONS(description='Datum des Erhalts der  Schnittstelle Umsatz'),
OFFEN_VON INTEGER OPTIONS(description='Zeitpunkt der Marktoeffnung'),
OFFEN_BIS INTEGER OPTIONS(description='Schließungszeitpunkt des Marktes'),
BONANZAHL_SUG INTEGER
OPTIONS(description='Bons mit mindestens einer positiven Position - einheitliche Definition der Kundenzahl innerhalb der Schwarz-Unternehmensgruppe'),
UMSATZ_BRUTTO_ODS_VERKAUF NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Befuellung im ETL-Prozess - Summe Umsaetze aus ods_verkauf. Nur K-POS'),
UMSATZ_BRUTTO_ODS_KASSENABSCHLUSS NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Befuellung im ETL-Prozess - Summe Umsaetze aus ods_kassenabschluss. Nur K_POS'),
BONANZAHL_KUNDENKARTE INTEGER
OPTIONS(description='Aggregation der Bons mit Kundenkarten_Typ (z.B. Payback oder Keine) auf Markt-Tag_2-Land_2-Ebene '),
OFFEN_THEKE_VON TIME OPTIONS(description='Thekenoeffnungszeit von pro Markt / Tag_2'),
OFFEN_THEKE_BIS TIME OPTIONS(description='Thekenoeffnungszeit bis pro Markt / Tag_2'),
BONANZAHL_SUG_KASSENABSCHLUSS INTEGER OPTIONS(description='Kunden Kassenabschluss (EOD), Logik analog bonanzahl_sug'),
SSM_UMSATZ_FAKTOR BIGNUMERIC(18,10) DEFAULT 1 NOT NULL
OPTIONS(description='Berechnung je Wochentag. HL_2 Planwert / Durchschnitt letzte 10 Wochen'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
WRG_ID STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
BONANZAHL_KUNDENKARTE_PAYBACK INTEGER
OPTIONS(description='Anzahl der Kunden mit Payback als Kundenkarte (nur für Polen).'),
BONANZAHL_FRISCHETHEKE_OHNE_FISCH INTEGER
OPTIONS(description='Kundenanzahl der Frischetheke ohne OWG 1005 Fisch (Sobald ein Kunde etwas aus den OWGs 1001, 1002, 1003, 1004 kauft, zählt dieser als Kunde der Frischetheke ohne Fisch).'),
PRIMARY KEY (MANDANT_ID, WUP_ID, NB_ID, DAT) NOT ENFORCED
) OPTIONS(description='TP1 TP2 Marktkalender mit Datensaetzen nur in Zukunft');