/* --------------------------------------------------------------------------------
   DDL for table: t_fact_kfl_gtp_item_gtin_day_2
   generated from Powerdesigner on Montag, 30. September 2024 17:17:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_fact_kfl_gtp_item_gtin_day_2 (
lob_cd STRING(100) NOT NULL
OPTIONS(description='line of business depends on the general source of the data, "KFL" if the data is taken from the Kaufland DWH, "LDL" if the data is taken from a Lidl DWH'),
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant_2) in the extract from the Kaufland DWH'),
kfl_gtp_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL goods transshipment point (Warenumschlagsplatz) in the extract from the Kaufland DWH'),
kfl_gtp_subsidiary_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the subsidiary type (Nebenstelle) of the KFL goods transshipment point (Warenumschlagsplatz) in the extract from the Kaufland DWH'),
kfl_item_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL item_2 (Artikel_2) in the extract from the Kaufland DWH'),
gtin_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Assigned GTIN of the NFPO stock keeping unit_2 for Kaufland.or Lidl            CBX: CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV_2, LDL_ITEM_ARTICLE_EAN.LDL_EAN_KL or LDL_EAN            LDL: P_LEW_CORE.T_MDM_ITEM_SKU_EAN_HIST.KFL_BARCODE or LDL_BARCODE            CORE_REL: T_NFPO_ITE_SKU_GTIN_HIST.KFL_GTIN_NR or LDL_GTIN_NR'),
cal_dt DATE NOT NULL OPTIONS(description='calendar_2 date of the fact in the extract from Kaufland DWH'),
curr_cd STRING(3) NOT NULL
OPTIONS(description='currency code for reporting, so far only EUR is reported, currency conversion has been done using exchange rates from Kaufland DWH if the source data has been extracted in other currencies'),
kfl_consolidated_promo_item_type_cd STRING(100) NOT NULL
OPTIONS(description='This attribute consolidates the content of the kfl_item_list_type_cd into a generalized information about whether an item_2 should be regarded as promotion item_2 or not.            "PN" - item_2 is a promotion item_2            "SO" - item_2 is not a promotion item_2'),
kfl_adv_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the Kaufland advertising week            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.KJWO_WW'),
kfl_adjust_sales_gross_val BIGNUMERIC(38,5)
OPTIONS(description='adjusted sales_2 gross revenue (sales_2 gross revenue minus return gross revenue) of the item_2            metric_type_id=567, 545            KFL: kfl-to-ldl_Umsatz_Absatz_GTIN.umsatz_brutto            LDL: ldl-EK80_MIS_GTIN_SALES.m1401_gross            CORE_REL: t_kfl_metric_gtp_item_barcode_day_2,metric_val, t_ldl_metric_store_item_barcode_day.metric_val'),
kfl_adjust_sales_net_val BIGNUMERIC(38,5)
OPTIONS(description='adjusted sales_2 net revenue (sales_2 net revenue minus return net revenue) of the item_2            metric_type_id=562, 541            KFL: kfl-to-ldl_Umsatz_Absatz_GTIN.umsatz_netto            LDL: ldl-EK80_MIS_GTIN_SALES.m1401            CORE_REL: t_kfl_metric_gtp_item_barcode_day_2,metric_val, t_ldl_metric_store_item_barcode_day.metric_val'),
kfl_return_gross_val BIGNUMERIC(38,5)
OPTIONS(description='return gross value of the item_2            metric_type_id 546            LDL: ldl-EK80_MIS_GTIN_SALES.wjxbfs3_gross            CORE_REL: t_ldl_metric_store_item_barcode_day.metric_val'),
kfl_return_net_val BIGNUMERIC(38,5)
OPTIONS(description='return net value of the item_2            metric_type_id 544            LDL: ldl-EK80_MIS_GTIN_SALES.wjxbfs3            CORE_REL: t_ldl_metric_client_item_barcode_day.metric_val'),
kfl_adjust_sales_qty BIGNUMERIC(38,5)
OPTIONS(description='adjusted sales_2 quantity (sales_2 quantity minus return quantity) of the item_2            metric_type_id=561, 542            KFL: kfl-to-ldl_Umsatz_Absatz_GTIN.vk_menge            LDL: ldl-EK80_MIS_GTIN_SALES.wjxbfs1            CORE_REL: t_kfl_metric_gtp_item_barcode_day_2, t_ldl_metric_client_item_barcode_day.metric_qty'),
kfl_return_qty BIGNUMERIC(38,5)
OPTIONS(description='return quantity of the item_2            metric_type_id 543            LDL: ldl-EK80_MIS_GTIN_SALES.wjxbfs2            CORE_REL: t_ldl_metric_client_item_barcode_day.metric_qty'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (lob_cd, kfl_client_id, kfl_item_nr, cal_dt, curr_cd, gtin_nr, kfl_gtp_nr, kfl_gtp_subsidiary_type_id)
NOT ENFORCED
)
OPTIONS(description='Aggregate fact table on level goods transshipment point, item_2, GTIN and day holding all relevant facts from Kaufland and Lidl in the Kaufland context for day by day Apollo reporting for Kaufland             CORE_REL: T_LDL_METRIC_STORE_ITEM_BARCODE_DAY_2, T_KFL_METRIC_GTP_ITEM_BARCODE_DAY_2');