/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_market_1
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_MARKET_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_market_sid                     NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key NFPO MARKET.
            CBX: CNT_CODELIST.CODE (code list ''LIDL_CONTINENT_TYPE'')
            LDL: P_LEW_CORE.T_MDM_MARKET.MARKET_SID',
   nfpo_market_cd                      VARCHAR(100)     NOT NULL COMMENT 'NFPO market code.
            CBX: CNT_CODELIST.CODE (code list ''LIDL_CONTINENT_TYPE'')
            LDL: P_LEW_CORE.T_MDM_MARKET.MARKET_CD',
   nfpo_market_name                    VARCHAR(100)     NOT NULL COMMENT 'NFPO market name.
            CBX: CNT_CODELIST.NAME (code list ''LIDL_CONTINENT_TYPE'')
            LDL: P_LEW_CORE.T_MDM_MARKET.MARKET',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_MARKET.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_MARKET.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_MARKET PRIMARY KEY (nfpo_market_sid) NOT ENFORCED 
)  COMMENT = 'NFPO target markets.';

