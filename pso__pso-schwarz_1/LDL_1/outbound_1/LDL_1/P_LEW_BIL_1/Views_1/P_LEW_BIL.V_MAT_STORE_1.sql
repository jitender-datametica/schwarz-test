CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat_store_1 AS SELECT LCTN.client_id,
 LCTN.loc_sid AS loc_sid_store,
 LCTN.src_werks,
 LCTN.src_orig_store_nr,
 LCTN.src_store_id,
 LCTN.src_wh_id,
 LCTN.loc_name,
 LCTN.loc_name2,
 LCTN.global_loc_id,
 LCTN.country_pol_sid,
 LCTN.country_pol_cd,
 LCTN.storetype_mark,
 LCTN.closing_dt,
 LCTN.opening_dt,
 COALESCE(LCTN.real_opening_dt, LCTN.sap_creation_wrf1_dt) AS real_opening_dt,
 LCTN.global_loc_type_cd,
 LCTN_H.addr_sid,
 COALESCE(LCTN_H.test_store_fg, 0) AS test_store_fg,
 LCTN_H.deleted_fg,
 LCTN_H.dwh_valid_from,
 LCTN_H.dwh_valid_to,
 LCTN_H.region_cd,
 CAST(W_ST.mde_lang_cd AS STRING) AS mde_lang_cd,
 ROUND(CAST(CASE
    WHEN W_ST.qty_min_dflt = ''
    THEN '0'
    ELSE W_ST.qty_min_dflt
    END AS BIGNUMERIC), 0) AS qty_min_dflt,
 W_ST.dat_opening_ovis,
 W_ST.dat_closing_ovis,
  CASE
  WHEN STRPOS(UPPER(LCTN.loc_name), 'DUMMY_1') <> 0
  THEN 1
  ELSE 0
  END AS dummy_store_fg,
  CASE
  WHEN LCTN.country_pol_cd IS NULL
  THEN 1
  ELSE 0
  END AS pseudo_store_fg,
  CASE
  WHEN CURRENT_DATE BETWEEN LCTN_H.dwh_valid_from AND LCTN_H.dwh_valid_to
  THEN 1
  ELSE 0
  END AS dwh_actual_fg,
  CASE
  WHEN LCTN_H.deleted_fg = 0 AND CURRENT_DATE BETWEEN COALESCE(LCTN.real_opening_dt, LCTN.opening_dt, LCTN_H.dwh_valid_from
     ) AND (COALESCE(LCTN.closing_dt, PARSE_DATE('%d.%m.%Y', '31.12.9999')))
  THEN 1
  ELSE 0
  END AS active_fg,
  CASE
  WHEN COALESCE(LCTN.real_opening_dt, LCTN.opening_dt) > CURRENT_DATE AND (LCTN.closing_dt > COALESCE(LCTN.real_opening_dt
       , LCTN.opening_dt) OR LCTN.closing_dt IS NULL)
  THEN 1
  ELSE 0
  END AS active_future_fg
FROM ldl_p_lew_core_ac.v_location_1 AS LCTN
 INNER JOIN ldl_p_lew_core_ac.v_location_hist_1 AS LCTN_H ON LCTN.client_id = LCTN_H.client_id AND LCTN.loc_sid = LCTN_H.loc_sid
   
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_store_1 AS W_ST ON LCTN.client_id = W_ST.client_id AND LCTN.loc_sid = W_ST.st_loc_sid
     AND CURRENT_DATE BETWEEN W_ST.dat_rec_start AND W_ST.dat_rec_end
 LEFT JOIN ldl_p_lew_core_ac.v_location_1 AS LCTN_WH ON LCTN.client_id = LCTN_WH.client_id AND ROUND(SAFE_CAST(SUBSTR(LCTN
       .global_loc_id, 4) AS BIGNUMERIC), 0) = ROUND(SAFE_CAST(SUBSTR(LCTN_WH.global_loc_id, 4) AS BIGNUMERIC), 0) AND
   UPPER(LCTN_WH.wh_store_mark) = 'B'
WHERE UPPER(LCTN.wh_store_mark) = 'A'
 AND LCTN_WH.client_id IS NULL
