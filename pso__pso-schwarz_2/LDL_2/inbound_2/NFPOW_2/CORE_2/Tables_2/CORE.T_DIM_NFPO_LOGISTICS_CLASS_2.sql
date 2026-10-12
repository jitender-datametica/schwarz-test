/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_logistics_class_2
   generated from Powerdesigner on Freitag, 12. Dezember 2025 14:01:01
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_LOGISTICS_CLASS_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_logistics_class_cd             VARCHAR(100)     NOT NULL COMMENT 'Code to classify the way the items will be transported from the central warehouse of OWIM into the countries.
            CBX: CNT_CODELIST.CODE (code list "LIDL_DELIVERYTYPE")
            LDL: P_LEW_CORE.T_REF_MDM_LOGISTICS_CLASS.MDM_LOGISTICS_CLASS_CD
            CORE_REL: T_NFPO_LOGISTICS_CLASS.NFPO_LOGISTICS_CLASS_CD',
   nfpo_logistics_class_name           VARCHAR(100)     COMMENT 'Name to classify the way the items will be transported from the central warehouse of OWIM into the countries.
            CBX: CNT_CODELIST.NAME (code list "LIDL_DELIVERYTYPE")
            LDL: P_LEW_CORE.T_REF_MDM_LOGISTICS_CLASS.MDM_LOGISTICS_CLASS_NAME
            CORE_REL: T_NFPO_LOGISTICS_CLASS.NFPO_LOGISTICS_CLASS_NAME',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_LOGISTICS_CLASS PRIMARY KEY (nfpo_logistics_class_cd) NOT ENFORCED 
)  COMMENT = 'NFPO classification of the way the items will be transported from the central warehouse of OWIM into the countries.
             CBX: CNT_CODELIST_2 (code list "LIDL_DELIVERYTYPE")
             LDL: P_LEW_CORE.T_REF_MDM_LOGISTICS_CLASS_2
             CORE_REL: T_NFPO_LOGISTICS_CLASS_2';

