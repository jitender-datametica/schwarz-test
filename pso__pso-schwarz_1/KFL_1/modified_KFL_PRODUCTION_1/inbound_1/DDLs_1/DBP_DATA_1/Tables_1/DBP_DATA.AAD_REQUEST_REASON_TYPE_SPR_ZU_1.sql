--==============================================================
-- Table: aad_request_reason_type_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_request_reason_type_spr_zu_1
   generated from Powerdesigner on Sonntag, 4. Juni 2023 15:32:46
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AAD_REQUEST_REASON_TYPE_SPR_ZU_1 (
   request_reason_type_id              INTEGER     NOT NULL COMMENT 'Identifier of the the reason code',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH - ein Mandant_1 pro Land.',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   request_reason_type_descr           VARCHAR(255)     COMMENT 'Describes the reason codes',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AAD_REQUEST_REASON_TYPE_SPR_ZU PRIMARY KEY (mandant_id, request_reason_type_id, spr_id) NOT ENFORCED
)  COMMENT = 'Translations of descriptions of AAD Request creation reason codes';
