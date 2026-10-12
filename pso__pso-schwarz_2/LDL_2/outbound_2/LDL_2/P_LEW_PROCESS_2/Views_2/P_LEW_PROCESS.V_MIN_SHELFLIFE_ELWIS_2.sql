CREATE OR REPLACE VIEW ldl_p_lew_process.v_min_shelflife_elwis_2 AS SELECT item_sid_config,
 MIN(min_consumption_day_cnt) AS min_consumption_day_cnt,
 MIN(min_shelflife_to_store_day_cnt) AS min_shelflife_to_store_day_cnt,
 MIN(min_shelflife_to_wh_day_cnt) AS min_shelflife_to_wh_day_cnt
FROM (SELECT CORE_ITEM.item_sid_config,
    NULLIF(imloh.dur_shelflife_day_cust, 0) AS min_consumption_day_cnt,
    NULLIF(imloh.dur_shelflife_day_store, 0) AS min_shelflife_to_store_day_cnt,
    NULLIF(imloh.dur_shelflife_day_wh, 0) AS min_shelflife_to_wh_day_cnt
   FROM ldl_p_lew_core_ac.v_item_2 AS CORE_ITEM
    LEFT JOIN (SELECT IT.client_id,
      IT.item_sid,
      MIN(CASE
        WHEN IT.shelflife_cust_cd IS NULL
        THEN IT.shelflife_cust_val
        WHEN CAST(IT.shelflife_cust_cd AS FLOAT64) = 2
        THEN IT.shelflife_cust_val * 30
        ELSE NULL
        END) AS dur_shelflife_day_cust,
      MIN(CASE
        WHEN IT.shelflife_loc_cd IS NULL
        THEN IT.shelflife_loc_val
        WHEN CAST(IT.shelflife_loc_cd AS FLOAT64) = 2
        THEN IT.shelflife_loc_val * 30
        ELSE NULL
        END) AS dur_shelflife_day_store,
      MIN(CASE
        WHEN IT.shelflife_vz_cd IS NULL
        THEN IT.shelflife_vz_val
        WHEN CAST(IT.shelflife_vz_cd AS FLOAT64) = 2
        THEN IT.shelflife_vz_val * 30
        ELSE NULL
        END) AS dur_shelflife_day_wh
     FROM ldl_p_lew_core_ac.v_item_info_per_location_hist_2 AS IT
      INNER JOIN (SELECT LCTN.client_id,
        LCTN.loc_sid AS loc_sid_wh
       FROM ldl_p_lew_core_ac.v_location_2 AS LCTN
        INNER JOIN ldl_p_lew_core_ac.v_location_hist_2 AS LCTN_H ON LCTN.loc_sid = LCTN_H.loc_sid
       WHERE UPPER(LCTN.wh_store_mark) = 'B'
        AND CURRENT_DATE BETWEEN LCTN_H.dwh_valid_from AND LCTN_H.dwh_valid_to
        AND LCTN.global_loc_id_length = 7
        AND LCTN.global_loc_ctry_cd <> 'ZV'
        AND LCTN.global_loc_type_cd = '9'
        AND LCTN.country_pol_cd IS NOT NULL) AS wh ON IT.client_id = wh.client_id AND IT.loc_sid = wh.loc_sid_wh
     WHERE CURRENT_DATE BETWEEN IT.dwh_valid_from AND IT.dwh_valid_to
      AND IT.deleted_fg = 0
     GROUP BY IT.client_id,
      IT.item_sid) AS imloh ON CORE_ITEM.client_id = imloh.client_id AND CORE_ITEM.item_sid = imloh.item_sid
   WHERE CORE_ITEM.src_matnr IS NOT NULL
    AND COALESCE(CAST(CORE_ITEM.log_var_cd AS BIGNUMERIC), 4) IN (2, 3)
   UNION ALL
   SELECT ELWIS_MAIN_ITEM.item_sid,
    NULLIF(imloh.dur_shelflife_day_cust, 0) AS min_consumption_day_cnt,
    NULLIF(imloh.dur_shelflife_day_store, 0) AS min_shelflife_to_store_day_cnt,
    NULLIF(imloh.dur_shelflife_day_wh, 0) AS min_shelflife_to_wh_day_cntrk
   FROM ldl_p_lew_core_ac.v_item_2 AS ELWIS_MAIN_ITEM
    LEFT JOIN (SELECT IT.client_id,
      IT.item_sid,
      MIN(CASE
        WHEN IT.shelflife_cust_cd IS NULL
        THEN IT.shelflife_cust_val
        WHEN CAST(IT.shelflife_cust_cd AS FLOAT64) = 2
        THEN IT.shelflife_cust_val * 30
        ELSE NULL
        END) AS dur_shelflife_day_cust,
      MIN(CASE
        WHEN IT.shelflife_loc_cd IS NULL
        THEN IT.shelflife_loc_val
        WHEN CAST(IT.shelflife_loc_cd AS FLOAT64) = 2
        THEN IT.shelflife_loc_val * 30
        ELSE NULL
        END) AS dur_shelflife_day_store,
      MIN(CASE
        WHEN IT.shelflife_vz_cd IS NULL
        THEN IT.shelflife_vz_val
        WHEN CAST(IT.shelflife_vz_cd AS FLOAT64) = 2
        THEN IT.shelflife_vz_val * 30
        ELSE NULL
        END) AS dur_shelflife_day_wh
     FROM ldl_p_lew_core_ac.v_item_info_per_location_hist_2 AS IT
      INNER JOIN (SELECT LCTN.client_id,
        LCTN.loc_sid AS loc_sid_wh
       FROM ldl_p_lew_core_ac.v_location_2 AS LCTN
        INNER JOIN ldl_p_lew_core_ac.v_location_hist_2 AS LCTN_H ON LCTN.loc_sid = LCTN_H.loc_sid
       WHERE UPPER(LCTN.wh_store_mark) = 'B'
        AND CURRENT_DATE BETWEEN LCTN_H.dwh_valid_from AND LCTN_H.dwh_valid_to
        AND LCTN.global_loc_id_length = 7
        AND LCTN.global_loc_ctry_cd <> 'ZV'
        AND LCTN.global_loc_type_cd = '9'
        AND LCTN.country_pol_cd IS NOT NULL) AS wh ON IT.client_id = wh.client_id AND IT.loc_sid = wh.loc_sid_wh
     WHERE CURRENT_DATE BETWEEN IT.dwh_valid_from AND IT.dwh_valid_to
      AND IT.deleted_fg = 0
     GROUP BY IT.client_id,
      IT.item_sid) AS imloh ON ELWIS_MAIN_ITEM.client_id = imloh.client_id AND ELWIS_MAIN_ITEM.item_sid = imloh.item_sid
      
   WHERE ELWIS_MAIN_ITEM.src_matnr IS NOT NULL
    AND COALESCE(CAST(ELWIS_MAIN_ITEM.log_var_cd AS BIGNUMERIC), 4) = 1) AS t
GROUP BY item_sid_config;