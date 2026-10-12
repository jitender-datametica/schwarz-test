/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_item_quality_class_2
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_ITEM_QUALITY_CLASS_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_quality_class_cd          VARCHAR(100)     NOT NULL COMMENT 'NFPO item_2 quality classification code.
            CBX: CNT_CODELIST.CODE (code list ''LDL_Article_Class'')
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_QUALITY_CLASS.ITEM_QUALITY_CLASS_CD',
   nfpo_item_quality_class_descr       VARCHAR(250)     NOT NULL COMMENT 'NFPO item_2 quality classification description.
            CBX: CNT_CODELIST.NAME (code list ''LDL_Article_Class'')
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_QUALITY_CLASS.ITEM_QUALITY_CLASS_DESCR',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_QUALITY_CLASS.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_QUALITY_CLASS.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_ITEM_QUALITY_CLASS PRIMARY KEY (nfpo_item_quality_class_cd) NOT ENFORCED 
)  COMMENT = 'NFPO item_2 classification related to item_2 quality compared to the overall market.
             CBX: CNT_CODELIST_2, code list ''LDL_Article_Class''
             LDL: P_LEW_CORE.T_REF_MDM_ITEM_QUALITY_CLASS_2';

