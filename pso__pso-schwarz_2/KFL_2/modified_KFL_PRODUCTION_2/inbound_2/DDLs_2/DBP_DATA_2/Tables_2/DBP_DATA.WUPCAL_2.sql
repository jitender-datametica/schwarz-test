--==============================================================
-- Table: wupcal_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wupcal_2
   generated from Powerdesigner on Freitag, 11. Juli 2025 11:08:31
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WUPCAL_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'PK Mandant_2 im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'PK Warenumschlagsplatz',
   nb_id                               INTEGER     NOT NULL COMMENT 'PK - Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat                                 DATE             NOT NULL COMMENT 'PK - Datum im Format JJJJ-MM_2-TT',
   offen                               INTEGER     COMMENT 'kennzeichnet, ob ein Markt zu einem Datum geoeffnet war. 1 offen, 0 geschlossen',
   werbewoche                          INTEGER     COMMENT 'wird z.Zt. nicht benutzt',
   datenlieferung_artbew_wg_sum        INTEGER     COMMENT 'Datenlieferungs-Stati	
            0	nicht geliefert
            1	geliefert
            2	kalkuliert
            3	gesplittet
            4	nicht mehr lieferbar
            5	kumuliert (ueber n Tage)
            6	kalkuliert und nicht mehr lieferbar',
   datenlieferung_bonanzahl            INTEGER     COMMENT 'Datenlieferungs-Stati	
            0	nicht geliefert
            1	geliefert
            2	kalkuliert
            3	gesplittet
            4	nicht mehr lieferbar
            5	kumuliert (ueber n Tage)
            6	kalkuliert und nicht mehr lieferbar',
   datenlieferung_misvier              INTEGER     COMMENT 'Daten aus der Schnittstelle misvier wurden geliefert
            Datenlieferungs-Stati	
            0	nicht geliefert
            1	geliefert
            2	kalkuliert
            3	gesplittet
            4	nicht mehr lieferbar
            5	kumuliert (ueber n Tage)
            6	kalkuliert und nicht mehr lieferbar',
   datenlieferung_artbew               INTEGER     COMMENT 'Lieferung der Artikelbewegungsdaten aus dem Markt
            Datenlieferungs-Stati	
            0	nicht geliefert
            1	geliefert
            2	kalkuliert
            3	gesplittet
            4	nicht mehr lieferbar
            5	kumuliert (ueber n Tage)
            6	kalkuliert und nicht mehr lieferbar',
   datenlieferung_qbm_status           INTEGER     COMMENT 'Lieferung der QBM-Daten (Reklamationen) aus dem Markt
            Datenlieferungs-Stati	
            0   nicht geliefert
            1    geliefert
            weitere Stati koennen zu einem spaeteren Zeitpunkt festgelegt werden',
   pruef_status_id_umsatz              INTEGER     COMMENT 'Status_2 der Pruefung des Umsatzes. Der Umsatz wird auf Plausibilitaet geprueft',
   pruef_status_id_kunde               INTEGER     COMMENT 'Status_2 der Pruefung der Kundenzahl. Die Kundenzahl wird auf Plausibilitaet geprueft',
   pruef_grund_id_umsatz               VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Grund der Pruefung des Umsatzes',
   pruef_grund_id_kunde                VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Grund der Pruefung der Kundenzahl',
   wrg_id                              VARCHAR(3)       COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   dat_extrakt_umsatz                  DATE             COMMENT 'Datum des Erhalts der  Schnittstelle Umsatz',
   offen_von                           INTEGER     COMMENT 'Zeitpunkt der Marktoeffnung',
   offen_bis                           INTEGER     COMMENT 'Schließungszeitpunkt des Marktes',
   offen_theke_von                     TIME(0)          COMMENT 'Thekenoeffnungszeit von pro Markt / Tag_2',
   offen_theke_bis                     TIME(0)          COMMENT 'Thekenoeffnungszeit bis pro Markt / Tag_2',
   umsatz_brutto_ods_verkauf           NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Befuellung im ETL-Prozess - Summe Umsaetze aus ods_verkauf. Nur K-POS',
   umsatz_brutto_ods_kassenabschluss   NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Befuellung im ETL-Prozess - Summe Umsaetze aus ods_kassenabschluss. Nur K_POS',
   bonanzahl                           INTEGER     COMMENT 'Anzahl der Kassenbons',
   bonanzahl_misvier                   INTEGER     COMMENT 'Anzahl Bons',
   bonanzahl_imbiss                    INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl Kunden im Imbiss des Marktes. Gehoert logisch nicht hierher, da abhaengig von einer Warengruppe bzw. bestimmten Kassierer-Nummern.',
   bonanzahl_sug                       INTEGER     COMMENT 'Bons mit mindestens einer positiven Position - einheitliche Definition der Kundenzahl innerhalb der Schwarz-Unternehmensgruppe',
   bonanzahl_sug_kassenabschluss       INTEGER     COMMENT 'Kunden Kassenabschluss (EOD), Logik analog bonanzahl_sug',
   bonanzahl_frischetheke_ohne_fisch   INTEGER     COMMENT 'Kundenanzahl der Frischetheke ohne OWG 1005 Fisch (Sobald ein Kunde etwas aus den OWGs 1001, 1002, 1003, 1004 kauft, zählt dieser als Kunde der Frischetheke ohne Fisch).',
   bonanzahl_kundenkarte_payback       INTEGER     COMMENT 'Anzahl der Kunden mit Payback als Kundenkarte (nur für Polen).',
   bonanzahl_kundenkarte               INTEGER     COMMENT 'Aggregation der Bons mit Kundenkarten_Typ_ID = 2 (Kaufland Loyalty Card) auf Markt-Tag_2-Land_2-Ebene ',
   betrag_vk_netto_kundenkarte         NUMBER(29,4)     COMMENT 'Umsatz netto mit Kaufland Loyalty Programm (kundenkarte_typ_id =2) auf Markt.Tag_2-Ebene.',
   ssm_umsatz_faktor                   NUMBER(38,10)    NOT NULL DEFAULT 1 COMMENT 'Berechnung je Wochentag. HL_2 Planwert / Durchschnitt letzte 10 Wochen',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WUPCAL PRIMARY KEY (mandant_id, wup_id, nb_id, dat) NOT ENFORCED
)  COMMENT = 'TP1 TP2 Marktkalender.';
