--==============================================================
-- Table: aad_request_type_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_request_type_spr_zu_2
   generated from Powerdesigner on Sonntag, 4. Juni 2023 15:30:52
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AAD_REQUEST_TYPE_SPR_ZU_2 (
   request_type_id                     NUMBER(38,0)     NOT NULL COMMENT 'specifies the type of request, 1=Period extension,  2 =Decryption',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH - ein Mandant_2 pro Land.',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   request_type_descr                  VARCHAR(255)     COMMENT 'Describes the request typ, e.g. Period extension, Decryption',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AAD_REQUEST_TYPE_SPR_ZU PRIMARY KEY (mandant_id, request_type_id, spr_id) NOT ENFORCED
)  COMMENT = 'Translations of descriptions of AAD Request Types';
