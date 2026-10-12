/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for AGG_REGION_ADV_WEEK_NAN
#-------------------------------------------------------------------------------
# Description: DDL for frontend MSTR Aggregate Table at the NAN (orig_item_nr) level
#              aggregated on Country_2 / Region_2 (WH), AdvWeek, ActionType. Information included for UWG, WGI.
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-09   Mike Davis     Initial version
#                                   Keeps defaults, virtuals and nullability (for reference).
#  1.1  2021-08-13   Mike Davis     Checks, AKU-Formatting
#                                   Defaults, virtuals and nullability removed where
#                                   this is specified at a lower (previous) level.
#                                   Nullability kept for PRIMARY KEY.
#  1.2  2021-09-13 Massimo Morelli  Fixed SCHEMA
#  1.3  2022-01-24 Andreas Kurz     Reworked the structure after DM review
#  1.4  2022-06-02 Prasanna Ranjan	Replaced CURRENT_ADV_WEEK_FG
#  2.0	2022-07-12 Nikolai Toknov  Changing the script for DevOps
#  2.1	2022-07-22 Andreas Kurz		Added _GID columns for MSTR As-Was CROSS JOIN
#  3.1  2023-06-28 Nikolai Toknov	Fix issue with DAT_VALID_FROM from the main branch
#  3.2  2023-07-26 Nikolai Toknov	Remove NOT NULL for an improvement in the definition of REJECT_FG
#  4.0  2024-02-13 Prasanna Ranjan	Added new columns for PIT Increment 2 (PV)
#  4.1  2024-03-25 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#  4.2  2024-03-25 Nikolai Toknov   add PV_LP_NET_VAL, PV_LP_NET_VAL_SHARE_PCT, PV_PD_NET_VAL, PV_PD_NET_VAL_SHARE_PCT, PV_WAWI_NET_VAL, PV_WAWI_NET_VAL_SHARE_PCT
#  4.3  2024-09-24 Prasanna Ranjan	Adjustment Increment 2.1 (PV)
#  4.4 	2025-02-12 Andreas Kurz		Removing PV_TYPE_ID Column
#  4.5  2025-06-26 Andreas Kurz		Added 3 columns for weighted Avg VK_2 Alt / Neu und Billiger in PCT
#-------------------------------------------------------------------------------
*/


-- Fakten / Measures / KPIs

-- PV_TYPE_ID								NUMBER(38,0)																COMMENT 'Type of PV (List of PV Types: Wawi PV ::= 1 | LP ::= 2 | NPPS ::= 3 | -1 ::= N/A | -2 ::= Total PV)'

-- Technical fields
 -- WGI
 -- UWG
 -- GID
 -- GID
 CREATE TABLE IF NOT EXISTS ldl_p_lew_fe_mstr_pit.t_agg_region_adv_week_nan_2
