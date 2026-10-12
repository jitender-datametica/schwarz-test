CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_org_sales_manager_2 AS SELECT S2WLK.client_id,
 S2WLK.src_wh_id AS wh_id,
 S2WLK.loc_sid_store AS store_id,
 COALESCE(ORG.sales_manager_id, - 100) AS sales_manager_id,
 COALESCE(ORG.sales_manager_name, 'Bezirksleiter') AS sales_manager_name,
 COALESCE(ORG.account_manager_id, - 1) AS account_manager_id
FROM ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_2 AS S2WLK
 LEFT JOIN ldl_p_lew_bil_ac.v_location_organization_2 AS ORG ON S2WLK.client_id = ORG.client_id AND S2WLK.loc_sid_wh = ORG
    .loc_sid_wh AND S2WLK.loc_sid_store = ORG.loc_sid_store;