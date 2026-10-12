CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_agg_rcpt_cnt_ldpl_wk_1 (client_id, wh_id, move_to_store_id, aspect_id
, cy_week, store_tot_rcpt, store_lp_rcpt, wh_tot_rcpt, wh_lp_rcpt, client_tot_rcpt, client_lp_rcpt) AS SELECT AG.client_id
 ,
 SM.wh_id,
 AG.move_to_store_id,
 AG.aspect_id,
 AG.cy_week,
 SUM(AG.cw_rcpts_cnt) AS store_tot_rcpt,
 SUM(CASE
   WHEN AG.lidlplus_cust_fg = 'Y'
   THEN AG.cw_rcpts_cnt
   ELSE 0
   END) AS store_lp_rcpt,
 SUM(SUM(AG.cw_rcpts_cnt)) OVER (PARTITION BY CAST(AG.client_id AS STRING), SM.wh_id, CAST(AG.cy_week AS STRING)
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS wh_tot_rcpt,
 SUM(SUM(CASE
    WHEN AG.lidlplus_cust_fg = 'Y'
    THEN AG.cw_rcpts_cnt
    ELSE 0
    END)) OVER (PARTITION BY CAST(AG.client_id AS STRING), SM.wh_id, CAST(AG.cy_week AS STRING) RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS wh_lp_rcpt,
 SUM(SUM(AG.cw_rcpts_cnt)) OVER (PARTITION BY CAST(AG.client_id AS STRING), CAST(AG.cy_week AS STRING) RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS client_tot_rcpt,
 SUM(SUM(CASE
    WHEN AG.lidlplus_cust_fg = 'Y'
    THEN AG.cw_rcpts_cnt
    ELSE 0
    END)) OVER (PARTITION BY CAST(AG.client_id AS STRING), CAST(AG.cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
  AND UNBOUNDED FOLLOWING) AS client_lp_rcpt
FROM ldl_p_lew_mart_lidl_digital.t_agg_unq_cust_ldpl_wk_1 AS AG
 INNER JOIN ldl_p_lew_mart_lidl_digital.v_org_store_merge_1 AS SM_1 ON AG.client_id = SM.client_id AND AG.move_to_store_id =
    SM.move_to_store_id AND AG.aspect_id = SM.aspect_id
WHERE SM.move_fg = 0
 AND SM.orig_store_nr <> SM.wh_id
GROUP BY AG.client_id,
 SM.wh_id,
 AG.move_to_store_id,
 AG.aspect_id,
 AG.cy_week;