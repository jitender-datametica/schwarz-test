/* --------------------------------------------------------------------------------
   DDL for table: t_customer_survey_section
   generated from Powerdesigner on Montag, 18. November 2024 11:55:34
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CUSTOMER_SURVEY_SECTION (
   customer_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Unique identifier of the customer (surrogate key).',
   survey_sid                          NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key SURVEY.',
   survey_version_nr                   NUMBER(38,0)     NOT NULL COMMENT 'Version of the survey, allows to track changes in the set of topics in the survey.',
   survey_version_section_name         VARCHAR(100)     NOT NULL COMMENT 'Name of the section in the versioned survey.',
   survey_tmsp                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the submission of the survey section.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_CUSTOMER_SURVEY_SECTION PRIMARY KEY (customer_sid, survey_sid, survey_version_nr, survey_version_section_name, survey_tmsp) NOT ENFORCED 
)  COMMENT = 'This table contains the survey sections for which customers have provided their answers at a certain point in time.';
