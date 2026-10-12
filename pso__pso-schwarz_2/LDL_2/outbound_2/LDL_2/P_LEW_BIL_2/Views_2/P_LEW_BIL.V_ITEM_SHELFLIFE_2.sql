CREATE OR REPLACE VIEW ldl_p_lew_bil.v_item_shelflife_2 AS SELECT ITEM.client_id,
 ITEM.item_sid,
 ITEM.item_name,
 COALESCE(imloh.dur_shelflife_day_cust, wiia.dur_shelflife_day_cust) AS dur_shelflife_day_cust,
 COALESCE(imloh.dur_shelflife_day_store, wiia.dur_shelflife_day_store) AS dur_shelflife_day_store,
 COALESCE(imloh.dur_shelflife_day_wh, wiia.dur_shelflife_day_wh) AS dur_shelflife_day_wh,
 COALESCE(wiia.period_id_shelflife_cust, - 1) AS period_id_shelflife_cust,
 COALESCE(wiia.period_id_shelflife_store, - 1) AS period_id_shelflife_store,
 COALESCE(wiia.period_id_shelflife_wh, - 1) AS period_id_shelflife_wh
FROM ldl_p_lew_core_ac.v_item_2 AS ITEM_2
 INNER JOIN ldl_p_lew_process_ac.v_sap_migration_client_2 AS C ON ITEM.client_id = C.client_id
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
   INNER JOIN ldl_p_lew_bil.v_warehouse_2 AS WH ON IT.client_id = WH.client_id AND IT.loc_sid = WH.loc_sid_wh AND WH.bges_active_fg
       = 1 AND WH.dwh_actual_fg = 1
  WHERE CURRENT_DATE BETWEEN IT.dwh_valid_from AND IT.dwh_valid_to
   AND IT.deleted_fg = 0
  GROUP BY IT.client_id,
   IT.item_sid) AS imloh ON ITEM.client_id = imloh.client_id AND ITEM.item_sid = imloh.item_sid AND C.migrated_fg = 1
 LEFT JOIN (SELECT client_id,
   item_sid,
   dur_shelflife_day_cust,
   dur_shelflife_day_store,
   dur_shelflife_day_wh,
   period_id_shelflife_cust,
   period_id_shelflife_store,
   period_id_shelflife_wh
  FROM ldl_p_lew_core_ac.v_wawi_itm_item_act_2) AS wiia ON ITEM.client_id = wiia.client_id AND ITEM.item_sid = wiia.item_sid
   
WHERE imloh.client_id IS NOT NULL
 OR wiia.client_id IS NOT NULL;