CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics.v_ftm_turnover_2 AS WITH A_SALES AS (SELECT A.client_id,
   RCTRY.country_iso_cd AS country_code,
   A.dat_formdate,
   TAG.cy_week,
   A.store_id,
   A.orig_store_nr,
   A.item_id,
   ART_INFO.orig_item_nr,
   UWG_INFO.itemgroup_int_id,
   ART_INFO.subitemgroup_id,
    CASE
    WHEN ART_INFO.buying_list_type_id IN (7, 8)
    THEN 'AKTIONSARTIKEL'
    ELSE 'SORTIMENT'
    END AS item_type,
    A.val_rtl_net_ejr_asis + A.val_return_net_ejr_asis AS sales_net_val,
     A.qty_piece_ejr_asis + A.qty_weight_ejr_asis + A.qty_return_ejr_asis AS sales_pieces_ejr,
   CAST('0' AS BIGNUMERIC) AS buying_val,
   ROUND(CAST('0' AS NUMERIC), 0) AS sales_based_margin,
   ROUND(CAST('0' AS NUMERIC), 0) AS sales_based_margin_pct
  FROM ldl_p_lew_mart_lead.v_agg_store_day_item_ejr_asis_2 AS A
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_country_2 AS RCTRY ON A.client_id = RCTRY.country_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday_2 AS TAG_2 ON A.dat_formdate = TAG.dat_calendar
   INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_item_2 AS ART_INFO ON A.client_id = ART_INFO.client_id AND A.item_id = ART_INFO
      .item_id AND A.dat_formdate >= ART_INFO.dat_valid_from
   INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_subitemgroup_2 AS UWG_INFO ON ART_INFO.subitemgroup_id = UWG_INFO.subitemgroup_id
    
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_store_skey_2 AS FIL ON A.client_id = FIL.client_id AND A.store_id = FIL.store_id
     
  WHERE A.currency_iso_cd = 'EUR'), B_BUYING AS (SELECT A.client_id,
   RCTRY.country_iso_cd AS country_code,
   A.dwh_cal_dt AS dat_formdate,
   TAG.cy_week,
   A.st_loc_sid AS store_id,
   FIL.orig_store_nr,
   ART_INFO2.item_id,
   A.orig_item_nr,
   UWG_INFO.itemgroup_int_id,
   ART_INFO.subitemgroup_id,
    CASE
    WHEN ART_INFO2.buying_list_type_id IN (7, 8)
    THEN 'AKTIONSARTIKEL'
    ELSE 'SORTIMENT'
    END AS item_type,
   ROUND(CAST('0' AS NUMERIC), 0) AS sales_net_val,
   ROUND(CAST('0' AS BIGNUMERIC), 0) AS sales_pieces_ejr,
   A.sales_buying_diff AS buying_val,
    A.sales_buying_diff / (COUNT(ART_INFO2.item_id) OVER (PARTITION BY A.client_id, A.orig_item_nr, A.dwh_cal_dt, A.st_loc_sid
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS sales_based_margin,
     A.sales_buying_diff / (COUNT(ART_INFO2.item_id) OVER (PARTITION BY A.client_id, A.orig_item_nr, A.dwh_cal_dt, A.st_loc_sid
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / (A.sales_net_val / (COUNT(ART_INFO2.item_id) OVER
        (PARTITION BY A.client_id, A.orig_item_nr, A.dwh_cal_dt, A.st_loc_sid RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING))) AS sales_based_margin_pct
  FROM ldl_p_lew_mart_lead.v_agg_avg_buy_price_str_day_itm_2 AS A
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_country_2 AS RCTRY ON A.client_id = RCTRY.country_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday_2 AS TAG_2 ON A.dwh_cal_dt = TAG.dat_calendar
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_store_skey_2 AS FIL ON A.client_id = FIL.client_id AND A.st_loc_sid = FIL.store_id
     
   INNER JOIN ldl_p_lew_mart_lead.t_itm_orig_item_2 AS ART_INFO ON A.client_id = ART_INFO.client_id AND A.orig_item_nr =
      ART_INFO.orig_item_nr AND A.dat_valid_from = ART_INFO.dat_valid_from
   INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_item_2 AS ART_INFO2 ON ART_INFO.client_id = ART_INFO2.client_id AND ART_INFO.orig_item_nr
      = ART_INFO2.orig_item_nr
   INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_subitemgroup_2 AS UWG_INFO ON ART_INFO.subitemgroup_id = UWG_INFO.subitemgroup_id
    
  WHERE A.currency_iso_cd = 'EUR') (SELECT client_id,
   country_code,
   dat_formdate,
   cy_week,
   store_id,
   orig_store_nr,
   item_id,
   orig_item_nr,
   itemgroup_int_id,
   subitemgroup_id,
   item_type,
   sales_net_val,
   sales_pieces_ejr,
   buying_val,
   sales_based_margin,
   sales_based_margin_pct
  FROM (SELECT client_id,
      country_code,
      dat_formdate,
      cy_week,
      store_id,
      orig_store_nr,
      item_id,
      orig_item_nr,
      itemgroup_int_id,
      subitemgroup_id,
      item_type,
      sales_net_val,
      sales_pieces_ejr,
      buying_val,
      sales_based_margin,
      sales_based_margin_pct
     FROM A_SALES
     UNION ALL
     SELECT client_id,
      country_code,
      dat_formdate,
      cy_week,
      store_id,
      orig_store_nr,
      item_id,
      orig_item_nr,
      itemgroup_int_id,
      subitemgroup_id,
      item_type,
      sales_net_val,
      sales_pieces_ejr,
      buying_val,
      sales_based_margin,
      sales_based_margin_pct
     FROM B_BUYING) AS t7);