--==============================================================
-- Table: ods_bon_buchungen_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ods_bon_buchungen_2
   generated from Powerdesigner on Dienstag, 1. Juni 2021 10:46:11
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods.ods_bon_buchungen_2 (
bon_id STRING(25) NOT NULL OPTIONS(description='eindeutige ID eines Bons, om DWHgenerierter Hashwert als Surrogate Key'),
bon_zeile BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Die Bonzeile des Bons'),
buchungsschluessel_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer des Buchungsschluessels, z.Bsp 11'),
wup_id BIGNUMERIC(38,0) OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprueft'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH - ein Mandant_2 pro Land_2'),
kpos_zahlung_typ_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Zahlungsmittel z. Bsp. DCC Diners Club'),
dat_booking DATE NOT NULL
OPTIONS(description='Buchungszeitpunkt des Bons, relevant z.B. für artbew. Kann vom Bondatum abweichen, z.B. wenn eine_2 Kasse offline war'),
bon_dat DATE OPTIONS(description='Checkoutdatum, auch Businessday bzw. Kassenkey'),
start_bon_zeile DATETIME NOT NULL OPTIONS(description='Zeitstempel bei Beginn der Bewegung'),
kasse_nr BIGNUMERIC(38,0) OPTIONS(description='Nummer der Kasse'),
bon_nr BIGNUMERIC(38,0)
OPTIONS(description='Die Bonnummer des Bons (ist eine_2 fortlaufende Nummer die in der Kasse generiert wird, im normal Fall ist diese Nummer pro tag_2 und Kasse Unique)'),
betrag_buchung NUMERIC(10,2) OPTIONS(description='Betrag der Buchung'),
kommentar_buchung STRING(100)
OPTIONS(description='Kommentar zu der Buchung. z.B. bei Geldentsorgung die Nummer der Geldtasche'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='ODS - Kassensystem KPOS. Enthält Backoffice Buchungen, wie z.B. Tresorabrechnung');