--==============================================================
-- Table: aad_request_reason_type_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_request_reason_type_spr_zu
   generated from Powerdesigner on Sonntag, 4. Juni 2023 15:32:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aad_request_reason_type_spr_zu (
request_reason_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier of the the reason code'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH - ein Mandant pro Land.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
request_reason_type_descr STRING(255) OPTIONS(description='Describes the reason codes'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, request_reason_type_id, spr_id) NOT ENFORCED
) OPTIONS(description='Translations of descriptions of AAD Request creation reason codes');