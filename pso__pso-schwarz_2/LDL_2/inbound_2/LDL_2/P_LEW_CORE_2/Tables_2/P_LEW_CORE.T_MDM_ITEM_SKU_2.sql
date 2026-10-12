/* --------------------------------------------------------------------------------
   DDL for table: t_mdm_item_sku_2
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 13:39:42
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MDM_ITEM_SKU_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   mdm_item_sku_sid                    NUMBER(38,0)     NOT NULL COMMENT 'surrogate key NFPO stock keeping unit_2
            CBX: 1. CNT_ITEM_2, LDL_ITEM_VARIANT
            2. CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV.1. CNT_ITEM.REF_NO, LDL_ITEM_VARIANT.LDL_STYLE_UNIQUE_IDS, LDL_ITEM_VARIANT.LDL_SIZE_CODE, LDL_ITEM_VARIANT.LDL_LSV_CODE
            2. CNT_ITEM.REF_NO, LDL_STYLE_UNIQUE_IDS, LDL_ITEM_SIZE.LDL_CODE, LDL_ITEM_LSV.LDL_CODE',
   src_item_doc_ref                    VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'NFPO item_2 instance reference
            CBX: 1. CNT_ITEM_2, LDL_ITEM_VARIANT
            2. CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV.1. CNT_ITEM.REF_NO
            2. CNT_ITEM.REF_NO',
   src_style_uniqids_cd                VARCHAR(2000)    NOT NULL COLLATE 'en-ci' COMMENT 'identifier of the style composition in the source system
            CBX: 1. CNT_ITEM_2, LDL_ITEM_VARIANT
            2. CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV.1. LDL_ITEM_VARIANT.LDL_STYLE_UNIQUE_IDS
            2. LDL_STYLE_UNIQUE_IDS',
   src_size_cd                         VARCHAR(300)     NOT NULL COLLATE 'en-ci' COMMENT 'identifier of the NFPO item_2 size for a certain item_2 in the source system
            CBX: 1. CNT_ITEM_2, LDL_ITEM_VARIANT
            2. CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV.1. LDL_ITEM_VARIANT.LDL_SIZE_CODE
            2. LDL_ITEM_SIZE.LDL_CODE',
   src_variant_cd                      VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'identifier of the regional NFPO item_2 variant for a certain item_2 in the source system
            CBX: 1. CNT_ITEM_2, LDL_ITEM_VARIANT
            2. CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV.1. LDL_ITEM_VARIANT.LDL_LSV_CODE
            2. LDL_ITEM_LSV.LDL_CODE',
   mdm_item_sid                        NUMBER(38,0)     NOT NULL COMMENT 'foreign key NFPO item_2 instance
            CBX: 1. CNT_ITEM_2, LDL_ITEM_VARIANT
            2. CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV.1. CNT_ITEM.REF_NO
            2. CNT_ITEM.REF_NO',
   mdm_item_set_sid                    NUMBER(38,0)     NOT NULL COMMENT 'foreign key NFPO item_2 set
            CBX: 1. CNT_ITEM_2, LDL_ITEM_VARIANT
            2. CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV.1. CNT_ITEM.REF_NO, LDL_ITEM_VARIANT.LDL_STYLE_UNIQUE_IDS
            2. CNT_ITEM.REF_NO, LDL_STYLE_UNIQUE_IDS',
   mdm_item_size_sid                   NUMBER(38,0)     NOT NULL COMMENT 'foreign key NFPO item_2 size
            CBX: CNT_ITEM_2,
            LDL_ITEM_SIZE.CNT_ITEM.REF_NO,
            LDL_ITEM_SIZE.LDL_CODE',
   mdm_item_variant_sid                NUMBER(38,0)     NOT NULL COMMENT 'foreign key regional NFPO item_2 variant
            CBX: 1. CNT_ITEM_2, LDL_ITEM_VARIANT
            2. CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV.1. CNT_ITEM.REF_NO, LDL_ITEM_VARIANT.LDL_LSV_CODE
            2. CNT_ITEM.REF_NO, LDL_ITEM_LSV.LDL_CODE',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_MDM_ITEM_SKU PRIMARY KEY (mdm_item_sku_sid) NOT ENFORCED 
)  COMMENT = 'NFPO item_2 sales_2 variants defined by styles, sizes and LSVs
             CBX: LDL_ITEM_ARTICLE_EAN_2, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2';
