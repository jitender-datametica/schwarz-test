/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_list_type_1
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:44:39
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_list_type_1 (
mdm_list_type_cd STRING(100) NOT NULL
OPTIONS(description='''NFPO codes for list types of items
            CBX:  CNT_CODELIST.CODE  (code list \'LIDL_ASSORTMENT_TYPE\')'''),
mdm_list_type_name STRING(100)
OPTIONS(description='''NFPO names for list types of items
            CBX:  CNT_CODELIST.NAME  (code list \'LIDL_ASSORTMENT_TYPE\')'''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (mdm_list_type_cd) NOT ENFORCED
)
OPTIONS(description='''NFPO codes for list types of items
             CBX: CNT_CODELIST_1 (code list "LIDL_ASSORTMENT_TYPE")''');