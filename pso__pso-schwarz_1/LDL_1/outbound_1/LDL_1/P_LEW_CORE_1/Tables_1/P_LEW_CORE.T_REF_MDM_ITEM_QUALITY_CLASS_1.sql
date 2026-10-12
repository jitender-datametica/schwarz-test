/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_item_quality_class_1
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:40:27
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_item_quality_class_1 (
item_quality_class_cd STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''NFPO code for item_1 quality classification
            CBX:  CNT_CODELIST.code (code list \'LDL_Article_Class\')'''),
item_quality_class_descr STRING(100) NOT NULL
OPTIONS(description='''NFPO description for item_1 quality classification
            CBX:  CNT_CODELIST.name (code list \'LDL_Article_Class\')'''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.')
)
OPTIONS(description='''NFPO item_1 classification related to item_1 quality compared to the overall market
             CBX: CNT_CODELIST_1 (code list "LDL_Article_Class")''');