--==============================================================
-- Table: angebot_attribut_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: angebot_attribut_spr_zu
   generated from Powerdesigner on Dienstag, 21. Januar 2025 11:32:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.angebot_attribut_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
angebot_attribut_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Attributs'),
angebot_attribut_bez STRING(200) NOT NULL OPTIONS(description='Sprachabhängige Bezeichnung des Attributs'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id, angebot_attribut_id) NOT ENFORCED
) OPTIONS(description='Tabelle für sprachabhängige Bezeichnungen der Attribute zum Angebot.');