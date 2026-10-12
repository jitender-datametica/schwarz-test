--==============================================================
-- Table: flw_schnittliste_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_schnittliste_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_schnittliste_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
schnittliste_id INTEGER NOT NULL OPTIONS(description='ID der Schnittliste aus ctlnr'),
sek_schl_id INTEGER NOT NULL OPTIONS(description='ID des Sekundärschlüssels aus sckey'),
sek_schl_typ_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Typ des Sekundärschlüssels aus sctyp'),
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
schnittliste_variante BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Bariante der Schnittliste aus varia'),
dat_von DATE NOT NULL OPTIONS(description='Gültigkeitsbeginn des Satzes aus gtvon'),
dat_bis DATE NOT NULL OPTIONS(description='Gültigkeitsende des Satzes aus gtbis'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, schnittliste_id, sek_schl_id) NOT ENFORCED
) OPTIONS(description='FLW - Schnittliste Kopf aus ctlk');