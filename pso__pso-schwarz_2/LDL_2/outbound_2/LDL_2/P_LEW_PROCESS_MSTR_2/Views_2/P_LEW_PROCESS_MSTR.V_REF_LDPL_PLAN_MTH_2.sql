/*
#----------------------------------------------------------------------------
# Coupon Type
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-12-08 Pawel Wieczorek          Initial version
#  1.1 2022-01-17 Pawel Wieczorek          Change DISCOUNT_PLAN_VAL to PRICE_CHANGE_PLAN_VAL
#  1.2 2022-02-07 Pawel Wieczorek          Change PRICE_CHANGE_PLAN_VAL into two columns PRICE_CHANGE_LP_REV_PLAN_VAL and PRICE_CHANGE_TOT_REV_PLAN_VAL
#  1.3 2022-02-08 Pawel Wieczorek          #261360 Change comments
#  1.4 2022-12-01 Marcin Kikola            Extension of the logic in the table within AP0149031
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_process_mstr.v_ref_ldpl_plan_mth_2 (client_id
OPTIONS(description='Identifier for client'), cy_month OPTIONS(description='Month number'), harmo_cal_month_no
OPTIONS(description='Harmonized month no per country_2 - month since rollout'), currency_iso_cd
OPTIONS(description='ISO code for the currency of the client.'), curr_tot_id
OPTIONS(description='Currency tot identifier'), price_change_lp_rev_plan_val
OPTIONS(description='Plan for LidlPlus Price Change divided by LidlPlus net turnover. 5% is stored as 5.0'),
price_change_tot_rev_plan_val
OPTIONS(description='Plan for LidlPlus Price Change divided by total net turnover. 5% is stored as 5.0. Used for data patch'),
total_net_plan_val OPTIONS(description='Plan for total revenue net value. 5% is stored as 5.0. Used for data patch'),
total_kpges_rev_plan OPTIONS(description='Rvenue plan value taken from KPGES'), total_new_reg_cnt_plan
OPTIONS(description='Plan value for LidlPlus registered users. Used for data patch'), lp_customer_sid_cnt_plan
OPTIONS(description='Plan value for LidlPlus identified customers. Used for data patch'),
price_change_tot_rev_plan_val_gross OPTIONS(description='Calculated value of LP price change'), total_net_plan_val_gross
OPTIONS(description='Calculated value of LP revenue'), dwh_load_id OPTIONS(description='Load identifier'), dwh_created
OPTIONS(description='Row created time'), dwh_updated OPTIONS(description='Row update time')) AS WITH CTE_CURR_RATE AS (SELECT
    client_id,
    currency_iso_cd,
    curr_tot_id,
    to_currency_iso_cd,
    rate_currency_exchange
   FROM ldl_p_lew_mart_msi.v_ref_currency_2 AS C
   WHERE local_currency_fg = 0
   UNION ALL
   SELECT client_id,
    currency_iso_cd,
    curr_tot_id,
    currency_iso_cd AS to_currency_iso_cd,
    1 AS rate_currency_exchange
   FROM ldl_p_lew_mart_msi.v_ref_currency_2 AS C
   WHERE currency_iso_cd = 'EUR'
     /* CTE CREATED TO OBTAIN LIST OF EXCHANGE RATES IN ORDER TO POPULATE LOCAL CURRENCIES AND EUR FOR NON EU COUNTRIES */
     ), KPGES AS (SELECT K.client_id,
   CAL.cy_month,
   K.currency_iso_cd,
   SUM(K.val_indicator) AS total_kpges_rev_plan
  FROM ldl_p_lew_mart_msi_ac.v_kpges_plan_day_wh_merge_2 AS K
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL ON K.dat_formdate = CAL.cal_dt
  WHERE K.indicator_id IN (157)
   AND K.currency_iso_cd = 'EUR'
   AND K.aspect_id = 2
  GROUP BY K.client_id,
   K.currency_iso_cd,
   CAL.cy_month) (/* CROSS JOIN TO OBTAIN KPGES UMSATZ VALUE */ SELECT P.client_id,
   P.cy_month,
   H.harmo_cal_month_no,
   C.to_currency_iso_cd AS currency_iso_cd,
    CASE
    WHEN C.to_currency_iso_cd = 'EUR'
    THEN 0
    ELSE P.client_id
    END AS curr_tot_id,
   P.price_change_lp_rev_plan_val,
   P.price_change_tot_rev_plan_val,
   P.total_net_plan_val,
    A.total_kpges_rev_plan * C.rate_currency_exchange,
   P.total_new_reg_cnt_plan,
   P.lp_customer_sid_cnt_plan,
      P.price_change_tot_rev_plan_val * A.total_kpges_rev_plan * C.rate_currency_exchange / 100 AS
   price_change_tot_rev_plan_val_gross,
      P.total_net_plan_val * A.total_kpges_rev_plan * C.rate_currency_exchange / 100 AS total_net_plan_val_gross,
   P.dwh_load_id,
   P.dwh_created,
   P.dwh_updated
  FROM ldl_p_lew_process_mstr.t_ref_ldpl_plan_mth_2 AS P
   LEFT JOIN ldl_p_lew_mart_lidl_digital.t_harmo_calendar_ldpl_day_2 AS H ON P.client_id = H.client_id AND P.cy_month = H
      .cy_month AND H.last_day_month_fg = 1
   INNER JOIN CTE_CURR_RATE AS C ON P.client_id = C.client_id AND P.currency_iso_cd = C.currency_iso_cd
   LEFT JOIN KPGES AS A ON P.client_id = A.client_id AND P.cy_month = A.cy_month AND P.currency_iso_cd = A.currency_iso_cd
     );