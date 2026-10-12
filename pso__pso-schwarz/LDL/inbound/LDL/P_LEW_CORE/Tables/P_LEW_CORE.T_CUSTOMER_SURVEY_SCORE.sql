/* --------------------------------------------------------------------------------
   DDL for table: t_customer_survey_score
   generated from Powerdesigner on Montag, 18. November 2024 11:55:43
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CUSTOMER_SURVEY_SCORE (
   customer_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Unique identifier of the customer (surrogate key).',
   survey_sid                          NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key SURVEY.',
   survey_version_nr                   NUMBER(38,0)     NOT NULL COMMENT 'Version of the survey, allows to track changes in the set of topics in the survey.',
   survey_version_section_name         VARCHAR(100)     NOT NULL COMMENT 'Name of the section in the versioned survey.',
   survey_tmsp                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the submission of the survey section.',
   survey_topic_sid                    NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key SURVEY TOPIC.',
   cust_survey_topic_score_fg          NUMBER(38,0)     COMMENT 'Score value of the topic in the store survey if it is a boolean topic type.',
   cust_survey_topic_score_cnt         NUMBER(38,0)     COMMENT 'Score value of the topic in the store survey if it is a count topic type.',
   cust_survey_topic_score_cy          NUMBER(38,0)     COMMENT 'Score value of the topic in the store survey if it is a calendar year topic type.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_CUSTOMER_SURVEY_SCORE PRIMARY KEY (survey_topic_sid, customer_sid, survey_sid, survey_version_nr, survey_version_section_name, survey_tmsp) NOT ENFORCED 
)  COMMENT = 'This table contains the answers from customers on the topics.';
