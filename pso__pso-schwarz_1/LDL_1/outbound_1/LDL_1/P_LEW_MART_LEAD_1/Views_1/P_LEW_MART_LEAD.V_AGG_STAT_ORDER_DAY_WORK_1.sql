/* Umsatz_Plan */ /* Abverkauf_Umsatz */ /* Kunden */ /* Umsatz_EJR */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_stat_order_day_work_1 (client_id, dat_calendar, currency_iso_cd,
curr_tot_id, order_cnt_stationary, order_lin_cnt_stationary, turnover_net_val_stationary,
plan_turnover_net_val_stationary) AS SELECT COALESCE(tab_kunden.client_id, tab_umsatz.client_id, tab_umsatz_plan.client_id
  ) AS client_id,
 COALESCE(tab_kunden.dat_calendar, tab_umsatz.dat_calendar, tab_umsatz_plan.dat_calendar) AS dat_calendar,
 COALESCE(tab_kunden.currency_iso_cd, tab_umsatz.currency_iso_cd, tab_umsatz_plan.currency_iso_cd) AS currency_iso_cd,
 COALESCE(tab_kunden.curr_tot_id, tab_umsatz.curr_tot_id, tab_umsatz_plan.curr_tot_id) AS curr_tot_id,
 SUM(tab_kunden.order_cnt_stationary) AS order_cnt_stationary,
 SUM(tab_umsatz.order_lin_cnt_stationary) AS order_lin_cnt_stationary,
 SUM(tab_umsatz.turnover_net_val_stationary) AS turnover_net_val_stationary,
 SUM(tab_umsatz_plan.plan_turnover_net_val_stationary) AS plan_turnover_net_val_stationary
FROM (SELECT A14.curr_tot_id,
   A14.currency_iso_cd,
   A11.dat_formdate AS dat_calendar,
   A12.client_id,
   SUM(A11.cnt_customer_asis) AS order_cnt_stationary
  FROM ldl_p_lew_mart_lead_ac.v_agg_str_day_ejr_txj_ww_ext_1 AS A11
   INNER JOIN ldl_p_lew_mart_lead_ac.v_org_store_merge_wh_1 AS A12 ON A11.client_id = A12.client_id AND A11.store_id = A12
     .store_id
   INNER JOIN ldl_p_lew_mart_lead_ac.v_ref_currency_1 AS A14 ON A11.client_id = A14.client_id AND A11.currency_iso_cd =
     A14.currency_iso_cd
  WHERE A12.aspect_id IN (1)
  GROUP BY A14.curr_tot_id,
   A14.currency_iso_cd,
   dat_calendar,
   A12.client_id) AS tab_kunden
 FULL JOIN (SELECT A120.curr_tot_id,
   A120.currency_iso_cd,
   A110.dat_formdate AS dat_calendar,
   A120.client_id,
   SUM(A110.qty_piece_ejr_asis + A110.qty_weight_ejr_asis + A110.qty_return_ejr_asis) AS order_lin_cnt_stationary,
   SUM(A110.val_rtl_net_ejr_asis + A110.val_return_net_ejr_asis) AS turnover_net_val_stationary
  FROM ldl_p_lew_mart_lead_ac.v_agg_wh_org_day_item_ejr_asis_1 AS A110
   INNER JOIN ldl_p_lew_mart_lead_ac.v_ref_currency_1 AS A120 ON A110.client_id = A120.client_id AND A110.currency_iso_cd
     = A120.currency_iso_cd
   INNER JOIN ldl_p_lew_mart_lead_ac.v_ref_client_lead_base_1 AS A13 ON A120.client_id = A13.client_id
  WHERE A110.aspect_id IN (1)
  GROUP BY A120.curr_tot_id,
   A120.currency_iso_cd,
   dat_calendar,
   A120.client_id) AS tab_umsatz ON tab_kunden.client_id = tab_umsatz.client_id AND tab_kunden.dat_calendar = tab_umsatz
     .dat_calendar AND tab_kunden.currency_iso_cd = tab_umsatz.currency_iso_cd AND tab_kunden.curr_tot_id = tab_umsatz.curr_tot_id
   
 FULL JOIN (SELECT A121.curr_tot_id,
   A121.currency_iso_cd,
   A111.dat_formdate AS dat_calendar,
   A121.client_id,
   SUM(A111.val_indicator) AS plan_turnover_net_val_stationary
  FROM ldl_p_lew_mart_lead_ac.v_kpges_plan_day_wh_merge_base_1 AS A111
   INNER JOIN ldl_p_lew_mart_lead_ac.v_ref_currency_1 AS A121 ON A111.client_id = A121.client_id AND A111.currency_iso_cd
     = A121.currency_iso_cd
   INNER JOIN ldl_p_lew_mart_lead_ac.v_cal_calendarday_base_1 AS A130 ON A111.dat_formdate = A130.dat_calendar
   INNER JOIN ldl_p_lew_mart_lead_ac.v_ref_client_lead_base_1 AS A140 ON A121.client_id = A140.client_id
  WHERE A130.cy_day_sequence <= 0
   AND A111.indicator_id IN (157)
   AND A111.aspect_id IN (1)
  GROUP BY A121.curr_tot_id,
   A121.currency_iso_cd,
   dat_calendar,
   A121.client_id) AS tab_umsatz_plan ON tab_umsatz.client_id = tab_umsatz_plan.client_id AND tab_umsatz.dat_calendar =
     tab_umsatz_plan.dat_calendar AND tab_umsatz.currency_iso_cd = tab_umsatz_plan.currency_iso_cd AND tab_umsatz.curr_tot_id
    = tab_umsatz_plan.curr_tot_id
GROUP BY client_id,
 dat_calendar,
 currency_iso_cd,
 curr_tot_id;