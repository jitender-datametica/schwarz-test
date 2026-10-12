/* --------------------------------------------------------------------------------
   DDL for table: t_fact_ldl_client_lob_international_item_month
   generated from Powerdesigner on Dienstag, 13. Mai 2025 10:31:24
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_fact_ldl_client_lob_international_item_month (
ldl_client_id BIGNUMERIC(38,0) NOT NULL,
lob_cd STRING(100) NOT NULL
OPTIONS(description='Line of business depends on the general source of the data, "KFL" if the data is taken from the Kaufland DWH, "LDL" if the data is taken from a Lidl DWH.'),
ldl_item_ian_nr BIGNUMERIC(38,0) NOT NULL,
cal_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the calendar month.            LDL: P_LEW_MART_MSI_AC.V_CAL_MONTH_DESC.CY_MONTH            CORE_REL: T_LDL_CALENDAR_MONTH.CAL_MONTH.CAL_MONTH'),
cal_year BIGNUMERIC(38,0)
OPTIONS(description='Identifier of the calendar year.            LDL: P_LEW_MART_MSI_AV.V_CAL_MONTH_DESC.CY_MONTH            CORE_REL: T_LDL_CALENDAR_MONTH.CAL_MONTH'),
curr_cd STRING(3) NOT NULL
OPTIONS(description='Currency code used by Lidl.            CORE_REL: T_LDL_CURRENCY.CURR_CD            LDL: P_LEW_CORE.T_CURRENCY.CURR_ISO_CD'),
kfl_consolidated_promo_item_type_cd STRING(100) NOT NULL
OPTIONS(description='This attribute consolidates the content of the KFL_ITEM_LIST_TYPE_CD into a generalized information about whether an item should be regarded as a promotion item or not.            "PN" = item is a promotion item            "SO" = item is not a promotion item            "no typification" = item is not receiving a type (for LDL, only KFL items get a type)'),
ldl_writeoff_net_val BIGNUMERIC(38,5),
kfl_total_writeoff_net_val BIGNUMERIC(38,5),
kfl_part_writeoff_net_val BIGNUMERIC(38,5),
kfl_buying_sales_net_val BIGNUMERIC(38,5),
ldl_adjust_sales_net_val BIGNUMERIC(38,5),
ldl_adjust_sales_qty BIGNUMERIC(38,5),
ldl_return_net_val BIGNUMERIC(38,5),
ldl_return_qty BIGNUMERIC(38,5),
ldl_pch_net_val BIGNUMERIC(38,5),
kfl_pch_net_val BIGNUMERIC(38,5),
ldl_rcv_qty BIGNUMERIC(38,5),
ldl_buying_rcv_net_val BIGNUMERIC(38,5),
ldl_retail_rcv_net_val BIGNUMERIC(38,5),
ldl_prev_1y_writeoff_net_val BIGNUMERIC(38,5),
kfl_prev_1y_total_writeoff_net_val BIGNUMERIC(38,5),
kfl_prev_1y_part_writeoff_net_val BIGNUMERIC(38,5),
kfl_prev_1y_buying_sales_net_val BIGNUMERIC(38,5),
ldl_prev_1y_adjust_sales_net_val BIGNUMERIC(38,5),
ldl_prev_1y_adjust_sales_qty BIGNUMERIC(38,5),
ldl_prev_1y_return_net_val BIGNUMERIC(38,5),
ldl_prev_1y_return_qty BIGNUMERIC(38,5),
ldl_prev_1y_pch_net_val BIGNUMERIC(38,5),
kfl_prev_1y_pch_net_val BIGNUMERIC(38,5),
ldl_prev_1y_rcv_qty BIGNUMERIC(38,5),
ldl_prev_1y_buying_rcv_net_val BIGNUMERIC(38,5),
ldl_prev_1y_retail_rcv_net_val BIGNUMERIC(38,5),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (ldl_client_id, lob_cd, ldl_item_ian_nr, cal_month, curr_cd, kfl_consolidated_promo_item_type_cd)
NOT ENFORCED
) OPTIONS(description='Comment 2Do');