(
client_id INTEGER NOT NULL OPTIONS(description='Client id'),
country_iso_cd STRING(3) OPTIONS(description='Country_2 ISO Code = WAWI Country_2 '),
country_descr STRING(16777216) OPTIONS(description='Country_2 Name'),
warehouse_sid INTEGER NOT NULL OPTIONS(description='Warehouse Surrogate ID'),
warehouse_mstr_sid INTEGER OPTIONS(description='Warehouse Surrogate ID'),
warehouse_gid INTEGER DEFAULT - 1000 OPTIONS(description='Warehouse Surrogate GID - As-Was CROSS JOIN key for Frontend'),
warehouse_mstr_gid INTEGER OPTIONS(description='Technical Field: MSTR GID'),
warehouse_name STRING(16777216) OPTIONS(description='Warehouse Name'),
orig_wh_nr INTEGER OPTIONS(description='Original Warehouse Number  / code from Wawi'),
adv_week_id INTEGER NOT NULL OPTIONS(description='Advertising week BK'),
adv_week_mstr_id INTEGER
OPTIONS(description='Advertising week MSTR Key (AdvWeek No. concatenated with 2-digit client ID)'),
adv_week_start_dt DATE OPTIONS(description='Start Date of Adv-Week'),
adv_week_end_dt DATE OPTIONS(description='End Date of Adv.-Week'),
adv_week_start_dt_descr STRING(16777216)
OPTIONS(description='Start Date of the Adv. Week in German format for the frontend'),
adv_week_end_dt_descr STRING(16777216)
OPTIONS(description='End Date of the Adv. Week in German format for the frontend'),
adv_week_start_day_sdescr STRING(16777216)
OPTIONS(description='German short description of the week day, when this adv week starts'),
adv_week_end_day_sdescr STRING(16777216)
OPTIONS(description='German short description of the week day, when this adv week ends'),
adv_week_start_day_descr STRING(16777216)
OPTIONS(description='German description of the week day, when this adv week starts'),
adv_week_end_day_descr STRING(16777216)
OPTIONS(description='German description of the week day, when this adv week ends'),
length_of_adv_week INTEGER OPTIONS(description='[Optional]: Number of Days in Adv. Week'),
adv_week_year_id INTEGER OPTIONS(description='Year ID of the Adv.-Week. 202137 -> 2021. Needed for Reporting'),
adv_week_week_nr INTEGER OPTIONS(description='Adv.Week Week Nbr. E.g. 202137 -> 37. Needed for Reporting'),
adv_week_sdescr STRING(16777216) OPTIONS(description='Adv. Week Short Description'),
adv_week_descr STRING(16777216) OPTIONS(description='Adv.Week Description'),
adv_week_ldescr STRING(16777216) OPTIONS(description='Adv. Week Long Description incl. dates'),
adv_week_overlap_ldescr STRING(16777216)
OPTIONS(description='Adv.Week Long Description incl. dates and the maximum date of the OVERlapping range into the next adv week'),
prev_1_adv_week_id INTEGER OPTIONS(description='Previous 1 Adv.Week ID e.g. 202124 -> 202123'),
next_1_adv_week_id INTEGER OPTIONS(description='Next 1 Adv.Week ID e.g. 202124 -> 202125'),
prev_1_year_adv_week_id INTEGER OPTIONS(description='Previous 1 Year Adv.Week ID e.g. 202124 -> 202024'),
last_adv_week_fg INTEGER DEFAULT 0 OPTIONS(description='[View] Flag / indicator last Adv.Week = 1'),
last_closed_adv_week_fg INTEGER DEFAULT 0 OPTIONS(description='[View] Flag / indicator last closed Adv.Week = 1'),
mov_adv_week_start_from_current INTEGER
OPTIONS(description='[View]: Current Adv.-Week is ::0 , pervious Adv.-Week is -1 Next Adv. Week is +1'),
max_adv_period_end_dt DATE
OPTIONS(description='[View] maximum assigned Adv. Period End Date, in case of OVERlapping period. Needed for Reporting Information Window.'),
reporting_line_sid INTEGER NOT NULL
OPTIONS(description='Hierarchy_2 level number to identify the individual reporting line (row) of e.g. a precalculated summary line.'),
reporting_line_descr STRING(16777216) OPTIONS(description='Description of the Reporting Line'),
orig_item_gid INTEGER DEFAULT - 1000
OPTIONS(description='NAN orig Item_2 number Surrogate GID - As-Was CROSS JOIN key for Frontend'),
orig_item_mstr_gid INTEGER OPTIONS(description='Technical Field: MSTR GID'),
orig_item_nr INTEGER NOT NULL OPTIONS(description='Item_2 business identifier. NaN := National Article Number'),
orig_item_mstr_nr INTEGER
OPTIONS(description='Item_2 business identifier. (NaN := National Article Number) MSTR Key: Special MSTR CROSS JOIN criteria to have surrogate ORIG_ITEM_NR + CLIENT_ID'),
dat_valid_from DATE DEFAULT DATE '8888-12-31' OPTIONS(description='Original Item_2 Source DATE from.'),
item_name STRING(16777216) OPTIONS(description='(short) item_2 name in local LANGUAGE'),
item_descr STRING(16777216) OPTIONS(description='(long) item_2 description in local LANGUAGE'),
item_int_descr STRING(16777216)
OPTIONS(description='(long) item_2 description in international LANGUAGE of centre (Deutsch)'),
item_fam_grp_sid INTEGER OPTIONS(description='Sid for item_2 family group.'),
item_fam_grp_src_id INTEGER OPTIONS(description='ID for family group from source system.'),
item_fam_grp_src_cd STRING(16777216) OPTIONS(description='Wawi Code for Article family group'),
item_fam_grp_name STRING(16777216) OPTIONS(description='Family group name.'),
item_fam_grp_descr STRING(16777216) OPTIONS(description='Family group description (local).'),
item_fam_grp_int_descr STRING(16777216) OPTIONS(description='Family group description (international).'),
sub_item_grp_gid INTEGER DEFAULT - 1000
OPTIONS(description='UWG orig Item_2 number Surrogate GID - As-Was CROSS JOIN key for Frontend'),
sub_item_grp_mstr_gid INTEGER OPTIONS(description='Technical Field: MSTR GID'),
sub_item_grp_sid INTEGER OPTIONS(description='Sid for item_2 sub group. UWG'),
sub_item_grp_mstr_sid INTEGER OPTIONS(description='Sub Item_2 Group SID (MSTR formatted) '),
sub_item_grp_src_cd STRING(16777216) OPTIONS(description='Item_2 sub group Wawi Source Code'),
sub_item_grp_name STRING(16777216) OPTIONS(description='Item_2 sub group name.'),
sub_item_grp_descr STRING(16777216) OPTIONS(description='Item_2 sub group description (local).'),
sub_item_grp_int_descr STRING(16777216) OPTIONS(description='Item_2 sub group description (international).'),
item_grp_int_gid INTEGER DEFAULT - 1000
OPTIONS(description='UWG orig Item_2 number Surrogate GID - As-Was CROSS JOIN key for Frontend'),
item_grp_int_mstr_gid INTEGER OPTIONS(description='Technical Field: MSTR GID'),
item_grp_int_sid INTEGER OPTIONS(description='Sid for item_2 international group. WGI'),
item_grp_int_mstr_sid INTEGER OPTIONS(description='SID for item_2 group international (WGI) (MSTR formatted) '),
item_grp_int_src_cd STRING(16777216) OPTIONS(description='Code for international group from source system.'),
item_grp_int_name STRING(16777216) OPTIONS(description='International group name.'),
item_grp_int_descr STRING(16777216) OPTIONS(description='International group description (local).'),
item_grp_int_int_descr STRING(16777216) OPTIONS(description='International group description (international).'),
brand_sid INTEGER OPTIONS(description='Sid for brand_2 of item.'),
brand_name STRING(16777216) OPTIONS(description='Brand_2 name.'),
brand_type_cd STRING(16777216) OPTIONS(description='Brand_2 type.'),
buying_list_type_id INTEGER OPTIONS(description='ID for buying list type. Only on Country_2 Level – no regionalization.'),
buying_list_type_descr STRING(16777216) OPTIONS(description='Buying list type description (local).'),
buying_list_type_int_descr STRING(16777216) OPTIONS(description='Buying list type description (international).'),
supplier_list_descr STRING(16777216)
OPTIONS(description='Future use: Comma separated list of suppliers / Vendors of this article. Descriptive Information only.'),
action_type_id INTEGER NOT NULL
OPTIONS(description='Action type id. -2 = Reporting Line Total, -1 = Undefined/No Action, 1 = PV, 2 = NF, 3 = FA respectively. '),
action_type_sort_val INTEGER OPTIONS(description='Sort information for reporting purposes.'),
action_type_name STRING(16777216) OPTIONS(description='(short) name in local LANGUAGE'),
action_type_descr STRING(16777216) OPTIONS(description='(long)  description in local LANGUAGE (may be unavailable)'),
sort_order_val STRING(16777216) OPTIONS(description='Default sorting order for the report'),
add_receipt_cnt BIGNUMERIC(38,0)
OPTIONS(description='Additional number of receipts, caused by the advertised PV item. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_receipt_per_store_cnt BIGNUMERIC(38,0)
OPTIONS(description='Additional number of receipts, caused by the advertised PV item_2 per store. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Additional TurnOVER, caused by the advertised PV item. Calculated by turnOVER of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_turnover_net_per_store_val BIGNUMERIC(38,5)
OPTIONS(description='Additional TurnOVER, caused by the advertised PV item_2, per store. Calculated by turnOVER of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_turnover_qty BIGNUMERIC(38,0)
OPTIONS(description='Additional turnover qantity, caused by the advertised PV item. Calculated by number of soled item_2 qty of current week, minus ist baseline value from the last 6 weeks. Only PV.'),
add_turnover_per_store_qty BIGNUMERIC(38,0)
OPTIONS(description='Additional turnover qantity, caused by the advertised PV item_2 per store. Calculated by number of soled item_2 qty of current week, minus ist baseline value from the last 6 weeks. Only PV.'),
add_turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='Additional Revenue, caused by the advertised PV item. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_turnover_revenue_net_per_store_val BIGNUMERIC(38,5)
OPTIONS(description='Additional Revenue, caused by the advertised PV item_2 per store. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
adv_item_cnt BIGNUMERIC(38,0)
OPTIONS(description='Number of action items that have been sold in any action_type (PV / NF / FA) during an advertising period.'),
adv_item_per_receipt_cnt BIGNUMERIC(38,5)
OPTIONS(description='Average number (pieces) of the advertised item_2 per receipt, which contains this item_2, during the advertising period.'),
adv_receipt_adv_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Total action net turnOVER (only the advertised items), of receipts that contain the specific advertised item_2, for the specific timeframe (advertising period / advertising week), in local currency. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive.'),
adv_receipt_np_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Normal price net turnOVER of receipts: Sum of the net turnOVER of all other non-advertised items of receipts containing the advertised item_2, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnOVER of all advertised items (including the specific advertised item_2) is excluded. See descriptions of the detailed formula components.'),
adv_receipt_total_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Total net turnOVER of receipts (promotion, non-promotion items), that contain the specific advertised item_2, for the specific timeframe (advertising period / advertising week), in local currency. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive.'),
base_receipt_cnt BIGNUMERIC(38,0)
OPTIONS(description='Expected/estimated number of receipts with specific item_2 / items of a specific group within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item_2 was not in PV). Calculated only for PV items.'),
base_restbon_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Expected baseline value for TurnOVER of Receipt Rest (Avg.) from the last 6 advertising weeks (median OVER the same weekday, when this item_2 was not in PV). Calculated only for PV items.'),
base_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Expected/estimated turnOVER of specific item_2 / items of a specific group within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item_2 was not in PV). Calculated only for PV items.'),
base_turnover_qty BIGNUMERIC(38,5)
OPTIONS(description='Expected / estimated sold quantity of the action item_2 within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item_2 was not in PV). Calculated only for PV items.'),
base_turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='Expected / estimated generated revenue of the action item_2 within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item_2 was not in PV). Calculated only for PV items.'),
cheaper_max_pct BIGNUMERIC(38,5)
OPTIONS(description='Maximum price reduction in % for the advertised PV item_2, which occured in a store (Price reductions could be different for each store). Calculated only for PV item_2 type on advertising period level. '),
cheaper_min_pct BIGNUMERIC(38,5)
OPTIONS(description='Minimum price reduction in % for the advertised PV item_2, which occured in a store (Price reductions could be different for each store). Calculated only for PV item_2 type on advertising period level. '),
cheaper_range STRING(16777216)
OPTIONS(description='Price reduction in % for the advertised PV item. Calculated only for PV item_2 type on advertising period level. Price reductions could be different for each store, so it is displayed as a range from the minimum to the maximum reduction, which occured in a store.'),
cheaper_weighted_avg_in_pct BIGNUMERIC(38,5)
OPTIONS(description='[Gewichteter Mittelwert Billiger] Weighted avarage price reduction in % for the advertised PV item_2, which occured in a store (Price reductions could be different for each store). Calculated only for PV item_2 type on advertising period level. '),
cherry_picker_receipt_cnt BIGNUMERIC(38,0)
OPTIONS(description='Number of\"cherry picker\" receipts, that contain the PV item_2 and the net turnOVER sum of all PV items on this receipt is at least 70% of the total receipt turnOVER. Only calculated for PV items. Return receipts are ignored. Not trivially aggregatable.'),
cherry_picker_receipt_cnt_pct BIGNUMERIC(38,5)
OPTIONS(description='Cherry Picker Quote in %: Number of Cherry Picker Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.'),
exclusive_buyer_receipt_cnt BIGNUMERIC(38,0)
OPTIONS(description='Number of the\"exclusive buyer\" receipts, that contain only one PV item_2 (multiple pieces of this item_2 are possible), and no other items on this receipt. Only calculated for PV items.'),
exclusive_buyer_receipt_cnt_pct BIGNUMERIC(38,5)
OPTIONS(description='Exclusive Buyer Quote in %: Number of Exclusive Buyer Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.'),
heavy_buyer_receipt_cnt BIGNUMERIC(38,0)
OPTIONS(description='Number of\"heavy buyer\" receipts, which contain the advertised item_2 (any type PV / NF / FA) and whose net turnOVER sum of all advertised items (any type PV / NF / FA) on this receipt is at least 70% of the total receipt\'s turnOVER, and the sales_2 quantity sum of all these advertised items on this receipt is at least 70% of the total receipt\'s sales_2 quantity. Return receipts are ignored. Not trivially aggregatable.'),
heavy_buyer_receipt_cnt_pct BIGNUMERIC(38,5)
OPTIONS(description='Heavy Buyer Quote in %: Number of Heavy Buyer Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.'),
price_buy_net BIGNUMERIC(38,5)
OPTIONS(description='Net buying price of the advertised item. Calculated as average of the delivered net value sum, divided by the delivered quantity from the warehouse receivings. '),
price_retail_new_gross_range STRING(16777216)
OPTIONS(description='Price Retail New (Gross): Gross retail price (sales_2 price) for the advertised item. Prices could be different for each store, so it is displayed as a range from the minimum to the maximum price, which occured in a store. Calculated for PV, NF, FA items on advertising period level. For PV it is meant to be the\"new\" price, which is reduced from the old price.'),
price_retail_new_max_gross BIGNUMERIC(38,5)
OPTIONS(description='Price Retail New Max. (Gross): Maximum new gross price (sales_2 price) for the advertised item_2, which occured in a store (prices could be different for each store). Calculated for PV, NF, FA items on advertising period level. For PV it is meant to be the\"new\" price, which is reduced from the old price.'),
price_retail_new_min_gross BIGNUMERIC(38,5)
OPTIONS(description='Price Retail New Min. (Gross): Minimum new gross price (sales_2 price) for the advertised PV item_2, which occured in a store (prices could be different for each store). Calculated for PV, NF, FA items on advertising period level. For PV it is meant to be the\"new\" price, which is reduced from the old price.'),
price_retail_old_gross_range STRING(16777216)
OPTIONS(description='Price Retail Old (Gross): Old gross retail price (sales_2 price) for the advertised PV item. Calculated only for PV item_2 type on advertising period level. Old prices could be different for each store, so it is displayed as a range from the minimum to the maximum old price, which occured in a store.'),
price_retail_old_max_gross BIGNUMERIC(38,5)
OPTIONS(description='Source, logic will be decided by CO! Price Retail Old Max. (Gross): Maximum old gross price (sales_2 price) for the advertised PV item_2, which occured in a store (old prices could be different for each store). Calculated only for PV item_2 type on advertising period level.'),
price_retail_old_min_gross BIGNUMERIC(38,5)
OPTIONS(description='Source, logic will be decided by CO! Price Retail Old Min. (Gross): Minimum old gross price (sales_2 price) for the advertised PV item_2, which occured in a store (old prices could be different for each store). Calculated only for PV item_2 type on advertising period level. '),
price_retail_old_weighted_avg_gross BIGNUMERIC(38,5)
OPTIONS(description='[Gewichteter Mittelwert VK_2 (alt) (brutto)]  Weighted avarage price Retail Old (Gross): Weighted avarage old gross price (sales_2 price) for the advertised item_2, which occured in a store (prices could be different for each store).'),
price_retail_new_weighted_avg_gross BIGNUMERIC(38,5)
OPTIONS(description='[Gewichteter Mittelwert VK_2 (neu) (brutto)]  Weighted avarage price Retail New (Gross): Weighted avarage new gross price (sales_2 price) for the advertised item_2, which occured in a store (prices could be different for each store). Calculated for PV, NF, FA items on advertising period level. For PV it is meant to be the\"new\" price, which is reduced from the old price.'),
pv_effic_revenue_factor BIGNUMERIC(38,5)
OPTIONS(description='Additional Revenue vs. Additional TurnOVER as a factor, caused by the advertised PV item. Indirectly uses the baseline values for revenue, turnOVER from the last 6 weeks. Only for PV.'),
pv_effic_turnover_factor BIGNUMERIC(38,5)
OPTIONS(description='(Additional TurnOVER minus Costs for the Price Reduction) vs. Costs for the Price Reduction, for the advertised PV item.'),
pv_net_val BIGNUMERIC(38,5)
OPTIONS(description='Absolute Advertising PV value in local currency. Calculated already on store level per item_2 as (difference of the old retail price minus new retail price) multiplied by the sales_2 quantity during the advertising period / advertising week.'),
pv_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='Advertising PV as percentage of absolute advertising PV vs. total turnOVER of all items (promo, non-promo).'),
pv_lp_net_val BIGNUMERIC(38,5)
OPTIONS(description='Absolute Advertising PV value in local currency for LP action type. Calculated already on store level per item_2 as (difference of the old retail price minus new retail price) multiplied by the sales_2 quantity during the advertising period / advertising week.'),
pv_lp_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='Advertising PV as percentage of absolute advertising PV LP vs. total turnOVER of all items (promo, non-promo).'),
pv_npps_net_val BIGNUMERIC(38,5)
OPTIONS(description='Absolute Advertising PV value in local currency for NPPS action type. Calculated already on store level per item_2 as (difference of the old retail price minus new retail price) multiplied by the sales_2 quantity during the advertising period / advertising week.'),
pv_npps_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='Advertising PV as percentage of absolute advertising PV NPPS vs. total turnOVER of all items (promo, non-promo).'),
pv_wawi_net_val BIGNUMERIC(38,5)
OPTIONS(description='Absolute Advertising PV value in local currency for WAWI action type. Calculated already on store level per item_2 as (difference of the old retail price minus new retail price) multiplied by the sales_2 quantity during the advertising period / advertising week.'),
pv_wawi_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='Advertising PV as percentage of absolute advertising PV WAWI vs. total turnOVER of all items (promo, non-promo).'),
pv_receipt_cnt_factor BIGNUMERIC(38,5)
OPTIONS(description='Factor of the Number of Receipts having this advertised PV item_2 (during the adv period) vs. its expected baseline value from the last 6 weeks. Only for PV items. See other metrics as part of the formula.'),
pv_turnover_net_val_factor BIGNUMERIC(38,5)
OPTIONS(description='Factor of the TurnOVER of this advertised PV item_2 (during the adv period) vs. its expected baseline value from the last 6 weeks. Only for PV items. See other metrics as part of the formula.'),
pv_turnover_qty_factor BIGNUMERIC(38,5)
OPTIONS(description='Factor of the Sales_2 Quantity of this advertised PV item_2 (during the adv period) vs. its expected baseline value from the last 6 weeks. Only for PV items. See other metrics as part of the formula.'),
receipt_cnt BIGNUMERIC(38,0)
OPTIONS(description='Number of advertised items receipts for the specific timeframe (advertising period / advertising week). These are receipts that contain the specific advertised item_2 and possibly other items. The advertised item_2 can belong to any action type (PV / NF / FA) and advertising period. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive, because different advertised items can be on the same receipt. This KPI shows, by how many customers the item_2 was bought, independently of the sold quantity.'),
receipt_cnt_share_pct BIGNUMERIC(38,5)
OPTIONS(description='Share of All Total Receipts in %: Share of the receipts that contain this advertised item_2, of the total number of receipts (containing promotion and / or non-promotion items), of a country_2 for the specific timeframe (advertising period / advertising week).'),
receipt_per_store_cnt BIGNUMERIC(38,5)
OPTIONS(description='Number of advertised items receipts per store for the specific timeframe (advertising period / advertising week). These are receipts that contain the specific advertised item_2 and possibly other items. The advertised item_2 can belong to any action type (PV / NF / FA) and advertising period. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive, because different advertised items can be on the same receipt. This KPI shows, by how many customers the item_2 was bought, independently of the sold quantity.'),
restbon_effect_pct BIGNUMERIC(38,5)
OPTIONS(description='TurnOVER of the rest of the receipt vs. its baseline in %, caused by the advertised PV item. Calculated by comparing the rest of the receipt during this promotion vs. the baseline value from the last 6 weeks. Only for PV. Only for these stores, which had this PV item_2 in promotion in the current advertising week.'),
restbon_np_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Rest of the receipt having a normal price: Average sum of the net turnOVER of all other non-advertised items of receipts containing the advertised item_2, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnOVER of all advertised items (including the specific advertised item_2) is excluded. See descriptions of the detailed formula components.'),
restbon_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Rest of the receipt: Average sum of the net turnOVER of all other items (incl. other advertised items) of receipts containing the advertised item_2, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnOVER of the advertised item_2 is excluded. See descriptions of the detailed formula components.'),
restbon_turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='The generated revenue (turnOVER minus buying price volume) of all items (promotion, non-promotion items) of the rest of the receipts (excluding the action item_2), which contain the advertised item. For the specific timeframe (advertising period / advertising week), in local currency.'),
store_cnt BIGNUMERIC(38,0)
OPTIONS(description='Number of stores that sold the action item_2 in the specific timeframe (advertising period / advertising week), in the region. For NF/FA items, additional 5 days prior advertising period are considered. No trivial aggregation, because each store might have multiple different items advertised.'),
total_receipt_cnt BIGNUMERIC(38,0)
OPTIONS(description='Total number of all receipts (containing promotion and / or non-promotion items) of a country_2 for the specific timeframe (advertising period / advertising week).'),
total_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Total net turnOVER of all items (promotion, non-promotion items) of a country_2 for the specific timeframe (advertising period / advertising week), in local currency. Returns are ignored. Especially on advertising week level: only the 7 days of the advertising week are considered.'),
turnover_margin_pct BIGNUMERIC(38,5)
OPTIONS(description='Revenue generated (turnOVER minus buying price volume) with this sold action item_2 vs. TurnOVER in %.'),
turnover_net_per_store_val BIGNUMERIC(38,5)
OPTIONS(description='Net turnOVER of the advertised item_2 per store, for the specific timeframe (advertising period / advertising week), returns are considered, in local currency. For NF/FA items, additional 5 days prior advertising period are considered.'),
turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Net turnOVER of the advertised item_2, for the specific timeframe (advertising period / advertising week), returns are considered, in local currency. For NF/FA items, additional 5 days prior advertising period are considered.'),
turnover_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='Total TurnOVER Share in %: TurnOVER of this advertised item_2 vs. the total turnOVER of all items (promo, non-promo) of the country_2, for the specific timeframe (advertising period / advertising week).'),
turnover_qty BIGNUMERIC(38,5)
OPTIONS(description='Sold quantity (returns are considered) of advertised items (NF / FA / PV) during their advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.'),
turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='Revenue generated with this sold action item. Absolute value of turnOVER minus buying price volume.'),
turnover_revenue_net_store_val BIGNUMERIC(38,5) OPTIONS(description='Absolute revenue in local currency per store.'),
volume_buy_net_val BIGNUMERIC(38,5)
OPTIONS(description='Buying Volume based on sales_2 in local currency. Calculated as the net buying price, multiplied by the sales_2 quantity of this advertised item_2 during the period.'),
reject_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues'),
reject_reason_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Link to DQ Reject Reason Codes'),
source_system_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Manual/Static'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field. ETL / AB-Initio Process ID'),
PRIMARY KEY (client_id, warehouse_sid, adv_week_id, reporting_line_sid, orig_item_nr, action_type_id, deleted_fg)
NOT ENFORCED
) CLUSTER BY client_id, adv_week_id
OPTIONS(description='Frontend MSTR Aggregate Table at the NAN level aggregated on Country_2 / Region_2 (WH), AdvWeek, ActionType. Information included for UWG, WGI.');