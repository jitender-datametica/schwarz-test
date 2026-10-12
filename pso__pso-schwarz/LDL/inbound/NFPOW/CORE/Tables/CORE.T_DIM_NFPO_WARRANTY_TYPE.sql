/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_warranty_type
   generated from Powerdesigner on Freitag, 12. Dezember 2025 14:01:01
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_WARRANTY_TYPE DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_warranty_type_cd               VARCHAR(100)     NOT NULL COMMENT 'NFPO warranty type code.
            CBX: CNT_CODELIST.CODE (code list "LIDL_WARRANTY_ART")
            LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE_TYPE.GUARANTEE_TYPE_CD
            CORE_REL: T_NFPO_WARRANTY_TYPE.NFPO_WARRANTY_TYPE_CD',
   nfpo_warranty_type_name             VARCHAR(100)     COMMENT 'NFPO warranty type description.
            CBX: CNT_CODELIST.NAME (code list "LIDL_WARRANTY_ART")
            LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE_TYPE.GUARANTEE_TYPE_DESCR
            CORE_REL: T_NFPO_WARRANTY_TYPE.NFPO_WARRANTY_TYPE_NAME',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_WARRANTY_TYPE PRIMARY KEY (nfpo_warranty_type_cd) NOT ENFORCED 
)  COMMENT = 'NFPO guarantee types of items.
             CBX: CNT_CODELIST (code list "LIDL_WARRANTY_ART")
             LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE_TYPE
             CORE_REL: T_NFPO_WARRANTY_TYPE';

