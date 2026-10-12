
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_ANALYTICS.V_PIT_SUBITEMGROUP_2
(
  client_id
, sub_item_grp_sid
, src_subitemgrp_cd
, sub_item_grp_descr_int
, sub_item_grp_descr_loc
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_ANALYTICS
AS
   SELECT
     sig.client_id,
   sig.sub_item_grp_sid,
   sig.src_subitemgrp_cd,
   sig.sub_item_grp_name                                   AS sub_item_grp_descr_int,
   COALESCE(dsc.sub_item_grp_descr, sig.sub_item_grp_name) AS sub_item_grp_descr_loc
  FROM p_lew_core_ac.v_subitemgroup_2 AS sig
   INNER JOIN p_lew_core_ac.v_country_2 AS ctr
   ON  sig.client_id = ctr.country_sid
   LEFT JOIN p_lew_core_ac.v_subitemgroup_descr_2 AS dsc
   ON  sig.client_id        = dsc.client_id
   AND sig.sub_item_grp_sid = dsc.sub_item_grp_sid
   AND ctr.lang_sid         = dsc.lang_sid
   UNION ALL
   SELECT
     country_sid,
   -2,
   'TOT',
   'TOT',
   'TOT'
  FROM p_lew_core_ac.v_country_2
   ;
