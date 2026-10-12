/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_display_type_1
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_DISPLAY_TYPE_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_display_type_cd                VARCHAR(100)     NOT NULL COMMENT 'NFPO display type code.
            CBX: CNT_CODELIST.CODE (code list ''LIDL_DISPLAYTYPE'')
            LDL: P_LEW_CORE.T_REF_MDM_DISPLAY_TYPE.DISPLAY_TYPE_CD',
   nfpo_display_type_name              VARCHAR(100)     COMMENT 'NFPO display type description.
            CBX: CNT_CODELIST.NAME (code list ''LIDL_DISPLAYTYPE'')
            LDL: P_LEW_CORE.T_REF_MDM_DISPLAY_TYPE.DISPLAY_TYPE',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_DISPLAY_TYPE.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_DISPLAY_TYPE.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_DISPLAY_TYPE PRIMARY KEY (nfpo_display_type_cd) NOT ENFORCED 
)  COMMENT = 'NFPO display types of items.';

