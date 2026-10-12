/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_organization_transaction_period
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:57:09
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_NFPO_ITEM_ORGANIZATION_TRANSACTION_PERIOD DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_org_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate key internal organization.
            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_SID',
   nfpo_item_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key of the related NFPO ITEM INSTANCE',
   nfpo_item_org_assigned_txn_period_begin_dt DATE             NOT NULL,
   nfpo_item_org_assigned_txn_period_end_dt DATE             NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_BUYER.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_BUYER.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_ORGANIZATION_TRANSACTION_PERIOD PRIMARY KEY (nfpo_org_sid, nfpo_item_sid) NOT ENFORCED 
)  COMMENT = '';
