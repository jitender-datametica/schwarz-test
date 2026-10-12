
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_ANALYTICS.V_SCA_ITEM_HIERARCHY_2
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_ANALYTICS
AS
   SELECT
   it.client_id,
   it.item_id AS item_sid,
   orig_item_nr,
   dat_valid_from,
   MAX(it.item_familygroup_id) OVER (PARTITION BY it.client_id, orig_item_nr,  dat_valid_from) AS item_familygroup_id,
   MAX(its.subitemgroup_id)  OVER (PARTITION BY it.client_id, orig_item_nr,  dat_valid_from) AS subitemgroup_id,
   MAX(its.itemgroup_int_id)  OVER (PARTITION BY it.client_id, orig_item_nr,  dat_valid_from) AS itemgroup_int_id
   FROM (SELECT client_id,
   orig_item_nr,
   dat_valid_from,
   item_id,
   MAX( item_familygroup_id) OVER (PARTITION By it.client_id, orig_item_nr,  dat_valid_from) AS item_familygroup_id
    FROM p_lew_mart_msi.v_itm_item_2 AS it
   ) AS it
   INNER JOIN p_lew_mart_msi.v_itm_familygroup_2 AS itf
   ON  it.client_id = itf.client_id
   AND it.item_familygroup_id = itf.item_familygroup_id
   INNER JOIN p_lew_mart_msi.v_itm_subitemgroup_2 AS its
   ON  itf.subitemgroup_id = its.subitemgroup_id
   WHERE it.orig_item_nr > 0;
