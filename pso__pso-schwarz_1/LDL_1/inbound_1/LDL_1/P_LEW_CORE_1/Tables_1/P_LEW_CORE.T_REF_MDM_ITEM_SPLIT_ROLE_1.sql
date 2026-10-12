/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_item_split_role_1
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:42:56
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_ITEM_SPLIT_ROLE_1 (
   mdm_item_split_role_cd              VARCHAR(100)     NOT NULL COMMENT 'NFPO code for the roles items can have in the split process to create Kaufland specific items from standard NFPO items due to different item_1 granularity requirements in Kaufland compared to Lidl (''Vereinzelung'')
            CBX: CNT_CODELIST.code (code list''LIDL_PARENT_CHILD'')',
   mdm_item_split_role_name            VARCHAR(100)     COMMENT 'NFPO name for the roles items can have in the split process to create Kaufland specific items from standard NFPO items due to different item_1 granularity requirements in Kaufland compared to Lidl (''Vereinzelung'')
            CBX: CNT_CODELIST.name (code list''LIDL_PARENT_CHILD'')',
   mdm_item_split_role_descr           VARCHAR(250)     COMMENT 'NFPO description for the roles items can have in the split process to create Kaufland specific items from standard NFPO items due to different item_1 granularity requirements in Kaufland compared to Lidl (''Vereinzelung'')
            CBX: CNT_CODELIST.name (code list''LIDL_PARENT_CHILD'')',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_ITEM_SPLIT_ROLE PRIMARY KEY (mdm_item_split_role_cd) NOT ENFORCED 
)  COMMENT = 'NFPO codes for the roles items can have in the split process to create Kaufland specific items from standard NFPO items due to different item_1 granularity requirements in Kaufland compared to Lidl ("Vereinzelung")
             CBX: CNT_CODELIST_1 (code list "LIDL_PARENT_CHILD")';
