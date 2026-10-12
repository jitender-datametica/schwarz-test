--==============================================================
-- Table: belos_adresse
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belos_adresse
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.belos_adresse (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
belos_adresse_id STRING(40) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutiger Schluessel zur Identifikation einer Belos Adresse'),
land_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Land, in dem sich der Markt befindet. Hat immer Länge von 2 Zeichen (PL, CZ, DE,..). Im Quellsystem SAP hat das Feld 3 Zeichen'),
adress_name STRING(60) COLLATE 'und:ci' OPTIONS(description='Name der Belos Adresse'),
adress_name_zusatz STRING(40) COLLATE 'und:ci' OPTIONS(description='Namenszusatz der Belos Adresse'),
strasse STRING(40) COLLATE 'und:ci' OPTIONS(description='Strasse der Belos Adresse'),
be_entlade_stelle STRING(40) COLLATE 'und:ci' OPTIONS(description='Be-/Entladestelle der Belos Adresse'),
plz STRING(10) COLLATE 'und:ci' OPTIONS(description='Postleitzahl'),
ansprechpartner STRING(40) COLLATE 'und:ci' OPTIONS(description='Ansprechpartner der Belos Adresse. Compress blank'),
ort STRING(40) COLLATE 'und:ci' OPTIONS(description='Ort der Belos Adresse'),
spedition_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Flag - der Wert 1 bedeutet, dass es sich um eine Spedition handelt'),
belos_standort_typ_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='ID des Belos_standorttyps. Wird im DWH vergeben'),
belos_adresse_num_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='numerischer Wert für die belos_adresse. Bei Märkten/Lägern ist hier die wup_id hinterlegt, ansonsten ein negativer Wert. Wird für CROSS JOIN-Zwecke benötigt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
)
OPTIONS(description='LIS - Stammdaten fuer die Belos Adressen. Die Eintraege haben keine Referenz zu der DWH Stammdatentabelle GP weil Belos keine Kreditorennummer liefert.');