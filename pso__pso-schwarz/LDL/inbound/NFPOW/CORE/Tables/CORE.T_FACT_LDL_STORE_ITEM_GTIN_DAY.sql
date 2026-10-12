/* --------------------------------------------------------------------------------
   DDL for table: t_fact_ldl_store_item_gtin_day
   generated from Powerdesigner on Montag, 30. September 2024 17:18:19
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_LDL_STORE_ITEM_GTIN_DAY DATA_RETENTION_TIME_IN_DAYS = 2 (
   lob_cd                              VARCHAR(100)     NOT NULL COMMENT 'Line of business depends on the general source of the data, "KFL" if the data is taken from the Kaufland DWH, "LDL" if the data is taken from a Lidl DWH.',
   ldl_store_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate key of the store in the Lidl DWH.
            LDL: P_LEW_MART_LEAD_AC.V_ITM_ITEM.STORE_SID',
   ldl_item_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate key of the item in the Lidl DWH.',
   gtin_nr                             VARCHAR(100)     NOT NULL COMMENT 'Assigned GTIN of the NFPO stock keeping unit for Kaufland.or Lidl.
            CBX: CNT_ITEM, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE, LDL_ITEM_SIZE, LDL_ITEM_LSV, LDL_ITEM_ARTICLE_EAN.LDL_EAN_KL or LDL_EAN
            LDL: P_LEW_CORE.T_MDM_ITEM_SKU_EAN_HIST.KFL_BARCODE or BARCODE
            CORE_REL: T_NFPO_ITE_SKU_GTIN_HIST.KFL_GTIN_NR or LDL_GTIN_NR',
   cal_dt                              DATE             NOT NULL COMMENT 'Calendar date of the fact in the extract from Kaufland DWH / Lidl retail DWH.',
   ldl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate key of the ERP client in the Lidl DWH.',
   curr_cd                             VARCHAR(3)       NOT NULL COMMENT 'Currency code used by Lidl.
            CORE_REL: T_LDL_CURRENCY.CURR_CD
            LDL: P_LEW_CORE.T_CURRENCY.CURR_ISO_CD',
   kfl_consolidated_promo_item_type_cd VARCHAR(100)     NOT NULL COMMENT 'This attribute consolidates the content of the KFL_ITEM_LIST_TYPE_CD into a generalized information about whether an item should be regarded as promotion item or not.
            "PN" = item is a promotion item
            "SO" = item is not a promotion item',
   ldl_adjust_sales_net_val            NUMBER(38,5)     COMMENT 'Ddjusted sales net revenue (sales net revenue minus return net revenue) of the item.
            METRIC_TYPE_ID = 562, 541
            KFL: KFL-TO-LDL_UMSATZ_ABSATZ_GTIN
            LDL: LDL-EK80_MIS_GTIN_SALES.M1401
            CORE_REL: T_KFL_METRIC_GTP_ITEM_BARCODE_DAY, T_LDL_METRIC_CLIENT_ITEM_BARCODE_DAY.METRIC_VAL',
   ldl_adjust_sales_qty                NUMBER(38,5)     COMMENT 'Adjusted sales quantity (sales quantity minus return quantity) of the item.
            METRIC_TYPE_ID = 561, 542
            KFL: KFL-TO-LDL_UMSATZ_ABSATZ_GTIN.VK_MENGE
            LDL: LDL-EK80_MIS_GTIN_SALES.WJXBFS1
            CORE_REL: T_KFL_METRIC_GTP_ITEM_BARCODE_DAY, T_LDL_METRIC_CLIENT_ITEM_BARCODE_DAY.METRIC_QTY',
   ldl_return_net_val                  NUMBER(38,5)     COMMENT 'Return net value of the item.
            METRIC_TYPE_ID = 544
            LDL: LDL-EK80_MIS_GTIN_SALES.WJXBFS3
            CORE_REL: T_LDL_METRIC_CLIENT_ITEM_BARCODE_DAY.METRIC_VAL',
   ldl_return_qty                      NUMBER(38,5)     COMMENT 'Return quantity of the item.
            METRIC_TYPE_ID = 543
            LDL: LDL-EK80_MIS_GTIN_SALES.WJXBFS2
            CORE_REL: T_LDL_METRIC_CLIENT_ITEM_BARCODE_DAY.METRIC_QTY',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_FACT_LDL_STORE_ITEM_GTIN_DAY PRIMARY KEY (lob_cd, cal_dt, curr_cd, gtin_nr, ldl_item_sid, ldl_store_sid, kfl_consolidated_promo_item_type_cd) NOT ENFORCED 
)  COMMENT = 'Aggregate fact table on level store, item, GTIN and day holding all relevant facts from Kaufland and Lidl in the Lidl context for day by day Apollo reporting for Lidl.
             CORE_REL: T_LDL_METRIC_STORE_ITEM_BARCODE_DAY, T_KFL_METRIC_GTP_ITEM_BARCODE_DAY';
