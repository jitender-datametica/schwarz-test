--==============================================================
-- Table: flw_schnitt_input_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_schnitt_input_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_schnitt_input_1 (
schnitt_id INTEGER NOT NULL OPTIONS(description='Eindeutige Nummer des Schnitts aus cutnr'),
sek_schl_typ_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Typ des Sekundärschlüssels aus sctyp'),
sek_schl_id INTEGER NOT NULL OPTIONS(description='ID des Sekundärschlüssels aus sckey'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
dat_von DATE NOT NULL OPTIONS(description='Gültigkeitsbeginn des Satzes aus gtvon'),
dat_bis DATE NOT NULL OPTIONS(description='Gültigkeitsende des Satzes aus gtbis'),
material_einzel_kosten NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Materialeinzelkosten aus price'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
system_id BIGNUMERIC(38,0) OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
trennprozess_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID des Trennprozesses aus trpro. Werte sind SDZ oder ZERL'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (schnitt_id, sek_schl_id, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Kopftabelle Schnitt-Input aus cutk');