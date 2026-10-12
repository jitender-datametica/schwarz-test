/* --------------------------------------------------------------------------------
   DDL for table: t_survey_topic_type_1
   generated from Powerdesigner on Montag, 18. November 2024 11:55:27
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_SURVEY_TOPIC_TYPE_1 (
   survey_topic_type_cd                VARCHAR(100)     NOT NULL COMMENT 'Code of the survey topic type.',
   survey_topic_type_descr             VARCHAR(250)     COMMENT 'Description of the survey topic type.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_SURVEY_TOPIC_TYPE PRIMARY KEY (survey_topic_type_cd) NOT ENFORCED 
)  COMMENT = 'This table contains the different types of survey topics based on the data domain of the answer.';
