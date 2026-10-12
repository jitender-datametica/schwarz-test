/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_us_completion_type
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_US_COMPLETION_TYPE DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_us_completion_type_cd          VARCHAR(100)     NOT NULL COMMENT 'NFPO completion types.
            CBX: CNT_CODELIST.CODE (code list ''LIDL_OWIMFH'' and ''LIDL_COMPLTYPE_US'')
            LDL: P_LEW_CORE.T_REF_MDM_COMPLETION_TYPE.MDM_COMPLETION_TYPE_CD',
   nfpo_us_completion_type_name        VARCHAR(100)     NOT NULL COMMENT 'NFPO completion type name.
            CBX: CNT_CODELIST.NAME (code list ''LIDL_OWIMFH'' and ''LIDL_COMPLTYPE_US'')
            LDL: P_LEW_CORE.T_REF_MDM_COMPLETION_TYPE.MDM_COMPLETION_TYPE_NAME',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_COMPLETION_TYPE.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_COMPLETION_TYPE.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_US_COMPLETION_TYPE PRIMARY KEY (nfpo_us_completion_type_cd) NOT ENFORCED 
)  COMMENT = 'NFPO completion type codes, different codes are used for different markets.';

