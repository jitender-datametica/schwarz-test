CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_CUST_CNT_WH_STR_WK_AGG
(	
cy_week_partial_week_id	
, client_id	
, wh_id	
, aspect_id	
, store_id	
, currency_iso_cd	
, business_yr	
, month_id	
, week_id	
, asis_cust_cnt_wh_str_day1	
, asis_cust_cnt_wh_str_day2	
, asis_cust_cnt_wh_str_day3	
, asis_cust_cnt_wh_str_day4	
, asis_cust_cnt_wh_str_day5	
, asis_cust_cnt_wh_str_day6	
, asis_cust_cnt_wh_str_day7	
, asis_cust_cnt_wh_str_wk	
, asis_cust_cnt_wh_str_mth	
, asis_cust_cnt_wh_str_yr	
, p1ycwd_cust_cnt_wh_str_wk	
, p1ycmd_cust_cnt_wh_str_mth	
, p1ycyd_cust_cnt_wh_str_yr	
, br_p1ycwd_cust_cnt_wh_str_wk	
, br_p1ycmd_cust_cnt_wh_str_mth	
, br_p1ycyd_cust_cnt_wh_str_yr	
)	
AS	
   SELECT	
   cy_week_partial_week_id,	
   client_id,	
   wh_id,	
   aspect_id,	
   store_id,	
   currency_iso_cd,	
   business_yr,	
   month_id,	
   week_id,	
   asis_cust_cnt_wh_str_day1,	
   asis_cust_cnt_wh_str_day2,	
   asis_cust_cnt_wh_str_day3,	
   asis_cust_cnt_wh_str_day4,	
   asis_cust_cnt_wh_str_day5,	
   asis_cust_cnt_wh_str_day6,	
   asis_cust_cnt_wh_str_day7,	
   asis_cust_cnt_wh_str_wk,	
   asis_cust_cnt_wh_str_mth,	
   asis_cust_cnt_wh_str_yr,	
   p1ycwd_cust_cnt_wh_str_wk,	
   p1ycmd_cust_cnt_wh_str_mth,	
   p1ycyd_cust_cnt_wh_str_yr,	
   br_p1ycwd_cust_cnt_wh_str_wk,	
   br_p1ycmd_cust_cnt_wh_str_mth,	
   br_p1ycyd_cust_cnt_wh_str_yr	
  FROM p_lew_mart_msi.t_cust_cnt_wh_str_wk_agg	
;