CREATE OR REPLACE TABLE kfl_production_dbp_data.wupcal_zukunft (
mandant_id INTEGER NOT NULL OPTIONS(description='PK Mandant im DWH'),
wup_id INTEGER NOT NULL OPTIONS(description='PK Warenumschlagsplatz'),
nb_id INTEGER NOT NULL
OPTIONS(description='PK - Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat DATE NOT NULL OPTIONS(description='PK - Datum im Format JJJJ-MM-TT'),
offen INTEGER OPTIONS(description='kennzeichnet, ob ein Markt zu einem Datum geoeffnet war. 1 offen, 0 geschlossen'),
werbewoche INTEGER OPTIONS(description='wird z.Zt. nicht benutzt'),
datenlieferung_artbew_wg_sum INTEGER
OPTIONS(description='Datenlieferungs-Stati:\t\n            0\tnicht geliefert\n            1\tgeliefert\n            2\tkalkuliert\n            3\tgesplittet\n            4\tnicht mehr lieferbar\n            5\tkumuliert (über n Tage)\n            6\tkalkuliert und nicht mehr lieferbar'),
bonanzahl INTEGER OPTIONS(description='Anzahl der Kassenbons'),
datenlieferung_bonanzahl INTEGER
OPTIONS(description='Datenlieferungs-Stati\t\n            0\tnicht geliefert\n            1\tgeliefert\n            2\tkalkuliert\n            3\tgesplittet\n            4\tnicht mehr lieferbar\n            5\tkumuliert (über n Tage)\n            6\tkalkuliert und nicht mehr lieferbar'),
bonanzahl_misvier INTEGER OPTIONS(description='Anzahl Bons'),
datenlieferung_misvier INTEGER
OPTIONS(description='Daten aus der Schnittstelle misvier wurden geliefert\n            Datenlieferungs-Stati\t\n            0\tnicht geliefert\n            1\tgeliefert\n            2\tkalkuliert\n            3\tgesplittet\n            4\tnicht mehr lieferbar\n            5\tkumuliert (über n Tage)\n            6\tkalkuliert und nicht mehr lieferbar'),
datenlieferung_artbew INTEGER
OPTIONS(description='Lieferung der Artikelbewegungsdaten aus dem Markt\n            Datenlieferungs-Stati\t\n            0\tnicht geliefert\n            1\tgeliefert\n            2\tkalkuliert\n            3\tgesplittet\n            4\tnicht mehr lieferbar\n            5\tkumuliert (über n Tage)\n            6\tkalkuliert und nicht mehr lieferbar'),
datenlieferung_qbm_status INTEGER
OPTIONS(description='Lieferung der QBM-Daten (Reklamationen) aus dem Markt\n            Datenlieferungs-Stati:\t\n            0   nicht geliefert\n            1   geliefert\n            weitere Stati können zu einem späteren Zeitpunkt festgelegt werden'),
bonanzahl_imbiss INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Kunden im Imbiss des Marktes. Gehoert logisch nicht hierher, da abhaengig von einer Warengruppe bzw. bestimmten Kassierer-Nummern.'),
pruef_status_id_umsatz INTEGER
OPTIONS(description='Status der Pruefung des Umsatzes. Der Umsatz wird auf Plausibilitaet geprueft'),
pruef_status_id_kunde INTEGER
OPTIONS(description='Status der Pruefung der Kundenzahl. Die Kundenzahl wird auf Plausibilität geprueft'),
pruef_grund_id_umsatz STRING(3) COLLATE 'und:ci' OPTIONS(description='Grund der Pruefung des Umsatzes'),
pruef_grund_id_kunde STRING(3) COLLATE 'und:ci' OPTIONS(description='Grund der Pruefung der Kundenzahl'),
dat_extrakt_umsatz DATE OPTIONS(description='Datum des Erhalts der  Schnittstelle Umsatz'),
offen_von INTEGER OPTIONS(description='Zeitpunkt der Marktoeffnung'),
offen_bis INTEGER OPTIONS(description='Schließungszeitpunkt des Marktes'),
bonanzahl_sug INTEGER
OPTIONS(description='Bons mit mindestens einer positiven Position - einheitliche Definition der Kundenzahl innerhalb der Schwarz-Unternehmensgruppe'),
umsatz_brutto_ods_verkauf NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Befuellung im ETL-Prozess - Summe Umsaetze aus ods_verkauf. Nur K-POS'),
umsatz_brutto_ods_kassenabschluss NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Befuellung im ETL-Prozess - Summe Umsaetze aus ods_kassenabschluss. Nur K_POS'),
bonanzahl_kundenkarte INTEGER
OPTIONS(description='Aggregation der Bons mit Kundenkarten_Typ (z.B. Payback oder Keine) auf Markt-Tag-Land-Ebene '),
offen_theke_von TIME OPTIONS(description='Thekenoeffnungszeit von pro Markt / Tag'),
offen_theke_bis TIME OPTIONS(description='Thekenoeffnungszeit bis pro Markt / Tag'),
bonanzahl_sug_kassenabschluss INTEGER OPTIONS(description='Kunden Kassenabschluss (EOD), Logik analog bonanzahl_sug'),
ssm_umsatz_faktor BIGNUMERIC(18,10) DEFAULT 1 NOT NULL
OPTIONS(description='Berechnung je Wochentag. HL Planwert / Durchschnitt letzte 10 Wochen'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
bonanzahl_kundenkarte_payback INTEGER
OPTIONS(description='Anzahl der Kunden mit Payback als Kundenkarte (nur für Polen).'),
bonanzahl_frischetheke_ohne_fisch INTEGER
OPTIONS(description='Kundenanzahl der Frischetheke ohne OWG 1005 Fisch (Sobald ein Kunde etwas aus den OWGs 1001, 1002, 1003, 1004 kauft, zählt dieser als Kunde der Frischetheke ohne Fisch).'),
PRIMARY KEY (mandant_id, wup_id, nb_id, dat) NOT ENFORCED
) OPTIONS(description='TP1 TP2 Marktkalender mit Datensaetzen nur in Zukunft');