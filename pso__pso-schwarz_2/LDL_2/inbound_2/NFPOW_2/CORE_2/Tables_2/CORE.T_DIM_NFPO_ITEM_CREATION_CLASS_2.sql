/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_item_creation_class_2
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_ITEM_CREATION_CLASS_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_creation_class_cd         VARCHAR(100)     NOT NULL COMMENT 'NFPO item_2 classification code related to item_2 creation and usage over time.
            CBX: CNT_CODELIST.CODE (code list ''LIDL_ARTICLETYPE'')
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_CLASS.ITEM_CLASS_CD',
   nfpo_item_creation_class_name       VARCHAR(100)     COMMENT 'NFPO item_2 classification description related to item_2 creation and usage over time.
            CBX: CTM_CODELIST_BOOK.CUST_TEXT1 (code list ''LIDL_ARTICLETYPE'')
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_CLASS.ITEM_CLASS',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_CLASS.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_CLASS.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_ITEM_CREATION_CLASS PRIMARY KEY (nfpo_item_creation_class_cd) NOT ENFORCED 
)  COMMENT = 'NFPO item_2 classification related to item_2 creation and usage over time.
             CBX: CNT_CODELIST_2, code list ''LIDL_ARTICLETYPE''
             LDL: P_LEW_CORE.T_REF_MDM_ITEM_CLASS_2';

