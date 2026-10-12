/* --------------------------------------------------------------------------------
   DDL for table: t_mdm_item_sku_2
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 13:39:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_sku_2 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical column required by the used ETL framework
            static 7 for all rows'''),
mdm_item_sku_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''surrogate key NFPO stock keeping unit_2
            CBX: 1. CNT_ITEM_2, LDL_ITEM_VARIANT
            2. CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV.1. CNT_ITEM.REF_NO, LDL_ITEM_VARIANT.LDL_STYLE_UNIQUE_IDS, LDL_ITEM_VARIANT.LDL_SIZE_CODE, LDL_ITEM_VARIANT.LDL_LSV_CODE
            2. CNT_ITEM.REF_NO, LDL_STYLE_UNIQUE_IDS, LDL_ITEM_SIZE.LDL_CODE, LDL_ITEM_LSV.LDL_CODE'''),
src_item_doc_ref STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''NFPO item_2 instance reference
            CBX: 1. CNT_ITEM_2, LDL_ITEM_VARIANT
            2. CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV.1. CNT_ITEM.REF_NO
            2. CNT_ITEM.REF_NO'''),
src_style_uniqids_cd STRING(2000) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''identifier of the style composition in the source system
            CBX: 1. CNT_ITEM_2, LDL_ITEM_VARIANT
            2. CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV.1. LDL_ITEM_VARIANT.LDL_STYLE_UNIQUE_IDS
            2. LDL_STYLE_UNIQUE_IDS'''),
src_size_cd STRING(300) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''identifier of the NFPO item_2 size for a certain item_2 in the source system
            CBX: 1. CNT_ITEM_2, LDL_ITEM_VARIANT
            2. CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV.1. LDL_ITEM_VARIANT.LDL_SIZE_CODE
            2. LDL_ITEM_SIZE.LDL_CODE'''),
src_variant_cd STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''identifier of the regional NFPO item_2 variant for a certain item_2 in the source system
            CBX: 1. CNT_ITEM_2, LDL_ITEM_VARIANT
            2. CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV.1. LDL_ITEM_VARIANT.LDL_LSV_CODE
            2. LDL_ITEM_LSV.LDL_CODE'''),
mdm_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key NFPO item_2 instance
            CBX: 1. CNT_ITEM_2, LDL_ITEM_VARIANT
            2. CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV.1. CNT_ITEM.REF_NO
            2. CNT_ITEM.REF_NO'''),
mdm_item_set_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key NFPO item_2 set
            CBX: 1. CNT_ITEM_2, LDL_ITEM_VARIANT
            2. CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV.1. CNT_ITEM.REF_NO, LDL_ITEM_VARIANT.LDL_STYLE_UNIQUE_IDS
            2. CNT_ITEM.REF_NO, LDL_STYLE_UNIQUE_IDS'''),
mdm_item_size_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key NFPO item_2 size
            CBX: CNT_ITEM_2,
            LDL_ITEM_SIZE.CNT_ITEM.REF_NO,
            LDL_ITEM_SIZE.LDL_CODE'''),
mdm_item_variant_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key regional NFPO item_2 variant
            CBX: 1. CNT_ITEM_2, LDL_ITEM_VARIANT
            2. CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV.1. CNT_ITEM.REF_NO, LDL_ITEM_VARIANT.LDL_LSV_CODE
            2. CNT_ITEM.REF_NO, LDL_ITEM_LSV.LDL_CODE'''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (mdm_item_sku_sid) NOT ENFORCED
)
OPTIONS(description='''NFPO item_2 sales_2 variants defined by styles, sizes and LSVs
             CBX: LDL_ITEM_ARTICLE_EAN_2, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2''');