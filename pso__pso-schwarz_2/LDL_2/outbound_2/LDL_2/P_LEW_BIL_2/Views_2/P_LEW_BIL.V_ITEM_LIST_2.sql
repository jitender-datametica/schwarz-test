CREATE OR REPLACE VIEW ldl_p_lew_bil.v_item_list_2 AS SELECT client_id,
 item_sid,
 loc_sid,
 active_from_dt,
 active_to_dt,
 list_type_mark,
 list_type_label,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
  CASE
  WHEN CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
  THEN 1
  ELSE 0
  END AS dwh_actual_fg,
  CASE
  WHEN deleted_fg = 1 OR active_to_dt < CURRENT_DATE OR active_from_dt > CURRENT_DATE
  THEN 0
  ELSE 1
  END AS active_fg
FROM ldl_p_lew_core_ac.v_item_listing_type_hist_2;