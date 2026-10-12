CREATE OR REPLACE TABLE ldl_p_lew_mart_lidl_digital.t_agg_rcpt_hdr_ldpl_mth_1 (
aspect_id INTEGER NOT NULL OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
client_id INTEGER NOT NULL OPTIONS(description='Identifier for client'),
move_to_store_id INTEGER NOT NULL OPTIONS(description='Store ID'),
wh_id INTEGER NOT NULL OPTIONS(description='Warehouse ID'),
lidlplus_cust_fg STRING(1) NOT NULL OPTIONS(description='Lidplus customer flag'),
adjust_growth_fg INTEGER NOT NULL OPTIONS(description='Adjust growth flag - berenigte steigerung'),
mth_rf_segment_sid INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Recency-frequency segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_mth.mth_rf_segment_sid'),
mth_m_segment_sid INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Monetary Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid'),
mth_st_segment_sid INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='STRATEGIC Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid'),
mth_fr_segment_sid INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='FREQUENCY Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid'),
mth_mo_segment_sid INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='new Monetary Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid'),
mth_re_segment_sid INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='RECENCY Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid'),
busyear_qtr_rf_segment_sid INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Recency-frequency segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_busyear_qtr.busyear_qtr_rf_segment_sid'),
busyear_qtr_m_segment_sid INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Monetary Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_busyear_qtr.busyear_m_segment_sid'),
cy_month INTEGER NOT NULL OPTIONS(description='Month number'),
harmo_cal_month_no INTEGER NOT NULL OPTIONS(description='Harmonized month no  per country_1 - month since rollout'),
currency_iso_cd STRING(3) NOT NULL OPTIONS(description='ISO code for the currency of the client.'),
curr_tot_id INTEGER NOT NULL OPTIONS(description='Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id'),
cm_mth_str_open_fg INTEGER OPTIONS(description='Store open flag : Current month'),
cm_tot_gros_val NUMERIC(29,5) OPTIONS(description='Total gross value : Current month'),
cm_tot_net_val NUMERIC(29,5) OPTIONS(description='Total net value : Current month'),
cm_rcpts_cnt INTEGER OPTIONS(description='Receipts count : Current month'),
cm_tot_rcpt_cnt_mth NUMERIC(29,5) OPTIONS(description='Receipts count'),
cm_trans_time_in_mins NUMERIC(29,5) OPTIONS(description='Transaction time measured in minutes : Current month'),
cm_items_scanned_cnt INTEGER OPTIONS(description='Number of items scanned : Current month'),
cm_discount_val NUMERIC(29,5) OPTIONS(description='Discount value : Current month'),
pm_mth_str_open_fg INTEGER OPTIONS(description='Store open flag : Previous month'),
pm_tot_gros_val NUMERIC(29,5) OPTIONS(description='Total gross value : Previous month'),
pm_tot_net_val NUMERIC(29,5) OPTIONS(description='Total net value : Previous month'),
pm_rcpts_cnt INTEGER OPTIONS(description='Receipts count : Previous month'),
pm_tot_rcpt_cnt_mth NUMERIC(29,5) OPTIONS(description='Receipts count'),
pm_trans_time_in_mins NUMERIC(29,5) OPTIONS(description='Transaction time measured in minutes : Previous month'),
pm_items_scanned_cnt INTEGER OPTIONS(description='Number of items scanned : Previous month'),
pm_discount_val NUMERIC(29,5) OPTIONS(description='Discount value : Previous month'),
pym_mth_str_open_fg INTEGER OPTIONS(description='Store open flag : Previous year month'),
pym_tot_gros_val NUMERIC(29,5) OPTIONS(description='Total gross value : Previous year month'),
pym_tot_net_val NUMERIC(29,5) OPTIONS(description='Total net value : Previous year month'),
pym_rcpts_cnt INTEGER OPTIONS(description='Receipts count : Previous year month'),
pym_tot_rcpt_cnt_mth NUMERIC(29,5) OPTIONS(description='Receipts count'),
pym_trans_time_in_mins NUMERIC(29,5) OPTIONS(description='Transaction time measured in minutes : Previous year month'),
pym_items_scanned_cnt INTEGER OPTIONS(description='Number of items scanned : Previous year month'),
pym_discount_val NUMERIC(29,5) OPTIONS(description='Discount value : Previous year month'),
load_id INTEGER NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
pcwo_reason_id INTEGER DEFAULT 0
OPTIONS(description='Unique ID of the write-off or Price change reason. Country_1-specific write-off reasons have ID>100.'),
coupon_reason_nr INTEGER DEFAULT 0 OPTIONS(description='Identifier of the booking reason in SCRM'),
cm_writeoff_val NUMERIC(29,5) DEFAULT 0 OPTIONS(description='Writeoff net value: Current month'),
pm_writeoff_val NUMERIC(29,5) DEFAULT 0 OPTIONS(description='Writeoff net value: Previous month'),
pym_writeoff_val NUMERIC(29,5) DEFAULT 0 OPTIONS(description='Writeoff net value: Current month'),
gender_cd STRING(5) DEFAULT 'na' NOT NULL OPTIONS(description='the code for the geder'),
age_range_cd STRING(10) DEFAULT 'na' NOT NULL OPTIONS(description='the code for the age range.'),
household_type_id INTEGER DEFAULT 0 OPTIONS(description='ID of the household type in which the customer lives.'),
child_age_range_group_id INTEGER DEFAULT 0
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'),
PRIMARY KEY (aspect_id, client_id, move_to_store_id, lidlplus_cust_fg, cy_month, currency_iso_cd, adjust_growth_fg,
 mth_rf_segment_sid, mth_m_segment_sid, busyear_qtr_rf_segment_sid, busyear_qtr_m_segment_sid) NOT ENFORCED
) OPTIONS(description='Lidlplus : Receipt header aggregated to month level');