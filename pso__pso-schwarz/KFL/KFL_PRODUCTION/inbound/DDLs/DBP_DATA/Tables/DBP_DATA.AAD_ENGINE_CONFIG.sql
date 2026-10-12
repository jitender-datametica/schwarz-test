--==============================================================
-- Table: aad_engine_config
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_engine_config
   generated from Powerdesigner on Mittwoch, 31. Mai 2023 07:06:10
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AAD_ENGINE_CONFIG (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH - ein Mandant pro Land.',
   config_id                           NUMBER(38,0)     NOT NULL COMMENT 'Unique Identifier of the config setting',
   config_val                          NUMBER(38,0)     NOT NULL COMMENT 'Value of the config setting',
   config_descr                        VARCHAR(255)     COMMENT 'Describes the meaning of the config parameter in English',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AAD_ENGINE_CONFIG PRIMARY KEY (mandant_id, config_id) NOT ENFORCED
)  COMMENT = 'Contains configuration that the fraud detection model uses when processing data.';
