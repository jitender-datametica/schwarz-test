/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_assortment_profile_type_1
   generated from Powerdesigner on Donnerstag, 12. September 2024 19:46:01
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_ASSORTMENT_PROFILE_TYPE_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_assort_profile_type_cd         VARCHAR(100)     NOT NULL COMMENT 'Code to indicate the importance profile of the item_1 in the assortment (Pflicht, Profilierung, Ergänzung).
            CBX: CNT_CODELIST.CODE (code list "LIDL_FMS_ASSORTMENT")
            LDL: P_LEW_CORE.T_REF_ASSORTMENT_PROFILE_TYPE.ASSORT_PROFILE_TYPE_CD
            CORE_REL: T_NFPO_ASSORTMENT_PROFILE_TYPE.NFPO_ASSORT_PROFILE_TYPE_CD',
   nfpo_assort_profile_type_name       VARCHAR(100)     COMMENT 'Name of the profile type of the assortment (Pflicht, Profilierung, Ergänzung).
            CBX: CNT_CODELIST.NAME (code list "LIDL_FMS_ASSORTMENT")
            LDL: P_LEW_CORE.T_REF_ASSORTMENT_PROFILE_TYPE.ASSORT_PROFILE_TYPE_NAME
            CORE_REL: T_NFPO_ASSORTMENT_PROFILE_TYPE.NFPO_ASSORT_PROFILE_TYPE_NAME',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',  
   CONSTRAINT PK_T_DIM_NFPO_ASSORTMENT_PROFILE_TYPE PRIMARY KEY (nfpo_assort_profile_type_cd) NOT ENFORCED 
)  COMMENT = 'Classification of the assortment by the importance of the in the assortment (Pflicht, Profilierung, Ergänzung).
             CBX: CNT_CODELIST.CODE (code list "LIDL_FMS_ASSORTMENT")
             LDL: P_LEW_CORE.T_REF_ASSORTMENT_PROFILE_TYPE_1
             CORE_REL: T_NFPO_ASSORTMENT_PROFILE_TYPE_1';
