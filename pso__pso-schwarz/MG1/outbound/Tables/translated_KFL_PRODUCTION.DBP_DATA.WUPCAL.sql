CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.WUPCAL (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='PK Mandant im DWH'),
WUP_ID INTEGER NOT NULL OPTIONS(description='PK Warenumschlagsplatz'),
NB_ID INTEGER NOT NULL
OPTIONS(description='PK - Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
DAT DATE NOT NULL OPTIONS(description='PK - Datum im Format JJJJ-MM-TT'),
OFFEN INTEGER OPTIONS(description='kennzeichnet, ob ein Markt zu einem Datum geoeffnet war. 1 offen, 0 geschlossen'),
WERBEWOCHE INTEGER OPTIONS(description='wird z.Zt. nicht benutzt'),
DATENLIEFERUNG_ARTBEW_WG_SUM INTEGER
OPTIONS(description='Datenlieferungs-Stati\t\n            0\tnicht geliefert\n            1\tgeliefert\n            2\tkalkuliert\n            3\tgesplittet\n            4\tnicht mehr lieferbar\n            5\tkumuliert (ueber n Tage)\n            6\tkalkuliert und nicht mehr lieferbar'),
DATENLIEFERUNG_BONANZAHL INTEGER
OPTIONS(description='Datenlieferungs-Stati\t\n            0\tnicht geliefert\n            1\tgeliefert\n            2\tkalkuliert\n            3\tgesplittet\n            4\tnicht mehr lieferbar\n            5\tkumuliert (ueber n Tage)\n            6\tkalkuliert und nicht mehr lieferbar'),
DATENLIEFERUNG_MISVIER INTEGER
OPTIONS(description='Daten aus der Schnittstelle misvier wurden geliefert\n            Datenlieferungs-Stati\t\n            0\tnicht geliefert\n            1\tgeliefert\n            2\tkalkuliert\n            3\tgesplittet\n            4\tnicht mehr lieferbar\n            5\tkumuliert (ueber n Tage)\n            6\tkalkuliert und nicht mehr lieferbar'),
DATENLIEFERUNG_ARTBEW INTEGER
OPTIONS(description='Lieferung der Artikelbewegungsdaten aus dem Markt\n            Datenlieferungs-Stati\t\n            0\tnicht geliefert\n            1\tgeliefert\n            2\tkalkuliert\n            3\tgesplittet\n            4\tnicht mehr lieferbar\n            5\tkumuliert (ueber n Tage)\n            6\tkalkuliert und nicht mehr lieferbar'),
DATENLIEFERUNG_QBM_STATUS INTEGER
OPTIONS(description='Lieferung der QBM-Daten (Reklamationen) aus dem Markt\n            Datenlieferungs-Stati\t\n            0   nicht geliefert\n            1    geliefert\n            weitere Stati koennen zu einem spaeteren Zeitpunkt festgelegt werden'),
PRUEF_STATUS_ID_UMSATZ INTEGER
OPTIONS(description='Status der Pruefung des Umsatzes. Der Umsatz wird auf Plausibilitaet geprueft'),
PRUEF_STATUS_ID_KUNDE INTEGER
OPTIONS(description='Status der Pruefung der Kundenzahl. Die Kundenzahl wird auf Plausibilitaet geprueft'),
PRUEF_GRUND_ID_UMSATZ STRING(3) COLLATE 'und:ci' OPTIONS(description='Grund der Pruefung des Umsatzes'),
PRUEF_GRUND_ID_KUNDE STRING(3) COLLATE 'und:ci' OPTIONS(description='Grund der Pruefung der Kundenzahl'),
WRG_ID STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
DAT_EXTRAKT_UMSATZ DATE OPTIONS(description='Datum des Erhalts der  Schnittstelle Umsatz'),
OFFEN_VON INTEGER OPTIONS(description='Zeitpunkt der Marktoeffnung'),
OFFEN_BIS INTEGER OPTIONS(description='Schließungszeitpunkt des Marktes'),
OFFEN_THEKE_VON TIME OPTIONS(description='Thekenoeffnungszeit von pro Markt / Tag'),
OFFEN_THEKE_BIS TIME OPTIONS(description='Thekenoeffnungszeit bis pro Markt / Tag'),
UMSATZ_BRUTTO_ODS_VERKAUF NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Befuellung im ETL-Prozess - Summe Umsaetze aus ods_verkauf. Nur K-POS'),
UMSATZ_BRUTTO_ODS_KASSENABSCHLUSS NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Befuellung im ETL-Prozess - Summe Umsaetze aus ods_kassenabschluss. Nur K_POS'),
BONANZAHL INTEGER OPTIONS(description='Anzahl der Kassenbons'),
BONANZAHL_MISVIER INTEGER OPTIONS(description='Anzahl Bons'),
BONANZAHL_IMBISS INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Kunden im Imbiss des Marktes. Gehoert logisch nicht hierher, da abhaengig von einer Warengruppe bzw. bestimmten Kassierer-Nummern.'),
BONANZAHL_SUG INTEGER
OPTIONS(description='Bons mit mindestens einer positiven Position - einheitliche Definition der Kundenzahl innerhalb der Schwarz-Unternehmensgruppe'),
BONANZAHL_SUG_KASSENABSCHLUSS INTEGER OPTIONS(description='Kunden Kassenabschluss (EOD), Logik analog bonanzahl_sug'),
BONANZAHL_FRISCHETHEKE_OHNE_FISCH INTEGER
OPTIONS(description='Kundenanzahl der Frischetheke ohne OWG 1005 Fisch (Sobald ein Kunde etwas aus den OWGs 1001, 1002, 1003, 1004 kauft, zählt dieser als Kunde der Frischetheke ohne Fisch).'),
BONANZAHL_KUNDENKARTE_PAYBACK INTEGER
OPTIONS(description='Anzahl der Kunden mit Payback als Kundenkarte (nur für Polen).'),
BONANZAHL_KUNDENKARTE INTEGER
OPTIONS(description='Aggregation der Bons mit Kundenkarten_Typ_ID = 2 (Kaufland Loyalty Card) auf Markt-Tag-Land-Ebene '),
BETRAG_VK_NETTO_KUNDENKARTE NUMERIC(29,4)
OPTIONS(description='Umsatz netto mit Kaufland Loyalty Programm (kundenkarte_typ_id =2) auf Markt.Tag-Ebene.'),
SSM_UMSATZ_FAKTOR BIGNUMERIC(18,10) DEFAULT 1 NOT NULL
OPTIONS(description='Berechnung je Wochentag. HL Planwert / Durchschnitt letzte 10 Wochen'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, WUP_ID, NB_ID, DAT) NOT ENFORCED
) OPTIONS(description='TP1 TP2 Marktkalender.');