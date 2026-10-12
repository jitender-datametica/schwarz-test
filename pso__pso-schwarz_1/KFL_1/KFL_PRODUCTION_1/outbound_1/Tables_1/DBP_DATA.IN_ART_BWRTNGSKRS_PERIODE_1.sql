--==============================================================
-- Table: in_art_bwrtngskrs_periode_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_art_bwrtngskrs_periode_1
   generated from Powerdesigner on Dienstag, 13. September 2022 11:58:56
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_art_bwrtngskrs_periode_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
gjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschaeftsjahresmonat'),
bewertungskreis_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='der Bewertungskreis enthaelt die wup_id. Theoretisch kann auch ein Buchungskreis enthalten sein. Über den Bewertungskreis wird die Verbindung zum Gleitenden Durchschnittspreis hergestellt  '),
in_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schluessel für die Artikelnummer.'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
dat_aenderung DATE NOT NULL OPTIONS(description='Aenderungsdatum des Satzes im SAP Quellsystem.'),
gjmo_bis BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Geschaeftsjahresmonat bis. Wird im DWH angereichert, um die Abfrage bei "Luecken" in den Monaten zu vereinfachen'),
mbew_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='kenneichnet die Quelltabelle des Satzes. Wenn aus mbew, dann = 1, mbewh = 0'),
menge_bestand_bme NUMERIC(18,3) NOT NULL OPTIONS(description='Gesamtbestand in Basismengeneinheiten aus lbkum'),
wert_bestand NUMERIC(18,4) OPTIONS(description='Wert des gesamten bewerteten Bestandes'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, gjmo, in_art_id) NOT ENFORCED
) OPTIONS(description='BIS- Bestand aus den SAP Industrie Datenquellen MBEWH und MBEW - MULTISET');