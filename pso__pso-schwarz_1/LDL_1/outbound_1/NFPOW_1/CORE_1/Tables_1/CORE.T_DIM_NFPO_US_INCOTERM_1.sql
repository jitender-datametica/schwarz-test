/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_us_incoterm_1
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_us_incoterm_1 (
nfpo_us_incoterm_cd STRING(100) NOT NULL
OPTIONS(description='''NFPO incoterm codes, similar to the terms defined by the International Chamber of Commerce.
            CBX: CNT_CODELIST.CODE (code list \'INCOTERM\' and \'LIDL_INCOTERM_US\')
            LDL: P_LEW_CORE.T_REF_MDM_INCOTERM.MDM_INCOTERM_CD'''),
nfpo_us_incoterm_name STRING(100) NOT NULL
OPTIONS(description='''NFPO incoterm names, similar to the terms defined by the International Chamber of Commerce.
            CBX: CNT_CODELIST.NAME (code list \'INCOTERM\' and \'LIDL_INCOTERM_US\')
            LDL: P_LEW_CORE.T_REF_MDM_INCOTERM.MDM_INCOTERM_NAME'''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_INCOTERM.DWH_CREATED'''),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_INCOTERM.DWH_UPDATED'''),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_us_incoterm_cd) NOT ENFORCED
)
OPTIONS(description='NFPO set of codes for commercial terms in the contracts, different codes are used for different markets.');