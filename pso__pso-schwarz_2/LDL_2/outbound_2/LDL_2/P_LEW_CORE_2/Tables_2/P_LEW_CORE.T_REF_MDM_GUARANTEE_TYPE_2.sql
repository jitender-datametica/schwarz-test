/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_guarantee_type_2
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:32:43
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_guarantee_type_2 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical column required by the used ETL framework
            static 7 for all rows'''),
guarantee_type_cd STRING(100) NOT NULL
OPTIONS(description='''NFPO warranty type code
            CBX: CNT_CODELIST.CODE (codelist \'LIDL_WARRANTY_ART\')'''),
guarantee_type_descr STRING(100)
OPTIONS(description='''NFPO warranty type description
            CBX: CNT_CODELIST.NAME (codelist \'LIDL_WARRANTY_ART\')'''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, guarantee_type_cd) NOT ENFORCED
)
OPTIONS(description='''NFPO guarantee types of items
             CBX: CNT_CODELIST_2 (code list "LIDL_WARRANTY_ART")''');