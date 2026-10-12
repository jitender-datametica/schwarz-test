/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_item_class_1
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:37:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_item_class_1 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical column required by the used ETL framework
            static 7 for all rows'''),
item_class_cd STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''NFPO item_1 classification code related to item_1 creation and usage over time
            CBX: CNT_CODELIST.CODE (codelist \'LIDL_ARTICLETYPE\')'''),
item_class STRING(100) COLLATE 'und:ci'
OPTIONS(description='''NFPO item_1 classification description related to item_1 creation and usage over time
            CBX: CTM_CODELIST_BOOK.CUST_TEXT1 (codelist \'LIDL_ARTICLETYPE\')'''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id) NOT ENFORCED
)
OPTIONS(description='''NFPO item_1 classification related to item_1 creation and usage over time
             CBX: CNT_CODELIST_1 (code list "LIDL_ARTICLETYPE")''');