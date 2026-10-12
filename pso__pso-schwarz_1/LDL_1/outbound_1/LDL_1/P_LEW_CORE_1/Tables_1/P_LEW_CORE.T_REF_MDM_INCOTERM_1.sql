/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_incoterm_1
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:33:43
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_incoterm_1 (
market_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key NFPO market
            derived from used source code list'''),
mdm_incoterm_cd STRING(100) NOT NULL
OPTIONS(description='''NFPO incoterm codes similar to the terms defined by the International Chamber of Commerce
            CBX:CNT_CODELIST.CODE (code list \'INCOTERM\' and \'LIDL_INCOTERM_US\')'''),
mdm_incoterm_name STRING(100) NOT NULL
OPTIONS(description='''NFPO incoterm names similar to the terms defined by the International Chamber of Commerce
            CBX:CNT_CODELIST.NAME (code list \'INCOTERM\' and \'LIDL_INCOTERM_US\')'''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (market_sid, mdm_incoterm_cd) NOT ENFORCED
)
OPTIONS(description='''NFPO set of codes for commercial terms in the contracts, different codes are used for different markets_1
             CBX: CNT_CODELIST_1 (code lists "INCOTERM", "LIDL_INCOTERM_US")''');