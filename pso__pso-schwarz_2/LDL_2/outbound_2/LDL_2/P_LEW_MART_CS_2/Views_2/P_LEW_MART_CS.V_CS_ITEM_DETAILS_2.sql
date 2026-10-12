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


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_cs_item_details_2 (client_id, int_subitemgroup_id, subitemgroup_id,
orig_item_nr, case_size, country_iso_cd, valid_from, valid_until, itemstatus_cd, packagetype_desc, dwh_updated,
dwh_created, dwh_load_id) AS SELECT client_id,
 COALESCE(int_subitemgroup_id, 0) AS int_subitemgroup_id,
 subitemgroup_id,
 orig_item_nr,
 case_size,
 src_country_lidl_cd AS country_iso_cd,
 valid_from,
 valid_until,
 COALESCE(itemstatus_cd, 0) AS itemstatus_cd,
 packagetype_desc,
 dwh_updated,
 dwh_created,
 dwh_load_id
FROM ldl_p_lew_mart_cs.v_gen_item_asis_2
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), orig_item_nr, CAST(case_size AS STRING) ORDER BY
       valid_from IS NULL, valid_from, dwh_created IS NULL, dwh_created, dwh_load_id IS NULL, dwh_load_id, itemstatus_cd
       IS NULL, itemstatus_cd, subitemgroup_id IS NULL, subitemgroup_id, int_subitemgroup_id IS NULL,
       int_subitemgroup_id)) = 1 AND orig_item_nr > 0;