
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_ANALYTICS.V_PIT_ITEM_FAMILYGROUP_1
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_ANALYTICS
AS
   SELECT
     client_id,
   item_fam_grp_sid,
   src_familygrp_cd    AS item_fam_grp_descr
  FROM p_lew_core_ac.v_item_familygroup_1
  UNION ALL
  SELECT
    country_sid,
   -2,
   'TOT'
  FROM p_lew_core_ac.v_country_1
;
