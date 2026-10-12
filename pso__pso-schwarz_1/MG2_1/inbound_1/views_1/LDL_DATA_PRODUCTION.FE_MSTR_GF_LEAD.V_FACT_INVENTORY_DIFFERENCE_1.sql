create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_FACT_INVENTORY_DIFFERENCE_1(
	COUNTRY_ORG_CD COMMENT 'The code of the business country_1 for which the related country_1 organization is responsible. (The business country_1 is not identical to a political country.)',
	INT_ORG_SID COMMENT 'The unique identifier (surrogate key) for the store or warehouse, where the inventory was done.',
	INT_ORG_TYPE_CD COMMENT 'The code identifying the discriminators for internal organizations',
	CURR_INT_ORG_NR COMMENT 'The number by which the internal organization is currently known to business. (This number may change over time)',
	INT_ORG_NAME COMMENT 'The name of the internal organization.',
	CAL_DT COMMENT 'The date for which the inventory was done.',
	BUS_YEAR COMMENT 'Business year of the inventory',
	CAL_MONTH COMMENT 'Calendar_1 month of the inventory',
	CAL_WEEK COMMENT 'Calendar_1 week of the inventory',
	LAST_DAY_OF_BUS_YEAR_FG COMMENT 'An indicator showing if this is the last day of the containing business year.',
	LAST_DAY_OF_MONTH_FG COMMENT 'An indicator showing if this is the last day of the containing month.',
	LAST_DAY_OF_WEEK_FG COMMENT 'An indicator showing if this is the last day of the containing week.',
	LAST_INV_OF_DAY_FG COMMENT 'An indicator showing if this is the last inventory of the day.',
	CAL_MONTH_PY COMMENT 'Calendar_1 month of the inventory in the previous year',
	CAL_WEEK_PY COMMENT 'Calendar_1 week of the inventory in the previous year',
	INV_PERIOD_START_DT COMMENT 'The inventory period is the business period between last full inventory and the current inventory. This attribute is the start date of this period.',
	INV_PERIOD_END_DT COMMENT 'The inventory period is the business period between last full inventory and the current inventory. This attribute is the end date of this period.',
	INV_TYPE_CD COMMENT 'The code identifying the subtype discriminator for inventories. It distinguishes between full and partial inventories.',
	INV_SID COMMENT 'The unique identifier (surrogate key) for the inventory event.',
	INV_NR COMMENT 'The number which identifies the inventory event in a given country.',
	CURR_CD COMMENT 'The code identifying the currency according to ISO-4217.',
	INV_NET_VAL COMMENT 'The total value of all products which have been counted as part of the inventory process in this internal organization (i.e. store or warehouse) on the inventory date. The value is based on the net sales_1 price that applies to this organization and and on the counted quantity. This measure is not additive across time! It is not necessarily in sync with the sum of the inventory amounts on product level.',
	INV_TURNOVER_NET_VAL COMMENT 'The net turnover amount in the given currency which was generated in this internal organization (i.e. store or warehouse) for the inventory period. This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_1 and returns. (In case the internal organization references a warehouse, this is only that portion of the turnover which was generated directly in the warehouse. Turnover of stores which are managed by this warehouse, are not included.) The inventory period is the time interval between the last full inventory and this inventory. This measure is not necessarily in sync with the sum of the inventory turnover on product level.',
	INV_DIFF_NET_VAL COMMENT 'The net amount of the inventory difference, i.e. the difference between the value of the calculated stock and the counted stock. This measure is not necessarily in sync with the sum of the inventory differences on product level.',
	INV_CNT COMMENT 'Number of inventories for an inventory which serves as an indicator',
	INV_TURNOVER_NET_VAL_SUM_BY COMMENT 'The absolute sum of net turnover amount for the current business year',
	INV_TURNOVER_NET_VAL_SUM_MTH COMMENT 'The absolute sum of net turnover amount for the current month',
	INV_TURNOVER_NET_VAL_SUM_WK COMMENT 'The absolute sum of net turnover amount for the current week',
	INV_DIFF_NET_VAL_SUM_BY COMMENT 'The absolute sum of net inventory difference amount for the current business year',
	INV_DIFF_NET_VAL_SUM_MTH COMMENT 'The absolute sum of net inventory difference amount for the current month',
	INV_DIFF_NET_VAL_SUM_WK COMMENT 'The absolute sum of net inventory difference amount for the current week',
	INV_CNT_SUM_BY COMMENT 'The absolute number of inventories for the current business year',
	INV_CNT_SUM_MTH COMMENT 'The absolute number of inventories for the current month',
	INV_CNT_SUM_WK COMMENT 'The absolute number of inventories for the current week',
	INV_TURNOVER_NET_VAL_CUM_BY COMMENT 'The cumulated sum of net turnover amount for the current business year',
	INV_TURNOVER_NET_VAL_CUM_MTH COMMENT 'The cumulated sum of net turnover amount for the current month',
	INV_TURNOVER_NET_VAL_CUM_WK COMMENT 'The cumulated sum of net turnover amount for the current week',
	INV_TURNOVER_NET_VAL_CUM_INV COMMENT 'The cumulated sum of net turnover amount for the current inventory day',
	INV_DIFF_NET_VAL_CUM_BY COMMENT 'The cumulated sum of net inventory difference amount for the current business year',
	INV_DIFF_NET_VAL_CUM_MTH COMMENT 'The cumulated sum of net inventory difference amount for the current month',
	INV_DIFF_NET_VAL_CUM_WK COMMENT 'The cumulated sum of net inventory difference amount for the current week',
	INV_DIFF_NET_VAL_CUM_INV COMMENT 'The cumulated sum of net turnover amount for the current inventory day',
	INV_CNT_CUM_BY COMMENT 'The cumulated number of inventories for the current business year',
	INV_CNT_CUM_MTH COMMENT 'The cumulated number of inventories for the current month',
	INV_CNT_CUM_WK COMMENT 'The cumulated number of inventories for the current week',
	INV_CNT_CUM_INV COMMENT 'The cumulated number of inventories for the current inventory day',
	INV_TURNOVER_NET_VAL_SUM_MTH_PY COMMENT 'The absolute sum of net turnover amount for the current month of previous business year',
	INV_TURNOVER_NET_VAL_SUM_WK_PY COMMENT 'The absolute sum of net turnover amount for the current week of previous business year',
	INV_DIFF_NET_VAL_SUM_MTH_PY COMMENT 'The absolute sum of net inventory difference amount for the current month of previous business year',
	INV_DIFF_NET_VAL_SUM_WK_PY COMMENT 'The absolute sum of net inventory difference amount for the current week of previous business year',
	INV_CNT_SUM_MTH_PY COMMENT 'The absolute number of inventories for the current month of previous business year',
	INV_CNT_SUM_WK_PY COMMENT 'The absolute number of inventories for the current week of previous business year',
	INV_TURNOVER_NET_VAL_CUM_MTH_PY COMMENT 'The cumulated sum of net turnover amount for the current month of previous business year',
	INV_TURNOVER_NET_VAL_CUM_WK_PY COMMENT 'The cumulated sum of net turnover amount for the current week of previous business year',
	INV_DIFF_NET_VAL_CUM_MTH_PY COMMENT 'The cumulated sum of net inventory difference amount for the current month of previous business year',
	INV_DIFF_NET_VAL_CUM_WK_PY COMMENT 'The cumulated sum of net inventory difference amount for the current week of previous business year',
	INV_CNT_CUM_MTH_PY COMMENT 'The cumulated number of inventories for the current month of previous business year',
	INV_CNT_CUM_WK_PY COMMENT 'The cumulated number of inventories for the current week of previous business year'
) COMMENT='Calculations of all inventory turnovers and inventory differences for all stores (actual values, business year cumulations, year-to-year comparison and variances from plan values).'
 as
