/* 
This view is for the presentation in Frontend.
*/
CREATE OR REPLACE VIEW fe_mstr_gf_lead.v_fact_inventory_difference_2 (
	country_org_cd COMMENT 'The code of the business country_2 for which the related country_2 organization is responsible. (The business country_2 is not identical to a political country.)',
	int_org_sid COMMENT 'The unique identifier (surrogate key) for the store or warehouse, where the inventory was done.',
	int_org_type_cd COMMENT 'The code identifying the discriminators for internal organizations',
	curr_int_org_nr COMMENT 'The number by which the internal organization is currently known to business. (This number may change over time)',
	int_org_name COMMENT 'The name of the internal organization.',
	cal_dt COMMENT 'The date for which the inventory was done.',
	bus_year COMMENT 'Business year of the inventory',
	cal_month COMMENT 'Calendar_2 month of the inventory',
	cal_week COMMENT 'Calendar_2 week of the inventory',
	last_day_of_bus_year_fg  COMMENT 'An indicator showing if this is the last day of the containing business year.',
	last_day_of_month_fg COMMENT 'An indicator showing if this is the last day of the containing month.',
	last_day_of_week_fg COMMENT 'An indicator showing if this is the last day of the containing week.',
	last_inv_of_day_fg  COMMENT 'An indicator showing if this is the last inventory of the day.',
	cal_month_py COMMENT 'Calendar_2 month of the inventory in the previous year',
	cal_week_py COMMENT 'Calendar_2 week of the inventory in the previous year',
	inv_period_start_dt COMMENT 'The inventory period is the business period between last full inventory and the current inventory. This attribute is the start date of this period.',
	inv_period_end_dt COMMENT 'The inventory period is the business period between last full inventory and the current inventory. This attribute is the end date of this period.',
	inv_type_cd COMMENT 'The code identifying the subtype discriminator for inventories. It distinguishes between full and partial inventories.',
	inv_sid COMMENT 'The unique identifier (surrogate key) for the inventory event.',
	inv_nr COMMENT 'The number which identifies the inventory event in a given country.', 
	curr_cd COMMENT 'The code identifying the currency according to ISO-4217.',
	inv_net_val COMMENT 'The total value of all products which have been counted as part of the inventory process in this internal organization (i.e. store or warehouse) on the inventory date. The value is based on the net sales_2 price that applies to this organization and and on the counted quantity. This measure is not additive across time! It is not necessarily in sync with the sum of the inventory amounts on product level.',
	inv_turnover_net_val COMMENT 'The net turnover amount in the given currency which was generated in this internal organization (i.e. store or warehouse) for the inventory period. This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_2 and returns. (In case the internal organization references a warehouse, this is only that portion of the turnover which was generated directly in the warehouse. Turnover of stores which are managed by this warehouse, are not included.) The inventory period is the time interval between the last full inventory and this inventory. This measure is not necessarily in sync with the sum of the inventory turnover on product level.',
	inv_diff_net_val COMMENT 'The net amount of the inventory difference, i.e. the difference between the value of the calculated stock and the counted stock. This measure is not necessarily in sync with the sum of the inventory differences on product level.',
	inv_cnt COMMENT 'Number of inventories for an inventory which serves as an indicator',
	inv_turnover_net_val_sum_by COMMENT 'The absolute sum of net turnover amount for the current business year',
	inv_turnover_net_val_sum_mth COMMENT 'The absolute sum of net turnover amount for the current month',
	inv_turnover_net_val_sum_wk COMMENT 'The absolute sum of net turnover amount for the current week',
	inv_diff_net_val_sum_by COMMENT 'The absolute sum of net inventory difference amount for the current business year', 
	inv_diff_net_val_sum_mth COMMENT 'The absolute sum of net inventory difference amount for the current month', 
	inv_diff_net_val_sum_wk COMMENT 'The absolute sum of net inventory difference amount for the current week', 
	inv_cnt_sum_by COMMENT 'The absolute number of inventories for the current business year',
	inv_cnt_sum_mth COMMENT 'The absolute number of inventories for the current month',
	inv_cnt_sum_wk COMMENT 'The absolute number of inventories for the current week',
	inv_turnover_net_val_cum_by COMMENT 'The cumulated sum of net turnover amount for the current business year',
	inv_turnover_net_val_cum_mth COMMENT 'The cumulated sum of net turnover amount for the current month',
	inv_turnover_net_val_cum_wk COMMENT 'The cumulated sum of net turnover amount for the current week',
	inv_turnover_net_val_cum_inv COMMENT 'The cumulated sum of net turnover amount for the current inventory day',
	inv_diff_net_val_cum_by COMMENT 'The cumulated sum of net inventory difference amount for the current business year', 
	inv_diff_net_val_cum_mth COMMENT 'The cumulated sum of net inventory difference amount for the current month', 
	inv_diff_net_val_cum_wk COMMENT 'The cumulated sum of net inventory difference amount for the current week', 
	inv_diff_net_val_cum_inv COMMENT 'The cumulated sum of net turnover amount for the current inventory day',
	inv_cnt_cum_by COMMENT 'The cumulated number of inventories for the current business year', 
	inv_cnt_cum_mth COMMENT 'The cumulated number of inventories for the current month', 
	inv_cnt_cum_wk COMMENT 'The cumulated number of inventories for the current week', 
	inv_cnt_cum_inv COMMENT 'The cumulated number of inventories for the current inventory day',
	inv_turnover_net_val_sum_mth_py COMMENT 'The absolute sum of net turnover amount for the current month of previous business year',
	inv_turnover_net_val_sum_wk_py COMMENT 'The absolute sum of net turnover amount for the current week of previous business year',
	inv_diff_net_val_sum_mth_py COMMENT 'The absolute sum of net inventory difference amount for the current month of previous business year',
	inv_diff_net_val_sum_wk_py COMMENT 'The absolute sum of net inventory difference amount for the current week of previous business year',
	inv_cnt_sum_mth_py COMMENT 'The absolute number of inventories for the current month of previous business year',
	inv_cnt_sum_wk_py COMMENT 'The absolute number of inventories for the current week of previous business year',
	inv_turnover_net_val_cum_mth_py COMMENT 'The cumulated sum of net turnover amount for the current month of previous business year',
	inv_turnover_net_val_cum_wk_py COMMENT 'The cumulated sum of net turnover amount for the current week of previous business year',
	inv_diff_net_val_cum_mth_py COMMENT 'The cumulated sum of net inventory difference amount for the current month of previous business year',
	inv_diff_net_val_cum_wk_py COMMENT 'The cumulated sum of net inventory difference amount for the current week of previous business year',
	inv_cnt_cum_mth_py COMMENT 'The cumulated number of inventories for the current month of previous business year',
	inv_cnt_cum_wk_py COMMENT 'The cumulated number of inventories for the current week of previous business year'
	) COMMENT= 'Calculations of all inventory turnovers and inventory differences for all stores (actual values, business year cumulations, year-to-year comparison and variances from plan values).'
AS
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
FROM core_dim.v_fact_inventory_difference_2 -- PK: inv_sid 
;