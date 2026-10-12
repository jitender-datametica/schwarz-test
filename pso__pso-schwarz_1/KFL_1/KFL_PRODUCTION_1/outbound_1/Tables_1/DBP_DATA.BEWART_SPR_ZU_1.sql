--==============================================================
-- Table: bewart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bewart_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.bewart_spr_zu_1 (
bewart_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
bewart_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Bewegungsart'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (bewart_id, spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description='Bewegungsart-Sprachen-Zuordnung');