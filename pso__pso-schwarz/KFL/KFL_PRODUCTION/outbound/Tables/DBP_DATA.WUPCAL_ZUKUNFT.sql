--==============================================================
-- Table: wupcal_zukunft
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wupcal_zukunft
   generated from Powerdesigner on Dienstag, 20. Juni 2023 16:14:40
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wupcal_zukunft (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='PK Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='PK Warenumschlagsplatz'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='PK - Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat DATE NOT NULL OPTIONS(description='PK - Datum im Format JJJJ-MM-TT'),
offen BIGNUMERIC(38,0)
OPTIONS(description='kennzeichnet, ob ein Markt zu einem Datum geoeffnet war. 1 offen, 0 geschlossen'),
werbewoche BIGNUMERIC(38,0) OPTIONS(description='wird z.Zt. nicht benutzt'),
datenlieferung_artbew_wg_sum BIGNUMERIC(38,0)
OPTIONS(description='Datenlieferungs-Stati:	            0	nicht geliefert            1	geliefert            2	kalkuliert            3	gesplittet            4	nicht mehr lieferbar            5	kumuliert (über n Tage)            6	kalkuliert und nicht mehr lieferbar'),
datenlieferung_bonanzahl BIGNUMERIC(38,0)
OPTIONS(description='Datenlieferungs-Stati	            0	nicht geliefert            1	geliefert            2	kalkuliert            3	gesplittet            4	nicht mehr lieferbar            5	kumuliert (über n Tage)            6	kalkuliert und nicht mehr lieferbar'),
datenlieferung_misvier BIGNUMERIC(38,0)
OPTIONS(description='Daten aus der Schnittstelle misvier wurden geliefert            Datenlieferungs-Stati	            0	nicht geliefert            1	geliefert            2	kalkuliert            3	gesplittet            4	nicht mehr lieferbar            5	kumuliert (über n Tage)            6	kalkuliert und nicht mehr lieferbar'),
datenlieferung_artbew BIGNUMERIC(38,0)
OPTIONS(description='Lieferung der Artikelbewegungsdaten aus dem Markt            Datenlieferungs-Stati	            0	nicht geliefert            1	geliefert            2	kalkuliert            3	gesplittet            4	nicht mehr lieferbar            5	kumuliert (über n Tage)            6	kalkuliert und nicht mehr lieferbar'),
datenlieferung_qbm_status BIGNUMERIC(38,0)
OPTIONS(description='Lieferung der QBM-Daten (Reklamationen) aus dem Markt            Datenlieferungs-Stati:	            0   nicht geliefert            1   geliefert            weitere Stati können zu einem späteren Zeitpunkt festgelegt werden'),
pruef_status_id_umsatz BIGNUMERIC(38,0)
OPTIONS(description='Status der Pruefung des Umsatzes. Der Umsatz wird auf Plausibilitaet geprueft'),
pruef_status_id_kunde BIGNUMERIC(38,0)
OPTIONS(description='Status der Pruefung der Kundenzahl. Die Kundenzahl wird auf Plausibilität geprueft'),
pruef_grund_id_umsatz STRING(3) COLLATE 'und:ci' OPTIONS(description='Grund der Pruefung des Umsatzes'),
pruef_grund_id_kunde STRING(3) COLLATE 'und:ci' OPTIONS(description='Grund der Pruefung der Kundenzahl'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
dat_extrakt_umsatz DATE OPTIONS(description='Datum des Erhalts der  Schnittstelle Umsatz'),
offen_von BIGNUMERIC(38,0) OPTIONS(description='Zeitpunkt der Marktoeffnung'),
offen_bis BIGNUMERIC(38,0) OPTIONS(description='Schließungszeitpunkt des Marktes'),
offen_theke_von TIME OPTIONS(description='Thekenoeffnungszeit von pro Markt / Tag'),
offen_theke_bis TIME OPTIONS(description='Thekenoeffnungszeit bis pro Markt / Tag'),
umsatz_brutto_ods_verkauf NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Befuellung im ETL-Prozess - Summe Umsaetze aus ods_verkauf. Nur K-POS'),
umsatz_brutto_ods_kassenabschluss NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Befuellung im ETL-Prozess - Summe Umsaetze aus ods_kassenabschluss. Nur K_POS'),
bonanzahl BIGNUMERIC(38,0) OPTIONS(description='Anzahl der Kassenbons'),
bonanzahl_misvier BIGNUMERIC(38,0) OPTIONS(description='Anzahl Bons'),
bonanzahl_imbiss BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Kunden im Imbiss des Marktes. Gehoert logisch nicht hierher, da abhaengig von einer Warengruppe bzw. bestimmten Kassierer-Nummern.'),
bonanzahl_sug BIGNUMERIC(38,0)
OPTIONS(description='Bons mit mindestens einer positiven Position - einheitliche Definition der Kundenzahl innerhalb der Schwarz-Unternehmensgruppe'),
bonanzahl_kundenkarte BIGNUMERIC(38,0)
OPTIONS(description='Aggregation der Bons mit Kundenkarten_Typ (z.B. Payback oder Keine) auf Markt-Tag-Land-Ebene '),
bonanzahl_kundenkarte_payback BIGNUMERIC(38,0)
OPTIONS(description='Anzahl der Kunden mit Payback als Kundenkarte (nur für Polen).'),
bonanzahl_sug_kassenabschluss BIGNUMERIC(38,0)
OPTIONS(description='Kunden Kassenabschluss (EOD), Logik analog bonanzahl_sug'),
bonanzahl_frischetheke_ohne_fisch BIGNUMERIC(38,0)
OPTIONS(description='Kundenanzahl der Frischetheke ohne OWG 1005 Fisch (Sobald ein Kunde etwas aus den OWGs 1001, 1002, 1003, 1004 kauft, zählt dieser als Kunde der Frischetheke ohne Fisch).'),
ssm_umsatz_faktor BIGNUMERIC(18,10) DEFAULT 1 NOT NULL
OPTIONS(description='Berechnung je Wochentag. HL Planwert / Durchschnitt letzte 10 Wochen'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, dat) NOT ENFORCED
) OPTIONS(description='TP1 TP2 Marktkalender mit Datensaetzen nur in Zukunft');