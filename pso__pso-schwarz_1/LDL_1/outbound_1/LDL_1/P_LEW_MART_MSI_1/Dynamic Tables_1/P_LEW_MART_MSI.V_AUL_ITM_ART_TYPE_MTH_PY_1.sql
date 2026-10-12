CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_aul_itm_art_type_mth_py_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT ITM.client_id,
 ITM.item_sid AS item_id,
 M.cy_month,
 ITM.buying_list_type_id,
 ITM.buying_list_type_desc,
 ITM2.buying_list_type_id AS buying_list_type_id_py,
 ITM2.buying_list_type_desc AS buying_list_type_desc_py
FROM ldl_p_lew_core_ac.v_wawi_itm_item_1 AS ITM
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_month_1 AS M ON DATE_SUB(IF(PARSE_DATE('%Y%m%d', SAFE_CAST(M.cy_month as STRING)
       || SAFE_CAST(1 as STRING)) = LAST_DAY(PARSE_DATE('%Y%m%d', SAFE_CAST(M.cy_month as STRING) || SAFE_CAST(1 as STRING)
        )), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m%d', SAFE_CAST(M.cy_month as STRING) || SAFE_CAST(1 as STRING)), INTERVAL
      1 MONTH)), DATE_ADD(PARSE_DATE('%Y%m%d', SAFE_CAST(M.cy_month as STRING) || SAFE_CAST(1 as STRING)), INTERVAL 1
     MONTH)), INTERVAL 1 DAY) BETWEEN ITM.dat_rec_start AND ITM.dat_rec_end
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_1 AS ITM2 ON ITM.client_id = ITM2.client_id AND ITM.item_sid = ITM2.item_sid
  AND DATE_SUB(IF(PARSE_DATE('%Y%m%d', SAFE_CAST(M.cy_month as STRING) || SAFE_CAST(1 as STRING)) = LAST_DAY(PARSE_DATE('%Y%m%d'
        , SAFE_CAST(M.cy_month as STRING) || SAFE_CAST(1 as STRING))), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m%d', SAFE_CAST(M
          .cy_month as STRING) || SAFE_CAST(1 as STRING)), INTERVAL 1 - 12 MONTH)), DATE_ADD(PARSE_DATE('%Y%m%d',
        SAFE_CAST(M.cy_month as STRING) || SAFE_CAST(1 as STRING)), INTERVAL 1 - 12 MONTH)), INTERVAL 1 DAY) BETWEEN
   ITM2.dat_rec_start AND ITM2.dat_rec_end
WHERE M.cy_month_sequence <= 0;
