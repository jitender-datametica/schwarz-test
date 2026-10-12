
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_ANALYTICS.V_PIT_ITEMGROUP_INTERNATIONAL_2
(
  client_id
, item_grp_int_sid
, src_itemgrp_int_cd
, item_grp_int_descr_int
, item_grp_int_descr_loc
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_ANALYTICS
AS
   SELECT
     igi.client_id,
   igi.item_grp_int_sid,
   igi.src_itemgrp_int_cd,
   igi.item_grp_int_name                                   AS item_grp_int_descr_int,
   COALESCE(dsc.item_grp_int_descr, igi.item_grp_int_name) AS item_grp_int_descr_loc
  FROM p_lew_core_ac.v_itemgroup_international_2 AS igi
   INNER JOIN p_lew_core_ac.v_country_2 AS ctr
   ON  igi.client_id = ctr.country_sid
   LEFT JOIN p_lew_core_ac.v_itemgroup_international_descr_2 AS dsc
   ON  igi.client_id        = dsc.client_id
   AND igi.item_grp_int_sid = dsc.item_grp_int_sid
   AND ctr.lang_sid         = dsc.lang_sid
   WHERE  igi.src_itemgrp_int_cd <> 8
   UNION ALL
   SELECT
     country_sid,
   -2,
   'TOT',
   'TOT',
   'TOT'
  FROM p_lew_core_ac.v_country_2
   ;
