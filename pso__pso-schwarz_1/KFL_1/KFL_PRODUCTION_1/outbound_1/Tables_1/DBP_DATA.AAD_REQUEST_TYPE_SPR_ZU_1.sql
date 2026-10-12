--==============================================================
-- Table: aad_request_type_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_request_type_spr_zu_1
   generated from Powerdesigner on Sonntag, 4. Juni 2023 15:30:52
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aad_request_type_spr_zu_1 (
request_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='specifies the type of request, 1=Period extension,  2 =Decryption'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH - ein Mandant_1 pro Land.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
request_type_descr STRING(255) OPTIONS(description='Describes the request typ, e.g. Period extension, Decryption'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, request_type_id, spr_id) NOT ENFORCED
) OPTIONS(description='Translations of descriptions of AAD Request Types');