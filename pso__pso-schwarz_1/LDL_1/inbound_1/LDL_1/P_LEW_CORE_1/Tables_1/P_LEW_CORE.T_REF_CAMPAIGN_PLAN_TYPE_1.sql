/* --------------------------------------------------------------------------------
   DDL for table: t_ref_campaign_plan_type_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_CAMPAIGN_PLAN_TYPE_1 (
   campaign_element_plan_type_cd       VARCHAR(8)       NOT NULL COLLATE 'en-ci' COMMENT 'A code uniquely identifying the campaign or campaign element plan type.',
   campaign_element_plan_type_descr    VARCHAR(100)     COLLATE 'en-ci' COMMENT 'A textual description for the campaign or campaign element plan type.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_CAMPAIGN_PLAN_TYPE PRIMARY KEY (campaign_element_plan_type_cd) NOT ENFORCED 
)  COMMENT = 'This minor entity defines the discriminators for plans for a certain campaign or campaign element.';

