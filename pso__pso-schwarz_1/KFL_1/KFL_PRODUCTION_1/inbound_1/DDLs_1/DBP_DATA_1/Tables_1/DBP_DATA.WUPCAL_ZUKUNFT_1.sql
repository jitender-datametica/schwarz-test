--==============================================================
-- Table: wupcal_zukunft_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wupcal_zukunft_1
   generated from Powerdesigner on Dienstag, 20. Juni 2023 16:14:40
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WUPCAL_ZUKUNFT_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'PK Mandant_1 im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'PK Warenumschlagsplatz',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'PK - Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat                                 DATE             NOT NULL COMMENT 'PK - Datum im Format JJJJ-MM_1-TT',
   offen                               NUMBER(38,0)     COMMENT 'kennzeichnet, ob ein Markt zu einem Datum geoeffnet war. 1 offen, 0 geschlossen',
   werbewoche                          NUMBER(38,0)     COMMENT 'wird z.Zt. nicht benutzt',
   datenlieferung_artbew_wg_sum        NUMBER(38,0)     COMMENT 'Datenlieferungs-Stati:	
            0	nicht geliefert
            1	geliefert
            2	kalkuliert
            3	gesplittet
            4	nicht mehr lieferbar
            5	kumuliert (über n Tage)
            6	kalkuliert und nicht mehr lieferbar',
   datenlieferung_bonanzahl            NUMBER(38,0)     COMMENT 'Datenlieferungs-Stati	
            0	nicht geliefert
            1	geliefert
            2	kalkuliert
            3	gesplittet
            4	nicht mehr lieferbar
            5	kumuliert (über n Tage)
            6	kalkuliert und nicht mehr lieferbar',
   datenlieferung_misvier              NUMBER(38,0)     COMMENT 'Daten aus der Schnittstelle misvier wurden geliefert
            Datenlieferungs-Stati	
            0	nicht geliefert
            1	geliefert
            2	kalkuliert
            3	gesplittet
            4	nicht mehr lieferbar
            5	kumuliert (über n Tage)
            6	kalkuliert und nicht mehr lieferbar',
   datenlieferung_artbew               NUMBER(38,0)     COMMENT 'Lieferung der Artikelbewegungsdaten aus dem Markt
            Datenlieferungs-Stati	
            0	nicht geliefert
            1	geliefert
            2	kalkuliert
            3	gesplittet
            4	nicht mehr lieferbar
            5	kumuliert (über n Tage)
            6	kalkuliert und nicht mehr lieferbar',
   datenlieferung_qbm_status           NUMBER(38,0)     COMMENT 'Lieferung der QBM-Daten (Reklamationen) aus dem Markt
            Datenlieferungs-Stati:	
            0   nicht geliefert
            1   geliefert
            weitere Stati können zu einem späteren Zeitpunkt festgelegt werden',
   pruef_status_id_umsatz              NUMBER(38,0)     COMMENT 'Status_1 der Pruefung des Umsatzes. Der Umsatz wird auf Plausibilitaet geprueft',
   pruef_status_id_kunde               NUMBER(38,0)     COMMENT 'Status_1 der Pruefung der Kundenzahl. Die Kundenzahl wird auf Plausibilität geprueft',
   pruef_grund_id_umsatz               VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Grund der Pruefung des Umsatzes',
   pruef_grund_id_kunde                VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Grund der Pruefung der Kundenzahl',
   wrg_id                              VARCHAR(3)       COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   dat_extrakt_umsatz                  DATE             COMMENT 'Datum des Erhalts der  Schnittstelle Umsatz',
   offen_von                           NUMBER(38,0)     COMMENT 'Zeitpunkt der Marktoeffnung',
   offen_bis                           NUMBER(38,0)     COMMENT 'Schließungszeitpunkt des Marktes',
   offen_theke_von                     TIME(0)          COMMENT 'Thekenoeffnungszeit von pro Markt / Tag_1',
   offen_theke_bis                     TIME(0)          COMMENT 'Thekenoeffnungszeit bis pro Markt / Tag_1',
   umsatz_brutto_ods_verkauf           NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Befuellung im ETL-Prozess - Summe Umsaetze aus ods_verkauf. Nur K-POS',
   umsatz_brutto_ods_kassenabschluss   NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Befuellung im ETL-Prozess - Summe Umsaetze aus ods_kassenabschluss. Nur K_POS',
   bonanzahl                           NUMBER(38,0)     COMMENT 'Anzahl der Kassenbons',
   bonanzahl_misvier                   NUMBER(38,0)     COMMENT 'Anzahl Bons',
   bonanzahl_imbiss                    NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Anzahl Kunden im Imbiss des Marktes. Gehoert logisch nicht hierher, da abhaengig von einer Warengruppe bzw. bestimmten Kassierer-Nummern.',
   bonanzahl_sug                       NUMBER(38,0)     COMMENT 'Bons mit mindestens einer positiven Position - einheitliche Definition der Kundenzahl innerhalb der Schwarz-Unternehmensgruppe',
   bonanzahl_kundenkarte               NUMBER(38,0)     COMMENT 'Aggregation der Bons mit Kundenkarten_Typ (z.B. Payback oder Keine) auf Markt-Tag_1-Land_1-Ebene ',
   bonanzahl_kundenkarte_payback       NUMBER(38,0)     COMMENT 'Anzahl der Kunden mit Payback als Kundenkarte (nur für Polen).',
   bonanzahl_sug_kassenabschluss       NUMBER(38,0)     COMMENT 'Kunden Kassenabschluss (EOD), Logik analog bonanzahl_sug',
   bonanzahl_frischetheke_ohne_fisch   NUMBER(38,0)     COMMENT 'Kundenanzahl der Frischetheke ohne OWG 1005 Fisch (Sobald ein Kunde etwas aus den OWGs 1001, 1002, 1003, 1004 kauft, zählt dieser als Kunde der Frischetheke ohne Fisch).',
   ssm_umsatz_faktor                   NUMBER(18,10)    NOT NULL DEFAULT 1 COMMENT 'Berechnung je Wochentag. HL_1 Planwert / Durchschnitt letzte 10 Wochen',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WUPCAL_ZUKUNFT PRIMARY KEY (mandant_id, wup_id, nb_id, dat) NOT ENFORCED
)  COMMENT = 'TP1 TP2 Marktkalender mit Datensaetzen nur in Zukunft';
