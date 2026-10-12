/* --------------------------------------------------------------------------------
   DDL for table: t_survey_topic_group_type
   generated from Powerdesigner on Montag, 18. November 2024 11:55:06
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_SURVEY_TOPIC_GROUP_TYPE (
   survey_topic_grp_type_cd            VARCHAR(100)     NOT NULL COMMENT 'Type code of the survey topic group.',
   survey_topic_grp_type_descr         VARCHAR(250)     COMMENT 'Description of the survey topic group.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_SURVEY_TOPIC_GROUP_TYPE PRIMARY KEY (survey_topic_grp_type_cd) NOT ENFORCED 
)  COMMENT = 'This table contains the type of a survey topic group based on the implementation of the topic in the UI with respect to the answer option type (single choice / multiple choice) and the complexity of the answer structure implementation (usage of chip components).';
