/* --------------------------------------------------------------------------------
   DDL for table: t_fact_kfl_gtp_item_advertise_day
   generated from Powerdesigner on Montag, 30. September 2024 17:15:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_fact_kfl_gtp_item_advertise_day (
lob_cd STRING(100) NOT NULL
OPTIONS(description='line of business depends on the general source of the data, "KFL" if the data is taken from the Kaufland DWH, "LDL" if the data is taken from a Lidl DWH'),
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant) in the extract from the Kaufland DWH'),
kfl_gtp_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL goods transshipment point (Warenumschlagsplatz) in the extract from the Kaufland DWH'),
kfl_gtp_subsidiary_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the subsidiary type (Nebenstelle) of the KFL goods transshipment point (Warenumschlagsplatz) in the extract from the Kaufland DWH'),
kfl_item_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL item (Artikel) in the extract from the Kaufland DWH'),
cal_week BIGNUMERIC(38,0) NOT NULL OPTIONS(description='calendar week of the fact in the extract from the Kaufland DWH'),
kfl_adv_period_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the advertising period type in the extract from the  Kaufland DWH'),
curr_cd STRING(3) NOT NULL
OPTIONS(description='currency code for reporting, so far only EUR is reported, currency conversion has been done using exchange rates from Kaufland DWH if the source data has been extracted in other currencies.            Manually filled : "EUR"'),
kfl_consolidated_promo_item_type_cd STRING(100) NOT NULL
OPTIONS(description='This attribute consolidates the content of the kfl_item_list_type_cd into a generalized information about whether an item should be regarded as promotion item or not.            "PN" - item is a promotion item            "SO" - item is not a promotion item'),
adv_dt DATE NOT NULL
OPTIONS(description='Starting date of the advertising campaign in the extracts  from Lidl retail and Kaufland'),
kfl_adv_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the Kaufland advertising week            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.KJWO_WW'),
kfl_adjust_adv_sales_7_qty BIGNUMERIC(38,5)
OPTIONS(description='sales quantity of the item from 5 days before the promotion sales starts until (including) day 7 of the promotion            metric_type_id 367            KFL:kfl-to-ldl_AVQ_VIS.menge_avq7            CORE_REL: t_fact_kfl_gtp_item_advertise_day.metric_qty'),
kfl_adv_stock_qty BIGNUMERIC(38,5)
OPTIONS(description='quantity of the item available for the promotion action            metric_type_id 361, 362, 363            KFL:kfl-to-ldl_AVQ_VIS.sql.bestand, kfl-to-ldl_AVQ_VIS.sql.bestand_zentral, kfl-to-ldl_AVQ_VIS.sql.bestand_aktionsstart            CORE_REL: t_fact_kfl_gtp_item_advertise_day.metric_qty'),
kfl_gtp_cnt BIGNUMERIC(38,0)
OPTIONS(description='contains 1 if the store should be counted as relevant store for the advertising action, else 0            CORE_REL: t_fact_kfl_gtp_item_advertise_day.'),
ldl_adjust_adv_sales_7_qty BIGNUMERIC(38,5)
OPTIONS(description='sales quantity of the item from 5 days before the promotion sales starts until (including) day 7 of the promotion            metric_type_id 4            LDL: x-kpi: EK80_MIS_7T_AVQ_QTY.m14113            CORE_REL: t_ldl_metric_store_item_day.'),
ldl_adv_stock_qty BIGNUMERIC(38,5)
OPTIONS(description='quantity of the item available for the promotion action            metric_type_id 1, 5            LDL: x-kpi: EK80_MIS_7T_AVQ_QTY.m1411, x-kpi: EK80_MIS_7T_AVQ_QTY.m14114            CORE_REL: t_ldl_metric_store_item_day.metric_qty'),
ldl_gtp_cnt BIGNUMERIC(38,0)
OPTIONS(description='contains 1 if the store should be counted as relevant store for the advertising action, else 0            CORE_REL: t_ldl_metric_store_item_day.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (lob_cd, kfl_client_id, kfl_item_nr, kfl_gtp_nr, kfl_gtp_subsidiary_type_id, cal_week, curr_cd,
 kfl_adv_period_type_id) NOT ENFORCED
)
OPTIONS(description='Aggregate fact table on level goods transshipment point, item and advertise date holding all relevant facts from Kaufland and Lidl in the Kaufland context for day by day Apollo reporting for Kaufland             CORE_REL: T_LDL_METRIC_STORE_ITEM_ADVERTISE_DAY, T_KFL_METRIC_GTP_ITEM_ADVERTISE_DAY');