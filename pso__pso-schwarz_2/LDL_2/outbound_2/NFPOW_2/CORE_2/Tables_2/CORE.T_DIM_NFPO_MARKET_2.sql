/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_market_2
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_market_2 (
nfpo_market_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''Surrogate Key NFPO MARKET.
            CBX: CNT_CODELIST.CODE (code list \'LIDL_CONTINENT_TYPE\')
            LDL: P_LEW_CORE.T_MDM_MARKET.MARKET_SID'''),
nfpo_market_cd STRING(100) NOT NULL
OPTIONS(description='''NFPO market code.
            CBX: CNT_CODELIST.CODE (code list \'LIDL_CONTINENT_TYPE\')
            LDL: P_LEW_CORE.T_MDM_MARKET.MARKET_CD'''),
nfpo_market_name STRING(100) NOT NULL
OPTIONS(description='''NFPO market name.
            CBX: CNT_CODELIST.NAME (code list \'LIDL_CONTINENT_TYPE\')
            LDL: P_LEW_CORE.T_MDM_MARKET.MARKET'''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_MARKET.DWH_CREATED'''),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_MARKET.DWH_UPDATED'''),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_market_sid) NOT ENFORCED
) OPTIONS(description='NFPO target markets.');