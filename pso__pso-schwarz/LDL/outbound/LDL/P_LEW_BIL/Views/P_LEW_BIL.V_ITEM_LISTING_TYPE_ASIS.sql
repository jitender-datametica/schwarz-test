CREATE OR REPLACE VIEW ldl_p_lew_bil.v_item_listing_type_asis AS SELECT client_id,
 item_sid,
 list_type
FROM (SELECT A.client_id,
   A.item_sid,
   COALESCE(A.list_type_mark, '-') AS list_type,
   COUNT(*) AS counti
  FROM ldl_p_lew_core_ac.v_item_listing_type_hist AS A
   INNER JOIN ldl_p_lew_core_ac.v_location AS B ON A.loc_sid = B.loc_sid AND B.wh_store_mark = 'A' AND B.global_loc_type_cd
      = '0'
   INNER JOIN ldl_p_lew_core_ac.v_location_hist AS C ON B.loc_sid = C.loc_sid AND C.demand_plan_active_fg = 1 AND
      CURRENT_DATE BETWEEN C.dwh_valid_from AND C.dwh_valid_to AND C.deleted_fg = 0
  WHERE CURRENT_DATE BETWEEN A.dwh_valid_from AND A.dwh_valid_to
   AND A.deleted_fg = 0
  GROUP BY A.client_id,
   A.item_sid,
   list_type
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.client_id AS STRING), CAST(A.item_sid AS STRING) ORDER BY counti
        IS NULL, counti)) = 1) AS t2;