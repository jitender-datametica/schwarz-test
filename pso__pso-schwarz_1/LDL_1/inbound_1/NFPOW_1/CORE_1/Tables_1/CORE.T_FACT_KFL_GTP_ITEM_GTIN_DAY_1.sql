/* --------------------------------------------------------------------------------
   DDL for table: t_fact_kfl_gtp_item_gtin_day_1
   generated from Powerdesigner on Montag, 30. September 2024 17:17:26
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_KFL_GTP_ITEM_GTIN_DAY_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   lob_cd                              VARCHAR(100)     NOT NULL COMMENT 'line of business depends on the general source of the data, "KFL" if the data is taken from the Kaufland DWH, "LDL" if the data is taken from a Lidl DWH',
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant_1) in the extract from the Kaufland DWH',
   kfl_gtp_nr                          NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL goods transshipment point (Warenumschlagsplatz) in the extract from the Kaufland DWH',
   kfl_gtp_subsidiary_type_id          NUMBER(38,0)     NOT NULL COMMENT 'identifier of the subsidiary type (Nebenstelle) of the KFL goods transshipment point (Warenumschlagsplatz) in the extract from the Kaufland DWH',
   kfl_item_nr                         NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL item_1 (Artikel_1) in the extract from the Kaufland DWH',
   gtin_nr                             NUMBER(38,0)     NOT NULL COMMENT 'Assigned GTIN of the NFPO stock keeping unit_1 for Kaufland.or Lidl
            CBX: CNT_ITEM_1, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_1, LDL_ITEM_SIZE_1, LDL_ITEM_LSV_1, LDL_ITEM_ARTICLE_EAN.LDL_EAN_KL or LDL_EAN
            LDL: P_LEW_CORE.T_MDM_ITEM_SKU_EAN_HIST.KFL_BARCODE or LDL_BARCODE
            CORE_REL: T_NFPO_ITE_SKU_GTIN_HIST.KFL_GTIN_NR or LDL_GTIN_NR',
   cal_dt                              DATE             NOT NULL COMMENT 'calendar_1 date of the fact in the extract from Kaufland DWH',
   curr_cd                             VARCHAR(3)       NOT NULL COMMENT 'currency code for reporting, so far only EUR is reported, currency conversion has been done using exchange rates from Kaufland DWH if the source data has been extracted in other currencies',
   kfl_consolidated_promo_item_type_cd VARCHAR(100)     NOT NULL COMMENT 'This attribute consolidates the content of the kfl_item_list_type_cd into a generalized information about whether an item_1 should be regarded as promotion item_1 or not.
            "PN" - item_1 is a promotion item_1
            "SO" - item_1 is not a promotion item_1',
   kfl_adv_week                        NUMBER(38,0)     COMMENT 'identifier of the Kaufland advertising week
            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.KJWO_WW',
   kfl_adjust_sales_gross_val          NUMBER(38,5)     COMMENT 'adjusted sales_1 gross revenue (sales_1 gross revenue minus return gross revenue) of the item_1
            metric_type_id=567, 545
            KFL: kfl-to-ldl_Umsatz_Absatz_GTIN.umsatz_brutto
            LDL: ldl-EK80_MIS_GTIN_SALES.m1401_gross
            CORE_REL: t_kfl_metric_gtp_item_barcode_day_1,metric_val, t_ldl_metric_store_item_barcode_day.metric_val',
   kfl_adjust_sales_net_val            NUMBER(38,5)     COMMENT 'adjusted sales_1 net revenue (sales_1 net revenue minus return net revenue) of the item_1
            metric_type_id=562, 541
            KFL: kfl-to-ldl_Umsatz_Absatz_GTIN.umsatz_netto
            LDL: ldl-EK80_MIS_GTIN_SALES.m1401
            CORE_REL: t_kfl_metric_gtp_item_barcode_day_1,metric_val, t_ldl_metric_store_item_barcode_day.metric_val',
   kfl_return_gross_val                NUMBER(38,5)     COMMENT 'return gross value of the item_1
            metric_type_id 546
            LDL: ldl-EK80_MIS_GTIN_SALES.wjxbfs3_gross
            CORE_REL: t_ldl_metric_store_item_barcode_day.metric_val',
   kfl_return_net_val                  NUMBER(38,5)     COMMENT 'return net value of the item_1
            metric_type_id 544
            LDL: ldl-EK80_MIS_GTIN_SALES.wjxbfs3
            CORE_REL: t_ldl_metric_client_item_barcode_day.metric_val',
   kfl_adjust_sales_qty                NUMBER(38,5)     COMMENT 'adjusted sales_1 quantity (sales_1 quantity minus return quantity) of the item_1
            metric_type_id=561, 542
            KFL: kfl-to-ldl_Umsatz_Absatz_GTIN.vk_menge
            LDL: ldl-EK80_MIS_GTIN_SALES.wjxbfs1
            CORE_REL: t_kfl_metric_gtp_item_barcode_day_1, t_ldl_metric_client_item_barcode_day.metric_qty',
   kfl_return_qty                      NUMBER(38,5)     COMMENT 'return quantity of the item_1
            metric_type_id 543
            LDL: ldl-EK80_MIS_GTIN_SALES.wjxbfs2
            CORE_REL: t_ldl_metric_client_item_barcode_day.metric_qty',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_FACT_KFL_GTP_ITEM_GTIN_DAY PRIMARY KEY (lob_cd, kfl_client_id, kfl_item_nr, cal_dt, curr_cd, gtin_nr, kfl_gtp_nr, kfl_gtp_subsidiary_type_id) NOT ENFORCED 
)  COMMENT = 'Aggregate fact table on level goods transshipment point, item_1, GTIN and day holding all relevant facts from Kaufland and Lidl in the Kaufland context for day by day Apollo reporting for Kaufland
             CORE_REL: T_LDL_METRIC_STORE_ITEM_BARCODE_DAY_1, T_KFL_METRIC_GTP_ITEM_BARCODE_DAY_1';
