/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_item_split_method_1
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:41:53
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_item_split_method_1 (
mdm_item_split_method_cd STRING(100) NOT NULL
OPTIONS(description='''NFPO code for the split methods in the split process to create Kaufland specific items from standard NFPO items due to different item_1 granularity requirements in Kaufland compared to Lidl (\'Vereinzelung\')
            CBX:  CNT_CODELIST.code (code list \'LIDL_STYLE_SPLITTING\')'''),
mdm_item_split_method_name STRING(100)
OPTIONS(description='''NFPO name for the split methods in the split process to create Kaufland specific items from standard NFPO items due to different item_1 granularity requirements in Kaufland compared to Lidl (\'Vereinzelung\')
            CBX:  CNT_CODELIST.name (code list \'LIDL_STYLE_SPLITTING\')'''),
mdm_item_split_method_descr STRING(250)
OPTIONS(description='''NFPO description for the split methods in the split process to create Kaufland specific items from standard NFPO items due to different item_1 granularity requirements in Kaufland compared to Lidl (\'Vereinzelung\')
            CBX:  CNT_CODELIST.name (code list \'LIDL_STYLE_SPLITTING\')'''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (mdm_item_split_method_cd) NOT ENFORCED
)
OPTIONS(description='''NFPO codes for the split methods in the split process to create Kaufland specific items from standard NFPO items due to different item_1 granularity requirements in Kaufland compared to Lidl ("Vereinzelung")
             CBX: CNT_CODELIST_1 (code list "LIDL_STYLE_SPLITTING")''');