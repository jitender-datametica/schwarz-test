/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_item_nfpo_item_2
   generated from Powerdesigner on Friday, 28 June 2024 13:47:32
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_ITEM_NFPO_ITEM_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant_2) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.mandant_id',
   kfl_item_nr                         NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL item_2 (Artikel_2) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.art_id',
   nfpo_item_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key of the related NFPO ITEM_2 INSTANCE',
   nfpo_item_sel_nr                    VARCHAR(100)     COMMENT 'NFPO source system internal identifier of the related article',
   ldl_item_ian_nr                     NUMBER(38,0)     NOT NULL COMMENT 'related Lidl International Item_2 number',
   ldl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate key of the related Lidl ERP client in the Lidl DWH',
   nfpo_parent_item_sid                NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key of the parent of the related NFPO ITEM_2 INSTANCE',
   ldl_parent_item_ian_nr              NUMBER(38,0)     NOT NULL COMMENT 'Lidl International Item_2 Number of the parent of the related NFPO ITEM_2 INSTANCE',
   pseudo_ldl_item_sid                 NUMBER(38,0)     NOT NULL COMMENT 'constructed identifier of the Kaufland item_2 in the Lidl item_2 context',
   nfpo_default_item_fg                BOOLEAN          COMMENT 'indicator whether this is the record which should be used to have an unique target item_2 record in NFPO (and LDL) in the case that more then one possible target record exist (for example for catalog items)',
   nfpo_item_kfl_item_assigned_txn_period_begin_dt DATE NOT NULL,
   nfpo_item_kfl_item_assigned_txn_period_end_dt DATE   NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction',   
   CONSTRAINT PK_T_KFL_ITEM_NFPO_ITEM PRIMARY KEY (kfl_client_id, kfl_item_nr, nfpo_item_sid) NOT ENFORCED 
)  COMMENT = 'This table relates Kaufland items to items in CBX and Lidl using the GTINs assigned to Kaufland items in the Kaufland DWH and the GTINs assigned to stock keeping units in CBX.';
