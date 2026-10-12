/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_ean_ownership_2
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:30:53
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_ean_ownership_2 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical column required by the used ETL framework
            static 7 for all rows'''),
ean_ownership_cd STRING(100) NOT NULL
OPTIONS(description='''NFPO GTIN assignement responisbility code
            CBX: CNT_CODELIST.CODE (codelist \'LIDL_GTIN_OUTPUT\')'''),
ean_ownership STRING(100) COLLATE 'und:ci'
OPTIONS(description='''NFPO GTIN assignement responisbility description
            CBX: CNT_CODELIST.NAME (codelist \'LIDL_GTIN_OUTPUT\')'''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (ean_ownership_cd) NOT ENFORCED
)
OPTIONS(description='''NFPO responsibilty of GTIN assignement to items
             CBX: CNT_CODELIST_2 (code list "LIDL_GTIN_OUTPUT")''');