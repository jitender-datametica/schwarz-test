/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_AGG_REGION_CENTRAL_NAN
#-------------------------------------------------------------------------------
# Description: DDL for frontend MSTR Aggregate Table at the NAN (orig_item_nr) level
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-08-02 Prasanna Ranjan  Initial version
#  4.1  2024-09-05 Nikolai Toknov	Adjustments of comments.
#  4.2  2024-09-24 Prasanna Ranjan	Adjustment Increment 2.1 (PV)
#  4.3  2024-12-17 Nikolai Toknov	Drop column PV_TYPE_ID
#  4.4  2024-12-23 Nikolai Toknov	Rename  MEDIUM_GRP_MSTR_SID_FE_LST -> MEDIUM_GRP_MSTR_SID_LST, MEDIUM_MSTR_SID_FE_LST -> MEDIUM_MSTR_SID_LST
#  4.5  2025-01-14 Nikolai Toknov	Drop columns MEDIUM_IGNORE_FG,MEDIUM_GRP_LIDLPLUS_FG,MEDIUM_ITEM_DISP_FG,MEDIUM_GRP_DRILLDOWN_DISP_FG
#  4.6  2025-01-25 Nikolai Toknov	Add columns PRICE_RETAIL_OLD_WEIGHTED_AVG_GROSS, PRICE_RETAIL_NEW_WEIGHTED_AVG_GROSS, CHEAPER_WEIGHTED_AVG_IN_PCT
#  4.7  2025-02-10 Nikolai Toknov	Add REJECT_LDESCR
#  4.8  2025-03-17 Nikolai Toknov	Add REPORTING_LINE_SID,REPORTING_LINE_DESCR
#  4.9  2025-03-20 Prasanna Ranjan	Add PV_ON_PV_DESCR
#  4.10 2025-03-24 Nikolai Toknov	Change for Azure-pipeline
#  4.11	2025-05-14 Nikolai Toknov 	Inkrement 2.1 CR new types of LP-promotions(Mail: 09.05.2025)
#-------------------------------------------------------------------------------
*/

/*
USE ROLE 		R_LDL_D_PIT_ETL;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_FE_MSTR_PIT;
USE WAREHOUSE 	WH_LDL_D_PIT_ETL_S;
*/

/*
ALTER table LDL.P_LEW_FE_MSTR_PIT.T_AGG_REGION_CENTRAL_NAN ADD
	REPORTING_LINE_SID						INTEGER					 								COMMENT 'Hierarchy level number to identify the individual reporting line (row) of e.g. a precalculated summary line.',
	REPORTING_LINE_DESCR					STRING 												COMMENT 'Description of the Reporting Line';
	PV_ON_PV_DESCR							STRING													COMMENT 'Ursprungs-Werbe-PV: Shows if item has already a Werbe-PV applied f.e. when LP-Werbe-PV on WaWi-Werbe-PV we display WaWi-Werbe-PV';

ALTER table LDL.P_LEW_FE_MSTR_PIT.T_AGG_REGION_CENTRAL_NAN ADD
	COUPON_AGG_LIST_DESCR							STRING																		COMMENT 'LP Coupons Description';

*/


-- MEDIUM_GRP_LIDLPLUS_FG					NUMBER(38,0)																COMMENT 'Indicator / Flag Medium Grouping on Lidl Plus',

-- GID
 -- WGI
 -- UWG
 -- Technical fields
 -- GID

-- MEDIUM_ITEM_DISP_FG						NUMBER(38,0)																COMMENT '',

-- MEDIUM_IGNORE_FG						NUMBER(38,0)																COMMENT 'Indicator / Flag Medium Ignore (hide the row for this medium in frontend)',

-- MEDIUM_GRP_DRILLDOWN_DISP_FG			NUMBER(38,0)																COMMENT '',

-- ACTION_TYPE_ID_FE_LST					STRING																		COMMENT '',

-- PV_TYPE_ID								NUMBER(38,0)																COMMENT 'Type of PV (List of PV Types: Wawi PV ::= 1 | LP ::= 2 | NPPS ::= 3 | -1 ::= N/A | -2 ::= Total PV)',

