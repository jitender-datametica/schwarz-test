/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_AGG_REGION_CATEGORY_ALL_1
#-------------------------------------------------------------------------------
# Description:  Create DDL for frontend MSTR Aggregate Table on Country_1 / Region_1 (WH), AdvWeek,
#               Related AdvWeek (up to 53 weeks in the past), UWG (Sub Item_1 Group) / WGI
#               (Itemgroup_1 International).
#               Aggregation levels distinguished by Reporting Line:
#               - Sub Item_1 Group Action Total
#               - Item_1 Group International Action Total
#               - Grand Action Total (over all international item_1 groups)
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-09 Mike Davis      	Initial version
#                                   Nullability conditions still to be added.
#  1.1  2021-08-12 Dirk Hering     	Fixes, formatting
#  1.2	2021-09-13 Massimo Morelli 	Fixed SCHEMA
#  1.3  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  1.4  2022-05-31 Prasanna Ranjan	Replaced CURRENT_ADV_WEEK_FG
#  2.0	2022-07-12 Nikolai Toknov  Changing the script for DevOps
#  2.1	2022-07-22 Andreas Kurz		Added _GID columns for MSTR As-Was CROSS JOIN
#  2.2  2023-01-25 Andreas Kurz		Adding ACTION_TYPE_ID Column Default -1000 n/A
#									ACTION_TYPE_SORT_VAL
#									ACTION_TYPE_NAME
#									ACTION_TYPE_DESCR
#  2.3  2023-07-26 Nikolai Toknov	Remove NOT NULL for an improvement in the definition of REJECT_FG
#  3.0  2024-02-13 Prasanna Ranjan	Added new columns for PIT Increment 2 (PV)
#  4.0  2024-03-25 Nikolai Toknov	Task 530802. (Architecture) Exclude using "virtual columns" that are not GA in database. Drop VC.
#  4.1  2024-09-05 Nikolai Toknov	Adjustments of comments
#-------------------------------------------------------------------------------
*/

