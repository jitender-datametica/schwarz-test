/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_organization_order_status_2
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_organization_order_status_2 (
nfpo_org_order_status_cd STRING(100) NOT NULL
OPTIONS(description='''NFPO status_2 code related to the order quantity definition process for the local NFPO\'s of items.
            CBX: CNT_CODELIST.CODE (code list \'LIDL_CO_STATUS\').
            LDL: P_LEW_CORE.T_REF_MDM_BUY_STATUS.BUY_STATUS_CD'''),
nfpo_org_order_status_descr_de STRING(250) NOT NULL
OPTIONS(description='''NFPO status_2 name related to the order quantity definition process for the local NFPO\'s of items.
            CBX: CNT_CODELIST.NAME
            LDL: P_LEW_CORE.T_REF_MDM_BUY_STATUS.BUY_STATUS'''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_BUY_STATUS.DWH_CREATED'''),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_BUY_STATUS.DWH_UPDATED'''),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_org_order_status_cd) NOT ENFORCED
)
OPTIONS(description='NFPO status_2 codes related to the order quantity definition process for the local NFPO\'s of items.');