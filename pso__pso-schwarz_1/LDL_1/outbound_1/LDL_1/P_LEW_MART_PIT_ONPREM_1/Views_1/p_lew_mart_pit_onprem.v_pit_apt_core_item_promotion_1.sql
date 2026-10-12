CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_apt_core_item_promotion_1 (client_id, item_sid, promotion_dt,
promotion_cy_week, promotion_busyear, promotion_end_dt, promotion_end_dt_created_fg, promotion_end_dt_truncated_fg,
promotion_period_orig_days, advertising_campaign, advertising_theme, advertising_group, advertising_sub_group,
turnover_plan_val, item_sid_prev_promotion, promotion_time_prev_promotion, sales_price, sales_price_orig,
sales_price_comment, promotion_comment, item_list_type, promotion_store_placement_int, promotion_store_placement_nat,
promotion_type_int, promotion_type_nat, deleted_fg, excluded_fg, dwh_load_id, dwh_created, dwh_updated) AS SELECT APT.client_id
 ,
 ItmMap.rltd_item_sid AS item_sid,
 APT.promotion_dt,
 APT.promotion_cy_week,
 APT.promotion_busyear,
  CASE
  WHEN APT.promotion_end_dt IS NULL
  THEN DATE_ADD(APT.promotion_dt, INTERVAL CAST(ROUND(pa.apt_time_gap_in_days) AS INTEGER) DAY)
  WHEN APT.promotion_end_dt > DATE_ADD(APT.promotion_dt, INTERVAL CAST(ROUND(pa.apt_time_gap_in_days) AS INTEGER) DAY)
   
  THEN DATE_ADD(APT.promotion_dt, INTERVAL CAST(ROUND(pa.apt_time_gap_in_days) AS INTEGER) DAY)
  ELSE APT.promotion_end_dt
  END AS `_promotion_end_dt`,
  CASE
  WHEN APT.promotion_end_dt IS NULL
  THEN 1
  ELSE 0
  END AS promotion_end_dt_created_fg,
  CASE
  WHEN APT.promotion_end_dt IS NULL
  THEN 0
  WHEN APT.promotion_end_dt > DATE_ADD(APT.promotion_dt, INTERVAL CAST(ROUND(pa.apt_time_gap_in_days) AS INTEGER) DAY)
   
  THEN 1
  ELSE 0
  END AS promotion_end_dt_truncated_fg,
  CASE
  WHEN APT.promotion_end_dt IS NULL
  THEN 0
  ELSE CAST(DATE_DIFF(APT.promotion_end_dt, APT.promotion_dt, DAY) AS BIGNUMERIC) + 1
  END AS promotion_period_orig_days,
 APT.advertising_campaign,
 CAST(ldl_p_lew_mart_pit.f_cleanstring(COLLATE(COALESCE(APT.advertising_theme, 'Kein Werbethema definiert'),'')) AS STRING) AS `_advertising_theme`,
 CAST(ldl_p_lew_mart_pit.f_cleanstring(COLLATE(COALESCE(APT.advertising_group, 'Sonstige'),'')) AS STRING) AS advertising_group,
 APT.advertising_sub_group,
 CAST(APT.turnover_plan_val AS BIGNUMERIC) AS turnover_plan_val,
 APT.item_sid_prev_promotion,
 APT.promotion_time_prev_promotion,
 CAST(APT.sales_price AS BIGNUMERIC) AS sales_price,
 CAST(APT.sales_price_orig AS BIGNUMERIC) AS sales_price_orig,
 APT.sales_price_comment,
 APT.promotion_comment,
 CAST(ldl_p_lew_mart_pit.f_cleanstring(COLLATE(COALESCE(APT.item_list_type, 'Sonstige'),'')) AS STRING) AS item_list_type,
 APT.promotion_store_placement_int,
 APT.promotion_store_placement_nat,
 APT.promotion_type_int,
 APT.promotion_type_nat,
 APT.deleted_fg,
 0 AS excluded_fg,
 APT.dwh_load_id,
 APT.dwh_created,
 APT.dwh_updated
FROM (SELECT *
  FROM ldl_p_lew_core_ac.v_item_promotion_adp_1
  WHERE deleted_fg = 0) AS APT
 INNER JOIN (SELECT client_id,
   MAX(`A118612`) AS adp_time_gap_in_days,
   MAX(`A118613`) AS apt_time_gap_in_days
  FROM (SELECT client_id,
     IF(param_id = 41, ROUND(SAFE_CAST(param_value as BIGNUMERIC), 0), NULL) AS `A118612`,
     IF(param_id = 54, ROUND(SAFE_CAST(param_value as BIGNUMERIC), 0), NULL) AS `A118613`
    FROM ldl_p_lew_mart_pit_onprem.t_pit_scope_country_param_1
    WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
     AND deleted_fg = 0
    QUALIFY version_nr = (MAX(version_nr) OVER (PARTITION BY CAST(client_id AS STRING), CAST(param_id AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS t2
  GROUP BY client_id) AS pa ON APT.client_id = pa.client_id
 INNER JOIN (SELECT MAINITM.client_id,
   MAINITM.item_sid,
   ITM.item_sid AS rltd_item_sid
  FROM ldl_p_lew_core_ac.v_item_1 AS MAINITM
   INNER JOIN ldl_p_lew_core_ac.v_item_1 AS ITM ON MAINITM.client_id = ITM.client_id AND ROUND(SAFE_CAST(COALESCE(MAINITM
         .src_orig_item_nr, TRIM(MAINITM.config_item_cd), MAINITM.src_matnr) AS BIGNUMERIC), 0) = ROUND(SAFE_CAST(COALESCE(ITM
         .src_orig_item_nr, TRIM(ITM.config_item_cd), ITM.src_matnr) AS BIGNUMERIC), 0) AND (MAINITM.src_dat_valid_from
       IS NULL OR ITM.src_dat_valid_from IS NULL OR MAINITM.src_dat_valid_from = ITM.src_dat_valid_from)
  GROUP BY MAINITM.client_id,
   MAINITM.item_sid,
   rltd_item_sid) AS ItmMap ON APT.client_id = ItmMap.client_id AND APT.item_sid = ItmMap.item_sid;