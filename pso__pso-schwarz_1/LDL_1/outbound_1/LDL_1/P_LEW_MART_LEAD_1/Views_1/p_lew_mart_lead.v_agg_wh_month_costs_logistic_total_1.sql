CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_wh_month_costs_logistic_total_1 AS SELECT AGG.client_id,
 AGG.cy_month,
  CASE
  WHEN AGG.client_id = 1 AND AGG.wh_id = 1 OR AGG.client_id = 2 AND AGG.wh_id = 10 OR AGG.client_id = 3 AND AGG.wh_id =
                                 1 OR AGG.client_id = 4 AND AGG.wh_id = 1 OR AGG.client_id = 5 AND AGG.wh_id = 1 OR AGG
                              .client_id = 6 AND AGG.wh_id = 1 OR AGG.client_id = 8 AND AGG.wh_id = 50 OR AGG.client_id
                            = 9 AND AGG.wh_id = 1 OR AGG.client_id = 10 AND AGG.wh_id = 10 OR AGG.client_id = 11 AND AGG
                          .wh_id = 1 OR AGG.client_id = 12 AND AGG.wh_id = 1 OR AGG.client_id = 13 AND AGG.wh_id = 50 OR
                       AGG.client_id = 14 AND AGG.wh_id = 1 OR AGG.client_id = 15 AND AGG.wh_id = 1 OR AGG.client_id =
                     16 AND AGG.wh_id = 1 OR AGG.client_id = 17 AND AGG.wh_id = 1 OR AGG.client_id = 18 AND AGG.wh_id =
                   1 OR AGG.client_id = 19 AND AGG.wh_id = 51 OR AGG.client_id = 20 AND AGG.wh_id = 1 OR AGG.client_id =
                21 AND AGG.wh_id = 2 OR AGG.client_id = 22 AND AGG.wh_id = 100 OR AGG.client_id = 23 AND AGG.wh_id = 99
           OR AGG.client_id = 24 AND AGG.wh_id = 1 OR AGG.client_id = 25 AND AGG.wh_id = 998 OR AGG.client_id = 26 AND
           AGG.wh_id = 1 OR AGG.client_id = 27 AND AGG.wh_id = 1 OR AGG.client_id = 28 AND AGG.wh_id = 1 OR AGG.client_id
         = 29 AND AGG.wh_id = 1 OR AGG.client_id = 32 AND AGG.wh_id = 700 OR AGG.client_id = 33 AND AGG.wh_id = 1 OR AGG
     .client_id = 34 AND AGG.wh_id = 1
  THEN AGG.client_id * - 1
  ELSE AGG.wh_id
  END AS wh_id,
 AGG.currency_iso_cd,
 CAST(CASE
   WHEN ref_cur.currency_iso_cd = 'EUR'
   THEN 0
   WHEN ref_cur.currency_iso_cd = 'GBP'
   THEN 40
   ELSE ref_cur.client_id
   END AS BIGNUMERIC) AS curr_tot_id,
 AGG.current_year_act_val,
 AGG.current_year_plan_val,
 AGG.prev_year_act_val
FROM ldl_p_lew_bil_ac.v_agg_wh_month_costs_logistic_total_1 AS AGG
 INNER JOIN (SELECT client_id,
    'EUR' AS currency_iso_cd
   FROM ldl_p_lew_core_ac.v_client_1
   WHERE curr_cd <> 'EUR'
   UNION ALL
   SELECT client_id,
    curr_cd AS currency_iso_cd
   FROM ldl_p_lew_core_ac.v_client_1) AS ref_cur ON AGG.client_id = ref_cur.client_id AND AGG.currency_iso_cd = ref_cur.currency_iso_cd;