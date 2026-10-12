--==============================================================
-- Table: aad_request_status_type_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_request_status_type_spr_zu
   generated from Powerdesigner on Sonntag, 4. Juni 2023 15:28:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aad_request_status_type_spr_zu (
request_status_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the types of statuses a request can have: default 0=open, 1= approved, 2=rejected'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH - ein Mandant pro Land.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
request_status_type_descr STRING(255)
OPTIONS(description='Describes status type: default 0=open, 1= approved, 2=rejected'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, request_status_type_id, spr_id) NOT ENFORCED
) OPTIONS(description='Translations of descriptions of AAD Request Status  types');