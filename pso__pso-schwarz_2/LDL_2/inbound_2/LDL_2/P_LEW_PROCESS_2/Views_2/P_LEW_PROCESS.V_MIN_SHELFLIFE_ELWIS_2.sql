CREATE OR REPLACE VIEW P_LEW_PROCESS.V_MIN_SHELFLIFE_ELWIS_2
   AS
      SELECT
           t.item_sid_config,
      MIN(t.min_consumption_day_cnt) AS min_consumption_day_cnt,
      MIN(t.min_shelflife_to_store_day_cnt) AS min_shelflife_to_store_day_cnt,
      MIN(t.min_shelflife_to_wh_day_cnt) AS min_shelflife_to_wh_day_cnt
      FROM (SELECT core_item.item_sid_config,
      NULLIF(imloh.dur_shelflife_day_cust,0) AS min_consumption_day_cnt,
      NULLIF(imloh.dur_shelflife_day_store,0) AS min_shelflife_to_store_day_cnt,
      NULLIF(imloh.dur_shelflife_day_wh,0) AS min_shelflife_to_wh_day_cnt
            FROM p_lew_core_ac.v_item_2 core_item
      LEFT OUTER JOIN
      (
      SELECT
        it.client_id,
      it.item_sid,
      MIN(CASE WHEN it.shelflife_cust_cd IS NULL THEN it.shelflife_cust_val WHEN it.shelflife_cust_cd = 2 THEN it.shelflife_cust_val*30 END) dur_shelflife_day_cust,
      MIN(CASE WHEN it.shelflife_loc_cd IS NULL THEN it.shelflife_loc_val WHEN it.shelflife_loc_cd = 2 THEN it.shelflife_loc_val*30 END) dur_shelflife_day_store,
      MIN(CASE WHEN it.shelflife_vz_cd IS NULL THEN it.shelflife_vz_val WHEN it.shelflife_vz_cd = 2 THEN it.shelflife_vz_val*30 END) dur_shelflife_day_wh
           FROM p_lew_core_ac.v_item_info_per_location_hist_2 it
      INNER JOIN (SELECT
      lctn.client_id,
      lctn.loc_sid AS loc_sid_wh
                        FROM p_lew_core_ac.v_location_2 lctn
      INNER JOIN p_lew_core_ac.v_location_hist_2 lctn_h
      ON lctn.loc_sid = lctn_h.loc_sid
      WHERE Upper(lctn.wh_store_mark) = 'B'
      AND CURRENT_DATE BETWEEN lctn_h.dwh_valid_from AND lctn_h.dwh_valid_to
      AND (global_loc_id_length = 7 AND global_loc_ctry_cd IS NOT NULL AND country_pol_cd IS NOT NULL AND global_loc_type_cd = '9' AND global_loc_ctry_cd <>  'ZV') /* bges_active_fg, BGES Identifikation fÃ¼r Elwis Daten */
      ) wh
      ON wh.client_id = it.client_id
      AND wh.loc_sid_wh = it.loc_sid
      WHERE CURRENT_DATE BETWEEN it.dwh_valid_from AND it.dwh_valid_to
      AND it.deleted_fg = 0
      GROUP BY 1,2
      ) imloh
      ON imloh.client_id = core_item.client_id
      AND imloh.item_sid = core_item.item_sid
      WHERE core_item.src_matnr IS NOT NULL
      AND COALESCE(core_item.log_var_cd,4) IN (2, 3)
      AND TRY_CAST(COALESCE(core_item.src_orig_item_nr,core_item.config_item_cd,core_item.src_matnr) AS DECIMAL(18,0)) IS NOT NULL
      UNION ALL
            SELECT elwis_main_item.item_sid,
      NULLIF(imloh.dur_shelflife_day_cust,0) AS min_consumption_day_cnt,
      NULLIF(imloh.dur_shelflife_day_store,0) AS min_shelflife_to_store_day_cnt,
      NULLIF(imloh.dur_shelflife_day_wh,0) AS min_shelflife_to_wh_day_cntrk
            FROM p_lew_core_ac.v_item_2 elwis_main_item
      LEFT OUTER JOIN
      (
      SELECT
        it.client_id,
      it.item_sid,
      MIN(CASE WHEN it.shelflife_cust_cd IS NULL THEN it.shelflife_cust_val WHEN it.shelflife_cust_cd = 2 THEN it.shelflife_cust_val*30 END) dur_shelflife_day_cust,
      MIN(CASE WHEN it.shelflife_loc_cd IS NULL THEN it.shelflife_loc_val WHEN it.shelflife_loc_cd = 2 THEN it.shelflife_loc_val*30 END) dur_shelflife_day_store,
      MIN(CASE WHEN it.shelflife_vz_cd IS NULL THEN it.shelflife_vz_val WHEN it.shelflife_vz_cd = 2 THEN it.shelflife_vz_val*30 END) dur_shelflife_day_wh
           FROM p_lew_core_ac.v_item_info_per_location_hist_2 it
      INNER JOIN (SELECT
      lctn.client_id,
      lctn.loc_sid AS loc_sid_wh
                        FROM p_lew_core_ac.v_location_2 lctn
      INNER JOIN p_lew_core_ac.v_location_hist_2 lctn_h
      ON lctn.loc_sid = lctn_h.loc_sid
      WHERE Upper(lctn.wh_store_mark) = 'B'
      AND CURRENT_DATE BETWEEN lctn_h.dwh_valid_from AND lctn_h.dwh_valid_to
      AND (global_loc_id_length = 7 AND global_loc_ctry_cd IS NOT NULL AND country_pol_cd IS NOT NULL AND global_loc_type_cd = '9' AND global_loc_ctry_cd <>  'ZV') /* bges_active_fg, BGES Identifikation fÃ¼r Elwis Daten */
      ) wh
      ON wh.client_id = it.client_id
      AND wh.loc_sid_wh = it.loc_sid
      WHERE CURRENT_DATE BETWEEN it.dwh_valid_from AND it.dwh_valid_to
      AND it.deleted_fg = 0
      GROUP BY 1,2
      ) imloh
      ON imloh.client_id = elwis_main_item.client_id
      AND imloh.item_sid = elwis_main_item.item_sid
      WHERE elwis_main_item.src_matnr IS NOT NULL
      AND COALESCE(elwis_main_item.log_var_cd,4) = 1
      AND TRY_CAST(COALESCE(elwis_main_item.src_orig_item_nr,elwis_main_item.config_item_cd,elwis_main_item.src_matnr) AS DECIMAL(18,0)) IS NOT NULL
      ) t
      GROUP BY t.item_sid_config;