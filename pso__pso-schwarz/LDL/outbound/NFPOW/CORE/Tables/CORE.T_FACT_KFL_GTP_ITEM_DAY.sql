/* --------------------------------------------------------------------------------
   DDL for table: t_fact_kfl_gtp_item_day
   generated from Powerdesigner on Montag, 30. September 2024 17:16:29
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_fact_kfl_gtp_item_day (
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
cal_dt DATE NOT NULL OPTIONS(description='calendar date of the fact in the extract from Kaufland DWH / Lidl retail DWH'),
curr_cd STRING(3) NOT NULL
OPTIONS(description='currency code for reporting, so far only EUR is reported, currency conversion has been done using exchange rates from Kaufland DWH if the source data has been extracted in other currencies.            Manually filled : "EUR"'),
kfl_consolidated_promo_item_type_cd STRING(100) NOT NULL
OPTIONS(description='This attribute consolidates the content of the kfl_item_list_type_cd into a generalized information about whether an item should be regarded as promotion item or not.            "PN" - item is a promotion item            "SO" - item is not a promotion item'),
kfl_adv_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the Kaufland advertising week            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.KJWO_WW'),
kfl_adjust_sales_gross_val BIGNUMERIC(38,5)
OPTIONS(description='adjusted sales gross revenue (sales gross revenue minus return gross revenue) of the item            metric_type_id=167, 45            KFL: kfl-to-ldl_Umsatz_Absatz.umsatz_brutto            LDL: x-kpi: EK80_MIS_UM_WJXBFS1.m1401_gross            CORE_REL: t_kfl_metric_gtp_item_day, t_ldl_metric_client_item_day.metric_val'),
kfl_adjust_sales_net_val BIGNUMERIC(38,5)
OPTIONS(description='adjusted sales net revenue (sales net revenue minus return net revenue) of the item            metric_type_id=162, 41            KFL: kfl-to-ldl_Umsatz_Absatz.umsatz_netto            LDL: x-kpi: EK80_MIS_UM_WJXBFS1.m1401            CORE_REL: t_kfl_metric_gtp_item_day, t_ldl_metric_client_item_day.metric_val'),
kfl_adjust_adv_sales_net_val BIGNUMERIC(38,5)
OPTIONS(description='Adjusted sales net revenue of the item if the item was sold during a promotion.            metric_type_id = 166, 41            KFL: kfl-to-ldl_Umsatz_Absatz. umsatz_netto_sa            LDL: x-kpi: EK80_MIS_UM_WJXBFS1.m1401            CORE_REL: T_KFL_METRIC_GTP_ITEM_DAY, T_LDL_METRIC_CLIENT_ITEM_DAY.METRIC_VAL'),
kfl_return_gross_val BIGNUMERIC(38,5)
OPTIONS(description='return gross value of the item            metric_type_id 273, 283, 46            KFL: kfl-to-ldl_Returns.rekl_wert_vk_b, kfl-to-ldl_Returns_DE.wjxbfs3            LDL: x-kpi: EK80_MIS_UM_WJXBFS1.wjxbfs3_gross            CORE_REL: t_kfl_metric_gtp_item_day, t_ldl_metric_client_item_day.metric_val'),
kfl_return_net_val BIGNUMERIC(38,5)
OPTIONS(description='return net value of the item            metric_type_id 272, 282, 44            KFL: kfl-to-ldl_Returns.rekl_wert_vk_n, kfl-to-ldl_Returns_DE.wjxbfs2            LDL: x-kpi: EK80_MIS_UM_WJXBFS1.wjxbfs3            CORE_REL: t_kfl_metric_gtp_item_day, t_ldl_metric_client_item_day.metric_val'),
kfl_adjust_sales_qty BIGNUMERIC(38,5)
OPTIONS(description='adjusted sales quantity (sales quantity minus return quantity) of the item            metric_type_id=161, 42            KFL: kfl-to-ldl_Umsatz_Absatz.vk_menge            LDL: x-kpi: EK80_MIS_UM_WJXBFS1.wjxbfs1            CORE_REL: t_kfl_metric_gtp_item_day, t_ldl_metric_client_item_day.metric_qty'),
kfl_adjust_adv_sales_qty BIGNUMERIC(38,5)
OPTIONS(description='Adjusted sales quantity of the item if the item was sold during a promotion.            metric_type_id = 164, 42            KFL: kfl-to-ldl_Umsatz_Absatz. vk_menge_sa             LDL: x-kpi: EK80_MIS_UM_WJXBFS1.wjxbfs1            CORE_REL: T_KFL_METRIC_GTP_ITEM_DAY, T_LDL_METRIC_CLIENT_ITEM_DAY.METRIC_QTY'),
kfl_return_qty BIGNUMERIC(38,5)
OPTIONS(description='return quantity of the item            metric_type_id 271,281, 43            KFL: kfl-to-ldl_Returns.rekl_menge_art , kfl-to-ldl_Returns_DE.wjxbfs1            LDL: x-kpi: EK80_MIS_UM_WJXBFS1.wjxbfs2            CORE_REL: t_kfl_metric_gtp_item_day, t_ldl_metric_client_item_day.metric_qty'),
kfl_rcv_qty BIGNUMERIC(38,5)
OPTIONS(description='receive quantity (Wareneingangsmenge)            metric_type_id 231,241,251,261            KFL: kfl-to-ldl_WE_Menge.menge, kfl-to-ldl_WE_Menge_DE.menge, kfl-to-ldl_WE_Menge_DE_IC.menge, kfl-to-ldl_WE_Menge_IC.menge            CORE_REL: t_kfl_metric_gtp_item_day.metric_qty'),
kfl_buying_sales_net_val BIGNUMERIC(38,5)
OPTIONS(description='value of sales quantity using net purchasing prices            metric_type_id 200, 211            KFL: kfl-to-ldl_WA_Kalk_DE_Umsatz.wjxbfs6, kfl-to-ldl_WA_Kalk_Umsatz.wa_kalk_kw            CORE_REL: t_kfl_metric_gtp_item_day.metric_val'),
kfl_total_writeoff_net_val BIGNUMERIC(38,5)
OPTIONS(description='net value of total write off            metric_type_id 121, 151, 371            KFL: kfl-to-ldl_Abschriften_DE_TA.abschr_vk, kfl-to-ldl_Abschriften_KMO_TA.vkwra, kfl-to-ldl_Abschriften_KMO_TA_LOG.betragvknettovz            CORE_REL: t_kfl_metric_gtp_item_day.metric_val'),
kfl_part_writeoff_net_val BIGNUMERIC(38,5)
OPTIONS(description='net value of partial write off            metric_type_id 103, 104, 131            KFL: kfl-to-ldl_Abschriften_DE_PA.aufschr_vk, kfl-to-ldl_Abschriften_DE_PA.abschr_vk, kfl-to-ldl_Abschriften_KMO_PA.usegvksadn            CORE_REL: t_kfl_metric_gtp_item_day.metric_val'),
ldl_writeoff_net_val BIGNUMERIC(38,5)
OPTIONS(description='net value of write off, Lidl only due to different methodology            metric_type_id 21, 31            KFL: ldl-EK80_MIS_UM_M1201BNL.m1201bnl, ldl-EK80_MIS_UM_M1201BNL1.m1201bnl            CORE_REL: t_ldl_metric_store_item_day.metric_val'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (lob_cd, kfl_client_id, kfl_item_nr, cal_dt, curr_cd, kfl_gtp_nr, kfl_gtp_subsidiary_type_id) NOT ENFORCED
)
OPTIONS(description='Aggregate fact table on level goods transshipment point, item and day holding all relevant facts from Kaufland and Lidl in the Kaufland context for day by day Apollo reporting for Kaufland             CORE_REL: T_LDL_METRIC_STORE_ITEM_DAY, T_KFL_METRIC_GTP_ITEM_DAY');