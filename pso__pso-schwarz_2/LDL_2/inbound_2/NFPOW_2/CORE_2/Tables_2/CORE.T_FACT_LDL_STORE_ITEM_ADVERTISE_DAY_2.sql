/* --------------------------------------------------------------------------------
   DDL for table: t_fact_ldl_store_item_advertise_day_2
   generated from Powerdesigner on Dienstag, 13. Mai 2025 10:35:59
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_LDL_STORE_ITEM_ADVERTISE_DAY_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   lob_cd                              VARCHAR(100)     NOT NULL COMMENT 'Line of business depends on the general source of the data, "KFL" if the data is taken from the Kaufland DWH, "LDL" if the data is taken from a Lidl DWH.',
   ldl_store_sid                       NUMBER(38,0)     NOT NULL,
   ldl_item_sid                        NUMBER(38,0)     NOT NULL,
   adv_dt                              DATE             NOT NULL COMMENT 'Starting date of the advertising campaign in the extracts from Lidl retail and Kaufland.',
   ldl_client_id                       NUMBER(38,0)     NOT NULL,
   curr_cd                             VARCHAR(3)       NOT NULL COMMENT 'Currency code used by Lidl.
            CORE_REL:T_LDL_CURRENCY.CURR_CD
            LDL: P_LEW_CORE.T_CURRENCY.CURR_ISO_CD',
   kfl_consolidated_promo_item_type_cd VARCHAR(100)     NOT NULL COMMENT 'This attribute consolidates the content of the KFL_ITEM_LIST_TYPE_CD into a generalized information about whether an item_2 should be regarded as a promotion item_2 or not.
            "PN" = item_2 is a promotion item_2
            "SO" = item_2 is not a promotion item_2
            "no typification" = item_2 is not receiving a type (for LDL, only KFL items get a type)',
   ldl_adv_stock_qty                   NUMBER(38,5),
   kfl_adv_stock_qty                   NUMBER(38,5),
   ldl_adjust_adv_sales_1_qty          NUMBER(38,5),
   ldl_adjust_adv_sales_3_qty          NUMBER(38,5),
   ldl_adjust_adv_sales_7_qty          NUMBER(38,5),
   kfl_adjust_adv_sales_7_qty          NUMBER(38,5),
   ldl_adjust_adv_sales_17_qty         NUMBER(38,5),
   ldl_adjust_adv_sales_17_net_val     NUMBER(38,5),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_FACT_LDL_STORE_ITEM_ADVERTISE_DAY PRIMARY KEY (ldl_store_sid, ldl_item_sid, lob_cd, adv_dt, curr_cd, kfl_consolidated_promo_item_type_cd) NOT ENFORCED 
)  COMMENT = 'Comment 2Do';
