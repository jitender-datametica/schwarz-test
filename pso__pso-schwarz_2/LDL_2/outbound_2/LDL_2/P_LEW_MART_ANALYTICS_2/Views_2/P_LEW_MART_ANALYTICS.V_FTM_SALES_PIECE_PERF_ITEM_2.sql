CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics.v_ftm_sales_piece_perf_item_2 (client_id, country_code, dat_formdate,
cy_week, store_id, orig_store_nr, item_id, orig_item_nr, itemgroup_int_id, subitemgroup_id, item_type, sales_pieces,
sales_pieces_total) AS SELECT SDPP.client_id,
 RCTRY.country_iso_cd AS country_code,
 SDPP.dwh_cal_dt AS dat_formdate,
 TAG.cy_week,
 SDPP.loc_sid_store AS store_id,
 SDPP.src_orig_store_nr AS orig_store_nr,
 ITMP.item_sid_map AS item_id,
 ART_INFO.orig_item_nr,
 UWG_INFO.itemgroup_int_id,
 ART_INFO.subitemgroup_id,
  CASE
  WHEN ART_INFO.buying_list_type_id IN (7, 8)
  THEN 'AKTIONSARTIKEL'
  ELSE 'SORTIMENT'
  END AS item_type,
 SDPP.sales_pieces,
 SDPP.sales_pieces_total
FROM ldl_p_lew_bil_ac.v_agg_store_day_piece_perf_item_2 AS SDPP
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITMP ON SDPP.client_id = ITMP.client_id AND SDPP.item_sid = ITMP.item_sid
   
 INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_item_2 AS ART_INFO ON ITMP.client_id = ART_INFO.client_id AND ITMP.item_sid_map =
   ART_INFO.item_id
 INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_subitemgroup_2 AS UWG_INFO ON ART_INFO.subitemgroup_id = UWG_INFO.subitemgroup_id
 INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday_2 AS TAG_2 ON SDPP.dwh_cal_dt = TAG.dat_calendar
 INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_country_2 AS RCTRY ON SDPP.client_id = RCTRY.country_id
WHERE SDPP.currency_iso_cd = 'EUR';