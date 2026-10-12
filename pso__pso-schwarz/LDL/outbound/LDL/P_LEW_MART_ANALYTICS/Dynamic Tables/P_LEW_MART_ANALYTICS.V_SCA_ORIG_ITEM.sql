CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_analytics.v_sca_orig_item
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT IT.dat_valid_from,
 IT.orig_item_nr,
 IT.client_id,
 MAX(IT.item_familygroup_id) AS item_familygroup_id,
 MAX(ITS.subitemgroup_id) AS subitemgroup_id,
 MAX(ITS.mainitemgroup_id) AS mainitemgroup_id,
 MAX(ITS.itemgroup_int_id) AS itemgroup_int_id
FROM ldl_p_lew_mart_msi.v_itm_item AS IT
 INNER JOIN ldl_p_lew_mart_msi.v_itm_familygroup AS ITF ON IT.client_id = ITF.client_id AND IT.item_familygroup_id = ITF
   .item_familygroup_id
 INNER JOIN ldl_p_lew_mart_msi.v_itm_subitemgroup AS ITS ON ITF.subitemgroup_id = ITS.subitemgroup_id
WHERE IT.orig_item_nr > 0
GROUP BY IT.dat_valid_from,
 IT.orig_item_nr,
 IT.client_id;