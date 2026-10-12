--==============================================================
-- Table: flw_art_bewertungskreis_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_bewertungskreis_per
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_art_bewertungskreis_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
dat_von DATE NOT NULL OPTIONS(description='Datum, ab dem der Preis gültig ist'),
bewertungskreis_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='der Bewertungskreis enthält die wup_id. Theoretisch kann auch ein Buchungskreis enthalten sein. Über den Bewertungskreis wird die Verbindung zum Gleitenden Durchschnittspreis hergestellt  '),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
dat_bis DATE NOT NULL
OPTIONS(description='Datum, bis zu dem der Preis gültig ist, bei aktuell gültigen Sätzen ist dies der 31.12.9999'),
preis_steuer_kz STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kennzeichen Preissteuerung aus vprsv'),
gld NUMERIC(18,6) NOT NULL OPTIONS(description='Gleitender Durchschnittspreis aus verpr'),
standard_preis NUMERIC(18,4) NOT NULL OPTIONS(description='Standardpreis aus stprs'),
preis_faktor BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Ganzzahliger Faktor, durch den der Preis geteilt werden muss, um auf den Preis pro Basiseinheit zu kommen aus peinh'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, flw_art_id, dat_von) NOT ENFORCED
) OPTIONS(description='FLW - Diese Tabelle bildet den gleitenden Durchschnittspreis ab. Quelle ist mbew');