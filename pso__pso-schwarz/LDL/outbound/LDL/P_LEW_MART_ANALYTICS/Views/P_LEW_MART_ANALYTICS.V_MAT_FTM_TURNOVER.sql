/* #----------------------------------------------------------------------------
# 22-08-2024 SNIK1809 - NEW setup
# 09-01-2025 SNIK1809 - Updated Buying with LDL_PRODUCTION.P_LEW_MART_LEAD.T_ITM_ORIG_ITEM
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics.v_mat_ftm_turnover AS WITH A_SALES AS (SELECT A.client_id,
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
   '0' AS buying_val,
   '0' AS sales_based_margin,
   '0' AS sales_based_margin_pct,
   PR.dwh_updated
  FROM ldl_p_lew_mart_lead.v_agg_store_day_item_ejr_asis AS A
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_country AS RCTRY ON A.client_id = RCTRY.country_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday AS TAG ON A.dat_formdate = TAG.dat_calendar
   INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_item AS ART_INFO ON A.client_id = ART_INFO.client_id AND A.item_id = ART_INFO
      .item_id AND A.dat_formdate >= ART_INFO.dat_valid_from
   INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_subitemgroup AS UWG_INFO ON ART_INFO.subitemgroup_id = UWG_INFO.subitemgroup_id
    
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_store_skey AS FIL ON A.client_id = FIL.client_id AND A.store_id
     -- NEW RECORDS + UPDATED OLD RECORDS WILL BE SEEN AS RESULT
 = FIL.store_id
   INNER JOIN (SELECT client_id,
     loc_sid,
     item_sid,
     MAX(dwh_updated) AS dwh_updated
    FROM ldl_p_lew_core_ac.v_pos_receiptline
    WHERE CAST(dwh_updated AS DATE) >= DATE_ADD(CURRENT_DATE, INTERVAL - 10 WEEK)
    GROUP BY client_id,
     loc_sid,
     item_sid) AS PR ON A.client_id = PR.client_id AND A.item_id = PR.item_sid AND A.store_id = PR.loc_sid
  WHERE A.currency_iso_cd = 'EUR'
   AND A.dat_formdate >= DATE_ADD(CURRENT_DATE, INTERVAL - 10 WEEK)), B_BUYING AS (SELECT client_id,
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
    sales_based_margin / sales_net_val_b AS sales_based_margin_pct,
   dwh_updated
  FROM (SELECT A.client_id,
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
      FIL.wh_id,
      '0' AS sales_net_val,
      '0' AS sales_pieces_ejr,
      COUNT(ART_INFO2.item_id) OVER (PARTITION BY CAST(A.client_id AS STRING), CAST(A.orig_item_nr AS STRING), A.dwh_cal_dt
         , CAST(A.st_loc_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cnt_itm,
      A.sales_buying_diff AS buying_val,
       A.sales_net_val / (COUNT(ART_INFO2.item_id) OVER (PARTITION BY CAST(A.client_id AS STRING), CAST(A.orig_item_nr AS STRING)
           , A.dwh_cal_dt, CAST(A.st_loc_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS
      sales_net_val_b,
       A.sales_buying_diff / (COUNT(ART_INFO2.item_id) OVER (PARTITION BY CAST(A.client_id AS STRING), CAST(A.orig_item_nr AS STRING)
           , A.dwh_cal_dt, CAST(A.st_loc_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS
      sales_based_margin,
        A.sales_buying_diff * (COUNT(ART_INFO2.item_id) OVER (PARTITION BY CAST(A.client_id AS STRING), CAST(A.orig_item_nr AS STRING)
            , A.dwh_cal_dt, CAST(A.st_loc_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / A
       .sales_net_val AS sales_based_margin_pct,
      ADJ.dwh_updated
     FROM ldl_p_lew_mart_lead.v_agg_avg_buy_price_str_day_itm AS A
      INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_country AS RCTRY ON A.client_id = RCTRY.country_id
      INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday AS TAG ON A.dwh_cal_dt = TAG.dat_calendar
      INNER JOIN ldl_p_lew_mart_msi_ac.v_org_store_skey AS FIL ON A.client_id = FIL.client_id AND A.st_loc_sid = FIL.store_id
        
      INNER JOIN ldl_p_lew_mart_lead.t_itm_orig_item AS ART_INFO ON A.client_id = ART_INFO.client_id AND A.orig_item_nr
         = ART_INFO.orig_item_nr AND A.dat_valid_from = ART_INFO.dat_valid_from
      INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_item AS ART_INFO2 ON ART_INFO.client_id = ART_INFO2.client_id AND ART_INFO
        .orig_item_nr = ART_INFO2.orig_item_nr
      INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_subitemgroup AS UWG_INFO ON ART_INFO.subitemgroup_id
       -- NEW RECORDS + UPDATED OLD RECORDS WILL BE SEEN AS RESULT
 = UWG_INFO.subitemgroup_id
      INNER JOIN (SELECT MOVI.client_id,
        MOVI.loc_sid_wh,
        I.item_sid,
        OSM.move_to_st_loc_sid AS st_loc_sid,
        I.src_orig_item_nr AS orig_item_nr,
        MAX(COALESCE(MOVI.dat_adjustment_rcv, MOVI.entry_dt)) AS dwh_updated
       FROM ldl_p_lew_bil_ac.v_mov_item_receive_wh AS MOVI
        INNER JOIN ldl_p_lew_core_ac.v_wawi_org_all_store_merge_act AS OSM ON MOVI.client_id = OSM.client_id AND MOVI.loc_sid_wh
            = OSM.wh_loc_sid AND OSM.aspect_id = 1
        INNER JOIN ldl_p_lew_core_ac.v_item AS I ON MOVI.item_sid = I.item_sid
       WHERE COALESCE(MOVI.dat_adjustment_rcv, MOVI.entry_dt) >= DATE_ADD(CURRENT_DATE, INTERVAL - 10 WEEK)
       GROUP BY MOVI.client_id,
        MOVI.loc_sid_wh,
        st_loc_sid,
        orig_item_nr,
        I.item_sid) AS ADJ ON A.client_id = ADJ.client_id AND CAST(ADJ.orig_item_nr AS FLOAT64) = A.orig_item_nr AND A.st_loc_sid
          = ADJ.st_loc_sid AND ART_INFO2.item_id = ADJ.item_sid
     WHERE A.currency_iso_cd = 'EUR'
      AND A.dwh_cal_dt >= DATE_ADD(CURRENT_DATE, INTERVAL - 10 WEEK)
     UNION ALL
     SELECT A.client_id,
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
      FIL.wh_id,
      '0' AS sales_net_val,
      '0' AS sales_pieces_ejr,
      COUNT(ART_INFO2.item_id) OVER (PARTITION BY CAST(A.client_id AS STRING), CAST(A.orig_item_nr AS STRING), A.dwh_cal_dt
         , CAST(A.st_loc_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cnt_itm,
      A.sales_buying_diff AS buying_val,
       A.sales_net_val / (COUNT(ART_INFO2.item_id) OVER (PARTITION BY CAST(A.client_id AS STRING), CAST(A.orig_item_nr AS STRING)
           , A.dwh_cal_dt, CAST(A.st_loc_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS
      sales_net_val_b,
       A.sales_buying_diff / (COUNT(ART_INFO2.item_id) OVER (PARTITION BY CAST(A.client_id AS STRING), CAST(A.orig_item_nr AS STRING)
           , A.dwh_cal_dt, CAST(A.st_loc_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS
      sales_based_margin,
        A.sales_buying_diff * (COUNT(ART_INFO2.item_id) OVER (PARTITION BY CAST(A.client_id AS STRING), CAST(A.orig_item_nr AS STRING)
            , A.dwh_cal_dt, CAST(A.st_loc_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / A
       .sales_net_val AS sales_based_margin_pct,
      CAST(PR.dwh_updated AS DATE) AS dwh_updated
     FROM ldl_p_lew_mart_lead.v_agg_avg_buy_price_str_day_itm AS A
      INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_country AS RCTRY ON A.client_id = RCTRY.country_id
      INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday AS TAG ON A.dwh_cal_dt = TAG.dat_calendar
      INNER JOIN ldl_p_lew_mart_msi_ac.v_org_store_skey AS FIL ON A.client_id = FIL.client_id AND A.st_loc_sid = FIL.store_id
        
      INNER JOIN ldl_p_lew_mart_lead.t_itm_orig_item AS ART_INFO ON A.client_id = ART_INFO.client_id AND A.orig_item_nr
         = ART_INFO.orig_item_nr AND A.dat_valid_from = ART_INFO.dat_valid_from
      INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_item AS ART_INFO2 ON ART_INFO.client_id = ART_INFO2.client_id AND ART_INFO
        .orig_item_nr = ART_INFO2.orig_item_nr
      INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_subitemgroup AS UWG_INFO ON ART_INFO.subitemgroup_id
       -- NEW RECORDS + UPDATED OLD RECORDS WILL BE SEEN AS RESULT
 = UWG_INFO.subitemgroup_id
      INNER JOIN (SELECT R.client_id,
        R.loc_sid,
        I.item_sid,
        I.src_orig_item_nr AS orig_item_nr,
        MAX(R.dwh_updated) AS dwh_updated
       FROM ldl_p_lew_core_ac.v_pos_receiptline AS R
        INNER JOIN ldl_p_lew_core_ac.v_item AS I ON R.item_sid = I.item_sid
       WHERE CAST(R.dwh_updated AS DATE) >= DATE_ADD(CURRENT_DATE, INTERVAL - 10 WEEK)
       GROUP BY R.client_id,
        R.loc_sid,
        orig_item_nr,
        I.item_sid) AS PR ON A.client_id = PR.client_id AND CAST(PR.orig_item_nr AS FLOAT64) = A.orig_item_nr AND A.st_loc_sid
          = PR.loc_sid AND ART_INFO2.item_id = PR.item_sid
     WHERE A.currency_iso_cd = 'EUR'
      AND A.dwh_cal_dt >= DATE_ADD(CURRENT_DATE, INTERVAL - 10 WEEK)) AS t17) (SELECT *
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
      CAST(buying_val AS BIGNUMERIC) AS buying_val,
      ROUND(CAST(sales_based_margin AS NUMERIC), 0) AS sales_based_margin,
      ROUND(CAST(sales_based_margin_pct AS NUMERIC), 0) AS sales_based_margin_pct,
      CAST(dwh_updated AS DATE) AS dwh_updated
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
      ROUND(CAST(sales_net_val AS NUMERIC), 2) AS sales_net_val,
      ROUND(CAST(sales_pieces_ejr AS BIGNUMERIC), 0) AS sales_pieces_ejr,
      buying_val,
      sales_based_margin,
      sales_based_margin_pct,
      dwh_updated
     FROM B_BUYING) AS t21);