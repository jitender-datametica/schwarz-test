/* --------------------------------------------------------------------------------
   DDL for table: t_campaign_element_plan_2
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CAMPAIGN_ELEMENT_PLAN_2 (
   campaign_elem_plan_sid              NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier (surrogate key) for a plan (sales_2 or activity plan) that is defined for a certain campaign element.',
   src_srcinst_cd                      VARCHAR(2)       COLLATE 'en-ci' COMMENT 'techn. identifier part of the campaign element plan (general) within APT source system',
   src_proplan_id                      VARCHAR(30)      COLLATE 'en-ci' COMMENT 'techn. identifier part of the campaign element plan (general) within APT source system',
   src_pvpac_id                        VARCHAR(30)      COLLATE 'en-ci' COMMENT 'techn. identifier part of the campaign element plan (activity) within APT source system',
   src_pvpit_id                        VARCHAR(30)      COLLATE 'en-ci' COMMENT 'techn. identifier part of the campaign element plan (general) within APT source system',
   src_salestype_value                 VARCHAR(20)      COLLATE 'en-ci' COMMENT 'techn. identifier part of the campaign element plan (sales_2 a. pricechange) within APT source system',
   src_pvpgp_no                        VARCHAR(20)      COLLATE 'en-ci' COMMENT 'techn. identifier part of the campaign element plan (general) within APT source system',
   src_valid_from                      DATE             COMMENT 'techn. identifier part of the campaign element plan (general) within APT source system',
   src_advmed_id                       VARCHAR(30)      COLLATE 'en-ci' COMMENT 'techn. identifier part of the campaign element plan (adv acitivity) within APT source system',
   src_strplm_id                       VARCHAR(30)      COLLATE 'en-ci' COMMENT 'techn. identifier part of the campaign element plan (storeplacement activity) within APT source system',
   campaign_plan_type_cd               VARCHAR(8)       COLLATE 'en-ci' COMMENT 'A code uniquely identifying the campaign element plan type.',
   campaign_activity_type_cd           VARCHAR(5)       COLLATE 'en-ci' COMMENT 'The discriminator code for campaign activities. It distinguishes between price changes, store placements and advertisements.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_CAMPAIGN_ELEMENT_PLAN PRIMARY KEY (campaign_elem_plan_sid) NOT ENFORCED 
)  COMMENT = 'Related to a campaign element there are certain plans - be it activity plans or sales_2 plans';

