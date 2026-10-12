CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_STAT_ORDER_WK_WORK_1
      (
       client_id
      ,cy_week
      ,currency_iso_cd
      ,curr_tot_id
      ,order_cnt_stationary                       /* Kunden */
      ,order_lin_cnt_stationary                   /* Abverkauf_Umsatz */
      ,turnover_net_val_stationary                /* Umsatz_EJR */
      ,plan_turnover_net_val_stationary           /* Umsatz_Plan */
      )
      AS
         SELECT
         COALESCE(tab_kunden.client_id, tab_umsatz.client_id, tab_umsatz_plan.client_id)
         ,COALESCE(tab_kunden.cy_week, tab_umsatz.cy_week, tab_umsatz_plan.cy_week)
         ,COALESCE(tab_kunden.currency_iso_cd, tab_umsatz.currency_iso_cd, tab_umsatz_plan.currency_iso_cd)
         ,COALESCE(tab_kunden.curr_tot_id, tab_umsatz.curr_tot_id, tab_umsatz_plan.curr_tot_id)
         ,SUM(tab_kunden.order_cnt_stationary)
         ,SUM(tab_umsatz.order_lin_cnt_stationary)
         ,SUM(tab_umsatz.turnover_net_val_stationary)
         ,SUM(tab_umsatz_plan.plan_turnover_net_val_stationary)
         FROM
         (SELECT
         a14.curr_tot_id  curr_tot_id
         ,a14.currency_iso_cd  currency_iso_cd
         ,a13.cy_week  cy_week
         ,a12.client_id  client_id
         ,SUM(a11.cnt_customer_asis)  order_cnt_stationary
         FROM p_lew_mart_lead_ac.v_agg_str_day_ejr_txj_ww_ext_1    a11
         INNER JOIN p_lew_mart_lead_ac.v_org_store_merge_wh_1    a12
         ON     (a11.client_id = a12.client_id AND
         a11.store_id = a12.store_id)
         INNER JOIN p_lew_mart_lead_ac.v_cal_calendarday_base_1    a13
         ON     (a11.dat_formdate = a13.dat_calendar)
         INNER JOIN p_lew_mart_lead_ac.v_ref_currency_1    a14
         ON     (a11.client_id = a14.client_id AND
         a11.currency_iso_cd = a14.currency_iso_cd)
     WHERE    (a12.aspect_id IN (1)        )
     GROUP BY
          a14.curr_tot_id
         ,a14.currency_iso_cd
         ,a13.cy_week
         ,a12.client_id ) AS tab_kunden
         FULL OUTER JOIN
         (SELECT
         a12.curr_tot_id  curr_tot_id
         ,a12.currency_iso_cd  currency_iso_cd
         ,a13.cy_week  cy_week
         ,a12.client_id  client_id
         ,SUM(((a11.qty_piece_ejr_asis + a11.qty_weight_ejr_asis) + a11.qty_return_ejr_asis))  order_lin_cnt_stationary
         ,SUM((a11.val_rtl_net_ejr_asis + a11.val_return_net_ejr_asis))    turnover_net_val_stationary
         FROM p_lew_mart_lead_ac.v_agg_wh_org_day_item_ejr_asis_1    a11
         INNER JOIN p_lew_mart_lead_ac.v_ref_currency_1    a12
         ON     (a11.client_id = a12.client_id AND
         a11.currency_iso_cd = a12.currency_iso_cd)
         INNER JOIN p_lew_mart_lead_ac.v_cal_calendarday_base_1    a13
         ON     (a11.dat_formdate = a13.dat_calendar)
         INNER JOIN p_lew_mart_lead_ac.v_ref_client_lead_base_1    a14
         ON     (a12.client_id = a14.client_id)
         WHERE    (a11.aspect_id IN (1)  )
         GROUP BY
              a12.curr_tot_id
             ,a12.currency_iso_cd
             ,a13.cy_week
             ,a12.client_id) AS tab_umsatz
         ON tab_kunden.client_id  = tab_umsatz.client_id
         AND tab_kunden.cy_week   =   tab_umsatz.cy_week
         AND    tab_kunden.currency_iso_cd = tab_umsatz.currency_iso_cd
         AND    tab_kunden.curr_tot_id = tab_umsatz.curr_tot_id
         FULL OUTER JOIN
         (SELECT
         a12.curr_tot_id  curr_tot_id
         ,a12.currency_iso_cd  currency_iso_cd
         ,a13.cy_week  cy_week
         ,a12.client_id  client_id
         ,SUM(a11.val_indicator)  plan_turnover_net_val_stationary
         FROM p_lew_mart_lead_ac.v_kpges_plan_day_wh_merge_base_1    a11
         INNER JOIN p_lew_mart_lead_ac.v_ref_currency_1    a12
         ON     (a11.client_id = a12.client_id AND
         a11.currency_iso_cd = a12.currency_iso_cd)
         INNER JOIN p_lew_mart_lead_ac.v_cal_calendarday_base_1    a13
         ON     (a11.dat_formdate = a13.dat_calendar)
         INNER JOIN p_lew_mart_lead_ac.v_ref_client_lead_base_1    a14
         ON     (a12.client_id = a14.client_id)
         WHERE    (a13.cy_day_sequence <=  0
          AND a11.indicator_id IN (157)
          AND a11.aspect_id IN (1)    )
         GROUP BY
              a12.curr_tot_id
             ,a12.currency_iso_cd
             ,a13.cy_week
             ,a12.client_id        ) AS tab_umsatz_plan
         ON     tab_umsatz.client_id  = tab_umsatz_plan.client_id
         AND    tab_umsatz.cy_week   =   tab_umsatz_plan.cy_week
         AND    tab_umsatz.currency_iso_cd = tab_umsatz_plan.currency_iso_cd
         AND    tab_umsatz.curr_tot_id = tab_umsatz_plan.curr_tot_id
         GROUP BY
          COALESCE(tab_kunden.client_id, tab_umsatz.client_id, tab_umsatz_plan.client_id)
         ,COALESCE(tab_kunden.cy_week, tab_umsatz.cy_week, tab_umsatz_plan.cy_week)
         ,COALESCE(tab_kunden.currency_iso_cd, tab_umsatz.currency_iso_cd, tab_umsatz_plan.currency_iso_cd)
         ,COALESCE(tab_kunden.curr_tot_id, tab_umsatz.curr_tot_id, tab_umsatz_plan.curr_tot_id);