/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_AGG_REGION_CATEGORY_ALL_1
#-------------------------------------------------------------------------------
# Description:  Create DDL for frontend MSTR Aggregate Table on Country_1 / Region_1 (WH), AdvWeek,
#               Related AdvWeek (up to 53 weeks in the past), UWG (Sub Item_1 Group) / WGI
#               (Itemgroup_1 International).
#               Aggregation levels distinguished by Reporting Line:
#               - Sub Item_1 Group Action Total
#               - Item_1 Group International Action Total
#               - Grand Action Total (over all international item_1 groups)
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-09 Mike Davis      	Initial version
#                                   Nullability conditions still to be added.
#  1.1  2021-08-12 Dirk Hering     	Fixes, formatting
#  1.2	2021-09-13 Massimo Morelli 	Fixed SCHEMA
#  1.3  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  1.4  2022-05-31 Prasanna Ranjan	Replaced CURRENT_ADV_WEEK_FG
#  2.0	2022-07-12 Nikolai Toknov  Changing the script for DevOps
#  2.1	2022-07-22 Andreas Kurz		Added _GID columns for MSTR As-Was CROSS JOIN
#  2.2  2023-01-25 Andreas Kurz		Adding ACTION_TYPE_ID Column Default -1000 n/A
#									ACTION_TYPE_SORT_VAL
#									ACTION_TYPE_NAME
#									ACTION_TYPE_DESCR
#  2.3  2023-07-26 Nikolai Toknov	Remove NOT NULL for an improvement in the definition of REJECT_FG
#  3.0  2024-02-13 Prasanna Ranjan	Added new columns for PIT Increment 2 (PV)
#  4.0  2024-03-25 Nikolai Toknov	Task 530802. (Architecture) Exclude using "virtual columns" that are not GA in database. Drop VC.
#  4.1  2024-09-05 Nikolai Toknov	Adjustments of comments.
#  4.2  2024-09-24 Nikolai Toknov	Add ADV_ITEM_RLTD_CNT
#  4.3  2024-09-24 Prasanna Ranjan	Adjustment Increment 2.1 (PV)
#  4.4  2025-02-10 Nikolai Toknov	Add REJECT_LDESCR
#-------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_fe_mstr_pit.t_agg_region_category_all_1 (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client id'),
country_iso_cd STRING(3) OPTIONS(description='Country_1 ISO Code = WAWI Country_1 '),
country_descr STRING(16777216) OPTIONS(description='Country_1 Name'),
warehouse_sid INTEGER NOT NULL OPTIONS(description='Warehouse Surrogate ID'),
warehouse_mstr_sid INTEGER OPTIONS(description='Warehouse Surrogate ID'),
warehouse_gid INTEGER DEFAULT - 1000 OPTIONS(description='Warehouse Surrogate GID - As-Was CROSS JOIN key for Frontend'),
warehouse_mstr_gid INTEGER OPTIONS(description='Technical Field: MSTR GID'),
warehouse_name STRING(16777216) OPTIONS(description='Warehouse Name'),
orig_wh_nr INTEGER OPTIONS(description='Original Warehouse Number  / code from Wawi'),
adv_week_id INTEGER NOT NULL OPTIONS(description='Advertising week BK'),
adv_week_mstr_id INTEGER
OPTIONS(description='Advertising week MSTR Key. (AdvWeek No. concatenated with 2-digit client ID)'),
nearest_rltd_adv_week_fg INTEGER DEFAULT 0
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
mov_adv_week_start_from_current INTEGER
OPTIONS(description='Current Adv.-Week is ::0 , pervious Adv.-Week is -1 Next Adv. Week is +1'),
max_adv_period_end_dt DATE
OPTIONS(description='maximum assigned Adv. Period End Date, in case of overlapping period. Needed for Reporting Information Window.'),
last_adv_week_fg INTEGER DEFAULT 0 OPTIONS(description='Flag / indicator last Adv.Week = 1'),
last_closed_adv_week_fg INTEGER DEFAULT 0 OPTIONS(description='Flag / indicator last closed Adv.Week = 1'),
rltd_adv_week_id INTEGER OPTIONS(description='Related Adv week BK. The adv week for comparison.'),
rltd_adv_week_mstr_id INTEGER
OPTIONS(description='Related Adv week MSTR Key (AdvWeek No. concatenated with 2-digit client ID). The adv week for comparison.'),
rltd_adv_week_sdescr STRING(16777216) OPTIONS(description='Related Adv. Week Short Description'),
rltd_adv_week_descr STRING(16777216) OPTIONS(description='Related Adv.Week Description'),
rltd_adv_week_ldescr STRING(16777216) OPTIONS(description='Related Adv. Week Long Description incl. dates'),
rltd_adv_week_start_dt DATE OPTIONS(description='Start Date of Related Adv-Week'),
rltd_adv_week_end_dt DATE OPTIONS(description='End Date of Related Adv.-Week'),
reporting_line_sid INTEGER NOT NULL
OPTIONS(description='Hierarchy_1 level number to identify the individual reporting line (row) of e.g. a precalculated summary line.'),
reporting_line_descr STRING(16777216) OPTIONS(description='Description of the Reporting Line'),
item_grp_int_gid INTEGER DEFAULT - 1000
OPTIONS(description='UWG orig Item_1 number Surrogate GID - As-Was CROSS JOIN key for Frontend'),
item_grp_int_mstr_gid INTEGER OPTIONS(description='Technical Field: MSTR GID'),
item_grp_int_sid INTEGER OPTIONS(description='SID for item_1 group international (WGI)'),
item_grp_int_mstr_sid INTEGER OPTIONS(description='SID for item_1 group international (WGI) (MSTR formatted)'),
item_grp_int_src_cd STRING(16777216) OPTIONS(description='Code for international group from source system.'),
item_grp_int_name STRING(16777216) OPTIONS(description='International group name.'),
item_grp_int_descr STRING(16777216) OPTIONS(description='International group description (local).'),
item_grp_int_int_descr STRING(16777216) OPTIONS(description='International group description (international).'),
sub_item_grp_gid INTEGER DEFAULT - 1000
OPTIONS(description='UWG orig Item_1 number Surrogate GID - As-Was CROSS JOIN key for Frontend'),
sub_item_grp_mstr_gid INTEGER OPTIONS(description='Technical Field: MSTR GID'),
sub_item_grp_sid INTEGER OPTIONS(description='Sub Item_1 Group SID'),
sub_item_grp_mstr_sid INTEGER OPTIONS(description='Sub Item_1 Group SID (MSTR formatted)'),
sub_item_grp_src_cd STRING(16777216) OPTIONS(description='Item_1 sub group Wawi Source Code'),
sub_item_grp_name STRING(16777216) OPTIONS(description='Item_1 sub group name.'),
sub_item_grp_descr STRING(16777216) OPTIONS(description='Item_1 sub group description (local).'),
sub_item_grp_int_descr STRING(16777216) OPTIONS(description='Item_1 sub group description (international).'),
sort_order_val STRING(16777216) OPTIONS(description='Default sorting order for the report'),
action_type_id INTEGER DEFAULT - 1000 NOT NULL
OPTIONS(description='Action type id. -2000 = Reporting Line Total, -1000 = Undefined/No Action, 1 = PV, 2 = NF, 3 = FA respectively.'),
action_type_sort_val INTEGER OPTIONS(description='Sort information for reporting purposes.'),
action_type_name STRING(16777216) OPTIONS(description='(short) name in local LANGUAGE'),
action_type_descr STRING(16777216) OPTIONS(description='(long)  description in local LANGUAGE (may be unavailable)'),
add_receipt_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Zusatzbons (Anz.)] Additional number of receipts, caused by the advertised PV item. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_receipt_per_store_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Zusatzbons / Filiale] Additional number of receipts, caused by the advertised PV item_1 per store. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Zusatzumsatz] Additional Turnover, caused by the advertised PV item. Calculated by turnover of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_turnover_net_per_store_val BIGNUMERIC(38,5)
OPTIONS(description='[Zusatzumsatz / Filiale] Additional Turnover, caused by the advertised PV item_1, per store (where the PV item_1 was sold). Calculated by turnover of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_turnover_qty BIGNUMERIC(38,0)
OPTIONS(description='[Zusatzmenge (Stk/kg)] Additional turnover qantity, caused by the advertised PV item. Calculated by number of soled item_1 qty of current week, minus ist baseline value from the last 6 weeks. Only PV.'),
add_turnover_per_store_qty BIGNUMERIC(38,0)
OPTIONS(description='[Zusatzmenge / Filiale] Additional turnover qantity, caused by the advertised PV item_1 per store. Calculated by number of soled item_1 qty of current week, minus ist baseline value from the last 6 weeks. Only PV.'),
add_turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Zusatzertrag] Additional Revenue, caused by the advertised PV item. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_turnover_revenue_net_per_store_val BIGNUMERIC(38,5)
OPTIONS(description='[Zusatzertrag / Filiale] Additional Revenue, caused by the advertised PV item_1 per store. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
adv_item_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Aktionsartikel (Anz.)] Number of action items that have been sold in any action_type (PV / NF / FA) during an advertising period.'),
adv_item_fa_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Aktionsartikel FA (Anz.)] Number of FA action items that have been sold during an advertising period.'),
adv_item_nf_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Aktionsartikel NF (Anz.)] Number of NF action items that have been sold during an advertising period.'),
adv_item_pv_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Aktionsartikel Werbe-PV Gesamt (Anz.)] Number of PV action items that have been sold during an advertising period.'),
adv_item_pv_lp_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Aktionsartikel Werbe-PV Lidl Plus (Anz.)] Number of action items that have been sold as action_type LP during an advertising period, in the region_1 of a chosen related advertising week.'),
adv_item_pv_npps_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Aktionsartikel Werbe-PV PromoDesigner (Anz.)] Number of action items that have been sold as action_type NPPS during an advertising period, in the region_1 of a chosen related advertising week.'),
adv_item_pv_wawi_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Aktionsartikel Werbe-PV (Anz.)] Number of action items that have been sold as action_type WAWI during an advertising period, in the region_1 of a chosen related advertising week.'),
adv_item_rltd_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Aktionsartikel Vergleich (Anz.)] Number of action items that have been sold in any action_type (PV / NF / FA) during an advertising period.'),
adv_item_fa_rltd_cnt BIGNUMERIC(38,0)
OPTIONS(description='[FA (Anz.)] Number of action items that have been sold in action_type FA during related advertising period.'),
adv_item_nf_rltd_cnt BIGNUMERIC(38,0)
OPTIONS(description='[NF (Anz.)] Number of action items that have been sold in action_type NF during related advertising period.'),
adv_item_pv_lp_rltd_cnt BIGNUMERIC(38,0)
OPTIONS(description='[LP-Werbe-PV (Anz.)] Number of action items that have been sold in action_type LP-Werbe-PV during related advertising period.'),
adv_item_pv_npps_rltd_cnt BIGNUMERIC(38,0)
OPTIONS(description='[NPPS-Werbe-PV (Anz.)] Number of action items that have been sold in action_type NPPS-Werbe-PV during related advertising period.'),
adv_item_pv_wawi_rltd_cnt BIGNUMERIC(38,0)
OPTIONS(description='[WaWi-Werbe-PV (Anz.)] Number of action items that have been sold in action_type WaWi-Werbe-PV during related advertising period.'),
adv_item_delta_rltd_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Δ Artikel_1 (Anz.)  oder  Δ Aktionsartikel (Anz.)] Number of action items that have been sold in any action_type (PV / NF / FA) during an advertising period, in the region_1 of a chosen related advertising week.'),
adv_item_fa_delta_rltd_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Δ FA (Anz.)] (Delta) Number of action items that have been sold in any action_type FA during an advertising period, in the region_1 of a chosen related advertising week.'),
adv_item_nf_delta_rltd_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Δ NF (Anz.)] (Delta) Number of action items that have been sold in any action_type NF during an advertising period, in the region_1 of a chosen related advertising week.'),
adv_item_pv_lp_delta_rltd_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Δ LP-Werbe-PV (Anz.)] (Delta) Number of action items that have been sold in action_type LP-Werbe-PV (Anz.) during an advertising period, in the region_1 of a chosen related advertising week.'),
adv_item_pv_npps_delta_rltd_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Δ NPPS-Werbe-PV (Anz.)] (Delta) Number of action items that have been sold in  action_type NPPS-Werbe-PV (Anz.) during an advertising period, in the region_1 of a chosen related advertising week.'),
adv_item_pv_wawi_delta_rltd_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Δ WaWi-Werbe-PV (Anz.)] (Delta) Number of action items that have been sold in action_type WaWi-Werbe-PV (Anz.) during an advertising period, in the region_1 of a chosen related advertising week.'),
adv_receipt_adv_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Umsatz Aktionsbons Aktionsartikel] Total action net turnover (only the advertised items), of receipts that contain the specific advertised item_1, for the specific timeframe (advertising period / advertising week), in local currency. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive.'),
adv_receipt_np_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Aktivierter NP-Umsatz] Normal price net turnover of receipts: Sum of the net turnover of all other non-advertised items of receipts containing the advertised item_1, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnover of all advertised items (including the specific advertised item_1) is excluded. See descriptions of the detailed formula components.'),
adv_receipt_total_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Umsatz Aktionsbons Gesamt] Total net turnover of receipts (promotion, non-promotion items), that contain the specific advertised item_1, for the specific timeframe (advertising period / advertising week), in local currency. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive.'),
base_receipt_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Bons Baseline (Anz.)] | [Bons Baseline Gesamt (Anz.)] Expected/estimated number of receipts with specific item_1 / items of a specific group within its advertising period, from the last 6 advertising weeks (median over the same weekday, when this item_1 was not in PV). Calculated only for PV items.'),
base_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Umsatz Baseline] | [Umsatz brutto Baseline] | [Umsatz Baseline Gesamt] Expected/estimated turnover of specific item_1 / items of a specific group within its advertising period, from the last 6 advertising weeks (median over the same weekday, when this item_1 was not in PV). Calculated only for PV items.'),
base_turnover_qty BIGNUMERIC(38,5)
OPTIONS(description='[Abverkauf Baseline (Stk/kg)] Expected / estimated sold quantity of the action item_1 within its advertising period, from the last 6 advertising weeks (median over the same weekday, when this item_1 was not in PV). Calculated only for PV items.'),
base_turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Abverkaufsertrag Baseline] Expected / estimated generated revenue of the action item_1 within its advertising period, from the last 6 advertising weeks (median over the same weekday, when this item_1 was not in PV). Calculated only for PV items.'),
cherry_picker_receipt_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Cherry Picker (Anz.)] Number of\"cherry picker\" receipts, that contain the PV item_1 and the net turnover sum of all PV items on this receipt is at least 70% of the total receipt turnover. Only calculated for PV items. Return receipts are ignored. Not trivially aggregatable.'),
cherry_picker_receipt_cnt_pct BIGNUMERIC(38,5)
OPTIONS(description='[Cherry Picker (%)] Cherry Picker Quote in %: Number of Cherry Picker Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.'),
heavy_buyer_receipt_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Cherry Picker (Anz.)] Number of\"heavy buyer\" receipts, which contain the advertised item_1 (any type PV / NF / FA) and whose net turnover sum of all advertised items (any type PV / NF / FA) on this receipt is at least 70% of the total receipts turnover, and the sales_1 quantity sum of all these advertised items on this receipt is at least 70% of the total receipts sales_1 quantity. Return receipts are ignored. Not trivially aggregatable.'),
heavy_buyer_receipt_cnt_pct BIGNUMERIC(38,5)
OPTIONS(description='[Cherry Picker (%)] Heavy Buyer Quote in %: Number of Heavy Buyer Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.'),
pv_effic_revenue_factor BIGNUMERIC(38,5)
OPTIONS(description='[PV-Effizienz Ertrag] Additional Revenue vs. Additional Turnover as a factor, caused by the advertised PV item. Indirectly uses the baseline values for revenue, turnover from the last 6 weeks. Only for PV.'),
pv_effic_turnover_factor BIGNUMERIC(38,5)
OPTIONS(description='[PV-Effizienz Umsatz] (Additional Turnover minus Costs for the Price Reduction) vs. Costs for the Price Reduction, for the advertised PV item.'),
pv_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Werbe-PV (Basis Abverkauf) Gesamt] Absolute Advertising PV value in local currency. Calculated already on store level per item_1 as (difference of the old retail price minus new retail price) multiplied by the sales_1 quantity during the advertising period / advertising week.'),
pv_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='[Werbe-PV (Basis Abverkauf) Gesamt (%)] Advertising PV as percentage of absolute advertising PV vs. total turnover of all items (promo, non-promo).'),
pv_lp_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Werbe-PV (Basis Abverkauf) Lidl Plus] Absolute Advertising PV value in local currency for LP action type. Calculated already on store level per item_1 as (difference of the old retail price minus new retail price) multiplied by the sales_1 quantity during the advertising period / advertising week.'),
pv_lp_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='[Werbe-PV (Basis Abverkauf) Lidl Plus (%)] Advertising PV as percentage of absolute advertising PV LP vs. total turnover of all items (promo, non-promo).'),
pv_npps_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Werbe-PV (Basis Abverkauf) PromoDesigner] Absolute Advertising PV value in local currency for NPPS action type. Calculated already on store level per item_1 as (difference of the old retail price minus new retail price) multiplied by the sales_1 quantity during the advertising period / advertising week.'),
pv_npps_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='[Werbe-PV (Basis Abverkauf) PromoDesigner (%)] Advertising PV as percentage of absolute advertising PV NPPS vs. total turnover of all items (promo, non-promo).'),
pv_wawi_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Werbe-PV (Basis Abverkauf) WaWi] Absolute Advertising PV value in local currency for WAWI action type. Calculated already on store level per item_1 as (difference of the old retail price minus new retail price) multiplied by the sales_1 quantity during the advertising period / advertising week.'),
pv_wawi_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='[Werbe-PV (Basis Abverkauf) WaWi (%)] Advertising PV as percentage of absolute advertising PV WAWI vs. total turnover of all items (promo, non-promo).'),
receipt_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Bons (Anz.)] Number of advertised items receipts for the specific timeframe (advertising period / advertising week). These are receipts that contain the specific advertised item_1 and possibly other items. The advertised item_1 can belong to any action type (PV / NF / FA) and advertising period. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive, because different advertised items can be on the same receipt. This KPI shows, by how many customers the item_1 was bought, independently of the sold quantity.'),
receipt_cnt_share_pct BIGNUMERIC(38,5)
OPTIONS(description='[Bon Penetration (%)] Share of All Total Receipts in %: Share of the receipts that contain this advertised item_1, of the total number of receipts (containing promotion and / or non-promotion items), of a country_1 for the specific timeframe (advertising period / advertising week).'),
receipt_delta_rltd_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Δ Bons (Anz.)] Absolute delta of the number of advertising receipts (which contain the advertising item_1) between the current advertising week and the related advertising week.'),
receipt_delta_rltd_cnt_pct BIGNUMERIC(38,5)
OPTIONS(description='[Δ Bons (%)] Percentage delta of the number of advertising receipts (which contain the advertising item_1) between the current advertising week and the related advertising week.'),
receipt_per_store_cnt BIGNUMERIC(38,5)
OPTIONS(description='[Bons / Filiale (Anz.)] Number of advertised items receipts per store for the specific timeframe (advertising period / advertising week). These are receipts that contain the specific advertised item_1 and possibly other items. The advertised item_1 can belong to any action type (PV / NF / FA) and advertising period. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive, because different advertised items can be on the same receipt. This KPI shows, by how many customers the item_1 was bought, independently of the sold quantity.'),
receipt_rltd_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Bons Vergleich (Anz.)] Number of advertised items receipts of a chosen related advertising week. These are receipts that contain the specific advertised item_1 and possibly other items. The advertised item_1 can belong to any action type (PV / NF / FA) and advertising period. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive, because different advertised items can be on the same receipt. This KPI shows, by how many customers the item_1 was bought, independently of the sold quantity.'),
restbon_np_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Ø-Restbon NP] Rest of the receipt having a normal price: Average sum of the net turnover of all other non-advertised items of receipts containing the advertised item_1, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnover of all advertised items (including the specific advertised item_1) is excluded. See descriptions of the detailed formula components.'),
restbon_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Ø-Restbon] Rest of the receipt: Average sum of the net turnover of all other items (incl. other advertised items) of receipts containing the advertised item_1, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnover of the advertised item_1 is excluded. See descriptions of the detailed formula components.'),
restbon_turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Ø-Kalkulation (Basis Abverkauf) (in %)Restbon] The generated revenue (turnover minus buying price volume) of all items (promotion, non-promotion items) of the rest of the receipts (excluding the action item_1), which contain the advertised item. For the specific timeframe (advertising period / advertising week), in local currency.'),
store_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Filialen (Basis Abverkauf) (Anz.)] Number of stores that sold the action item_1 in the specific timeframe (advertising period / advertising week), in the region. For NF/FA items, additional 5 days prior advertising period are considered. No trivial aggregation, because each store might have multiple different items advertised.'),
total_receipt_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Bons Gesamt (Anz.)] Total number of all receipts (containing promotion and / or non-promotion items) of a country_1 for the specific timeframe (advertising period / advertising week).'),
total_receipt_rltd_cnt BIGNUMERIC(38,0)
OPTIONS(description='[Bons Gesamt Vergleich (Anz.)] Total number of all receipts (containing promotion and / or non-promotion items) of a country_1 for the specific timeframe (advertising period / advertising week) of a chosen related advertising week.'),
total_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Umsatz Gesamt] Total net turnover of all items (promotion, non-promotion items) of a country_1 for the specific timeframe (advertising period / advertising week), in local currency. Returns are ignored. Especially on advertising week level: only the 7 days of the advertising week are considered.'),
turnover_margin_pct BIGNUMERIC(38,5)
OPTIONS(description='[Kalkulation (Basis Abverkauf) (in %)] Revenue generated (turnover minus buying price volume) with this sold action item_1 vs. Turnover in %.'),
turnover_net_delta_rltd_val BIGNUMERIC(38,5)
OPTIONS(description='[Δ Umsatz] Absolute delta of the turnover of the advertising items between the current advertising week and the related advertising week.'),
turnover_net_delta_rltd_val_pct BIGNUMERIC(38,5)
OPTIONS(description='[Δ Umsatz (%)] Percentage delta of the turnover of the advertising items between the current advertising week and the related advertising week.'),
turnover_net_per_store_val BIGNUMERIC(38,5)
OPTIONS(description='[Umsatz / Filiale] Net turnover of the advertised item_1 per store, for the specific timeframe (advertising period / advertising week), returns are considered, in local currency. For NF/FA items, additional 5 days prior advertising period are considered.'),
turnover_net_rltd_val BIGNUMERIC(38,5)
OPTIONS(description='[Umsatz Vergleich] Net turnover of the advertised item_1, for the specific timeframe (advertising period / advertising week) of the chosen related advertising week, returns are considered, in local currency. For NF/FA items, additional 5 days prior advertising period are considered.'),
turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Umsatz] | [Umsatz Gesamt Aktionen] Net turnover of the advertised item_1, for the specific timeframe (advertising period / advertising week), returns are considered, in local currency. For NF/FA items, additional 5 days prior advertising period are considered.'),
turnover_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='[UA (%)] Total Turnover Share in %: Turnover of this advertised item_1 vs. the total turnover of all items (promo, non-promo) of the country_1, for the specific timeframe (advertising period / advertising week).'),
turnover_qty BIGNUMERIC(38,5)
OPTIONS(description='[Abverkauf (Werbeperiode) (Stk/kg)] Sold quantity (returns are considered) of advertised items (NF / FA / PV) during their advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.'),
turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='[Abverkaufsertrag] Revenue generated with this sold action item. Absolute value of turnover minus buying price volume.'),
turnover_revenue_net_store_val BIGNUMERIC(38,5)
OPTIONS(description='[Abverkaufsertrag / Filiale] Absolute revenue in local currency per store.'),
volume_buy_net_val BIGNUMERIC(38,5)
OPTIONS(description='[EK-Volumen Basis Abverkauf (LW)] Buying Volume based on sales_1 in local currency. Calculated as the net buying price, multiplied by the sales_1 quantity of this advertised item_1 during the period.'),
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
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID')
) CLUSTER BY client_id, adv_week_id
OPTIONS(description='frontend MSTR Aggregate Table on Country_1 / Region_1 (WH), AdvWeek, Related AdvWeek (up to 53 weeks in the past), UWG (Sub Item_1 Group) / WGI (Itemgroup_1 International). Aggregation levels distinguished by Reporting Line: Sub Item_1 Group Action Total, Item_1 Group International Action Total, Grand Action Total (over all international item_1 groups)');