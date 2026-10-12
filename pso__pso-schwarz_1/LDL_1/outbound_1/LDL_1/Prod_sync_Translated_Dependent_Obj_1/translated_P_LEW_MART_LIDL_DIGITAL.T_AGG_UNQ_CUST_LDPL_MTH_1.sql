DROP TABLE IF EXISTS ldl_p_lew_mart_lidl_digital.t_agg_unq_cust_ldpl_mth_1;
CREATE OR REPLACE TABLE ldl_p_lew_mart_lidl_digital.t_agg_unq_cust_ldpl_mth_1 (
aspect_id INTEGER NOT NULL OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
client_id INTEGER NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
cy_month INTEGER NOT NULL OPTIONS(description='Lidl+ : Month value (-1 means data is not at month level)'),
harmo_cal_month_no INTEGER NOT NULL OPTIONS(description='Harmonized month no  per country_1 - month since rollout'),
move_to_store_id INTEGER NOT NULL OPTIONS(description='Lidl Store Id'),
wh_id INTEGER NOT NULL OPTIONS(description='Warehouse ID'),
customer_sid INTEGER NOT NULL OPTIONS(description='Surrogate Key CUSTOMER'),
lidlplus_cust_fg STRING(1) NOT NULL OPTIONS(description='Lidl Plus Customer Flag'),
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
currency_iso_cd STRING(3) NOT NULL OPTIONS(description='iso code for the clients (countrys) currency'),
curr_tot_id INTEGER NOT NULL OPTIONS(description='Fixe Werte fur EUR=0, GBP=40 sonst Client_Id'),
cm_cust_act INTEGER OPTIONS(description='Current Month Customer Active flag 1 for active 0 for not active'),
pm_cust_act INTEGER OPTIONS(description='Previous Month Customer Active flag 1 for active 0 for not active'),
pym_cust_act INTEGER OPTIONS(description='Previous Year Month Customer Active flag 1 for active 0 for not active'),
cm_mth_str_open_fg INTEGER OPTIONS(description='Store open flag : Current month'),
cm_rcpts_cnt INTEGER OPTIONS(description='Receipts count : Current month'),
pm_mth_str_open_fg INTEGER OPTIONS(description='Store open flag : Previous month'),
pm_rcpts_cnt INTEGER OPTIONS(description='Receipts count : Previous month'),
pym_mth_str_open_fg INTEGER OPTIONS(description='Store open flag : Previous year month'),
pym_rcpts_cnt INTEGER OPTIONS(description='Receipts count : Previous year month'),
load_id INTEGER NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (aspect_id, client_id, cy_month, move_to_store_id, customer_sid, adjust_growth_fg, currency_iso_cd)
NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='Table for Unique customer every Month');