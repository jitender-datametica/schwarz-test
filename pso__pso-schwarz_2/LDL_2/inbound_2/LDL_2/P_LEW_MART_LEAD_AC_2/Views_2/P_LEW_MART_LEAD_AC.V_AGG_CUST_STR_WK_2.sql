CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_CUST_STR_WK_2
AS
   SELECT
     client_id,
   loc_sid_store,
   currency_iso_cd,
   busyear,
   month_id,
   cy_week_partial_week_id,
   cust_wd1_val,
   cust_wd2_val,
   cust_wd3_val,
   cust_wd4_val,
   cust_wd5_val,
   cust_wd6_val,
   cust_wd7_val,
   cust_wktd_val,
   cust_mtd_val,
   cust_bytd_val,
   prev1y_cust_wktd_val,
   prev1y_cust_mtd_val,
   prev1y_cust_bytd_val,
   adj_cust_wktd_val,
   adj_cust_mtd_val,
   adj_cust_bytd_val

  FROM p_lew_mart_lead.t_agg_cust_str_wk_2;