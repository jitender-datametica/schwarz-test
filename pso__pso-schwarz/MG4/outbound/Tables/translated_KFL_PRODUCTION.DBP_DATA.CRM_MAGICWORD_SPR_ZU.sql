CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_magicword_spr_zu (
crm_magicword_id STRING(36) NOT NULL
OPTIONS(description='Topic related to the content of the ticket which had been defined by the business'),
mandant_id INTEGER NOT NULL OPTIONS(description='country ID'),
spr_id INTEGER NOT NULL OPTIONS(description='language ID'),
crm_magicword_bez STRING(100) OPTIONS(description='description of the magic word'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_magicword_id, mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='Spr_zu für magic word surrogate keys (=\"Zauberwort\" = topic category tag for CRM tickets)');