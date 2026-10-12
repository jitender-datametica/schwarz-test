/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_display_type_1
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:28:57
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_display_type_1 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical column required by the used ETL framework
            static 7 for all rows'''),
display_type_cd STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''NFPO display type code
            CBX: CNT_CODELIST.CODE (codelist \'LIDL_DISPLAYTYPE\')'''),
display_type STRING(100) COLLATE 'und:ci'
OPTIONS(description='''NFPO display type description
            CBX: CNT_CODELIST.NAME (codelist \'LIDL_DISPLAYTYPE\')'''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id) NOT ENFORCED
) OPTIONS(description='''NFPO display types of items
             CBX: CNT_CODELIST_1 (code list "LIDL_DISPLAYTYPE")''');