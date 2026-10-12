--==============================================================
-- Table: crm_kundenherkunft_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_kundenherkunft_spr_zu
   generated from Powerdesigner on Dienstag, 5. August 2025 17:32:37
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_kundenherkunft_spr_zu (
kundenherkunft_cd STRING(50) NOT NULL
OPTIONS(description='Code der Kundenherkunft ( example values: K-App,Marktplatz,Mobiles Registrierungsformular,kappAndroid,kappIOS,marketplaceLoyalty,sscTerminal,sscWeb,Web).'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
kundenherkunft_bez STRING(200) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung der Kundenherkunft (bspw. aus der K-App, aus dem Customer Service etc.)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (kundenherkunft_cd, spr_id) NOT ENFORCED
) OPTIONS(description='CRM - Sprachtabelle für Kundenherkunft aus Cosmos DB CRM.');