UNION ALL
SELECT LCTN.client_id,
 LCTN.loc_sid AS loc_sid_store,
 LCTN_WH.src_werks,
 LCTN.src_orig_store_nr,
 LCTN.src_store_id,
 LCTN_WH.src_wh_id,
 LCTN_WH.loc_name,
 LCTN_WH.loc_name2,
 LCTN_WH.global_loc_id,
 LCTN_WH.country_pol_sid,
 LCTN_WH.country_pol_cd,
 LCTN_WH.storetype_mark,
 LCTN_WH.closing_dt,
 LCTN_WH.opening_dt,
 COALESCE(LCTN_WH.real_opening_dt, LCTN_WH.sap_creation_wrf1_dt) AS real_opening_dt,
 LCTN_WH.global_loc_type_cd,
 LCTN_WH_H.addr_sid,
 COALESCE(LCTN_WH_H.test_store_fg, 0) AS test_store_fg,
 LCTN_WH_H.deleted_fg,
 LCTN_WH_H.dwh_valid_from,
 LCTN_WH_H.dwh_valid_to,
 LCTN_WH_H.region_cd,
 CAST(W_ST.mde_lang_cd AS STRING) AS mde_lang_cd,
 ROUND(CAST(W_ST.qty_min_dflt AS BIGNUMERIC), 0) AS qty_min_dflt,
 W_ST.dat_opening_ovis,
 W_ST.dat_closing_ovis,
  CASE
  WHEN STRPOS(UPPER(LCTN.loc_name), 'DUMMY_1') <> 0
  THEN 1
  ELSE 0
  END AS dummy_store_fg,
  CASE
  WHEN LCTN_WH.country_pol_cd IS NULL
  THEN 1
  ELSE 0
  END AS pseudo_store_fg,
  CASE
  WHEN CURRENT_DATE BETWEEN LCTN_WH_H.dwh_valid_from AND LCTN_WH_H.dwh_valid_to
  THEN 1
  ELSE 0
  END AS dwh_actual_fg,
  CASE
  WHEN LCTN_WH_H.deleted_fg = 0 AND CURRENT_DATE BETWEEN COALESCE(LCTN_WH.real_opening_dt, LCTN_WH.opening_dt, LCTN_WH_H
     .dwh_valid_from) AND (COALESCE(LCTN_WH.closing_dt, PARSE_DATE('%d.%m.%Y', '31.12.9999')))
  THEN 1
  ELSE 0
  END AS active_fg,
  CASE
  WHEN COALESCE(LCTN_WH.real_opening_dt, LCTN_WH.opening_dt) > CURRENT_DATE AND (LCTN_WH.closing_dt > COALESCE(LCTN_WH.real_opening_dt
       , LCTN_WH.opening_dt) OR LCTN_WH.closing_dt IS NULL)
  THEN 1
  ELSE 0
  END AS active_future_fg
FROM ldl_p_lew_core_ac.v_location_1 AS LCTN
 LEFT JOIN ldl_p_lew_core_ac.v_location_1 AS LCTN_WH ON LCTN.client_id = LCTN_WH.client_id AND ROUND(SAFE_CAST(SUBSTR(LCTN
       .global_loc_id, 4) AS BIGNUMERIC), 0) = ROUND(SAFE_CAST(SUBSTR(LCTN_WH.global_loc_id, 4) AS BIGNUMERIC), 0) AND
   UPPER(LCTN_WH.wh_store_mark) = 'B'
 LEFT JOIN ldl_p_lew_core_ac.v_location_hist_1 AS LCTN_WH_H ON LCTN_WH.client_id = LCTN_WH_H.client_id AND LCTN_WH.loc_sid
    = LCTN_WH_H.loc_sid
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_store_1 AS W_ST ON LCTN_WH.client_id = W_ST.client_id AND LCTN_WH.loc_sid = W_ST.st_loc_sid
     AND CURRENT_DATE BETWEEN W_ST.dat_rec_start AND W_ST.dat_rec_end
WHERE UPPER(LCTN.wh_store_mark) = 'A'
 AND LCTN_WH.client_id IS NOT NULL;