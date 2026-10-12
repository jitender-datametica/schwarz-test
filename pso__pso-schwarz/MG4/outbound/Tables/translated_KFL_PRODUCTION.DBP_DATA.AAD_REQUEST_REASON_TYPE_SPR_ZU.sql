CREATE OR REPLACE TABLE kfl_production_dbp_data.aad_request_reason_type_spr_zu (
request_reason_type_id INTEGER NOT NULL OPTIONS(description='Identifier of the the reason code'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH - ein Mandant pro Land.'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
request_reason_type_descr STRING(255) OPTIONS(description='Describes the reason codes'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, request_reason_type_id, spr_id) NOT ENFORCED
) OPTIONS(description='Translations of descriptions of AAD Request creation reason codes');