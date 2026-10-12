/* --------------------------------------------------------------------------------
   DDL for table: t_fact_ldl_store_item_day_1
   generated from Powerdesigner on Dienstag, 13. Mai 2025 10:38:07
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_LDL_STORE_ITEM_DAY_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   lob_cd                              VARCHAR(100)     NOT NULL COMMENT 'Line of business depends on the general source of the data, "KFL" if the data is taken from the Kaufland DWH, "LDL" if the data is taken from a Lidl DWH.',
   ldl_store_sid                       NUMBER(38,0)     NOT NULL,
   ldl_item_sid                        NUMBER(38,0)     NOT NULL,
   cal_dt                              DATE             NOT NULL COMMENT 'Calendar_1 date of the fact in the extract from Kaufland DWH / Lidl retail DWH.',
   ldl_client_id                       NUMBER(38,0)     NOT NULL,
   curr_cd                             VARCHAR(3)       NOT NULL COMMENT 'Currency code used by Lidl.
            CORE_REL: T_LDL_CURRENCY.CURR_CD
            LDL: P_LEW_CORE.T_CURRENCY.CURR_ISO_CD',
   kfl_consolidated_promo_item_type_cd VARCHAR(100)     NOT NULL COMMENT 'This attribute consolidates the content of the KFL_ITEM_LIST_TYPE_CD into a generalized information about whether an item_1 should be regarded as promotion item_1 or not.
            "PN" = item_1 is a promotion item_1
            "SO" = item_1 is not a promotion item_1
            "no typification" = item_1 is not receiving a type (for LDL, only KFL items get a type)',
   ldl_writeoff_net_val                NUMBER(38,5),
   kfl_total_writeoff_net_val          NUMBER(38,5),
   kfl_part_writeoff_net_val           NUMBER(38,5),
   kfl_buying_sales_net_val            NUMBER(38,5),
   ldl_adjust_sales_net_val            NUMBER(38,5),
   ldl_adjust_sales_qty                NUMBER(38,5),
   ldl_return_net_val                  NUMBER(38,5),
   ldl_return_qty                      NUMBER(38,5),
   ldl_pch_net_val                     NUMBER(38,5),
   kfl_pch_net_val                     NUMBER(38,5),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_FACT_LDL_STORE_ITEM_DAY PRIMARY KEY (lob_cd, cal_dt, curr_cd, ldl_item_sid, ldl_store_sid, kfl_consolidated_promo_item_type_cd) NOT ENFORCED 
)  COMMENT = 'Comment 2Do';
