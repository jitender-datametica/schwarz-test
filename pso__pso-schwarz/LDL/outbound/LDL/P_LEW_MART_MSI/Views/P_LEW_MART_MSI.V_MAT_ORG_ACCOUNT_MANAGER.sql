CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_org_account_manager AS SELECT S2WLK.client_id,
 S2WLK.src_wh_id AS wh_id,
 COALESCE(ORG.account_manager_id, - 1) AS account_manager_id,
 MAX(COALESCE(ORG.account_manager_name, 'Vertriebsleiter')) AS account_manager_name
FROM ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown AS S2WLK
 LEFT JOIN ldl_p_lew_bil_ac.v_location_organization AS ORG ON S2WLK.client_id = ORG.client_id AND S2WLK.loc_sid_wh = ORG
    .loc_sid_wh AND S2WLK.loc_sid_store = ORG.loc_sid_store
GROUP BY S2WLK.client_id,
 wh_id,
 account_manager_id;