SELECT country_org_cd
	, int_org_sid
	, int_org_type_cd
	, curr_int_org_nr
	, int_org_name
	, cal_dt
	, bus_year
	, cal_month
	, cal_week
	, last_day_of_bus_year_fg
	, last_day_of_month_fg
	, last_day_of_week_fg
	, last_inv_of_day_fg
	, cal_month_py
	, cal_week_py
	, inv_period_start_dt
	, inv_period_end_dt
	, inv_type_cd
	, inv_sid
	, inv_nr
	, curr_cd
	, inv_net_val
	, inv_turnover_net_val
	, inv_diff_net_val
	, inv_cnt
	, inv_turnover_net_val_sum_by
	, inv_turnover_net_val_sum_mth
	, inv_turnover_net_val_sum_wk
	, inv_diff_net_val_sum_by
	, inv_diff_net_val_sum_mth
	, inv_diff_net_val_sum_wk
	, inv_cnt_sum_by
	, inv_cnt_sum_mth
	, inv_cnt_sum_wk
	, inv_turnover_net_val_cum_by
	, inv_turnover_net_val_cum_mth
	, inv_turnover_net_val_cum_wk
	, inv_turnover_net_val_cum_inv
	, inv_diff_net_val_cum_by
	, inv_diff_net_val_cum_mth
	, inv_diff_net_val_cum_wk
	, inv_diff_net_val_cum_inv
	, inv_cnt_cum_by
	, inv_cnt_cum_mth
	, inv_cnt_cum_wk
	, inv_cnt_cum_inv
	, inv_turnover_net_val_sum_mth_py
	, inv_turnover_net_val_sum_wk_py
	, inv_diff_net_val_sum_mth_py
	, inv_diff_net_val_sum_wk_py
	, inv_cnt_sum_mth_py
	, inv_cnt_sum_wk_py
	, inv_turnover_net_val_cum_mth_py
	, inv_turnover_net_val_cum_wk_py
	, inv_diff_net_val_cum_mth_py
	, inv_diff_net_val_cum_wk_py
	, inv_cnt_cum_mth_py
	, inv_cnt_cum_wk_py
FROM core_dim.v_fact_inventory_difference_1 -- PK: inv_sid 
;