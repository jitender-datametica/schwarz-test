/* --------------------------------------------------------------------------------
   DDL for table: t_survey_topic_group_1
   generated from Powerdesigner on Montag, 18. November 2024 11:54:56
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_SURVEY_TOPIC_GROUP_1 (
   survey_topic_grp_sid                NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key SURVEY TOPIC GROUP.',
   survey_topic_grp_name               VARCHAR(100)     NOT NULL COMMENT 'Name of the survey topic group.',
   survey_topic_grp_type_cd            VARCHAR(100)     COMMENT 'Type Code of the survey topic group',
   survey_topic_grp_descr              VARCHAR(250)     COMMENT 'Description of the survey topic group.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_SURVEY_TOPIC_GROUP PRIMARY KEY (survey_topic_grp_sid) NOT ENFORCED 
)  COMMENT = 'This table contains information about groups of  topics.';
