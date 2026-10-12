
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_ANALYTICS.V_PIT_ITEM_2
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_ANALYTICS
AS
   SELECT
     itm.client_id,
   itm.item_sid,
   itm.src_orig_item_nr                      AS orig_item_nr,
   itm.item_name                             AS item_descr_int,
   COALESCE(dsc.item_descr, itm.item_name)   AS item_descr_loc,
   ifg.src_familygrp_cd                      AS uwg_af_desc,
   TO_NUMBER(NULL)     AS subitemgroup_id,
   TO_NUMBER(NULL)     AS listing_fg,
   TO_NUMBER(NULL)     AS item_familygroup_id,
   NULL AS subitemgroup_desc_intl,
   NULL AS item_family_desc_intl
   FROM p_lew_core_ac.v_item_2 AS itm
   INNER JOIN p_lew_core_ac.v_item_hist_2 AS ith
   ON  itm.client_id = ith.client_id
   AND itm.item_sid = ith.item_sid
   AND CURRENT_DATE BETWEEN ith.dwh_valid_from AND ith.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_country_2 AS ctr
   ON  itm.client_id = ctr.country_sid
   LEFT JOIN p_lew_core_ac.v_item_descr_2 AS dsc
   ON  itm.client_id = dsc.client_id
   AND itm.item_sid  = dsc.item_sid
   AND ctr.lang_sid  = dsc.lang_sid
   INNER JOIN p_lew_core_ac.v_item_familygroup_2 AS ifg
   ON  ith.client_id        = ifg.client_id
   AND ith.item_fam_grp_sid = ifg.item_fam_grp_sid
   UNION ALL
   SELECT
     country_sid,
   -2,
   'TOT',
   'TOT',
   'TOT',
   'TOT',
   TO_NUMBER(NULL) AS subitemgroup_id,
   TO_NUMBER(NULL) AS listing_fg,
   TO_NUMBER(NULL) AS item_familygroup_id,
   NULL AS subitemgroup_desc_intl,
   NULL AS item_family_desc_intl
   FROM p_lew_core_ac.v_country_2
   ;
