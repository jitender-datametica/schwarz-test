/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_gtin_ownership_2
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:52:35
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_GTIN_OWNERSHIP_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_gtin_ownership_cd              VARCHAR(100)     NOT NULL COMMENT 'NFPO GTIN assignment responsibility code.
            CBX: CNT_CODELIST.CODE (code list ''LIDL_GTIN_OUTPUT'')
            LDL: P_LEW_CORE.T_REF_MDM_EAN_OWNERSHIP.EAN_OWNERSHIP_CD',
   nfpo_gtin_ownership_descr           VARCHAR(250)     COMMENT 'NFPO GTIN assignment responsibility descriptions.
            CBX: CNT_CODELIST.NAME (code list ''LIDL_GTIN_OUTPUT'')
            LDL: P_LEW_CORE.T_REF_MDM_EAN_OWNERSHIP.EAN_OWNERSHIP',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_EAN_OWNERSHIP.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_EAN_OWNERSHIP.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_GTIN_OWNERSHIP PRIMARY KEY (nfpo_gtin_ownership_cd) NOT ENFORCED 
)  COMMENT = 'NFPO responsibility of GTIN assignment to items.
             CBX: CNT_CODELIST_2, code list ''LIDL_GTIN_OUTPUT''
             LDL: P_LEW_CORE.T_REF_MDM_EAN_OWNERSHIP_2
             CORE_REL: T_NFPO_GTIN_OWNERSHIP_2';
