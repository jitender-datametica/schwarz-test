/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_item_nfpo_item_2
   generated from Powerdesigner on Dienstag, 1. August 2023 13:10:45
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LDL_ITEM_NFPO_ITEM_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate key of the ERP client in the Lidl DWH
            LDL: P_LEW_MART_LEAD_AC.V_ITM_ITEM.CLIENT_ID',
   ldl_item_sid                        NUMBER(38,0)     NOT NULL COMMENT 'surrogate key of the item_2 in the Lidl DWH
            LDL: P_LEW_MART_LEAD_AC.V_ITM_ITEM.ITEM_ID',
   nfpo_item_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key of the related NFPO ITEM_2 INSTANCE',
   nfpo_item_sel_nr                    VARCHAR(100)     COMMENT 'NFPO source system internal identifier of the related article',
   ldl_item_ian_nr                     NUMBER(38,0)     NOT NULL COMMENT 'related Lidl International Item_2 number',
   kfl_visible_fg                      BOOLEAN          NOT NULL COMMENT 'indicator whether the item_2 can be included into the Apollo Kaufland reporting',
   kfl_client_id                       NUMBER(38,0)     COMMENT 'related identifier of the KFL client (Mandant_2) in the Kaufland DWH',
   pseudo_kfl_item_nr                  NUMBER(38,0)     COMMENT 'constructed identifier of the Lidl item_2 in the Kaufland item_2 context',
   nfpo_default_item_fg                BOOLEAN          NOT NULL COMMENT 'indicator whether this is the record which should be used to have an unique target item_2 record in NFPO (and KFL) in the case that more then one possible target record exist (for example for catalog items)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction',   
   CONSTRAINT PK_T_LDL_ITEM_NFPO_ITEM PRIMARY KEY (ldl_item_sid, nfpo_item_sid) NOT ENFORCED 
)  COMMENT = 'this table relates Lidl items to items in CBX and KFL';
