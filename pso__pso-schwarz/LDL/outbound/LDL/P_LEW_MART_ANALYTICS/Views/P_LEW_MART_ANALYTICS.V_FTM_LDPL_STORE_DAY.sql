CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics.v_ftm_ldpl_store_day (client_id, country_code, dat_formdate, cy_week,
store_id, orig_store_nr, cnt_cust, cnt_rcpt) AS SELECT A11.client_id,
 A12.country_iso_cd AS country_code,
 A11.dat_calendar AS dat_formdate,
 A11.cy_week,
 A11.loc_sid AS store_id,
 A12.orig_store_nr,
 SUM(A11.cnt_cust) AS cnt_cust,
 SUM(A11.cnt_rcpt) AS cnt_rcpt
FROM (SELECT dwh_cal_dt AS dat_calendar,
   move_to_store_id,
   aspect_id,
   client_id,
   loc_sid,
   cy_week,
    CASE
    WHEN COUNT(DISTINCT customer_sid) = 0
    THEN NULL
    ELSE COUNT(DISTINCT customer_sid)
    END AS cnt_cust,
    CASE
    WHEN COUNT(DISTINCT receipt_cnt_uniq) = 0
    THEN NULL
    ELSE COUNT(DISTINCT receipt_cnt_uniq)
    END AS cnt_rcpt
  FROM ldl_p_lew_mart_lidl_digital.v_agg_client_store_rcpt_item_ldpl_day
  WHERE aspect_id = 2
   AND lidlplus_cust_fg = 'Y'
  GROUP BY dat_calendar,
   move_to_store_id,
   aspect_id,
   client_id,
   loc_sid,
   cy_week) AS A11
 INNER JOIN ldl_p_lew_mart_msi.v_org_all_store_merge AS A12 ON A11.aspect_id = A12.aspect_id AND A11.client_id = A12.client_id
     AND A11.move_to_store_id = A12.move_to_store_id
GROUP BY A11.client_id,
 country_code,
 dat_formdate,
 A11.cy_week,
 store_id,
 A12.orig_store_nr;