/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_case_composition_1
   generated from Powerdesigner on Donnerstag, 6. November 2025 15:40:22
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_CASE_COMPOSITION_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_case_composition_cd            VARCHAR(100)     NOT NULL COMMENT 'Code of options to put items in the case. Indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
            CBX: CNT_CODELIST.CODE (code list "LIDL_NUMBEROFSET")
            LDL: P_LEW_CORE.T_REF_MDM_CASE_COMPOSITION.MDM_CASE_COMPOSITION_CD
            CORE_REL: T_NFPO_CASE_COMPOSITION.NFPO_CASE_COMPOSITION_CD',
   nfpo_case_composition_txt           VARCHAR(1000)    NOT NULL COMMENT 'Text of options to put items in the case. Indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
            CBX: CNT_CODELIST.NAME (code list "LIDL_NUMBEROFSET")
            LDL: P_LEW_CORE.T_REF_MDM_CASE_COMPOSITION.MDM_CASE_COMPOSITION_TXT
            CORE_REL: T_NFPO_CASE_COMPOSITION.NFPO_CASE_COMPOSITION_TXT',
   nfpo_subcase_size_qty               NUMBER(38,5)     COMMENT 'Predefined number of items in the text of options to put items in the case when the case will be filled by subcases which contain a predefined number of items.
            CBX: CNT_CODELIST.NAME (code list "LIDL_NUMBEROFSET")
            LDL: P_LEW_CORE.T_REF_MDM_CASE_COMPOSITION.SUBCASE_SIZE_QTY
            CORE_REL: T_NFPO_CASE_COMPOSITION.NFPO_SUBCASE_SIZE_QTY',
   nfpo_case_composition_name          VARCHAR(100)     COMMENT 'Text of options to put items in the case without the predefined number of items in possible sub cases. Indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
            CBX: CNT_CODELIST.NAME (code list "LIDL_NUMBEROFSET")
            LDL: P_LEW_CORE.T_REF_MDM_CASE_COMPOSITION.MDM_CASE_COMPOSITION_NAME
            CORE_REL: T_NFPO_CASE_COMPOSITION.NFPO_CASE_COMPOSITION_NAME',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_CASE_COMPOSITION PRIMARY KEY (nfpo_case_composition_cd) NOT ENFORCED 
)  COMMENT = 'List of options to put items in the case, indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
             CBX: CNT_CODELIST_1, code list "LIDL_NUMBEROFSET"
             LDL: P_LEW_CORE.T_REF_MDM_CASE_COMPOSITION_1
             CORE_REL: T_NFPO_CASE_COMPOSITION_1';
