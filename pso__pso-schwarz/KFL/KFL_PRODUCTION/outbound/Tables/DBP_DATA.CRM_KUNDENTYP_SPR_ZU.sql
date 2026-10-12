--==============================================================
-- Table: crm_kundentyp_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_kundentyp_spr_zu
   generated from Powerdesigner on Dienstag, 5. August 2025 17:32:37
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_kundentyp_spr_zu (
kundentyp_cd STRING(60) COLLATE 'und:ci' NOT NULL OPTIONS(description='Code des Kundentypes.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
kundentyp_bez STRING(150) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung des Kundentyps (bspw. aus der K-App, aus dem Customer Service etc.)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (spr_id) NOT ENFORCED
) OPTIONS(description='CRM - Sprachtabelle Kundentyp aus Cosmos DB CRM.');