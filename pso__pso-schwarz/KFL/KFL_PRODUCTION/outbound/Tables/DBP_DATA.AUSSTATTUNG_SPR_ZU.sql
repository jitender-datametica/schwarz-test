--==============================================================
-- Table: ausstattung_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ausstattung_spr_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ausstattung_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
ausstattung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID des Ausstattungsmerkmals. Wird im DWH vergeben'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.'),
ausstattung_bez STRING(40) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung des Ausstattungsmerkmals, z.Bsp. Kundenkasse'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, ausstattung_id, spr_id) NOT ENFORCED
) OPTIONS(description='VIS - sprachabhängige Bezeichnung der Ausstattungsmerkmale, z.Bsp. Leergutkasse');