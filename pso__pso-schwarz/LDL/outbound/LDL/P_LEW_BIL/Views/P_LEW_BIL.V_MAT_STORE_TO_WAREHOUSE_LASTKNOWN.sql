CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat_store_to_warehouse_lastknown AS SELECT STWH.client_id,
 STWH.loc_sid_store,
 STWH.loc_sid_wh_01 AS loc_sid_wh,
 WH.src_wh_id,
 LOC.src_orig_store_nr,
 STWH.dwh_valid_from,
 STWH.dwh_valid_to,
 1 AS dwh_actual_fg,
  CASE
  WHEN CURRENT_DATE BETWEEN STWH.dwh_valid_from AND STWH.dwh_valid_to
  THEN 1
  ELSE 0
  END AS active_fg,
 0 AS future_active_fg
FROM ldl_p_lew_bil.v_store_to_wh_delivery_hist AS STWH
 INNER JOIN ldl_p_lew_core_ac.v_location AS LOC ON STWH.client_id = LOC.client_id AND STWH.loc_sid_store = LOC.loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_location AS WH ON STWH.client_id = WH.client_id AND STWH.loc_sid_wh_01 = WH.loc_sid
WHERE STWH.lastknown_fg = 1
UNION ALL
SELECT client_id,
 loc_sid_wh AS loc_sid_store,
 loc_sid_wh,
 src_wh_id,
 src_wh_id AS orig_store_nr,
 PARSE_DATE('%F', '1900-01-01') AS dwh_valid_from,
 PARSE_DATE('%F', '9999-12-30') AS dwh_valid_to,
 1 AS dwh_actual_fg,
 1 AS active_fg,
 0 AS future_active_fg
FROM ldl_p_lew_bil.v_warehouse AS LOC
WHERE dwh_actual_fg = 1
 AND active_fg = 1;