/* --------------------------------------------------------------------------------
   DDL for table: t_survey_2
   generated from Powerdesigner on Montag, 18. November 2024 11:54:06
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_SURVEY_2 (
   survey_sid                          NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key SURVEY.',
   cx_info_provider_nr                 VARCHAR(100)     NOT NULL COMMENT 'Identifier of the provider or collector of the customer experience information.',
   survey_name                         VARCHAR(100)     NOT NULL COMMENT 'Name of the survey.',
   survey_descr                        VARCHAR(250)     COMMENT 'Description of the survey.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_SURVEY PRIMARY KEY (survey_sid) NOT ENFORCED 
)  COMMENT = 'This table contains general information about ditfferent surveys.';
