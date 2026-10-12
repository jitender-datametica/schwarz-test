CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_item_map_deleteme
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
/* could fix a missing parent by coalescing with the child but we don't want to mask the error */ 
/* Child */
/* Parent */ 
SELECT ITMC.client_id,
 ITMC.item_sid,
 ITMC.item_id,
 ITMP.client_id AS parent_client_id,
 ITMC.parent_item_sid,
 ITMP.item_id AS parent_item_id
FROM ldl_p_lew_mart_msi.v_item_map_direct_deleteme AS ITMC
 LEFT JOIN ldl_p_lew_mart_msi.v_item_map_direct_deleteme AS ITMP ON ITMC.parent_item_sid = ITMP.item_sid;