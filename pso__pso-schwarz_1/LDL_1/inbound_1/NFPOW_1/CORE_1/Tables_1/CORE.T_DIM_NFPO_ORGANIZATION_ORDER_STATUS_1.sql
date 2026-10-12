/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_organization_order_status_1
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_ORGANIZATION_ORDER_STATUS_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_org_order_status_cd            VARCHAR(100)     NOT NULL COMMENT 'NFPO status_1 code related to the order quantity definition process for the local NFPO''s of items.
            CBX: CNT_CODELIST.CODE (code list ''LIDL_CO_STATUS'').
            LDL: P_LEW_CORE.T_REF_MDM_BUY_STATUS.BUY_STATUS_CD',
   nfpo_org_order_status_descr_de      VARCHAR(250)     NOT NULL COMMENT 'NFPO status_1 name related to the order quantity definition process for the local NFPO''s of items.
            CBX: CNT_CODELIST.NAME
            LDL: P_LEW_CORE.T_REF_MDM_BUY_STATUS.BUY_STATUS',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_BUY_STATUS.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_BUY_STATUS.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_ORGANIZATION_ORDER_STATUS PRIMARY KEY (nfpo_org_order_status_cd) NOT ENFORCED 
)  COMMENT = 'NFPO status_1 codes related to the order quantity definition process for the local NFPO''s of items.';

