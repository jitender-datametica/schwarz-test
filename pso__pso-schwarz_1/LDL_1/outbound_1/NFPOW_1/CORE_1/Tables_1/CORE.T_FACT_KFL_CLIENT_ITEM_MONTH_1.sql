/* --------------------------------------------------------------------------------
   DDL for table: t_fact_kfl_client_item_month_1
   generated from Powerdesigner on Montag, 30. September 2024 17:14:35
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_fact_kfl_client_item_month_1 (
lob_cd STRING(100) NOT NULL
OPTIONS(description='line of business depends on the general source of the data, "KFL" if the data is taken from the Kaufland DWH, "LDL" if the data is taken from a Lidl DWH'),
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant_1) in the extract from the Kaufland DWH'),
kfl_item_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL item_1 (Artikel_1) in the extract from the Kaufland DWH'),
cal_month BIGNUMERIC(38,0) NOT NULL OPTIONS(description='calendar_1 month of the fact in the extract from Kaufland DWH'),
curr_cd STRING(3) NOT NULL
OPTIONS(description='currency code for reporting, so far only EUR is reported, currency conversion has been done using exchange rates from Kaufland DWH if the source data has been extracted in other currencies.            Manually filled : "EUR"'),
kfl_consolidated_promo_item_type_cd STRING(100) NOT NULL
OPTIONS(description='This attribute consolidates the content of the kfl_item_list_type_cd into a generalized information about whether an item_1 should be regarded as promotion item_1 or not.            "PN" - item_1 is a promotion item_1            "SO" - item_1 is not a promotion item_1'),
kfl_adjust_sales_gross_val BIGNUMERIC(38,5)
OPTIONS(description='adjusted sales_1 gross revenue (sales_1 gross revenue minus return gross revenue) of the item_1            metric_type_id=167, 45            KFL: kfl-to-ldl_Umsatz_Absatz.umsatz_brutto            LDL: x-kpi: EK80_MIS_UM_WJXBFS1.m1401_gross            CORE_REL: t_kfl_metric_gtp_item_day_1, t_ldl_metric_client_item_day.metric_val'),
kfl_adjust_sales_net_val BIGNUMERIC(38,5)
OPTIONS(description='adjusted sales_1 net revenue (sales_1 net revenue minus return net revenue) of the item_1            metric_type_id=162, 41            KFL: kfl-to-ldl_Umsatz_Absatz.umsatz_netto            LDL: x-kpi: EK80_MIS_UM_WJXBFS1.m1401            CORE_REL: t_kfl_metric_gtp_item_day_1, t_ldl_metric_client_item_day.metric_val'),
kfl_adjust_adv_sales_net_val BIGNUMERIC(38,5)
OPTIONS(description='Adjusted sales_1 net revenue of the item_1 if the item_1 was sold during a promotion.            metric_type_id = 166, 41            KFL: kfl-to-ldl_Umsatz_Absatz. umsatz_netto_sa            LDL: x-kpi: EK80_MIS_UM_WJXBFS1.m1401            CORE_REL: T_KFL_METRIC_GTP_ITEM_DAY_1, T_LDL_METRIC_CLIENT_ITEM_DAY.METRIC_VAL'),
kfl_return_gross_val BIGNUMERIC(38,5)
OPTIONS(description='return gross value of the item_1            metric_type_id 273, 283, 46            KFL: kfl-to-ldl_Returns.rekl_wert_vk_b, kfl-to-ldl_Returns_DE.wjxbfs3            LDL: x-kpi: EK80_MIS_UM_WJXBFS1.wjxbfs3_gross            CORE_REL: t_kfl_metric_gtp_item_day_1, t_ldl_metric_client_item_day.metric_val'),
kfl_return_net_val BIGNUMERIC(38,5)
OPTIONS(description='return net value of the item_1            metric_type_id 272, 282, 44            KFL: kfl-to-ldl_Returns.rekl_wert_vk_n, kfl-to-ldl_Returns_DE.wjxbfs2            LDL: x-kpi: EK80_MIS_UM_WJXBFS1.wjxbfs3            CORE_REL: t_kfl_metric_gtp_item_day_1, t_ldl_metric_client_item_day.metric_val'),
kfl_adjust_sales_qty BIGNUMERIC(38,5)
OPTIONS(description='adjusted sales_1 quantity (sales_1 quantity minus return quantity) of the item_1            metric_type_id=161, 42            KFL: kfl-to-ldl_Umsatz_Absatz.vk_menge            LDL: x-kpi: EK80_MIS_UM_WJXBFS1.wjxbfs1            CORE_REL: t_kfl_metric_gtp_item_day_1, t_ldl_metric_client_item_day.metric_qty'),
kfl_adjust_adv_sales_qty BIGNUMERIC(38,5)
OPTIONS(description='Adjusted sales_1 quantity of the item_1 if the item_1 was sold during a promotion.            metric_type_id = 164, 42            KFL: kfl-to-ldl_Umsatz_Absatz. vk_menge_sa             LDL: x-kpi: EK80_MIS_UM_WJXBFS1.wjxbfs1            CORE_REL: T_KFL_METRIC_GTP_ITEM_DAY_1, T_LDL_METRIC_CLIENT_ITEM_DAY.METRIC_QTY'),
kfl_return_qty BIGNUMERIC(38,5)
OPTIONS(description='return quantity of the item_1            metric_type_id 271,281, 43            KFL: kfl-to-ldl_Returns.rekl_menge_art , kfl-to-ldl_Returns_DE.wjxbfs1            LDL: x-kpi: EK80_MIS_UM_WJXBFS1.wjxbfs2            CORE_REL: t_kfl_metric_gtp_item_day_1, t_ldl_metric_client_item_day.metric_qty'),
kfl_rcv_qty BIGNUMERIC(38,5)
OPTIONS(description='receive quantity (Wareneingangsmenge)            metric_type_id 231,241,251,261, 71            KFL: kfl-to-ldl_WE_Menge.menge, kfl-to-ldl_WE_Menge_DE.menge, kfl-to-ldl_WE_Menge_DE_IC.menge, kfl-to-ldl_WE_Menge_IC.menge            LDL: x-kpi: EK80_MIS_WE.m1105we            CORE_REL: t_kfl_metric_gtp_item_day_1, t_ldl_metric_client_item_day.metric_qty'),
kfl_buying_sales_net_val BIGNUMERIC(38,5)
OPTIONS(description='value of sales_1 quantity using net purchasing prices            metric_type_id 200, 211            KFL: kfl-to-ldl_WA_Kalk_DE_Umsatz.wjxbfs6, kfl-to-ldl_WA_Kalk_Umsatz.wa_kalk_kw            CORE_REL: t_kfl_metric_gtp_item_day.metric_val'),
ldl_buying_rcv_net_val BIGNUMERIC(38,5)
OPTIONS(description='value of receive quantity using net purchasing prices            metric_type_id 72            LDL: x-kpi: EK80_MIS_WE.weeknettowert            CORE_REL: t_ldl_metric_client_item_day.metric_val'),
ldl_retail_rcv_net_val BIGNUMERIC(38,5)
OPTIONS(description='value of receive quantity using net sales_1 prices            metric_type_id 73            LDL: x-kpi: EK80_MIS_WE.wevknettowertinklsonderkond            CORE_REL: t_ldl_metric_client_item_day.metric_val'),
kfl_total_writeoff_net_val BIGNUMERIC(38,5)
OPTIONS(description='net value of total write off            metric_type_id 121, 151, 371            KFL: kfl-to-ldl_Abschriften_DE_TA.abschr_vk, kfl-to-ldl_Abschriften_KMO_TA.vkwra, kfl-to-ldl_Abschriften_KMO_TA_LOG.betragvknettovz            CORE_REL: t_kfl_metric_gtp_item_day.metric_val'),
kfl_part_writeoff_net_val BIGNUMERIC(38,5)
OPTIONS(description='net value of partial write off            metric_type_id 103, 104, 131            KFL: kfl-to-ldl_Abschriften_DE_PA.aufschr_vk, kfl-to-ldl_Abschriften_DE_PA.abschr_vk, kfl-to-ldl_Abschriften_KMO_PA.usegvksadn            CORE_REL: t_kfl_metric_gtp_item_day.metric_val'),
ldl_writeoff_net_val BIGNUMERIC(38,5)
OPTIONS(description='net value of write off, Lidl only due to different methodology            metric_type_id 21, 31            KFL: ldl-EK80_MIS_UM_M1201BNL.m1201bnl, ldl-EK80_MIS_UM_M1201BNL1.m1201bnl            CORE_REL: t_ldl_metric_store_item_day.metric_val'),
kfl_prev_1y_adjust_sales_gross_val BIGNUMERIC(38,5)
OPTIONS(description='adjusted sales_1 gross revenue (sales_1 gross revenue minus return gross revenue) of the item_1            metric_type_id=167, 45            KFL: kfl-to-ldl_Umsatz_Absatz.umsatz_brutto            LDL: x-kpi: EK80_MIS_UM_WJXBFS1.m1401_gross            CORE_REL: t_kfl_metric_gtp_item_day_1, t_ldl_metric_client_item_day.metric_val'),
kfl_prev_1y_adjust_sales_net_val BIGNUMERIC(38,5)
OPTIONS(description='adjusted sales_1 net revenue (sales_1 net revenue minus return net revenue) of the item_1            metric_type_id=162, 41            KFL: kfl-to-ldl_Umsatz_Absatz.umsatz_netto            LDL: x-kpi: EK80_MIS_UM_WJXBFS1.m1401            CORE_REL: t_kfl_metric_gtp_item_day_1, t_ldl_metric_client_item_day.metric_val'),
kfl_prev_1y_adjust_adv_sales_net_val BIGNUMERIC(38,5)
OPTIONS(description='Adjusted sales_1 net revenue of the item_1 if the item_1 was sold during a promotion.            metric_type_id = 166, 41            KFL: kfl-to-ldl_Umsatz_Absatz. umsatz_netto_sa            LDL: x-kpi: EK80_MIS_UM_WJXBFS1.m1401            CORE_REL: T_KFL_METRIC_GTP_ITEM_DAY_1, T_LDL_METRIC_CLIENT_ITEM_DAY.METRIC_VAL'),
kfl_prev_1y_return_gross_val BIGNUMERIC(38,5)
OPTIONS(description='return gross value of the item_1            metric_type_id 273, 283, 46            KFL: kfl-to-ldl_Returns.rekl_wert_vk_b, kfl-to-ldl_Returns_DE.wjxbfs3            LDL: x-kpi: EK80_MIS_UM_WJXBFS1.wjxbfs3_gross            CORE_REL: t_kfl_metric_gtp_item_day_1, t_ldl_metric_client_item_day.metric_val'),
kfl_prev_1y_return_net_val BIGNUMERIC(38,5)
OPTIONS(description='return net value of the item_1            metric_type_id 272, 282, 44            KFL: kfl-to-ldl_Returns.rekl_wert_vk_n, kfl-to-ldl_Returns_DE.wjxbfs2            LDL: x-kpi: EK80_MIS_UM_WJXBFS1.wjxbfs3            CORE_REL: t_kfl_metric_gtp_item_day_1, t_ldl_metric_client_item_day.metric_val'),
kfl_prev_1y_adjust_sales_qty BIGNUMERIC(38,5)
OPTIONS(description='adjusted sales_1 quantity (sales_1 quantity minus return quantity) of the item_1            metric_type_id=161, 42            KFL: kfl-to-ldl_Umsatz_Absatz.vk_menge            LDL: x-kpi: EK80_MIS_UM_WJXBFS1.wjxbfs1            CORE_REL: t_kfl_metric_gtp_item_day_1, t_ldl_metric_client_item_day.metric_qty'),
kfl_prev_1y_adjust_adv_sales_qty BIGNUMERIC(38,5)
OPTIONS(description='Adjusted sales_1 quantity of the item_1 if the item_1 was sold during a promotion.            metric_type_id = 164, 42            KFL: kfl-to-ldl_Umsatz_Absatz. vk_menge_sa             LDL: x-kpi: EK80_MIS_UM_WJXBFS1.wjxbfs1            CORE_REL: T_KFL_METRIC_GTP_ITEM_DAY_1, T_LDL_METRIC_CLIENT_ITEM_DAY.METRIC_QTY'),
kfl_prev_1y_return_qty BIGNUMERIC(38,5)
OPTIONS(description='return quantity of the item_1            metric_type_id 271,281, 43            KFL: kfl-to-ldl_Returns.rekl_menge_art , kfl-to-ldl_Returns_DE.wjxbfs1            LDL: x-kpi: EK80_MIS_UM_WJXBFS1.wjxbfs2            CORE_REL: t_kfl_metric_gtp_item_day_1, t_ldl_metric_client_item_day.metric_qty'),
kfl_prev_1y_rcv_qty BIGNUMERIC(38,5)
OPTIONS(description='receive quantity (Wareneingangsmenge)            metric_type_id 231,241,251,261, 71            KFL: kfl-to-ldl_WE_Menge.menge, kfl-to-ldl_WE_Menge_DE.menge, kfl-to-ldl_WE_Menge_DE_IC.menge, kfl-to-ldl_WE_Menge_IC.menge            LDL: x-kpi: EK80_MIS_WE.m1105we            CORE_REL: t_kfl_metric_gtp_item_day_1, t_ldl_metric_client_item_day.metric_qty'),
kfl_prev_1y_buying_sales_net_val BIGNUMERIC(38,5)
OPTIONS(description='value of sales_1 quantity using net purchasing prices            metric_type_id 200, 211            KFL: kfl-to-ldl_WA_Kalk_DE_Umsatz.wjxbfs6, kfl-to-ldl_WA_Kalk_Umsatz.wa_kalk_kw            CORE_REL: t_kfl_metric_gtp_item_day.metric_val'),
ldl_prev_1y_buying_rcv_net_val BIGNUMERIC(38,5)
OPTIONS(description='value of receive quantity using net purchasing prices            metric_type_id 72            LDL: x-kpi: EK80_MIS_WE.weeknettowert            CORE_REL: t_ldl_metric_client_item_day.metric_val'),
ldl_prev_1y_retail_rcv_net_val BIGNUMERIC(38,5)
OPTIONS(description='value of receive quantity using net sales_1 prices            metric_type_id 73            LDL: x-kpi: EK80_MIS_WE.wevknettowertinklsonderkond            CORE_REL: t_ldl_metric_client_item_day.metric_val'),
kfl_prev_1y_total_writeoff_net_val BIGNUMERIC(38,5)
OPTIONS(description='net value of total write off            metric_type_id 121, 151, 371            KFL: kfl-to-ldl_Abschriften_DE_TA.abschr_vk, kfl-to-ldl_Abschriften_KMO_TA.vkwra, kfl-to-ldl_Abschriften_KMO_TA_LOG.betragvknettovz            CORE_REL: t_kfl_metric_gtp_item_day.metric_val'),
kfl_prev_1y_part_writeoff_net_val BIGNUMERIC(38,5)
OPTIONS(description='net value of partial write off            metric_type_id 103, 104, 131            KFL: kfl-to-ldl_Abschriften_DE_PA.aufschr_vk, kfl-to-ldl_Abschriften_DE_PA.abschr_vk, kfl-to-ldl_Abschriften_KMO_PA.usegvksadn            CORE_REL: t_kfl_metric_gtp_item_day.metric_val'),
ldl_prev_1y_writeoff_net_val BIGNUMERIC(38,5)
OPTIONS(description='net value of write off, Lidl only due to different methodology            metric_type_id 21, 31            KFL: ldl-EK80_MIS_UM_M1201BNL.m1201bnl, ldl-EK80_MIS_UM_M1201BNL1.m1201bnl            CORE_REL: t_ldl_metric_store_item_day.metric_val'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (lob_cd, cal_month, kfl_client_id, kfl_item_nr, curr_cd, kfl_consolidated_promo_item_type_cd) NOT ENFORCED
)
OPTIONS(description='Aggregate fact table on level client, item_1 and month holding all relevant facts from Kaufland and Lidl in the Kaufland context for monthly Apollo reporting for Kaufland             CORE_REL: T_LDL_METRIC_CLIENT_ITEM_DAY_1, T_LDL_METRIC_STORE_ITEM_DAY_1, T_KFL_METRIC_GTP_ITEM_DAY_1');