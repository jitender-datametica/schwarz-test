/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_warranty_duration_1
   generated from Powerdesigner on Donnerstag, 6. November 2025 15:42:02
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_WARRANTY_DURATION_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_warranty_dur_cd                VARCHAR(100)     NOT NULL COMMENT 'NFPO warranty duration code.
            CBX: CNT_CODELIST.CODE (code list "LIDL_WARRANTY")
            LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE.GUARANTEE_CD
            CORE_REL: T_NFPO_WARRANTY_DURATION.NFPO_WARRANTY_DUR_CD',
   nfpo_warranty_dur_name              VARCHAR(100)     COMMENT 'NFPO warranty duration name.
            CBX: CNT_CODELIST.NAME (code list "LIDL_WARRANTY")
            LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE.GUARANTEE_DESCR
            CORE_REL: T_NFPO_WARRANTY_DURATION.NFPO_WARRANTY_DUR_NAME',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_WARRANTY_DURATION PRIMARY KEY (nfpo_warranty_dur_cd) NOT ENFORCED 
)  COMMENT = 'NFPO guarantee length types of items.
             CBX: CNT_CODELIST_1, code list "LIDL_WARRANTY"
             LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE_1
             CORE_REL: T_NFPO_WARRANTY_DURATION_1';
