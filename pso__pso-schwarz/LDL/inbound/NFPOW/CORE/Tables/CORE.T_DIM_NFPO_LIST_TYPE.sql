/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_list_type
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_LIST_TYPE DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_list_type_cd                   VARCHAR(100)     NOT NULL COMMENT 'NFPO codes for list types of items.
            CBX: CNT_CODELIST.CODE (code list ''LIDL_ASSORTMENT_TYPE'')
            LDL: P_LEW_CORE.T_REF_MDM_LIST_TYPE.MDM_LIST_TYPE_CD',
   nfpo_list_type_name                 VARCHAR(100)     COMMENT 'NFPO names for list types of items.
            CBX: CNT_CODELIST.NAME (code list ''LIDL_ASSORTMENT_TYPE'')
            LDL: P_LEW_CORE.T_REF_MDM_LIST_TYPE.MDM_LIST_TYPE_NAME',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_LIST_TYPE PRIMARY KEY (nfpo_list_type_cd) NOT ENFORCED 
)  COMMENT = 'Comment 2Do';

