/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_guarantee
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:31:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_guarantee (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical column required by the used ETL framework
            static 7 for all rows'''),
guarantee_cd STRING(100) NOT NULL
OPTIONS(description='''NFPO warranty duration code
            CBX: CNT_CODELIST.CODE (codelist \'LIDL_WARRANTY\')'''),
guarantee_descr STRING(100)
OPTIONS(description='''NFPO warranty duration name
            CBX: CNT_CODELIST.NAME (codelist \'LIDL_WARRANTY\')'''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, guarantee_cd) NOT ENFORCED
)
OPTIONS(description='''NFPO guarantee length types of items
             CBX: CNT_CODELIST (code list "LIDL_WARRANTY")''');