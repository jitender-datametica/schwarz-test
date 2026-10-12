/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_item_split_method_1
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:41:53
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_ITEM_SPLIT_METHOD_1 (
   mdm_item_split_method_cd            VARCHAR(100)     NOT NULL COMMENT 'NFPO code for the split methods in the split process to create Kaufland specific items from standard NFPO items due to different item_1 granularity requirements in Kaufland compared to Lidl (''Vereinzelung'')
            CBX:  CNT_CODELIST.code (code list ''LIDL_STYLE_SPLITTING'')',
   mdm_item_split_method_name          VARCHAR(100)     COMMENT 'NFPO name for the split methods in the split process to create Kaufland specific items from standard NFPO items due to different item_1 granularity requirements in Kaufland compared to Lidl (''Vereinzelung'')
            CBX:  CNT_CODELIST.name (code list ''LIDL_STYLE_SPLITTING'')',
   mdm_item_split_method_descr         VARCHAR(250)     COMMENT 'NFPO description for the split methods in the split process to create Kaufland specific items from standard NFPO items due to different item_1 granularity requirements in Kaufland compared to Lidl (''Vereinzelung'')
            CBX:  CNT_CODELIST.name (code list ''LIDL_STYLE_SPLITTING'')',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_ITEM_SPLIT_METHOD PRIMARY KEY (mdm_item_split_method_cd) NOT ENFORCED 
)  COMMENT = 'NFPO codes for the split methods in the split process to create Kaufland specific items from standard NFPO items due to different item_1 granularity requirements in Kaufland compared to Lidl ("Vereinzelung")
             CBX: CNT_CODELIST_1 (code list "LIDL_STYLE_SPLITTING")';
