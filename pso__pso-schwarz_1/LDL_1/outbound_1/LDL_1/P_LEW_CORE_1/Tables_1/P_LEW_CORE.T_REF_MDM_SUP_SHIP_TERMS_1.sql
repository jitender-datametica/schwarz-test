/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_sup_ship_terms_1
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:47:33
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_sup_ship_terms_1 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical column required by the used ETL framework
            static 7 for all rows'''),
sup_ship_terms_cd STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''NFPO supplier_1 related shipping term codes
            CBX: CNT_CODELIST.CODE (codelist \'LDL_WBP_CAL_PROFILE\')'''),
sup_ship_terms STRING(100) COLLATE 'und:ci'
OPTIONS(description='''NFPO supplier_1 related shipping term names
            CBX: CNT_CODELIST.NAME (codelist \'LDL_WBP_CAL_PROFILE\')'''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.')
)
OPTIONS(description='''NFPO supplier_1 related shipping terms
             CBX: CNT_CODELIST_1 (code list "LDL_WBP_CAL_PROFILE")''');