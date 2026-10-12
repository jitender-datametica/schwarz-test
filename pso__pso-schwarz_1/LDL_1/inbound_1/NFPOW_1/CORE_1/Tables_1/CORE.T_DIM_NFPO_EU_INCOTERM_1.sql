/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_eu_incoterm_1
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_EU_INCOTERM_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_eu_incoterm_cd                 VARCHAR(100)     NOT NULL COMMENT 'NFPO incoterm codes, similar to the terms defined by the International Chamber of Commerce.
            CBX: CNT_CODELIST.CODE (code list ''INCOTERM'' and ''LIDL_INCOTERM_US'')
            LDL: P_LEW_CORE.T_REF_MDM_INCOTERM.MDM_INCOTERM_CD',
   nfpo_eu_incoterm_name               VARCHAR(100)     NOT NULL COMMENT 'NFPO incoterm names, similar to the terms defined by the International Chamber of Commerce.
            CBX: CNT_CODELIST.NAME (code list ''INCOTERM'' and ''LIDL_INCOTERM_US'')
            LDL: P_LEW_CORE.T_REF_MDM_INCOTERM.MDM_INCOTERM_NAME',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_INCOTERM.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_INCOTERM.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_EU_INCOTERM PRIMARY KEY (nfpo_eu_incoterm_cd) NOT ENFORCED 
)  COMMENT = 'NFPO set of codes for commercial terms in the contracts, different codes are used for different markets.';

