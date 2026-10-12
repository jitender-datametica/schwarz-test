CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_m_cost_center_store_1 AS
-- store.orig_store_nr as cost_center, -- old version; the following was needed because there are costs on WH level

/* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
SELECT MOVE_STORE.orig_store_nr AS store_nr,
 STORE.store_id,
 STORE.store_desc AS store_name,
 WH.wh_id,
 WH.wh_desc AS wh_name,
 STORE.move_fg,
 STORE.transfer_fg,
 STORE.move_to_store_id,
 ROUND(CAST(TRUNC(CAST(COALESCE(CAST(MAPPING_WH_STORE.cost_center AS BIGNUMERIC), STORE.orig_store_nr) AS BIGNUMERIC)) AS BIGNUMERIC)
  , 0) AS cost_center,
 /* new version */ LOC.sales_manager_name,
 LOC.account_manager_name,
 STORE.dat_opening_ovis,
 STORE.dat_closing_ovis,
 STORE.mis_store_active_fg,
 MAP_INFO.longitude,
 MAP_INFO.latitude
FROM ldl_s_conl.v_org_store_merge_1 AS STORE
 INNER JOIN ldl_s_conl.v_org_wh_merge_1 AS WH ON STORE.client_id = WH.client_id AND STORE.wh_id = WH.wh_id AND WH.aspect_id
    = 1
 LEFT JOIN ldl_s_conl.v_org_store_merge_1 AS MOVE_STORE ON STORE.client_id = MOVE_STORE.client_id AND STORE.move_to_store_id
     = MOVE_STORE.store_id AND MOVE_STORE.aspect_id = 1
 LEFT JOIN ldl_s_conl.v_location_organization_1 AS LOC ON STORE.client_id = LOC.client_id AND STORE.store_id = LOC.loc_sid_store
     AND CURRENT_DATE BETWEEN LOC.active_from_dt AND LOC.active_to_dt
 LEFT JOIN ldl_s_conl.v_org_all_store_merge_1 AS MAP_INFO ON STORE.move_to_store_id = MAP_INFO.move_to_store_id AND STORE
    .client_id = MAP_INFO.client_id AND MAP_INFO.aspect_id = 1
 LEFT JOIN ldl_s_conl_workbench.t_m_cost_center_warehouse_1 AS MAPPING_WH_STORE ON MAPPING_WH_STORE.mis_dummy_store_nr
  IS NOT NULL AND MOVE_STORE.orig_store_nr = MAPPING_WH_STORE.mis_dummy_store_nr
WHERE STORE.aspect_id = 1;