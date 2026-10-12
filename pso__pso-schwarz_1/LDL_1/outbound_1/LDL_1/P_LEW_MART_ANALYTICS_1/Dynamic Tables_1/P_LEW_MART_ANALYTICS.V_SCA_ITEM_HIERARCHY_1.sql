
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_analytics.v_sca_item_hierarchy_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT it.client_id,
 it.item_id AS item_sid,
 it.orig_item_nr,
 it.dat_valid_from,
 MAX(it.item_familygroup_id) OVER (PARTITION BY CAST(it.client_id AS STRING), it.orig_item_nr, it.dat_valid_from
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS item_familygroup_id,
 MAX(ITS.subitemgroup_id) OVER (PARTITION BY CAST(it.client_id AS STRING), it.orig_item_nr, it.dat_valid_from
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS subitemgroup_id,
 MAX(ITS.itemgroup_int_id) OVER (PARTITION BY CAST(it.client_id AS STRING), it.orig_item_nr, it.dat_valid_from
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS itemgroup_int_id
FROM (SELECT client_id,
   orig_item_nr,
   dat_valid_from,
   item_id,
   MAX(item_familygroup_id) OVER (PARTITION BY CAST(client_id AS STRING), orig_item_nr, dat_valid_from RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS item_familygroup_id
  FROM ldl_p_lew_mart_msi.v_itm_item_1 AS IT) AS it
 INNER JOIN ldl_p_lew_mart_msi.v_itm_familygroup_1 AS ITF ON it.client_id = ITF.client_id AND it.item_familygroup_id = ITF
   .item_familygroup_id
 INNER JOIN ldl_p_lew_mart_msi.v_itm_subitemgroup_1 AS ITS ON ITF.subitemgroup_id = ITS.subitemgroup_id
WHERE it.orig_item_nr > 0;
