/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_MAT_APT_ITEM_SUBITEMGRP_REL_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_MAT_APT_ITEM_SUBITEMGRP_REL_2
(
  client_id
, country_iso_cd
, org_item_nr
, valid_from
, case_size
, dat_rec_start
, dat_rec_end
, subitemgroup_no
, dwh_updated
, dwh_created
, dwh_load_id
, load_id
, src_id
)
AS
SELECT
a.client_id,
a.src_country_lidl_cd     AS country_iso_cd,
a.orig_item_nr            AS org_item_nr,
a.valid_from              AS valid_from,
COALESCE(a.case_size, 0)  AS case_size,
a.valid_from              AS dat_rec_start,
a.valid_until             AS dat_rec_end,
a.subitemgroup_id         AS subitemgroup_no,
a.dwh_updated             AS dwh_updated,
a.dwh_created             AS dwh_created,
a.dwh_load_id             AS dwh_load_id,
CAST(-1 AS INTEGER)   AS load_id,
2                         AS src_id
FROM p_lew_mart_cs.v_gen_item_asis_2 a

WHERE a.subitemgroup_id > 0
  AND a.subitemgroup_id IS NOT NULL
  AND a.itemstatus_cd > 3
  AND a.itemstatus_cd < 10
  AND a.buying_list_type_id IS NOT NULL
  AND a.buying_list_type_id > 0

GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13
QUALIFY ROW_NUMBER () OVER (PARTITION BY a.client_id, a.orig_item_nr, a.valid_from, COALESCE(a.case_size, 0) ORDER BY a.subitemgroup_id DESC NULLS LAST) = 1
;


