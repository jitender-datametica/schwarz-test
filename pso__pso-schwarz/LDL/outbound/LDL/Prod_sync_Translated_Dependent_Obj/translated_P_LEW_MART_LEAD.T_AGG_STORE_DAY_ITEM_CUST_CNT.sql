DROP TABLE IF EXISTS ldl_p_lew_mart_lead.t_agg_store_day_item_cust_cnt;
CREATE OR REPLACE TABLE ldl_p_lew_mart_lead.t_agg_store_day_item_cust_cnt (
client_id INTEGER NOT NULL OPTIONS(description='Client identifier'),
loc_sid_store INTEGER NOT NULL OPTIONS(description='Store identifier'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Record date'),
cy_month INTEGER NOT NULL OPTIONS(description='Month'),
item_sid INTEGER NOT NULL OPTIONS(description='Item identifier'),
src_orig_item_nr INTEGER OPTIONS(description='Item number'),
item_grp_int_sid INTEGER OPTIONS(description='Item group identifier'),
itemgroup_int_id INTEGER OPTIONS(description='Item group number'),
sub_item_grp_sid INTEGER OPTIONS(description='Sub item group identifier'),
subitemgroup_id INTEGER OPTIONS(description='Sub item group number'),
item_fam_grp_sid INTEGER OPTIONS(description='Item family group identifier'),
item_familygroup_id STRING(15) OPTIONS(description='Item family group number'),
buying_list_type_id_curr INTEGER NOT NULL OPTIONS(description='Buying list type current identifier'),
buying_list_type_id_hist INTEGER NOT NULL OPTIONS(description='Buying list type historic identifier'),
listing_type_id_hist INTEGER NOT NULL OPTIONS(description='Listing type historic identifier'),
wgi_cnt_customer INTEGER NOT NULL OPTIONS(description='Number of customers on WGI level'),
uwg_cnt_customer INTEGER NOT NULL OPTIONS(description='Number of customers on UWG level'),
fam_cnt_customer INTEGER NOT NULL OPTIONS(description='Number of customers on Article Family level'),
itm_cnt_customer INTEGER NOT NULL OPTIONS(description='Number of customers on item level'),
buy_list_cnt_customer INTEGER NOT NULL OPTIONS(description='Number of customers on buying list type current level'),
buy_list_hist_cnt_customer INTEGER NOT NULL
OPTIONS(description='Number of customers on buying list type historic level'),
list_type_hist_cnt_customer INTEGER NOT NULL OPTIONS(description='Number of customers on listing type historic level'),
store_day_cnt_customer INTEGER NOT NULL OPTIONS(description='Number of customers on store day level'),
dwh_load_id INTEGER NOT NULL OPTIONS(description='DWH load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) record created')
) CLUSTER BY client_id, dwh_cal_dt
OPTIONS(description='Customer count on store day item level.');