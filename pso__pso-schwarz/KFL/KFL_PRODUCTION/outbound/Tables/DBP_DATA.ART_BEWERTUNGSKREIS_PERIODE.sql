--==============================================================
-- Table: art_bewertungskreis_periode
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_bewertungskreis_periode
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_bewertungskreis_periode (
gjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahresmonat'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig);'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
bewertungskreis_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='der Bewertungskreis enthält die wup_id. Theoretisch kann auch ein Buchungskreis enthalten sein. Über den Bewertungskreis wird die Verbindung zum Gleitenden Durchschnittspreis hergestellt aus bwkey                        '),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
dat_aenderung DATE NOT NULL OPTIONS(description='Aenderungsdatum des Satzes im SAP Quellsystem.'),
menge_bestand_bme NUMERIC(18,3) NOT NULL OPTIONS(description='Gesamtbestand in Basismengeneinheiten aus lbkum'),
wert_bestand NUMERIC(18,4) NOT NULL
OPTIONS(description='Entspricht nicht dem Produkt aus Menge und Preis und muss daher als eigener Wert gespeichert werden. Aus salk3'),
vk_wert NUMERIC(18,2) NOT NULL OPTIONS(description='Zum Verkaufspreis bewerteter Bestand aus vksal'),
mbew_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='kenneichnet die Quelltabelle des Satzes. Wenn aus mbew, dann = 1, mbewh = 0'),
gjmo_bis BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Geschäftsjahresmonat bis. Wird im DWH angereichert, um die Abfrage bei "Lücken" in den Monaten zu vereinfachen'),
bewertung_klasse_id STRING(4) COLLATE 'und:ci'
OPTIONS(description='Die Bewertungsklasse bestimmt u.a. die Sachkonten, die fortgeschrieben werden. Quelle ist bklas'),
preis_steuer_kz STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Preissteuerkennzeichen.S= S- Preis, V=GLD. Aus vprsv'),
gld NUMERIC(18,6) NOT NULL
OPTIONS(description='Gleitender Durchschnittspreis. In KMO die Basis zur Bewertung der Bestände. Ist unabhängig vom preis_steuer_kz vorhanden. Quelle ist verpr'),
standard_preis NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Der Standardpreis ist nur bei entsprechend gesetztem preis_steuer_kz gefüllt (S). Quelle ist stprs'),
dat_letzte_preisaenderung DATE OPTIONS(description='Datum der letzten Preisaenderung aus der Tabelle mbew,  Feld laepr'),
vk_wert_netto NUMERIC(18,2) NOT NULL OPTIONS(description='Zum Netto-Verkaufspreis bewerteter Bestand.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (gjmo, art_id, mandant_id) NOT ENFORCED
) CLUSTER BY mandant_id
OPTIONS(description='WWC - Bewerteter Bestand aus den SAP Datenquellen MBEWH und MBEW ');