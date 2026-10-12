CREATE OR REPLACE VIEW s_conl_workbench.v_m_cost_center_store
AS
(SELECT
move_store.orig_store_nr as store_nr,
store.store_id,
store.store_desc as store_name,
wh.wh_id,
wh_desc as wh_name,
store.move_fg,
store.transfer_fg,
store.move_to_store_id,
--store.orig_store_nr as cost_center, -- old version; the following was needed because there are costs on WH level
Cast(TRUNC(coalesce(mapping_wh_store.cost_center, store.orig_store_nr)) as Integer) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/as cost_center,
/* new version*/
loc.sales_manager_name,
loc.account_manager_name,
store.dat_opening_ovis,
store.dat_closing_ovis,
store.mis_store_active_fg,
map_info.longitude,
map_info.latitude
FROM s_conl.v_org_store_merge as store
INNER JOIN s_conl.v_org_wh_merge as wh
ON store.client_id = wh.client_id
AND store.wh_id = wh.wh_id
and wh.aspect_id = 1
LEFT JOIN s_conl.v_org_store_merge AS move_store
ON store.client_id = move_store.client_id
AND store.move_to_store_id = move_store.store_id
and move_store.aspect_id = 1
LEFT JOIN s_conl.v_location_organization as loc
ON store.client_id = loc.client_id
AND store.store_id = loc.loc_sid_store
AND CURRENT_DATE BETWEEN loc.active_from_dt AND loc.active_to_dt
LEFT JOIN s_conl.v_org_all_store_merge as map_info
ON store.move_to_store_id = map_info.move_to_store_id
AND store.client_id = map_info.client_id
AND map_info.aspect_id = 1
LEFT JOIN s_conl_workbench.t_m_cost_center_warehouse as mapping_wh_store
ON mapping_wh_store.mis_dummy_store_nr is not null
AND move_store.orig_store_nr  = mapping_wh_store.mis_dummy_store_nr
WHERE store.aspect_id = 1

);


