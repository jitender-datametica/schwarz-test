/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_item_gtin_nfpo_item_sku_1
   generated from Powerdesigner on Montag, 30. September 2024 17:18:57
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_ITEM_GTIN_NFPO_ITEM_SKU_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant_1) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.mandant_id',
   kfl_item_nr                         NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL item_1 (Artikel_1) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.art_id',
   kfl_gtin_nr                         VARCHAR(100)     NOT NULL COMMENT 'Assigned GTIN of the NFPO stock keeping unit_1 for Kaufland.
            CBX: CNT_ITEM_1, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_1, LDL_ITEM_SIZE_1, LDL_ITEM_LSV_1, LDL_ITEM_ARTICLE_EAN.LDL_EAN_KL
            LDL: P_LEW_CORE.T_MDM_ITEM_SKU_EAN_HIST.KFL_BARCODE',
   nfpo_item_sku_sid                   NUMBER(38,0)     NOT NULL COMMENT 'Foreign Key NFPO STOCK KEEPING UNIT.
            CBX: CNT_ITEM_1, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_1, LDL_ITEM_SIZE_1, LDL_ITEM_LSV_1, LDL_ITEM_ARTICLE_EAN.CNT_ITEM.REF_NO, LDL_STYLE_UNIQUE_IDS, LDL_ITEM_SIZE.LDL_CODE, LDL_ITEM_LSV.LDL_CODE
            LDL: P_LEW_CORE.T_MDM_ITEM_SKU_EAN_HIST.MDM_ITEM_SKU_SID',
   nfpo_item_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key of the related NFPO ITEM_1 INSTANCE',
   nfpo_item_sel_nr                    VARCHAR(100)     COMMENT 'NFPO source system internal identifier of the related article',
   ldl_item_ian_nr                     NUMBER(38,0)     NOT NULL COMMENT 'related Lidl International Item_1 number',
   ldl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate key of the related Lidl ERP client in the Lidl DWH',
   nfpo_parent_item_sid                NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key of the parent of the related NFPO ITEM_1 INSTANCE',
   ldl_parent_item_ian_nr              NUMBER(38,0)     NOT NULL COMMENT 'Lidl International Item_1 Number of the parent of the related NFPO ITEM_1 INSTANCE',
   pseudo_ldl_item_sid                 NUMBER(38,0)     NOT NULL COMMENT 'constructed identifier of the Kaufland item_1 in the Lidl item_1 context',
   nfpo_default_item_sku_fg            BOOLEAN          COMMENT 'indicator whether this is the record which should be used to have an unique target item_1 record in NFPO (and LDL) in the case that more then one possible target record exist (for example for catalog items)',
   nfpo_item_kfl_item_assigned_txn_period_begin_dt DATE             NOT NULL,
   nfpo_item_kfl_item_assigned_txn_period_end_dt DATE             NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction',   
   CONSTRAINT PK_T_KFL_ITEM_GTIN_NFPO_ITEM_SKU PRIMARY KEY (kfl_client_id, kfl_item_nr, kfl_gtin_nr, nfpo_item_sku_sid) NOT ENFORCED 
)  COMMENT = 'This table relates Kaufland item_1 + GTIN combinations to stock keeping units in CBX using the GTINs assigned to Kaufland items in the Kaufland DWH and the GTINs assigned to stock keeping units in CBX.';
