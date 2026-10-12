CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat_agg_store_day_sales_payment_type (client_id, dat_formdate, cy_month, loc_sid
, orig_store_nr, currency_iso_cd, sales_net_val_pos, return_net_val_pos, cnt_customer, sales_payment_type) AS SELECT a.client_id
 ,
 a.dwh_cal_dt AS dat_formdate,
 ROUND(CAST(FORMAT_DATE('%Y%m', a.dwh_cal_dt) AS BIGNUMERIC), 0) AS cy_month,
 a.loc_sid,
 STORE.src_orig_store_nr AS orig_store_nr,
 B.curr_cd_from AS currency_iso_cd,
  a.sales_net_val_ln / B.exchange_rate AS sales_net_val_pos,
  a.return_net_val_ln / B.exchange_rate AS return_net_val_pos,
 a.cnt_customer,
 a.sales_payment_type
FROM (SELECT client_id,
   dwh_cal_dt,
   loc_sid,
   sales_payment_type,
   SUM(sales_net_val_ln) AS sales_net_val_ln,
   SUM(return_net_val_ln) AS return_net_val_ln,
   COUNT(`A11868`) AS cnt_customer
  FROM (SELECT rcpt.client_id,
     rcpt.dwh_cal_dt,
     rcpt.loc_sid,
     MIN(t9.tendertype_ejr_cd) AS sales_payment_type,
     MAX(rcpt.sales_net_val_ln) AS sales_net_val_ln,
     MAX(rcpt.return_net_val_ln) AS return_net_val_ln,
     1 AS `A11868`
    FROM (SELECT RH.client_id,
       RH.loc_sid,
       RH.receipt_id,
       RH.register_id,
       RH.dwh_cal_dt,
       paym.paym_val_max AS receipt_paym_val_max,
       rl.sales_net_val_ln,
       rl.return_net_val_ln
      FROM ldl_p_lew_core_ac.v_pos_receiptheader AS RH
       INNER JOIN (SELECT client_id,
         loc_sid,
         receipt_id,
         register_id,
         dwh_cal_dt,
         MAX(payment_val) AS paym_val_max
        FROM (SELECT client_id,
           loc_sid,
           receipt_id,
           register_id,
           tendertype_ejr_cd,
           dwh_cal_dt,
           SUM(payment_val) AS payment_val
          FROM ldl_p_lew_core_ac.v_pos_ctrl_payment
          WHERE turnover_relevant_fg = 1
          GROUP BY client_id,
           loc_sid,
           receipt_id,
           register_id,
           tendertype_ejr_cd,
           dwh_cal_dt) AS p
        GROUP BY client_id,
         loc_sid,
         receipt_id,
         register_id,
         dwh_cal_dt) AS paym ON RH.client_id = paym.client_id AND RH.loc_sid = paym.loc_sid AND RH.register_id = paym.register_id
            AND RH.receipt_id = paym.receipt_id AND RH.dwh_cal_dt = paym.dwh_cal_dt
       INNER JOIN (SELECT client_id,
         loc_sid,
         register_id,
         receipt_id,
         dwh_cal_dt,
         SUM(CASE
           WHEN transaction_type_cd BETWEEN '100' AND '109' OR transaction_type_cd BETWEEN '120' AND '129' OR
               transaction_type_cd = '306' OR transaction_type_cd BETWEEN '600' AND '609' OR transaction_type_cd BETWEEN
             '620' AND '629'
           THEN IFNULL(sales_val, 0) * 100 / COALESCE(CASE
              WHEN CAST(vat_pct_val AS NUMERIC) + 100 = 0
              THEN NULL
              ELSE CAST(vat_pct_val AS NUMERIC) + 100
              END, 100)
           ELSE 0
           END) AS sales_net_val_ln,
         SUM(CASE
           WHEN transaction_type_cd BETWEEN '140' AND '149' OR transaction_type_cd BETWEEN '640' AND '649'
           THEN IFNULL(sales_val, 0) * 100 / COALESCE(CASE
              WHEN CAST(vat_pct_val AS NUMERIC) + 100 = 0
              THEN NULL
              ELSE CAST(vat_pct_val AS NUMERIC) + 100
              END, 100)
           ELSE 0
           END) AS return_net_val_ln
        FROM ldl_p_lew_core_ac.v_pos_receiptline
        WHERE turnover_relevant_fg = 1
        GROUP BY client_id,
         loc_sid,
         register_id,
         receipt_id,
         dwh_cal_dt) AS rl ON RH.client_id = rl.client_id AND RH.loc_sid = rl.loc_sid AND RH.register_id = rl.register_id
            AND RH.receipt_id = rl.receipt_id AND RH.dwh_cal_dt = rl.dwh_cal_dt
      WHERE RH.turnover_relevant_fg = 1) AS rcpt
     INNER JOIN (SELECT client_id,
       loc_sid,
       receipt_id,
       register_id,
       dwh_cal_dt,
       tendertype_ejr_cd,
       SUM(payment_val) AS paym_val_sum
      FROM ldl_p_lew_core_ac.v_pos_ctrl_payment
      WHERE turnover_relevant_fg = 1
      GROUP BY client_id,
       loc_sid,
       receipt_id,
       register_id,
       tendertype_ejr_cd,
       dwh_cal_dt) AS t9 ON rcpt.client_id = t9.client_id AND rcpt.loc_sid = t9.loc_sid AND rcpt.receipt_id = t9.receipt_id
           AND rcpt.register_id = t9.register_id AND rcpt.dwh_cal_dt = t9.dwh_cal_dt AND rcpt.receipt_paym_val_max = t9
       .paym_val_sum
    GROUP BY rcpt.client_id,
     rcpt.loc_sid,
     rcpt.receipt_id,
     rcpt.register_id,
     rcpt.dwh_cal_dt) AS t12
  GROUP BY client_id,
   dwh_cal_dt,
   loc_sid,
   sales_payment_type) AS a
 INNER JOIN ldl_p_lew_core_ac.v_location AS STORE ON a.client_id = STORE.client_id AND a.loc_sid = STORE.loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist AS B ON a.client_id = B.client_id AND CURRENT_DATE BETWEEN B.active_from_dt
    AND B.active_to_dt AND CURRENT_DATE BETWEEN B.dwh_valid_from AND B.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type AS C ON B.client_id = C.client_id AND B.x_rate_type_sid = C.x_rate_type_sid
     AND C.src_kurst = '@BEWE';