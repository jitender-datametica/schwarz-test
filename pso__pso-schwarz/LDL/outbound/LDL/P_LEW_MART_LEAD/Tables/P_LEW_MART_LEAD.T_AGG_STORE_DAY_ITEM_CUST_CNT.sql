/*
#----------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_AGG_STORE_DAY_ITEM_CUST_CNT
#----------------------------------------------------------------------------
# History:
# 1.0 2022-03-18  Marcin Malec        Initial Version
#                                     SPEC0148143 - Anz. Kunden | Sortimentsebene
# 1.1 2023-06-14  Marcin Malec        Removing NOT NULL constraint for WGI/UWG columns - client/item/day issues with missing references in source data
# 1.2 2025-04-03  Bharat Yeddulapalli  Added new column to bring customer count at Store - Day Level as part of AP0257238| SPEC0304265.
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_store_day_item_cust_cnt (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client identifier'),
loc_sid_store BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Store identifier'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Record date'),
cy_month BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Month'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Item identifier'),
src_orig_item_nr BIGNUMERIC(38,0) OPTIONS(description='Item number'),
item_grp_int_sid BIGNUMERIC(38,0) OPTIONS(description='Item group identifier'),
itemgroup_int_id BIGNUMERIC(38,0) OPTIONS(description='Item group number'),
sub_item_grp_sid BIGNUMERIC(38,0) OPTIONS(description='Sub item group identifier'),
subitemgroup_id BIGNUMERIC(38,0) OPTIONS(description='Sub item group number'),
item_fam_grp_sid BIGNUMERIC(38,0) OPTIONS(description='Item family group identifier'),
item_familygroup_id STRING(15) OPTIONS(description='Item family group number'),
buying_list_type_id_curr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Buying list type current identifier'),
buying_list_type_id_hist BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Buying list type historic identifier'),
listing_type_id_hist BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Listing type historic identifier'),
wgi_cnt_customer BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Number of customers on WGI level'),
uwg_cnt_customer BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Number of customers on UWG level'),
fam_cnt_customer BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Number of customers on Article Family level'),
itm_cnt_customer BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Number of customers on item level'),
buy_list_cnt_customer BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Number of customers on buying list type current level'),
buy_list_hist_cnt_customer BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Number of customers on buying list type historic level'),
list_type_hist_cnt_customer BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Number of customers on listing type historic level'),
store_day_cnt_customer BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Number of customers on store day level'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Timestamp record created')
) CLUSTER BY client_id, dwh_cal_dt
OPTIONS(description='Customer count on store day item level.');