/* --------------------------------------------------------------------------------
   DDL for table: t_fact_kfl_client_item_day_2
   generated from Powerdesigner on Montag, 30. September 2024 16:55:04
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_fact_kfl_client_item_day_2 (
lob_cd STRING(100) NOT NULL
OPTIONS(description='line of business depends on the general source of the data, "KFL" if the data is taken from the Kaufland DWH, "LDL" if the data is taken from a Lidl DWH'),
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant_2) in the extract from the Kaufland DWH'),
kfl_item_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL item_2 (Artikel_2) in the extract from the Kaufland DWH'),
cal_dt DATE NOT NULL OPTIONS(description='calendar_2 date of the fact in the extract from Kaufland DWH / Lidl retail DWH'),
curr_cd STRING(3) NOT NULL
OPTIONS(description='currency code for reporting, so far only EUR is reported, currency conversion has been done using exchange rates from Kaufland DWH if the source data has been extracted in other currencies.            Manually filled : "EUR"'),
kfl_consolidated_promo_item_type_cd STRING(100) NOT NULL
OPTIONS(description='This attribute consolidates the content of the kfl_item_list_type_cd into a generalized information about whether an item_2 should be regarded as promotion item_2 or not.            "PN" - item_2 is a promotion item_2            "SO" - item_2 is not a promotion item_2'),
kfl_adv_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the Kaufland advertising week            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.KJWO_WW            CORE_REL: t_kfl_client_day_advertise_week.kfl_adv_week'),
kfl_rcv_qty BIGNUMERIC(38,5)
OPTIONS(description='receive quantity (Wareneingangsmenge)            metric_type_id 231,241,251,261, 71            KFL: kfl-to-ldl_WE_Menge.menge, kfl-to-ldl_WE_Menge_DE.menge, kfl-to-ldl_WE_Menge_DE_IC.menge, kfl-to-ldl_WE_Menge_IC.menge            LDL: x-kpi: EK80_MIS_WE.m1105we            CORE_REL: t_kfl_metric_gtp_item_day_2, t_ldl_metric_client_item_day.metric_qty'),
ldl_buying_rcv_net_val BIGNUMERIC(38,5)
OPTIONS(description='value of receive quantity using net purchasing prices            metric_type_id 72            LDL: x-kpi: EK80_MIS_WE.weeknettowert            CORE_REL: t_ldl_metric_client_item_day.metric_val'),
ldl_retail_rcv_net_val BIGNUMERIC(38,5)
OPTIONS(description='value of receive quantity using net sales_2 prices            metric_type_id 73            LDL: x-kpi: EK80_MIS_WE.wevknettowertinklsonderkond            CORE_REL: t_ldl_metric_client_item_day.metric_val'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (lob_cd, kfl_client_id, kfl_item_nr, cal_dt, curr_cd) NOT ENFORCED
)
OPTIONS(description='Aggregate fact table on level client, item_2 and day holding all relevant facts from Kaufland and Lidl in the Kaufland context for day by day Apollo reporting for Kaufland             CORE_REL: T_LDL_METRIC_CLIENT_ITEM_DAY_2');