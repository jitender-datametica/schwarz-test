/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_CS_ITEM_DETAILS_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_CS_ITEM_DETAILS_2
(
client_id
, int_subitemgroup_id
, subitemgroup_id
, orig_item_nr
, case_size
, country_iso_cd
, valid_from
, valid_until
, itemstatus_cd
, packagetype_desc
, dwh_updated
, dwh_created
, dwh_load_id
)
AS
   SELECT
   i.client_id                         AS client_id,
   COALESCE(i.int_subitemgroup_id,0) AS int_subitemgroup_id,
   i.subitemgroup_id,
   i.orig_item_nr,
   i.case_size,
   i.src_country_lidl_cd             AS country_iso_cd,
   i.valid_from,
   i.valid_until,
   COALESCE(i.itemstatus_cd,0)       AS itemstatus_cd,
   i.packagetype_desc,
   i.dwh_updated,
   i.dwh_created,
   i.dwh_load_id
   FROM (SELECT
   client_id,
   int_subitemgroup_id,
   subitemgroup_id,
   orig_item_nr,
   case_size,
   src_country_lidl_cd,
   valid_from,
   valid_until,
   itemstatus_cd,
   packagetype_desc,
   dwh_updated,
   dwh_created,
   dwh_load_id,
   ROW_NUMBER() OVER (PARTITION BY client_id,orig_item_nr,case_size ORDER BY valid_from DESC NULLS LAST, dwh_created DESC NULLS LAST, dwh_load_id DESC NULLS LAST,itemstatus_cd DESC NULLS LAST, subitemgroup_id DESC NULLS LAST, int_subitemgroup_id) AS rownumber
   FROM p_lew_mart_cs.v_gen_item_asis_2
        ) i

  WHERE i.rownumber = 1
  AND i.orig_item_nr > 0
;