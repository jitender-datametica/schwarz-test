/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for F_DELIVERY_WH_ITEM
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Intermediate Fact Table Delivery to WH
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  1.1  2021-08-25 Mike Davis      Checks, formatting, FK support (now removed)
#  1.2  2021-10-11 Massimo Morelli eliminate the fields ITEM_STOCK_REAL_QTY and ITEM_DELIVERY_TO_STORE_QTY
#                                  which are not in the specification document
#  1.3  2022-01-24 Andreas Kurz	   Reworked the structure after DM review
#  1.4  2023-02-09 Massimo Morelli eliminate the fields ITEM_RCV_QTY and ITEM_BUYING_PRICE_EFF
#  1.5  2023-03-25 Massimo Morelli Added the 5 fields requested today
#  1.6  2023-04-01 Massimo Morelli Added country price and flag
#  1.7  2023-04-15 Massimo Morelli Added 7 Auditing flags
#-------------------------------------------------------------------------------
*/


-- if still no price, we usa also the out of range

-- AKU 2022-01-27 Note only national currency's of the countries are used
 -- MM 2022-02-09 only buying price now

-- Technical fields
 -- AKU 20220401: Country Level KPIs, this wil be always calculated
 -- We flag this accourdingly

-- MM 2022-03-25 requested in the daily

-- MaMo 20220415 Add auditing flags to check the algorithm. If a row is touched in a step, the flag is activated

-- We use the InRange Values (INRANGE_FG == 1)

-- AKU 20220401: When there is no EK-Price or the EK-Price == 0.00 for this WH then we take the country (ctry) level EK-Price for this WH

-- AKU 2022-01-25 CROSS JOIN criteria for t_cntl_buying_price_range
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_f_delivery_wh_item
(
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g AT=1'),
country_iso_cd STRING(3) OPTIONS(description='Country ISO Code = WAWI Country'),
country_descr STRING(16777216) OPTIONS(description='Country Name'),
day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Day of Sales'),
store_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Unique key Region surrogate key'),
item_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Item Variant (Case Size)'),
orig_item_nr INTEGER OPTIONS(description='Item NaN (National Artikel Nummer) Link to Item History'),
action_type_id INTEGER
OPTIONS(description='Action type id is derived from WaWi Article reference data. Undefined/No Action, PV, NF, FA respectively.'),
item_fa_fg INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Flag / indicator telling Item is FA Food Action'),
item_nf_fg INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Flag / indicator telling that item NF None-Food'),
item_pv_fg INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Flag / indicator telling item is PV (Preisveränderung) '),
item_np_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Flag / indicator telling item Normalsortiment (NP Normalpreis) '),
orig_store_nr INTEGER OPTIONS(description='Original Store Number / code from Wawi'),
store_name STRING(16777216) OPTIONS(description='Store Name'),
warehouse_sid INTEGER OPTIONS(description='Warehouse Surrogate ID  L2'),
warehouse_name STRING(16777216) OPTIONS(description='Warehouse Name'),
orig_wh_nr INTEGER OPTIONS(description='Original Wahrehouse Number  / code from Wawi'),
curr_sid INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[FK] Unique Currency SID based Local Currency of Lidl Country'),
curr_cd STRING(16777216) OPTIONS(description='Currency Code'),
sub_item_grp_src_cd STRING(16777216) OPTIONS(description='Item sub group Wawi Source Code'),
item_grp_int_src_cd STRING(16777216) OPTIONS(description='Code for international group from source system.'),
item_buying_price BIGNUMERIC(38,5) DEFAULT 0 NOT NULL
OPTIONS(description='Einkaufspreis (EK) Buying Price - Debugging Purpose only'),
item_buying_price_calc_fg INTEGER DEFAULT 0
OPTIONS(description='Flag indicates is warehouse price was 0 and has been calculated from country price'),
last_wh_rcv_day_dt DATE OPTIONS(description='Date of the last warhouse row considered in the calculation of the price'),
item_rcv_qty BIGNUMERIC(38,5) DEFAULT 0 NOT NULL OPTIONS(description='Quantity used for the calculation of the price'),
item_rcv_buying_value BIGNUMERIC(38,5) DEFAULT 0 NOT NULL
OPTIONS(description='Value used for the calculation of the price'),
inrange_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Flag: 1 -> (deliveries) In range, 0 -> (deliveries) out of range, -1 no range or no deliveries at all'),
buy_price_range_days INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Range (in days) we look into the past to find the deliveries used to calculate the price'),
ctry_item_buying_price BIGNUMERIC(38,5) DEFAULT 0 NOT NULL
OPTIONS(description='Buying price (per item) at the level of the country'),
aud_01_wh_in_range_fg INTEGER DEFAULT 0
OPTIONS(description='Auditing Flag step 01: row touched in getting in_range wh prices'),
aud_02_wh_out_range_fg INTEGER DEFAULT 0
OPTIONS(description='Auditing Flag step 02: row touched in getting out_of range wh prices'),
aud_03_cli_in_range_fg INTEGER DEFAULT 0
OPTIONS(description='Auditing Flag step 03: row touched in getting in_range client prices'),
aud_04_cli_out_range_fg INTEGER DEFAULT 0
OPTIONS(description='Auditing Flag step 04: row touched in getting out_of range client prices'),
aud_05_mdn_wh_to_cli_fg INTEGER DEFAULT 0
OPTIONS(description='Auditing Flag step 05: row touched in getting median wh prices to client prices where qty cancels out at client level'),
aud_06_0_client_to_wh_fg INTEGER DEFAULT 0
OPTIONS(description='Auditing Flag step 06: row touched in getting the missing wh prices equal to client prices'),
aud_07_miss_cli_to_wh_fg INTEGER DEFAULT 0
OPTIONS(description='Auditing Flag step 07: row touched in getting the missing wh/item ombination equal to client prices'),
reject_reason_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Link to DQ Reject Reason Codes'),
reject_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues'),
source_system_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Source System EJR / WAWI / Delivery'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (client_id, day_dt, store_sid, item_sid, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id, day_dt
OPTIONS(description='Intermediate Fact Table on WH Delivery (buying price)');