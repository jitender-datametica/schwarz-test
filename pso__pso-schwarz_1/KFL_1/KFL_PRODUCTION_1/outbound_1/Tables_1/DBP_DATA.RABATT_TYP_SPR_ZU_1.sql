--==============================================================
-- Table: rabatt_typ_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: rabatt_typ_spr_zu_1
   generated from Powerdesigner on Dienstag, 21. Januar 2025 11:43:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rabatt_typ_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
rabatt_typ_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Rabatt Typs. Gibt die Art_1 des gewährten Rabattes an, bspw. Normalpreis (1), Rabattpreis (2), Absoluter Rabatt (3). etc.'),
rabatt_typ_bez STRING(200) NOT NULL OPTIONS(description='Sprachabhängige Bezeichnung des Rabatttyps.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id, rabatt_typ_id) NOT ENFORCED
) OPTIONS(description='Tabelle für sprachabhängige Bezeichnungen des Rabatttyps');