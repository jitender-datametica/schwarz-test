
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_ANALYTICS.V_SCA_ORIG_ITEM_1
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_ANALYTICS
AS
   SELECT
    it.dat_valid_from,
   it.orig_item_nr,
   it.client_id,
   MAX(it.item_familygroup_id) AS item_familygroup_id,
   MAX(its.subitemgroup_id) AS subitemgroup_id,
   MAX(its.mainitemgroup_id) AS mainitemgroup_id,
   MAX(its.itemgroup_int_id) AS itemgroup_int_id
   FROM p_lew_mart_msi.v_itm_item_1 AS it
   INNER JOIN p_lew_mart_msi.v_itm_familygroup_1 AS itf
   ON  it.client_id = itf.client_id
   AND it.item_familygroup_id = itf.item_familygroup_id
   INNER JOIN p_lew_mart_msi.v_itm_subitemgroup_1 AS its
   ON  itf.subitemgroup_id = its.subitemgroup_id
   WHERE it.orig_item_nr > 0
   GROUP BY
    it.dat_valid_from
   ,it.orig_item_nr
   ,it.client_id;
