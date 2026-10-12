CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_fact_inventory_difference_1 (country_org_cd
OPTIONS(description='The code of the business country_1 for which the related country_1 organization is responsible. (The business country_1 is not identical to a political country.)'),
int_org_sid
OPTIONS(description='The unique identifier (surrogate key) for the store or warehouse, where the inventory was done.'),
int_org_type_cd OPTIONS(description='The code identifying the discriminators for internal organizations'),
curr_int_org_nr
OPTIONS(description='The number by which the internal organization is currently known to business. (This number may change over time)'),
int_org_name OPTIONS(description='The name of the internal organization.'), cal_dt
OPTIONS(description='The date for which the inventory was done.'), bus_year
OPTIONS(description='Business year of the inventory'), cal_month OPTIONS(description='Calendar_1 month of the inventory'),
cal_week OPTIONS(description='Calendar_1 week of the inventory'), last_day_of_bus_year_fg
OPTIONS(description='An indicator showing if this is the last day of the containing business year.'),
last_day_of_month_fg OPTIONS(description='An indicator showing if this is the last day of the containing month.'),
last_day_of_week_fg OPTIONS(description='An indicator showing if this is the last day of the containing week.'),
last_inv_of_day_fg OPTIONS(description='An indicator showing if this is the last inventory of the day.'), cal_month_py
OPTIONS(description='Calendar_1 month of the inventory in the previous year'), cal_week_py
OPTIONS(description='Calendar_1 week of the inventory in the previous year'), inv_period_start_dt
OPTIONS(description='The inventory period is the business period between last full inventory and the current inventory. This attribute is the start date of this period.'),
inv_period_end_dt
OPTIONS(description='The inventory period is the business period between last full inventory and the current inventory. This attribute is the end date of this period.'),
inv_type_cd
OPTIONS(description='The code identifying the subtype discriminator for inventories. It distinguishes between full and partial inventories.'),
inv_sid OPTIONS(description='The unique identifier (surrogate key) for the inventory event.'), inv_nr
OPTIONS(description='The number which identifies the inventory event in a given country.'), curr_cd
OPTIONS(description='The code identifying the currency according to ISO-4217.'), inv_net_val
OPTIONS(description='The total value of all products which have been counted as part of the inventory process in this internal organization (i.e. store or warehouse) on the inventory date. The value is based on the net sales_1 price that applies to this organization and and on the counted quantity. This measure is not additive across time! It is not necessarily in sync with the sum of the inventory amounts on product level.'),
inv_turnover_net_val
OPTIONS(description='The net turnover amount in the given currency which was generated in this internal organization (i.e. store or warehouse) for the inventory period. This is the consolidated amount after applying the priority logic. The turnover is the difference of sales_1 and returns. (In case the internal organization references a warehouse, this is only that portion of the turnover which was generated directly in the warehouse. Turnover of stores which are managed by this warehouse, are not included.) The inventory period is the time interval between the last full inventory and this inventory. This measure is not necessarily in sync with the sum of the inventory turnover on product level.'),
inv_diff_net_val
OPTIONS(description='The net amount of the inventory difference, i.e. the difference between the value of the calculated stock and the counted stock. This measure is not necessarily in sync with the sum of the inventory differences on product level.'),
inv_cnt OPTIONS(description='Number of inventories for an inventory which serves as an indicator'),
inv_turnover_net_val_sum_by OPTIONS(description='The absolute sum of net turnover amount for the current business year'),
inv_turnover_net_val_sum_mth OPTIONS(description='The absolute sum of net turnover amount for the current month'),
inv_turnover_net_val_sum_wk OPTIONS(description='The absolute sum of net turnover amount for the current week'),
inv_diff_net_val_sum_by
OPTIONS(description='The absolute sum of net inventory difference amount for the current business year'),
inv_diff_net_val_sum_mth
OPTIONS(description='The absolute sum of net inventory difference amount for the current month'),
inv_diff_net_val_sum_wk OPTIONS(description='The absolute sum of net inventory difference amount for the current week'),
inv_cnt_sum_by OPTIONS(description='The absolute number of inventories for the current business year'), inv_cnt_sum_mth
OPTIONS(description='The absolute number of inventories for the current month'), inv_cnt_sum_wk
OPTIONS(description='The absolute number of inventories for the current week'), inv_turnover_net_val_cum_by
OPTIONS(description='The cumulated sum of net turnover amount for the current business year'),
inv_turnover_net_val_cum_mth OPTIONS(description='The cumulated sum of net turnover amount for the current month'),
inv_turnover_net_val_cum_wk OPTIONS(description='The cumulated sum of net turnover amount for the current week'),
inv_turnover_net_val_cum_inv
OPTIONS(description='The cumulated sum of net turnover amount for the current inventory day'), inv_diff_net_val_cum_by
OPTIONS(description='The cumulated sum of net inventory difference amount for the current business year'),
inv_diff_net_val_cum_mth
OPTIONS(description='The cumulated sum of net inventory difference amount for the current month'),
inv_diff_net_val_cum_wk OPTIONS(description='The cumulated sum of net inventory difference amount for the current week'),
inv_diff_net_val_cum_inv OPTIONS(description='The cumulated sum of net turnover amount for the current inventory day'),
inv_cnt_cum_by OPTIONS(description='The cumulated number of inventories for the current business year'), inv_cnt_cum_mth
OPTIONS(description='The cumulated number of inventories for the current month'), inv_cnt_cum_wk
OPTIONS(description='The cumulated number of inventories for the current week'), inv_cnt_cum_inv
OPTIONS(description='The cumulated number of inventories for the current inventory day'),
inv_turnover_net_val_sum_mth_py
OPTIONS(description='The absolute sum of net turnover amount for the current month of previous business year'),
inv_turnover_net_val_sum_wk_py
OPTIONS(description='The absolute sum of net turnover amount for the current week of previous business year'),
inv_diff_net_val_sum_mth_py
OPTIONS(description='The absolute sum of net inventory difference amount for the current month of previous business year'),
inv_diff_net_val_sum_wk_py
OPTIONS(description='The absolute sum of net inventory difference amount for the current week of previous business year'),
inv_cnt_sum_mth_py
OPTIONS(description='The absolute number of inventories for the current month of previous business year'),
inv_cnt_sum_wk_py
OPTIONS(description='The absolute number of inventories for the current week of previous business year'),
inv_turnover_net_val_cum_mth_py
OPTIONS(description='The cumulated sum of net turnover amount for the current month of previous business year'),
inv_turnover_net_val_cum_wk_py
OPTIONS(description='The cumulated sum of net turnover amount for the current week of previous business year'),
inv_diff_net_val_cum_mth_py
OPTIONS(description='The cumulated sum of net inventory difference amount for the current month of previous business year'),
inv_diff_net_val_cum_wk_py
OPTIONS(description='The cumulated sum of net inventory difference amount for the current week of previous business year'),
inv_cnt_cum_mth_py
OPTIONS(description='The cumulated number of inventories for the current month of previous business year'),
inv_cnt_cum_wk_py
OPTIONS(description='The cumulated number of inventories for the current week of previous business year'))
OPTIONS(DESCRIPTION = `CALCULATIONS OF ALL INVENTORY TURNOVERS AND INVENTORY DIFFERENCES FOR ALL STORES (ACTUAL VALUES, BUSINESS YEAR CUMULATIONS, YEAR-TO-YEAR COMPARISON AND VARIANCES FROM PLAN VALUES).`)
AS -- PK: inv_sid
 SELECT country_org_cd,
 int_org_sid,
 int_org_type_cd,
 curr_int_org_nr,
 int_org_name,
 cal_dt,
 bus_year,
 cal_month,
 cal_week,
 last_day_of_bus_year_fg,
 last_day_of_month_fg,
 last_day_of_week_fg,
 last_inv_of_day_fg,
 cal_month_py,
 cal_week_py,
 inv_period_start_dt,
 inv_period_end_dt,
 inv_type_cd,
 inv_sid,
 inv_nr,
 curr_cd,
 inv_net_val,
 inv_turnover_net_val,
 inv_diff_net_val,
 inv_cnt,
 inv_turnover_net_val_sum_by,
 inv_turnover_net_val_sum_mth,
 inv_turnover_net_val_sum_wk,
 inv_diff_net_val_sum_by,
 inv_diff_net_val_sum_mth,
 inv_diff_net_val_sum_wk,
 inv_cnt_sum_by,
 inv_cnt_sum_mth,
 inv_cnt_sum_wk,
 inv_turnover_net_val_cum_by,
 inv_turnover_net_val_cum_mth,
 inv_turnover_net_val_cum_wk,
 inv_turnover_net_val_cum_inv,
 inv_diff_net_val_cum_by,
 inv_diff_net_val_cum_mth,
 inv_diff_net_val_cum_wk,
 inv_diff_net_val_cum_inv,
 inv_cnt_cum_by,
 inv_cnt_cum_mth,
 inv_cnt_cum_wk,
 inv_cnt_cum_inv,
 inv_turnover_net_val_sum_mth_py,
 inv_turnover_net_val_sum_wk_py,
 inv_diff_net_val_sum_mth_py,
 inv_diff_net_val_sum_wk_py,
 inv_cnt_sum_mth_py,
 inv_cnt_sum_wk_py,
 inv_turnover_net_val_cum_mth_py,
 inv_turnover_net_val_cum_wk_py,
 inv_diff_net_val_cum_mth_py,
 inv_diff_net_val_cum_wk_py,
 inv_cnt_cum_mth_py,
 inv_cnt_cum_wk_py
FROM ldl_data_production_core_dim.v_fact_inventory_difference_1;