-- Fakten / Measures / KPIs
 CREATE TABLE IF NOT EXISTS ldl_p_lew_fe_mstr_pit.t_agg_region_central_nan (
client_id INTEGER NOT NULL OPTIONS(description='Client id'),
country_iso_cd STRING(3) OPTIONS(description='Country ISO Code = WAWI Country '),
country_descr STRING(16777216) OPTIONS(description='Country Name'),
warehouse_sid INTEGER NOT NULL OPTIONS(description='Warehouse Surrogate ID'),
warehouse_mstr_sid INTEGER OPTIONS(description='Warehouse Surrogate ID'),
warehouse_gid INTEGER DEFAULT - 1000 OPTIONS(description='Warehouse Surrogate GID - As-Was CROSS JOIN key for Frontend'),
warehouse_mstr_gid INTEGER OPTIONS(description='Technical Field: MSTR GID'),
warehouse_name STRING(16777216) OPTIONS(description='Warehouse Name'),
orig_wh_nr INTEGER OPTIONS(description='Original Warehouse Number  / code from Wawi'),
adv_week_id INTEGER NOT NULL OPTIONS(description='Advertising week BK'),
adv_week_mstr_id INTEGER
OPTIONS(description='Advertising week MSTR Key. (AdvWeek No. concatenated with 2-digit client ID)'),
nearest_rltd_adv_week_fg INTEGER
OPTIONS(description='1: Flag indicates, that the related adv week is the previous of the adv week; 0: any other related adv week'),
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
length_of_adv_week INTEGER OPTIONS(description='Number of Days in Adv. Week'),
adv_week_year_id INTEGER OPTIONS(description='Year ID of the Adv.-Week. 202137 -> 2021. Needed for Reporting'),
adv_week_week_nr INTEGER OPTIONS(description='Adv.Week Week Nbr. E.g. 202137 -> 37. Needed for Reporting'),
adv_week_sdescr STRING(16777216) OPTIONS(description='Adv. Week Short Description'),
adv_week_descr STRING(16777216) OPTIONS(description='Adv.Week Description'),
adv_week_ldescr STRING(16777216) OPTIONS(description='Adv. Week Long Description incl. dates'),
adv_week_overlap_ldescr STRING(16777216)
OPTIONS(description='Adv.Week Long Description incl. dates and the maximum date of the overlapping range into the next adv week'),
prev_1_adv_week_id INTEGER OPTIONS(description='Previous 1 Adv.Week ID e.g. 202124 -> 202123'),
next_1_adv_week_id INTEGER OPTIONS(description='Next 1 Adv.Week ID e.g. 202124 -> 202125'),
prev_1_year_adv_week_id INTEGER OPTIONS(description='Previous 1 Year Adv.Week ID e.g. 202124 -> 202024'),
last_adv_week_fg INTEGER DEFAULT 0 OPTIONS(description='Flag / indicator last Adv.Week = 1'),
last_closed_adv_week_fg INTEGER DEFAULT 0 OPTIONS(description='Flag / indicator last closed Adv.Week = 1'),
mov_adv_week_start_from_current INTEGER
OPTIONS(description='Current Adv.-Week is ::0 , pervious Adv.-Week is -1 Next Adv. Week is +1'),
max_adv_period_end_dt DATE
OPTIONS(description='maximum assigned Adv. Period End Date, in case of overlapping period. Needed for Reporting Information Window.'),
reporting_line_sid INTEGER
OPTIONS(description='Hierarchy level number to identify the individual reporting line (row) of e.g. a precalculated summary line.'),
reporting_line_descr STRING(16777216) OPTIONS(description='Description of the Reporting Line'),
orig_item_gid INTEGER DEFAULT - 1000
OPTIONS(description='NAN orig Item number Surrogate GID - As-Was CROSS JOIN key for Frontend'),
orig_item_mstr_gid INTEGER OPTIONS(description='Technical Field: MSTR GID'),
orig_item_nr INTEGER NOT NULL OPTIONS(description='Item business identifier. NaN := National Article Number'),
orig_item_mstr_nr INTEGER
OPTIONS(description='Item business identifier. (NaN := National Article Number) MSTR Key: Special MSTR CROSS JOIN criteria to have surrogate ORIG_ITEM_NR + CLIENT_ID'),
dat_valid_from DATE DEFAULT DATE '8888-12-31' OPTIONS(description='Original Item Source DATE from.'),
item_name STRING(16777216) OPTIONS(description='(short) item name in local LANGUAGE'),
item_descr STRING(16777216) OPTIONS(description='(long) item description in local LANGUAGE'),
item_int_descr STRING(16777216)
OPTIONS(description='(long) item description in international LANGUAGE of centre (Deutsch)'),
item_fam_grp_sid INTEGER OPTIONS(description='Sid for item family group.'),
item_fam_grp_src_id INTEGER OPTIONS(description='ID for family group from source system.'),
item_fam_grp_src_cd STRING(16777216) OPTIONS(description='Wawi Code for Article family group'),
item_fam_grp_name STRING(16777216) OPTIONS(description='Family group name.'),
item_fam_grp_descr STRING(16777216) OPTIONS(description='Family group description (local).'),
item_fam_grp_int_descr STRING(16777216) OPTIONS(description='Family group description (international).'),
sub_item_grp_gid INTEGER DEFAULT - 1000
OPTIONS(description='UWG orig Item number Surrogate GID - As-Was CROSS JOIN key for Frontend'),
sub_item_grp_mstr_gid INTEGER OPTIONS(description='Technical Field: MSTR GID'),
sub_item_grp_sid INTEGER OPTIONS(description='Sub Item Group SID'),
sub_item_grp_mstr_sid INTEGER OPTIONS(description='Sub Item Group SID (MSTR formatted)'),
sub_item_grp_src_cd STRING(16777216) OPTIONS(description='Item sub group Wawi Source Code'),
sub_item_grp_name STRING(16777216) OPTIONS(description='Item sub group name.'),
sub_item_grp_descr STRING(16777216) OPTIONS(description='Item sub group description (local).'),
sub_item_grp_int_descr STRING(16777216) OPTIONS(description='Item sub group description (international).'),
item_grp_int_gid INTEGER DEFAULT - 1000
OPTIONS(description='UWG orig Item number Surrogate GID - As-Was CROSS JOIN key for Frontend'),
item_grp_int_mstr_gid INTEGER OPTIONS(description='Technical Field: MSTR GID'),
item_grp_int_sid INTEGER OPTIONS(description='SID for item group international (WGI)'),
item_grp_int_mstr_sid INTEGER OPTIONS(description='SID for item group international (WGI) (MSTR formatted)'),
item_grp_int_src_cd STRING(16777216) OPTIONS(description='Code for international group from source system.'),
item_grp_int_name STRING(16777216) OPTIONS(description='International group name.'),
item_grp_int_descr STRING(16777216) OPTIONS(description='International group description (local).'),
item_grp_int_int_descr STRING(16777216) OPTIONS(description='International group description (international).'),
brand_sid INTEGER OPTIONS(description='Sid for brand of item.'),
brand_name STRING(16777216) OPTIONS(description='Brand name.'),
brand_type_cd STRING(16777216) OPTIONS(description='Brand type.'),
buying_list_type_id INTEGER OPTIONS(description='ID for buying list type. Only on Country Level – no regionalization.'),
buying_list_type_descr STRING(16777216) OPTIONS(description='Buying list type description (local).'),
buying_list_type_int_descr STRING(16777216) OPTIONS(description='Buying list type description (international).'),
supplier_list_descr STRING(16777216)
OPTIONS(description='Future use: Comma separated list of suppliers / Vendors of this article. Descriptive Information only.'),
adv_period_id INTEGER NOT NULL OPTIONS(description='Unique identifier of Adv. Period'),
adv_period_mstr_id INTEGER OPTIONS(description='Needed for MSTR Reporting'),
adv_period_start_dt DATE OPTIONS(description='Start Date of the Adv.Period'),
adv_period_end_dt DATE OPTIONS(description='End Date of the Adv.Period'),
adv_period_start_day_id INTEGER OPTIONS(description='Day Number of the Adv.Period Start Day (nach ISO)'),
adv_period_start_dt_descr STRING(16777216)
OPTIONS(description='Start Date of the Adv.Period in German format for the frontend'),
adv_period_end_dt_descr STRING(16777216)
OPTIONS(description='End Date of the Adv.Period in German format for the frontend'),
adv_period_end_day_id INTEGER OPTIONS(description='Day Number of the Adv.Period End Day'),
adv_period_start_day_sdescr STRING(16777216)
OPTIONS(description='German short description of the week day, when this period starts'),
adv_period_end_day_sdescr STRING(16777216)
OPTIONS(description='German short description of the week day, when this period ends'),
adv_period_start_day_descr STRING(16777216)
OPTIONS(description='German description of the week day, when this period starts'),
adv_period_end_day_descr STRING(16777216)
OPTIONS(description='German description of the week day, when this period ends'),
adv_period_length_in_days INTEGER OPTIONS(description='Length of the Adv.Period'),
adv_period_cnt BIGNUMERIC(38,0) OPTIONS(description='Number of unique store-level (start and end dates) periods.'),
overlap_period_fg INTEGER OPTIONS(description='Flag Indicates is True (1) if period extend into next calendar week'),
overlap_adv_period_start_dt DATE
OPTIONS(description='Start Date of the overlapping  Adv.Period. (Start_dt – overlap_end Dt) (overlap_start_dt – end_dt)'),
overlap_adv_period_end_dt DATE OPTIONS(description='End Date of the overlapping Adv.Period'),
overlap_adv_week_id INTEGER OPTIONS(description='Adv. Week ID of overlapping Periods. '),
adv_period_descr STRING(16777216) OPTIONS(description='Adv. Period Description'),
adv_period_ldescr STRING(16777216) OPTIONS(description='Adv.Period Long Description'),
current_adv_period_fg INTEGER OPTIONS(description='Flag / indicator current Adv.Period = 1'),
action_type_id INTEGER NOT NULL
OPTIONS(description='Action type id. -2000 = Reporting Line Total, -1000 = Undefined/No Action, 1 = PV, 2 = NF, 3 = FA respectively.'),
action_type_sort_val INTEGER OPTIONS(description='Sort information for reporting purposes.'),
action_type_name STRING(16777216) OPTIONS(description='(short) name in local LANGUAGE'),
action_type_descr STRING(16777216) OPTIONS(description='(long)  description in local LANGUAGE (may be unavailable)'),
pv_on_pv_descr STRING(16777216)
OPTIONS(description='Ursprungs-Werbe-PV: Shows if item has already a Werbe-PV applied f.e. when LP-Werbe-PV on WaWi-Werbe-PV we display WaWi-Werbe-PV'),
theme_grp_int_sid INTEGER DEFAULT - 1000 NOT NULL
OPTIONS(description='Unique system ID, sid, for the theme INTEGER group.'),
theme_grp_int_mstr_sid INTEGER
OPTIONS(description='Unique system ID, sid, for the theme INTEGER group + Client_ID, as MSTR Key'),
theme_grp_int_name STRING(16777216) OPTIONS(description='Theme INTEGER group name.'),
theme_grp_int_sort_val INTEGER
OPTIONS(description='internal sorting value for the INTEGER theme (ordered by Theme group Name)'),
theme_grp_nat_sid INTEGER DEFAULT - 1000 NOT NULL OPTIONS(description='Unique system ID, sid, for the theme nat group.'),
theme_grp_nat_mstr_sid INTEGER
OPTIONS(description='Unique system ID, sid, for the theme nat group + Client_ID, as MSTR Key'),
theme_grp_nat_name STRING(16777216) OPTIONS(description='Theme nat group name.'),
theme_grp_nat_sort_val INTEGER
OPTIONS(description='internal sorting value for the nat theme (ordered by Theme group Name)'),
theme_grp_nat_cat_sid INTEGER DEFAULT - 1000 NOT NULL
OPTIONS(description='Unique system ID, sid, for the theme nat group category.'),
theme_grp_nat_cat_mstr_sid INTEGER
OPTIONS(description='Unique system ID, sid, for the theme nat group category + Client_ID, as MSTR Key'),
theme_grp_nat_cat_name STRING(16777216) OPTIONS(description='Theme nat group category name.'),
theme_grp_nat_cat_sort_val INTEGER
OPTIONS(description='Internal sorting value for the nat theme category (ordered by Theme group Name)'),
medium_agg_list_descr STRING(16777216)
OPTIONS(description='Comma-separated list of all advertising media (of all media groups), in which this item has been advertised during this period.'),
medium_grp_agg_list_descr STRING(16777216) OPTIONS(description=''),
medium_mstr_sid_lst STRING(16777216) OPTIONS(description=''),
medium_grp_mstr_sid_lst STRING(16777216) OPTIONS(description=''),
coupon_agg_list_descr STRING(16777216) OPTIONS(description='LP Coupons Description'),
sort_order_val STRING(16777216) OPTIONS(description='Default sorting order for the report'),
add_receipt_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Zusatzbons (Anz.)] Additional number of receipts, caused by the advertised PV item. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_receipt_per_store_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Zusatzbons / Filiale] Additional number of receipts, caused by the advertised PV item per store. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Zusatzumsatz] Additional Turnover, caused by the advertised PV item. Calculated by turnover of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_turnover_net_per_store_val BIGNUMERIC(38,5)
OPTIONS(description='[Zusatzumsatz / Filiale] Additional Turnover, caused by the advertised PV item, per store (where the PV item was sold). Calculated by turnover of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_turnover_qty BIGNUMERIC(38,0)
OPTIONS(description='[Zusatzmenge (Stk/kg)] Additional turnover qantity, caused by the advertised PV item. Calculated by number of soled item qty of current week, minus ist baseline value from the last 6 weeks. Only PV.'),
add_turnover_per_store_qty BIGNUMERIC(38,0)
OPTIONS(description='[Zusatzmenge / Filiale] Additional turnover qantity, caused by the advertised PV item per store. Calculated by number of soled item qty of current week, minus ist baseline value from the last 6 weeks. Only PV.'),
add_turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Zusatzertrag] Additional Revenue, caused by the advertised PV item. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
adv_item_per_receipt_cnt BIGNUMERIC(38,5)
OPTIONS(description='[ø-Artikel / Bon (Anz.)] Average number (pieces) of the advertised item per receipt, which contains this item, during the advertising period.'),
add_turnover_revenue_net_per_store_val BIGNUMERIC(38,5)
OPTIONS(description='[Zusatzertrag / Filiale] Additional Revenue, caused by the advertised PV item per store. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
adv_receipt_adv_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Umsatz Aktionsbons Aktionsartikel] Total action net turnover (only the advertised items), of receipts that contain the specific advertised item, for the specific timeframe (advertising period / advertising week), in local currency. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive.'),
adv_receipt_np_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Aktivierter NP-Umsatz] Normal price net turnover of receipts: Sum of the net turnover of all other non-advertised items of receipts containing the advertised item, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnover of all advertised items (including the specific advertised item) is excluded. See descriptions of the detailed formula components.'),
adv_receipt_total_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Umsatz Aktionsbons Gesamt] Total net turnover of receipts (promotion, non-promotion items), that contain the specific advertised item, for the specific timeframe (advertising period / advertising week), in local currency. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive.'),
base_receipt_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Bons Baseline (Anz.)] | [Bons Baseline Gesamt (Anz.)] Expected/estimated number of receipts with specific item / items of a specific group within its advertising period, from the last 6 advertising weeks (median over the same weekday, when this item was not in PV). Calculated only for PV items.'),
base_restbon_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Ø-Restbon Baseline] Expected baseline value for Turnover of Receipt Rest (Avg.) from the last 6 advertising weeks (median over the same weekday, when this item was not in PV). Calculated only for PV items.'),
base_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Umsatz Baseline] | [Umsatz brutto Baseline] | [Umsatz Baseline Gesamt] Expected/estimated turnover of specific item / items of a specific group within its advertising period, from the last 6 advertising weeks (median over the same weekday, when this item was not in PV). Calculated only for PV items.'),
base_turnover_qty BIGNUMERIC(38,5)
OPTIONS(description='[Abverkauf Baseline (Stk/kg)] Expected / estimated sold quantity of the action item within its advertising period, from the last 6 advertising weeks (median over the same weekday, when this item was not in PV). Calculated only for PV items.'),
base_turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Abverkaufsertrag Baseline] Expected / estimated generated revenue of the action item within its advertising period, from the last 6 advertising weeks (median over the same weekday, when this item was not in PV). Calculated only for PV items.'),
cheaper_max_pct BIGNUMERIC(38,5)
OPTIONS(description='[Billiger % bis] Maximum price reduction in % for the advertised PV item, which occured in a store (Price reductions could be different for each store). Calculated only for PV item type on advertising period level. '),
cheaper_min_pct BIGNUMERIC(38,5)
OPTIONS(description='[Billiger % von] Minimum price reduction in % for the advertised PV item, which occured in a store (Price reductions could be different for each store). Calculated only for PV item type on advertising period level. '),
cheaper_range STRING(16777216)
OPTIONS(description='[Billiger (%) WAWI PV] | [Billiger (%)  LP] Price reduction in % for the advertised PV item. Calculated only for PV item type on advertising period level. Price reductions could be different for each store, so it is displayed as a range from the minimum to the maximum reduction, which occured in a store.'),
cheaper_weighted_avg_in_pct BIGNUMERIC(38,5)
OPTIONS(description='[Gewichteter Mittelwert Billiger] Weighted avarage price reduction in % for the advertised PV item, which occured in a store (Price reductions could be different for each store). Calculated only for PV item type on advertising period level. '),
cherry_picker_receipt_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Cherry Picker (Anz.)] Number of\"cherry picker\" receipts, that contain the PV item and the net turnover sum of all PV items on this receipt is at least 70% of the total receipt turnover. Only calculated for PV items. Return receipts are ignored. Not trivially aggregatable.'),
cherry_picker_receipt_cnt_pct BIGNUMERIC(38,5)
OPTIONS(description='[Cherry Picker (%)] Cherry Picker Quote in %: Number of Cherry Picker Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.'),
deliv_qty BIGNUMERIC(38,5)
OPTIONS(description='[Anliefermenge Filiale (Stk/kg)] Delivered Quantity (pc/kg) of the advertised NF/FA item. This is the sum of the deliveries (5 days before the period start date, up to 13 days after the period start date) and the stock on the 6th day before the period start date. Only for NF/FA items.'),
exclusive_buyer_receipt_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Exklusiv-Käufer (Anz.)] number of the\"exclusive buyer\" receipts, that contain only one PV item (multiple pieces of this item are possible), and no other items on this receipt. Only calculated for PV items.'),
exclusive_buyer_receipt_cnt_pct BIGNUMERIC(38,5)
OPTIONS(description='[Exklusiv-Käufer (%)] Exclusive Buyer Quote in %: number of Exclusive Buyer Receipts vs. number of Receipts having this advertised item. See other metrics as part of the formula.'),
heavy_buyer_receipt_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Cherry Picker (Anz.)] Number of\"heavy buyer\" receipts, which contain the advertised item (any type PV / NF / FA) and whose net turnover sum of all advertised items (any type PV / NF / FA) on this receipt is at least 70% of the total receipts turnover, and the sales quantity sum of all these advertised items on this receipt is at least 70% of the total receipts sales quantity. Return receipts are ignored. Not trivially aggregatable.'),
heavy_buyer_receipt_cnt_pct BIGNUMERIC(38,5)
OPTIONS(description='[Cherry Picker (%)] Heavy Buyer Quote in %: Number of Heavy Buyer Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.'),
price_buy_net BIGNUMERIC(38,5)
OPTIONS(description='[EK] Net buying price of the advertised item. Calculated as average of the delivered net value sum, divided by the delivered quantity from the warehouse receivings. '),
price_retail_new_gross_range STRING(16777216)
OPTIONS(description='[VK (neu) (brutto)] Price Retail New (Gross): Gross retail price (sales price) for the advertised item. Prices could be different for each store, so it is displayed as a range from the minimum to the maximum price, which occured in a store. Calculated for PV, NF, FA items on advertising period level. For PV it is meant to be the\"new\" price, which is reduced from the old price.'),
price_retail_new_max_gross BIGNUMERIC(38,5)
OPTIONS(description='[VK (neu) (brutto) bis] Price Retail New Max. (Gross): Maximum new gross price (sales price) for the advertised item, which occured in a store (prices could be different for each store). Calculated for PV, NF, FA items on advertising period level. For PV it is meant to be the\"new\" price, which is reduced from the old price.'),
price_retail_new_min_gross BIGNUMERIC(38,5)
OPTIONS(description='[VK (neu) (brutto) von] Price Retail New Min. (Gross): Minimum new gross price (sales price) for the advertised PV item, which occured in a store (prices could be different for each store). Calculated for PV, NF, FA items on advertising period level. For PV it is meant to be the\"new\" price, which is reduced from the old price.'),
price_retail_old_gross_range STRING(16777216)
OPTIONS(description='[VK (alt) (brutto)] Price Retail Old (Gross): Old gross retail price (sales price) for the advertised PV item. Calculated only for PV item type on advertising period level. Old prices could be different for each store, so it is displayed as a range from the minimum to the maximum old price, which occured in a store.'),
price_retail_old_max_gross BIGNUMERIC(38,5)
OPTIONS(description='[VK (alt) (brutto) bis] Source, logic will be decided by CO! Price Retail Old Max. (Gross): Maximum old gross price (sales price) for the advertised PV item, which occured in a store (old prices could be different for each store). Calculated only for PV item type on advertising period level. '),
price_retail_old_min_gross BIGNUMERIC(38,5)
OPTIONS(description='[VK (alt) (brutto) von] Source, logic will be decided by CO! Price Retail Old Min. (Gross): Minimum old gross price (sales price) for the advertised PV item, which occured in a store (old prices could be different for each store). Calculated only for PV item type on advertising period level. '),
price_retail_old_weighted_avg_gross BIGNUMERIC(38,5)
OPTIONS(description='[Gewichteter Mittelwert VK (alt) (brutto)]  Weighted avarage price Retail Old (Gross): Weighted avarage old gross price (sales price) for the advertised item, which occured in a store (prices could be different for each store).'),
price_retail_new_weighted_avg_gross BIGNUMERIC(38,5)
OPTIONS(description='[Gewichteter Mittelwert VK (neu) (brutto)]  Weighted avarage price Retail New (Gross): Weighted avarage new gross price (sales price) for the advertised item, which occured in a store (prices could be different for each store). Calculated for PV, NF, FA items on advertising period level. For PV it is meant to be the\"new\" price, which is reduced from the old price.'),
pv_effic_revenue_factor BIGNUMERIC(38,5)
OPTIONS(description='[PV-Effizienz Ertrag] Additional Revenue vs. Additional Turnover as a factor, caused by the advertised PV item. Indirectly uses the baseline values for revenue, turnover from the last 6 weeks. Only for PV.'),
pv_effic_turnover_factor BIGNUMERIC(38,5)
OPTIONS(description='[PV-Effizienz Umsatz] (Additional Turnover minus Costs for the Price Reduction) vs. Costs for the Price Reduction, for the advertised PV item.'),
pv_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Werbe-PV (Basis Abverkauf) Gesamt] Absolute Advertising PV value in local currency. Calculated already on store level per item as (difference of the old retail price minus new retail price) multiplied by the sales quantity during the advertising period / advertising week.'),
pv_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='[Werbe-PV (Basis Abverkauf) Gesamt (%)] Advertising PV as percentage of absolute advertising PV vs. total turnover of all items (promo, non-promo).'),
pv_lp_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Werbe-PV (Basis Abverkauf) Lidl Plus] Absolute Advertising PV value in local currency for LP action type. Calculated already on store level per item as (difference of the old retail price minus new retail price) multiplied by the sales quantity during the advertising period / advertising week.'),
pv_lp_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='[Werbe-PV (Basis Abverkauf) Lidl Plus (%)] Advertising PV as percentage of absolute advertising PV LP vs. total turnover of all items (promo, non-promo).'),
pv_npps_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Werbe-PV (Basis Abverkauf) PromoDesigner] Absolute Advertising PV value in local currency for NPPS action type. Calculated already on store level per item as (difference of the old retail price minus new retail price) multiplied by the sales quantity during the advertising period / advertising week.'),
pv_npps_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='[Werbe-PV (Basis Abverkauf) PromoDesigner (%)] Advertising PV as percentage of absolute advertising PV NPPS vs. total turnover of all items (promo, non-promo).'),
pv_wawi_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Werbe-PV (Basis Abverkauf) WaWi] Absolute Advertising PV value in local currency for WAWI action type. Calculated already on store level per item as (difference of the old retail price minus new retail price) multiplied by the sales quantity during the advertising period / advertising week.'),
pv_wawi_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='[Werbe-PV (Basis Abverkauf) WaWi (%)] Advertising PV as percentage of absolute advertising PV WAWI vs. total turnover of all items (promo, non-promo).'),
pv_receipt_cnt_factor BIGNUMERIC(38,5)
OPTIONS(description='[Faktor Bons PV] Factor of the number of Receipts having this advertised PV item (during the adv period) vs. its expected baseline value from the last 6 weeks. Only for PV items. See other metrics as part of the formula.'),
pv_turnover_net_val_factor BIGNUMERIC(38,5)
OPTIONS(description='[Faktor Umsatz PV] Factor of the Turnover of this advertised PV item (during the adv period) vs. its expected baseline value from the last 6 weeks. Only for PV items. See other metrics as part of the formula.'),
pv_turnover_qty_factor BIGNUMERIC(38,5)
OPTIONS(description='[Faktor Menge PV] Factor of the Sales Quantity of this advertised PV item (during the adv period) vs. its expected baseline value from the last 6 weeks. Only for PV items. See other metrics as part of the formula.'),
receipt_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Bons (Anz.)] Number of advertised items receipts for the specific timeframe (advertising period / advertising week). These are receipts that contain the specific advertised item and possibly other items. The advertised item can belong to any action type (PV / NF / FA) and advertising period. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive, because different advertised items can be on the same receipt. This KPI shows, by how many customers the item was bought, independently of the sold quantity.'),
receipt_cnt_share_pct BIGNUMERIC(38,5)
OPTIONS(description='[Bon Penetration (%)] Share of All Total Receipts in %: Share of the receipts that contain this advertised item, of the total number of receipts (containing promotion and / or non-promotion items), of a country for the specific timeframe (advertising period / advertising week).'),
receipt_per_store_cnt BIGNUMERIC(38,5)
OPTIONS(description='[Bons / Filiale (Anz.)] Number of advertised items receipts per store for the specific timeframe (advertising period / advertising week). These are receipts that contain the specific advertised item and possibly other items. The advertised item can belong to any action type (PV / NF / FA) and advertising period. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive, because different advertised items can be on the same receipt. This KPI shows, by how many customers the item was bought, independently of the sold quantity.'),
restbon_effect_pct BIGNUMERIC(38,5)
OPTIONS(description='[Ø-Restbon Promotion vs. Ø-Restbon NP] Turnover of the rest of the receipt vs. its baseline in %, caused by the advertised PV item. Calculated by comparing the rest of the receipt during this promotion vs. the baseline value from the last 6 weeks. Only for PV. Only for these stores, which had this PV item in promotion in the current advertising week.'),
restbon_np_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Ø-Restbon NP] Rest of the receipt having a normal price: Average sum of the net turnover of all other non-advertised items of receipts containing the advertised item, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnover of all advertised items (including the specific advertised item) is excluded. See descriptions of the detailed formula components.'),
restbon_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Ø-Restbon] Rest of the receipt: Average sum of the net turnover of all other items (incl. other advertised items) of receipts containing the advertised item, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnover of the advertised item is excluded. See descriptions of the detailed formula components.'),
restbon_turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Ø-Kalkulation (Basis Abverkauf) (in %)Restbon] The generated revenue (turnover minus buying price volume) of all items (promotion, non-promotion items) of the rest of the receipts (excluding the action item), which contain the advertised item. For the specific timeframe (advertising period / advertising week), in local currency.'),
store_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Filialen (Basis Abverkauf) (Anz.)] Number of stores that sold the action item in the specific timeframe (advertising period / advertising week), in the region. For NF/FA items, additional 5 days prior advertising period are considered. No trivial aggregation, because each store might have multiple different items advertised.'),
total_receipt_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Bons Gesamt (Anz.)] Total number of all receipts (containing promotion and / or non-promotion items) of a country for the specific timeframe (advertising period / advertising week).'),
total_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Umsatz Gesamt] Total net turnover of all items (promotion, non-promotion items) of a country for the specific timeframe (advertising period / advertising week), in local currency. Returns are ignored. Especially on advertising week level: only the 7 days of the advertising week are considered.'),
turnover_1d_pct BIGNUMERIC(38,5)
OPTIONS(description='[Abverkauf 1T (%)] Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only) of the first day of the advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.'),
turnover_1d_per_store_qty BIGNUMERIC(38,5)
OPTIONS(description='[Abverkauf / Filiale 1T (Stk/kg)] Sold quantity (returns are considered) per store of advertised items (NF / FA / PV) of the first day of the advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.'),
turnover_1d_qty BIGNUMERIC(38,5)
OPTIONS(description='[Abverkauf 1T (Stk/kg)] Sold quantity (returns are considered) of advertised items (NF / FA / PV) of the first day of the advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.'),
turnover_3d_pct BIGNUMERIC(38,5)
OPTIONS(description='[Abverkauf 3T (%)] Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only): The metric will use the number of sold items always for 3 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.'),
turnover_3d_per_store_qty BIGNUMERIC(38,5)
OPTIONS(description='[Abverkauf / Filiale 3T (Stk/kg)] Sold quantity (returns are considered) per store of advertised items (NF / FA / PV): The metric will use the number of sold items always for 3 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.'),
turnover_3d_qty BIGNUMERIC(38,5)
OPTIONS(description='[Abverkauf 3T (Stk/kg)] The metric will use the number of sold items always for 3 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.'),
turnover_7d_pct BIGNUMERIC(38,5)
OPTIONS(description='[Abverkauf 7T (%)] Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only): The metric will use the number of sold items always for 7 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.'),
turnover_7d_per_store_qty BIGNUMERIC(38,5)
OPTIONS(description='[Abverkauf / Filiale 7T (Stk/kg)] Sold quantity (returns are considered) per store of advertised items (NF / FA / PV): The metric will use the number of sold items always for 7 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.'),
turnover_7d_qty BIGNUMERIC(38,5)
OPTIONS(description='[Abverkauf 7T (Stk/kg)] The metric will use the number of sold items always for 7 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.'),
turnover_42d_pct BIGNUMERIC(38,5)
OPTIONS(description='[Abverkauf 42T (%)] Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only): The metric will use the number of sold items always for 42 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.'),
turnover_42d_per_store_qty BIGNUMERIC(38,0)
OPTIONS(description='[Abverkauf / Filiale 42T (Stk/kg)] Sold quantity (returns are considered) per store of advertised items (NF / FA / PV): The metric will use the number of sold items always for 42 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.'),
turnover_42d_qty BIGNUMERIC(38,0)
OPTIONS(description='[Abverkauf 42T (Stk/kg)] The metric will use the number of sold items always for 42 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.'),
turnover_margin_pct BIGNUMERIC(38,5)
OPTIONS(description='[Kalkulation (Basis Abverkauf) (in %)] Revenue generated (turnover minus buying price volume) with this sold action item vs. Turnover in %.'),
turnover_net_per_store_val BIGNUMERIC(38,5)
OPTIONS(description='[Umsatz / Filiale] Net turnover of the advertised item per store, for the specific timeframe (advertising period / advertising week), returns are considered, in local currency. For NF/FA items, additional 5 days prior advertising period are considered.'),
turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Umsatz] | [Umsatz Gesamt Aktionen] Net turnover of the advertised item, for the specific timeframe (advertising period / advertising week), returns are considered, in local currency. For NF/FA items, additional 5 days prior advertising period are considered.'),
turnover_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='[UA (%)] Total Turnover Share in %: Turnover of this advertised item vs. the total turnover of all items (promo, non-promo) of the country, for the specific timeframe (advertising period / advertising week).'),
turnover_pct BIGNUMERIC(38,5)
OPTIONS(description='[Abverkauf (Werbeperiode) (%)] Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only) during their advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.'),
turnover_per_store_qty BIGNUMERIC(38,5)
OPTIONS(description='[Abverkauf / Filiale (Werbeperiode) (Stk/kg)] Sold quantity (returns are considered) per store of advertised items (NF / FA / PV) during their advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.'),
turnover_qty BIGNUMERIC(38,5)
OPTIONS(description='[Abverkauf (Werbeperiode) (Stk/kg)] Sold quantity (returns are considered) of advertised items (NF / FA / PV) during their advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.'),
turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Abverkaufsertrag] Revenue generated with this sold action item. Absolute value of turnover minus buying price volume.'),
turnover_revenue_net_store_val BIGNUMERIC(38,5)
OPTIONS(description='[Abverkaufsertrag / Filiale] Absolute revenue in local currency per store.'),
volume_buy_net_val BIGNUMERIC(38,5)
OPTIONS(description='[EK-Volumen Basis Abverkauf (LW)] Buying Volume based on sales in local currency. Calculated as the net buying price, multiplied by the sales quantity of this advertised item during the period.'),
reject_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues'),
reject_reason_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Link to DQ Reject Reason Codes'),
reject_ldescr STRING(16777216) OPTIONS(description='Detailed description of the rejection reason'),
source_system_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Manual/Static'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (client_id, warehouse_sid, adv_week_id, adv_period_id, action_type_id, orig_item_nr, deleted_fg)
NOT ENFORCED
) CLUSTER BY client_id, adv_week_id
OPTIONS(description='Frontend MSTR Aggregate Table at the NAN (orig_item_nr) level aggregated on Country / Region (WH), AdvWeek, AdvPeriod, ActionType. Information included for UWG, WGI.');