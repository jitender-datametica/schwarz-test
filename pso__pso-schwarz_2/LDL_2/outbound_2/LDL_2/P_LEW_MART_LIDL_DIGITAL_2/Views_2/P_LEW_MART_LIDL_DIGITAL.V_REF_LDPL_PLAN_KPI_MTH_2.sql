/*
#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2025-03-19 Marcin Kikola    Initial version AP0263904
#------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_ref_ldpl_plan_kpi_mth_2 (client_id
OPTIONS(description='Identifier for client'), cy_month OPTIONS(description='Month number'), busyear
OPTIONS(description='Business year number'), harmo_cal_month_no
OPTIONS(description='Harmonized month no per country_2 - month since rollout'), currency_iso_cd
OPTIONS(description='ISO code for the currency of the client.'), curr_tot_id
OPTIONS(description='Currency tot identifier'), lp_customer_sid_cnt_plan
OPTIONS(description='Plan value for Lidl Plus identified customers. Used for data patch'),
lp_customer_sid_cnt_plan_busyear
OPTIONS(description='Plan value for Lidl Plus identified customers per business year. Used for data patch'),
lp_receipt_cnt_plan OPTIONS(description='Plan value for Lidl Plus count of receipts. Used for data patch'),
lp_net_val_eur_plan OPTIONS(description='Plan value for Lidl Plus revenue net value in EUR. Used for data patch'),
total_net_val_eur_plan OPTIONS(description='Plan value for total revenue net value in EUR. Used for data patch'),
lp_discount_val_eur_plan OPTIONS(description='Plan value for Lidl Plus discount in EUR. Used for data patch'),
lp_new_reg_cnt_plan OPTIONS(description='Plan value for Lidl Plus registered users. Used for data patch'),
lp_new_reg_cnt_plan_busyear
OPTIONS(description='Plan value for Lidl Plus registered users per business year. Used for data patch'),
lp_advertising_discount OPTIONS(description='Plan value for Lidl Plus advertising discount in EUR. Used for data patch'),
non_lp_advertising_discount
OPTIONS(description='Plan value for Total Plus advertising discount in EUR. Used for data patch'),
total_advertising_discount
OPTIONS(description='Plan value for Non Lidl Plus advertising discount in EUR. Used for data patch'),
loyalty_advertising_discount
OPTIONS(description='Plan value for Loyalty advertising discount in EUR. Used for data patch'),
promo_advertising_discount
OPTIONS(description='Plan value for Loyalty advertising discount in EUR. Used for data patch'), dwh_load_id
OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row created time'), dwh_updated
OPTIONS(description='Row update time')) AS WITH CTE_CURR_RATE AS (SELECT client_id,
    currency_iso_cd,
    curr_tot_id,
    to_currency_iso_cd,
     CASE
     WHEN to_currency_iso_cd = 'EUR'
     THEN 0
     ELSE client_id
     END AS to_curr_tot_id,
    rate_currency_exchange
   FROM ldl_p_lew_mart_msi.v_ref_currency_2 AS C
   WHERE local_currency_fg = 0
   UNION ALL
   SELECT client_id,
    currency_iso_cd,
    curr_tot_id,
    currency_iso_cd AS to_currency_iso_cd,
    0 AS to_curr_tot_id,
    1 AS rate_currency_exchange
   FROM ldl_p_lew_mart_msi.v_ref_currency_2 AS C
   WHERE currency_iso_cd = 'EUR'
     /* CTE CREATED TO OBTAIN LIST OF EXCHANGE RATES IN ORDER TO POPULATE LOCAL CURRENCIES AND EUR FOR NON EU COUNTRIES */
     ) (SELECT P.client_id,
   P.cy_month,
   M.busyear,
   H.harmo_cal_month_no,
   C.to_currency_iso_cd AS currency_iso_cd,
   C.to_curr_tot_id AS curr_tot_id,
   P.lp_customer_sid_cnt_plan,
   LAST_VALUE(P.lp_customer_sid_cnt_plan) OVER (PARTITION BY CAST(P.client_id AS STRING), CAST(M.busyear AS STRING)
    ORDER BY M.cy_month IS NULL, M.cy_month RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   lp_customer_sid_cnt_plan_busyear,
   P.lp_receipt_cnt_plan,
    P.lp_net_val_eur_plan * C.rate_currency_exchange AS lp_net_val_plan,
    P.total_net_val_eur_plan * C.rate_currency_exchange AS total_net_val_plan,
    P.lp_discount_val_eur_plan * C.rate_currency_exchange AS lp_discount_val_plan,
   P.lp_new_reg_cnt_plan,
   LAST_VALUE(P.lp_new_reg_cnt_plan) OVER (PARTITION BY CAST(P.client_id AS STRING), CAST(M.busyear AS STRING) ORDER BY
      M.cy_month IS NULL, M.cy_month RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   lp_new_reg_cnt_plan_busyear,
   P.lp_advertising_discount,
   P.non_lp_advertising_discount,
   P.total_advertising_discount,
   P.loyalty_advertising_discount,
   P.promo_advertising_discount,
   P.dwh_load_id,
   P.dwh_created,
   P.dwh_updated
  FROM ldl_p_lew_mart_lidl_digital.t_ref_ldpl_plan_kpi_mth_2 AS P
   LEFT JOIN ldl_p_lew_core.t_cal_month_2 AS M ON P.cy_month = M.cy_month
   LEFT JOIN ldl_p_lew_mart_lidl_digital.t_harmo_calendar_ldpl_day_2 AS H ON P.client_id = H.client_id AND P.cy_month = H
      .cy_month AND H.last_day_month_fg = 1
   INNER JOIN CTE_CURR_RATE AS C ON P.client_id = C.client_id AND P.currency_iso_cd = C.currency_iso_cd);