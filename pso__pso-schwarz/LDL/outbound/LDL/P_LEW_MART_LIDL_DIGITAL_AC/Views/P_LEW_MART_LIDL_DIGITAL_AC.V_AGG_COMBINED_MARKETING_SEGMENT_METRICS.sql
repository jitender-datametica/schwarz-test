CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_agg_combined_marketing_segment_metrics (client_id
OPTIONS(description='Identifier for client'), cy_month OPTIONS(description='Month number'), mth_st_segment_sid
OPTIONS(description='new strategy Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid'),
currency_iso_cd OPTIONS(description='ISO code for the currency of the client.'), curr_tot_id
OPTIONS(description='Fixe Werte fur EUR=0 GBP=40 sonst Client_Id'), sales_piece_weight_qty_tp
OPTIONS(description='TOtal number of items sold: Current month'), sales_piece_weight_qty_pyp
OPTIONS(description='TOtal number of items sold: Previous month'), receipt_cnt_tp
OPTIONS(description='TOtal count of receipts: Current month'), receipt_cnt_pyp
OPTIONS(description='TOtal count of receipts: Previous month'), customer_sid_tp
OPTIONS(description='Distinct count of lidl plus users: Current month'), customer_sid_pyp
OPTIONS(description='Distinct count of lidl plus users: Previous month'), tot_reg_tp
OPTIONS(description='Total number of registered users: Current month'), tot_reg_pyp
OPTIONS(description='Total number of registered users: Previous month'), discount_val_lp_tp
OPTIONS(description='Total lidl plus discount net value : Current month'), discount_val_lp_pyp
OPTIONS(description='Total lidl plus discount net value : Previous month'), total_net_val_tp
OPTIONS(description='Total revenue net value : Current month'), total_net_val_pyp
OPTIONS(description='Total revenue net value : Previous month'), total_net_val_lp_tp
OPTIONS(description='Total lidl plus revenue net value : Current month'), total_net_val_lp_pyp
OPTIONS(description='Total lidl plus revenue net value : Previous month'))
OPTIONS(DESCRIPTION = `VIEW USED AS AN AGGREGATE FOR SOURCING DATA INTO RFM DASHBAORD IN STRATEGY`) AS WITH
 UNIFIED_FACT_STREAMS AS (SELECT F.client_id,
    F.cy_month,
    F.mth_st_segment_sid,
    F.currency_iso_cd,
    F.curr_tot_id,
    SUM(F.sales_piece_weight_qty) AS s1_m1,
    CAST(NULL AS NUMERIC) AS s1_m2,
    CAST(NULL AS INTEGER) AS s2_m1,
    CAST(NULL AS INTEGER) AS s2_m2,
    CAST(NULL AS BIGINT) AS s2_m3,
    CAST(NULL AS BIGINT) AS s2_m4,
    CAST(NULL AS INTEGER) AS s3_m1,
    CAST(NULL AS INTEGER) AS s3_m2,
    CAST(NULL AS BIGNUMERIC) AS s4_m1,
    CAST(NULL AS BIGNUMERIC) AS s4_m2,
    CAST(NULL AS NUMERIC) AS s5_m1,
    CAST(NULL AS NUMERIC) AS s5_m2,
    CAST(NULL AS NUMERIC) AS s6_m1,
    CAST(NULL AS NUMERIC) AS s6_m2
   FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_client_store_item_ldpl_day AS F
    INNER JOIN ldl_p_lew_mart_msi.v_cal_month_desc AS G ON F.cy_month = G.cy_month
    INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_month AS H ON F.cy_month = H.cy_month
   WHERE F.lidlplus_cust_fg = 'Y'
    AND H.cy_month_sequence BETWEEN -25 AND 0
    AND F.mth_st_segment_sid NOT IN (-9, 0)
   GROUP BY F.client_id,
    F.cy_month,
    F.mth_st_segment_sid,
    F.currency_iso_cd,
    F.curr_tot_id,
    s1_m2,
    s2_m1,
    s2_m2,
    s2_m3,
    s2_m4,
    s3_m1,
    s3_m2,
    s4_m1,
    s4_m2,
    s5_m1,
    s5_m2,
    s6_m1,
    s6_m2
   UNION ALL
   SELECT F0.client_id,
    F0.cy_month_prev_1y AS cy_month,
    F0.mth_st_segment_sid,
    F0.currency_iso_cd,
    F0.curr_tot_id,
    CAST(NULL AS NUMERIC) AS s1_m1,
    SUM(F0.sales_piece_weight_qty) AS s1_m2,
    CAST(NULL AS INTEGER) AS s2_m1,
    CAST(NULL AS INTEGER) AS s2_m2,
    CAST(NULL AS BIGINT) AS s2_m3,
    CAST(NULL AS BIGINT) AS s2_m4,
    CAST(NULL AS INTEGER) AS s3_m1,
    CAST(NULL AS INTEGER) AS s3_m2,
    CAST(NULL AS BIGNUMERIC) AS s4_m1,
    CAST(NULL AS BIGNUMERIC) AS s4_m2,
    CAST(NULL AS NUMERIC) AS s5_m1,
    CAST(NULL AS NUMERIC) AS s5_m2,
    CAST(NULL AS NUMERIC) AS s6_m1,
    CAST(NULL AS NUMERIC) AS s6_m2
   FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_client_store_item_ldpl_day AS F0
    INNER JOIN ldl_p_lew_mart_msi.v_cal_month_desc AS G0 ON F0.cy_month_prev_1y = G0.cy_month
    INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_month AS H0 ON F0.cy_month = H0.cy_month
   WHERE F0.lidlplus_cust_fg = 'Y'
    AND H0.cy_month_sequence BETWEEN -25 AND 0
    AND F0.mth_st_segment_sid NOT IN (-9, 0)
   GROUP BY F0.client_id,
    cy_month,
    F0.mth_st_segment_sid,
    F0.currency_iso_cd,
    F0.curr_tot_id,
    s1_m1,
    s2_m1,
    s2_m2,
    s2_m3,
    s2_m4,
    s3_m1,
    s3_m2,
    s4_m1,
    s4_m2,
    s5_m1,
    s5_m2,
    s6_m1,
    s6_m2
   UNION ALL
   SELECT F1.client_id,
    F1.cy_month,
    F1.mth_st_segment_sid,
    F1.currency_iso_cd,
    F1.curr_tot_id,
    CAST(NULL AS NUMERIC) AS s1_m1,
    CAST(NULL AS NUMERIC) AS s1_m2,
    SUM(F1.cm_rcpts_cnt) AS s2_m1,
    SUM(F1.pym_rcpts_cnt) AS s2_m2,
    COUNT(DISTINCT CASE
      WHEN F1.cm_cust_act = 1
      THEN F1.customer_sid
      ELSE NULL
      END) AS s2_m3,
    COUNT(DISTINCT CASE
      WHEN F1.pym_cust_act = 1
      THEN F1.customer_sid
      ELSE NULL
      END) AS s2_m4,
    CAST(NULL AS INTEGER) AS s3_m1,
    CAST(NULL AS INTEGER) AS s3_m2,
    CAST(NULL AS BIGNUMERIC) AS s4_m1,
    CAST(NULL AS BIGNUMERIC) AS s4_m2,
    CAST(NULL AS NUMERIC) AS s5_m1,
    CAST(NULL AS NUMERIC) AS s5_m2,
    CAST(NULL AS NUMERIC) AS s6_m1,
    CAST(NULL AS NUMERIC) AS s6_m2
   FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_unq_cust_ldpl_mth AS F1
    INNER JOIN ldl_p_lew_mart_msi.v_cal_month_desc AS G1 ON F1.cy_month = G1.cy_month
    INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_month AS H1 ON F1.cy_month = H1.cy_month
   WHERE H1.cy_month_sequence BETWEEN -25 AND 0
    AND F1.lidlplus_cust_fg = 'Y'
    AND F1.curr_tot_id = 0
    AND F1.mth_st_segment_sid NOT IN (-9, 0)
   GROUP BY F1.client_id,
    F1.cy_month,
    F1.mth_st_segment_sid,
    F1.currency_iso_cd,
    F1.curr_tot_id,
    s1_m1,
    s1_m2,
    s3_m1,
    s3_m2,
    s4_m1,
    s4_m2,
    s5_m1,
    s5_m2,
    s6_m1,
    s6_m2
   UNION ALL
   SELECT F2.client_id,
    F2.cy_month,
    F2.mth_st_segment_sid,
    'EUR' AS currency_iso_cd,
    0 AS curr_tot_id,
    CAST(NULL AS NUMERIC) AS s1_m1,
    CAST(NULL AS NUMERIC) AS s1_m2,
    CAST(NULL AS INTEGER) AS s2_m1,
    CAST(NULL AS INTEGER) AS s2_m2,
    CAST(NULL AS BIGINT) AS s2_m3,
    CAST(NULL AS BIGINT) AS s2_m4,
    SUM(F2.cm_total_new_reg_cnt) AS s3_m1,
    SUM(F2.pym_total_new_reg_cnt) AS s3_m2,
    CAST(NULL AS BIGNUMERIC) AS s4_m1,
    CAST(NULL AS BIGNUMERIC) AS s4_m2,
    CAST(NULL AS NUMERIC) AS s5_m1,
    CAST(NULL AS NUMERIC) AS s5_m2,
    CAST(NULL AS NUMERIC) AS s6_m1,
    CAST(NULL AS NUMERIC) AS s6_m2
   FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_cust_reg_dereg_ldpl_mth AS F2
    INNER JOIN ldl_p_lew_mart_msi.v_cal_month_desc AS G2 ON F2.cy_month = G2.cy_month
    INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_month AS H2 ON F2.cy_month = H2.cy_month
   WHERE H2.cy_month_sequence BETWEEN -25 AND 0
    AND F2.mth_st_segment_sid NOT IN (-9, 0)
   GROUP BY F2.client_id,
    F2.cy_month,
    F2.mth_st_segment_sid,
    currency_iso_cd,
    curr_tot_id,
    s1_m1,
    s1_m2,
    s2_m1,
    s2_m2,
    s2_m3,
    s2_m4,
    s4_m1,
    s4_m2,
    s5_m1,
    s5_m2,
    s6_m1,
    s6_m2
   UNION ALL
   SELECT F3.client_id,
    F3.cy_month,
    F3.mth_st_segment_sid,
    F3.currency_iso_cd,
    F3.curr_tot_id,
    CAST(NULL AS NUMERIC) AS s1_m1,
    CAST(NULL AS NUMERIC) AS s1_m2,
    CAST(NULL AS INTEGER) AS s2_m1,
    CAST(NULL AS INTEGER) AS s2_m2,
    CAST(NULL AS BIGINT) AS s2_m3,
    CAST(NULL AS BIGINT) AS s2_m4,
    CAST(NULL AS INTEGER) AS s3_m1,
    CAST(NULL AS INTEGER) AS s3_m2,
    SUM(F3.discount_val) AS s4_m1,
    CAST(NULL AS BIGNUMERIC) AS s4_m2,
    CAST(NULL AS NUMERIC) AS s5_m1,
    CAST(NULL AS NUMERIC) AS s5_m2,
    CAST(NULL AS NUMERIC) AS s6_m1,
    CAST(NULL AS NUMERIC) AS s6_m2
   FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_rcpt_coupon_promo_discount_ldpl_day AS F3
    INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_feature AS F_FEAT ON F3.feature_id = F_FEAT.feature_id
    INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_feature_subgroup AS F_SUB ON F_FEAT.feature_subgroup_id = F_SUB.feature_subgroup_id
     
    INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_feature_group AS J ON F_SUB.feature_group_id = J.feature_group_id
    INNER JOIN ldl_p_lew_mart_msi.v_cal_month_desc AS G3 ON F3.cy_month = G3.cy_month
    INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_month AS H3 ON F3.cy_month = H3.cy_month
   WHERE F3.lidlplus_cust_fg = 'Y'
    AND J.loyalty_id = 1
    AND H3.cy_month_sequence BETWEEN -25 AND 0
    AND F3.mth_st_segment_sid NOT IN (-9, 0)
   GROUP BY F3.client_id,
    F3.cy_month,
    F3.mth_st_segment_sid,
    F3.currency_iso_cd,
    F3.curr_tot_id,
    s1_m1,
    s1_m2,
    s2_m1,
    s2_m2,
    s2_m3,
    s2_m4,
    s3_m1,
    s3_m2,
    s4_m2,
    s5_m1,
    s5_m2,
    s6_m1,
    s6_m2
   UNION ALL
   SELECT F4.client_id,
    F4.cy_month_prev_1y AS cy_month,
    F4.mth_st_segment_sid,
    F4.currency_iso_cd,
    F4.curr_tot_id,
    CAST(NULL AS NUMERIC) AS s1_m1,
    CAST(NULL AS NUMERIC) AS s1_m2,
    CAST(NULL AS INTEGER) AS s2_m1,
    CAST(NULL AS INTEGER) AS s2_m2,
    CAST(NULL AS BIGINT) AS s2_m3,
    CAST(NULL AS BIGINT) AS s2_m4,
    CAST(NULL AS INTEGER) AS s3_m1,
    CAST(NULL AS INTEGER) AS s3_m2,
    CAST(NULL AS BIGNUMERIC) AS s4_m1,
    SUM(F4.discount_val) AS s4_m2,
    CAST(NULL AS NUMERIC) AS s5_m1,
    CAST(NULL AS NUMERIC) AS s5_m2,
    CAST(NULL AS NUMERIC) AS s6_m1,
    CAST(NULL AS NUMERIC) AS s6_m2
   FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_rcpt_coupon_promo_discount_ldpl_day AS F4
    INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_feature AS F_FEAT0 ON F4.feature_id = F_FEAT0.feature_id
    INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_feature_subgroup AS F_SUB0 ON F_FEAT0.feature_subgroup_id = F_SUB0.feature_subgroup_id
     
    INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_feature_group AS J0 ON F_SUB0.feature_group_id = J0.feature_group_id
     
    INNER JOIN ldl_p_lew_mart_msi.v_cal_month_desc AS G4 ON F4.cy_month_prev_1y = G4.cy_month
    INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_month AS H4 ON F4.cy_month = H4.cy_month
   WHERE F4.lidlplus_cust_fg = 'Y'
    AND J0.loyalty_id = 1
    AND H4.cy_month_sequence BETWEEN -25 AND 0
    AND F4.mth_st_segment_sid NOT IN (-9, 0)
   GROUP BY F4.client_id,
    cy_month,
    F4.mth_st_segment_sid,
    F4.currency_iso_cd,
    F4.curr_tot_id,
    s1_m1,
    s1_m2,
    s2_m1,
    s2_m2,
    s2_m3,
    s2_m4,
    s3_m1,
    s3_m2,
    s4_m1,
    s5_m1,
    s5_m2,
    s6_m1,
    s6_m2
   UNION ALL
   SELECT F5.client_id,
    F5.cy_month,
    F5.mth_st_segment_sid,
    F5.currency_iso_cd,
    F5.curr_tot_id,
    CAST(NULL AS NUMERIC) AS s1_m1,
    CAST(NULL AS NUMERIC) AS s1_m2,
    CAST(NULL AS INTEGER) AS s2_m1,
    CAST(NULL AS INTEGER) AS s2_m2,
    CAST(NULL AS BIGINT) AS s2_m3,
    CAST(NULL AS BIGINT) AS s2_m4,
    CAST(NULL AS INTEGER) AS s3_m1,
    CAST(NULL AS INTEGER) AS s3_m2,
    CAST(NULL AS BIGNUMERIC) AS s4_m1,
    CAST(NULL AS BIGNUMERIC) AS s4_m2,
    SUM(F5.cm_tot_net_val) AS s5_m1,
    SUM(F5.pym_tot_net_val) AS s5_m2,
    CAST(NULL AS NUMERIC) AS s6_m1,
    CAST(NULL AS NUMERIC) AS s6_m2
   FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_rcpt_hdr_ldpl_mth AS F5
    INNER JOIN ldl_p_lew_mart_msi.v_cal_month_desc AS G5 ON F5.cy_month = G5.cy_month
    INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_month AS H5 ON F5.cy_month = H5.cy_month
   WHERE H5.cy_month_sequence BETWEEN -25 AND 0
    AND F5.mth_st_segment_sid NOT IN (-9, 0)
   GROUP BY F5.client_id,
    F5.cy_month,
    F5.mth_st_segment_sid,
    F5.currency_iso_cd,
    F5.curr_tot_id,
    s1_m1,
    s1_m2,
    s2_m1,
    s2_m2,
    s2_m3,
    s2_m4,
    s3_m1,
    s3_m2,
    s4_m1,
    s4_m2,
    s6_m1,
    s6_m2
   UNION ALL
   SELECT F6.client_id,
    F6.cy_month,
    F6.mth_st_segment_sid,
    F6.currency_iso_cd,
    F6.curr_tot_id,
    CAST(NULL AS NUMERIC) AS s1_m1,
    CAST(NULL AS NUMERIC) AS s1_m2,
    CAST(NULL AS INTEGER) AS s2_m1,
    CAST(NULL AS INTEGER) AS s2_m2,
    CAST(NULL AS BIGINT) AS s2_m3,
    CAST(NULL AS BIGINT) AS s2_m4,
    CAST(NULL AS INTEGER) AS s3_m1,
    CAST(NULL AS INTEGER) AS s3_m2,
    CAST(NULL AS BIGNUMERIC) AS s4_m1,
    CAST(NULL AS BIGNUMERIC) AS s4_m2,
    CAST(NULL AS NUMERIC) AS s5_m1,
    CAST(NULL AS NUMERIC) AS s5_m2,
    SUM(F6.cm_tot_net_val) AS s6_m1,
    SUM(F6.pym_tot_net_val) AS s6_m2
   FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_rcpt_hdr_ldpl_mth AS F6
    INNER JOIN ldl_p_lew_mart_msi.v_cal_month_desc AS G6 ON F6.cy_month = G6.cy_month
    INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_month AS H6 ON F6.cy_month = H6.cy_month
   WHERE F6.lidlplus_cust_fg = 'Y'
    AND H6.cy_month_sequence BETWEEN -25 AND 0
    AND F6.mth_st_segment_sid NOT IN (-9, 0)
   GROUP BY F6.client_id,
    F6.cy_month,
    F6.mth_st_segment_sid,
    F6.currency_iso_cd,
    F6.curr_tot_id,
    s1_m1,
    s1_m2,
    s2_m1,
    s2_m2,
    s2_m3,
    s2_m4,
    s3_m1,
    s3_m2,
    s4_m1,
    s4_m2,
    s5_m1,
    s5_m2), CONSOLIDATED_METRICS AS (SELECT client_id,
   cy_month,
   mth_st_segment_sid,
   currency_iso_cd,
   curr_tot_id -- SQL 1 LIDL PLUS ABVERKAUF BEREINIGT EJR (STK./KG)
,
   MAX(s1_m1) AS sales_piece_weight_qty_tp,
   MAX(s1_m2) AS sales_piece_weight_qty_pyp,
   MAX(s2_m1) AS receipt_cnt_tp,
   MAX(s2_m2) AS receipt_cnt_pyp,
   MAX(s2_m3) AS customer_sid_tp,
   MAX(s2_m4) AS customer_sid_pyp,
   MAX(s3_m1) AS tot_reg_tp,
   MAX(s3_m2) AS tot_reg_pyp,
   MAX(s4_m1) AS discount_val_lp_tp,
   MAX(s4_m2) AS discount_val_lp_pyp,
   MAX(s5_m1) AS total_net_val_tp,
   MAX(s5_m2) AS total_net_val_pyp,
   MAX(s6_m1) AS total_net_val_lp_tp,
   MAX(s6_m2) AS total_net_val_lp_pyp
  FROM UNIFIED_FACT_STREAMS
  GROUP BY client_id,
   cy_month,
   mth_st_segment_sid,
   currency_iso_cd,
   curr_tot_id) (-- 
 -- SQL 1: STREAMS FOR V_AGG_CLIENT_STORE_ITEM_LDPL_DAY
 -- 

  -- CURRENT LIDL PLUS ABVERKAUF BEREINIGT EJR (STK./KG)

  -- PREVIOUS 1 YEAR LIDL PLUS ABVERKAUF BEREINIGT EJR (STK./KG)
 -- 

  -- SQL 2: COMBINED RECEIPTS STREAM AND DISTINCT COUNT OF CUSTOMERS(V_AGG_UNQ_CUST_LDPL_MTH)
 -- 

  -- COMPUTES BOTH PREVIOUS 1 YEAR LIDL PLUS BON (ANZ.) AND CURRENT MONTH LIDL PLUS BON (ANZ.) IN 1 PASS

  -- CURRENT MONTH AND PREVIOUS YEAR LIDL PLUS KUNDEN (ANZ.)
 -- 
 -- SQL 3: STREAM FOR V_AGG_CUST_REG_DEREG_LDPL_MTH

  -- 
 -- LIDL PLUS REGISTRIERTE NUTZER (ANZ.)
 -- 
 -- SQL 4: STREAMS FOR V_AGG_RCPT_COUPON_PROMO_DISCOUNT_LDPL_DAY

  -- 
 -- CURRENT MONTH LOYALTY PREISVERÄNDERUNG (LW)
 -- PREVIOUS 1 YEAR LOYALTY PREISVERÄNDERUNG (LW)

  -- SQL 5: TOTAL NET VALUES (GESAMT UMSATZ EJR (LW))
 -- SQL 6: TOTAL NET VALUES (LIDL PLUS UMSATZ EJR (LW))

  -- SQL 2 LIDL PLUS BON (ANZ.)
 -- SQL 3 LIDL PLUS REGISTRIERTE NUTZER (ANZ.)

  -- SQL 4 LOYALTY PREISVERÄNDERUNG (LW) LJ
 -- SQL 5: TOTAL NET VALUES (GESAMT UMSATZ EJR (LW))

  -- SQL 6: TOTAL NET VALUES (LIDL PLUS UMSATZ EJR (LW))
 SELECT client_id,
   cy_month,
   mth_st_segment_sid,
   currency_iso_cd,
   curr_tot_id,
   sales_piece_weight_qty_tp,
   sales_piece_weight_qty_pyp,
   receipt_cnt_tp,
   receipt_cnt_pyp,
   customer_sid_tp,
   customer_sid_pyp,
   tot_reg_tp,
   tot_reg_pyp,
   discount_val_lp_tp,
   discount_val_lp_pyp,
   total_net_val_tp,
   total_net_val_pyp,
   total_net_val_lp_tp,
   total_net_val_lp_pyp
  FROM CONSOLIDATED_METRICS);