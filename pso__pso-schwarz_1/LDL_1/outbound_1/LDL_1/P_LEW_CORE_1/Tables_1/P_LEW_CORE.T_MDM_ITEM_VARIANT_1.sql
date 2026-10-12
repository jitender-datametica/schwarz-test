CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_variant_1 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical column required by the used ETL framework
            static 7 for all rows'''),
mdm_item_variant_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''surrogate key regional NFPO item_1 variant
            CBX: CNT_ITEM_1,
            LDL_ITEM_LSV.CNT_ITEM.REF_NO,
            LDL_ITEM_LSV.LDL_CODE'''),
src_item_doc_ref STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''NFPO item_1 instance reference
            CBX: CNT_ITEM.REF_NO'''),
src_variant_cd STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''identifier of the regional NFPO item_1 variant for a certain item_1 in the source system
            CBX: LDL_ITEM_LSV.LDL_CODE'''),
variant_name STRING(300) COLLATE 'und:ci'
OPTIONS(description='''name of the regional NFPO item_1 variant
            CBX: LDL_ITEM_LSV.LDL_NAME'''),
mdm_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key NFPO item_1 instance
            CBX: CNT_ITEM.REF_NO'''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (mdm_item_variant_sid) NOT ENFORCED
)
OPTIONS(description='''NFPO item_1 variant defining local variants (extra sizes, languages, plugs, etc.) 
             CBX: LDL_ITEM_LSV_1''');