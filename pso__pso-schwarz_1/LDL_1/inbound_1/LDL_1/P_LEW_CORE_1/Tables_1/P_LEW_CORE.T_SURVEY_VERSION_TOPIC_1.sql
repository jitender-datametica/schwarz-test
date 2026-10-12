/* --------------------------------------------------------------------------------
   DDL for table: t_survey_version_topic_1
   generated from Powerdesigner on Montag, 18. November 2024 11:54:45
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_SURVEY_VERSION_TOPIC_1 (
   survey_sid                          NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key SURVEY.',
   survey_version_nr                   NUMBER(38,0)     NOT NULL COMMENT 'Version of the survey, allows to track changes in the set of topics in the survey.',
   survey_version_section_name         VARCHAR(100)     NOT NULL COMMENT 'Name of the section in the versioned survey. ',
   survey_topic_sid                    NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key SURVEY TOPIC.',
   survey_topic_grp_sid                NUMBER(38,0)     COMMENT 'Surrogate Key SURVEY TOPIC GROUP.',
   cx_info_provider_nr                 VARCHAR(100)     NOT NULL COMMENT 'Identifier of the provider or collector of the customer experience information.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_SURVEY_VERSION_TOPIC PRIMARY KEY (survey_sid, survey_version_nr, survey_version_section_name, survey_topic_sid) NOT ENFORCED 
)  COMMENT = 'This table contains information about which topics are used in which survey versions.';
