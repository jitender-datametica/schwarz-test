--==============================================================
-- Table: ods_bon_buchungen_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ods_bon_buchungen_1
   generated from Powerdesigner on Dienstag, 1. Juni 2021 10:46:11
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_ODS.ods_bon_buchungen_1 (
   bon_id                              VARCHAR(25)     NOT NULL COMMENT 'eindeutige ID eines Bons, om DWHgenerierter Hashwert als Surrogate Key',
   bon_zeile                           INTEGER    NOT NULL COMMENT 'Die Bonzeile des Bons',
   buchungsschluessel_id               INTEGER    NOT NULL COMMENT 'Nummer des Buchungsschluessels, z.Bsp 11',
   wup_id                              INTEGER    COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprueft',
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH - ein Mandant_1 pro Land_1',
   kpos_zahlung_typ_id                 VARCHAR(4)      collate 'en-ci' NOT NULL COMMENT 'Zahlungsmittel z. Bsp. DCC Diners Club',
   dat_booking                         DATE            NOT NULL COMMENT 'Buchungszeitpunkt des Bons, relevant z.B. für artbew. Kann vom Bondatum abweichen, z.B. wenn eine_1 Kasse offline war',
   bon_dat                             DATE            COMMENT 'Checkoutdatum, auch Businessday bzw. Kassenkey',
   start_bon_zeile                     TIMESTAMP_NTZ   NOT NULL COMMENT 'Zeitstempel bei Beginn der Bewegung',
   kasse_nr                            INTEGER    COMMENT 'Nummer der Kasse',
   bon_nr                              INTEGER    COMMENT 'Die Bonnummer des Bons (ist eine_1 fortlaufende Nummer die in der Kasse generiert wird, im normal Fall ist diese Nummer pro tag_1 und Kasse Unique)',
   betrag_buchung                      NUMBER(29,2)    COMMENT 'Betrag der Buchung',
   kommentar_buchung                   VARCHAR(100)    COMMENT 'Kommentar zu der Buchung. z.B. bei Geldentsorgung die Nummer der Geldtasche'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'ODS - Kassensystem KPOS. Enthält Backoffice Buchungen, wie z.B. Tresorabrechnung';