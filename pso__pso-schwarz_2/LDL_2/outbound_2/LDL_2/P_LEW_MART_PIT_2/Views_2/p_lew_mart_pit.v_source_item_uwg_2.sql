/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW FOR V_SOURCE_ITEM_UWG_2
#-------------------------------------------------------------------------------
# Description: CREATE VIEW FOR V_SOURCE_ITEM_UWG_2 (item_2 sub group)
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli     Initial version
#  1.1  2021-09-07 Mike Davis          Refinement
#  1.2  2021-09-17 Mike Davis          Formatting
#  1.3  2021-09-29 Dirk Hering         Use example role added, data types added, column order, formatting
#  1.4  2021-10-12 Dirk Hering         Deduplication from source (Qualify Row Number = 1); isg_hist.dwh_updated
#  1.5	2023-04-27 Nikolai Toknov	   Use ITEM_GRP_INT_SID as AS-IS. WA. The target solution requires changes in architecture and joining at the T_A_*-level
#  1.6  2024-02-01 Andreas Kurz		   Enhance View WGI by additionbal condition used in WaWi-PV Detection
#									   PV_UWG_GROUP_FG
#  1.7	2024-09-23 Nikolai Toknov	   Add schema name for f_CleanValidToDate
#-------------------------------------------------------------------------------
*/
/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_MART_PIT_2;
 */
/*
---------------------------------------------------------------------
0.   CREATE VIEW in V_SOURCE_ITEM_UWG_2
     Merge the coure sources: t_subitemgroup_2, t_subitemgroup_hist_2, t_subitemgroup_descr_2
------------------------------------------------------------------------
*/



CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_item_uwg_2 OPTIONS(DESCRIPTION = `V_SOURCE_ITEM_UWG_2`) AS SELECT CAST(t3.client_id AS BIGNUMERIC)
 AS client_id,
 CAST(t3.sub_item_grp_sid AS BIGNUMERIC) AS sub_item_grp_sid,
 CAST(t3.src_subitemgrp_cd AS STRING) AS sub_item_grp_src_cd,
 IF(t3.src_subitemgrp_nr IS NOT NULL AND (t3.src_subitemgrp_nr BETWEEN 100 AND 399 OR t3.src_subitemgrp_nr IN (75, 76))
  , 1, 0) AS pv_uwg_group_fg,
 CAST(COALESCE(t3.sub_item_grp_name, t13.sub_item_grp_descr, t11.sub_item_grp_descr, 'N/A') AS STRING) AS
 sub_item_grp_name,
 CAST(COALESCE(t11.sub_item_grp_descr, t3.sub_item_grp_name, t13.sub_item_grp_descr, 'N/A') AS STRING) AS
 sub_item_grp_descr,
 CAST(COALESCE(t13.sub_item_grp_descr, t11.sub_item_grp_descr, t3.sub_item_grp_name, 'N/A') AS STRING) AS
 sub_item_grp_int_descr,
 COALESCE(isg_hist.item_grp_int_sid, - 1) AS item_grp_int_sid,
 TO_HEX(MD5(COALESCE(CAST(COALESCE(t3.sub_item_grp_name, t13.sub_item_grp_descr, t11.sub_item_grp_descr, 'N/A') AS STRING)
       , '') || COALESCE(CAST(COALESCE(t11.sub_item_grp_descr, t3.sub_item_grp_name, t13.sub_item_grp_descr, 'N/A') AS STRING)
       , '') || COALESCE(CAST(COALESCE(t13.sub_item_grp_descr, t11.sub_item_grp_descr, t3.sub_item_grp_name, 'N/A') AS STRING)
      , '') || COALESCE(CAST(COALESCE(isg_hist.item_grp_int_sid, - 1) AS STRING), ''))) AS scd_key_md,
 DATE(COALESCE(isg_hist.dwh_valid_from, DATE('1900-01-01'))) AS valid_from_dt,
 DATE(ldl_p_lew_mart_pit.f_cleanvalidtodate(isg_hist.dwh_valid_to)) AS valid_to_dt,
 CAST(isg_hist.deleted_fg AS BIGNUMERIC) AS deleted_fg,
 isg_hist.dwh_updated AS dwh_updated_ts
FROM (SELECT client_id,
   sub_item_grp_sid,
   src_node,
   src_subitemgrp_cd,
   ROUND(SAFE_CAST(src_subitemgrp_cd AS BIGNUMERIC), 0) AS src_subitemgrp_nr,
   src_subitemgrp_id,
   sub_item_grp_name,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM ldl_p_lew_core.t_subitemgroup_2
  WHERE client_id IN (SELECT client_id
     FROM ldl_p_lew_mart_pit.t_dim_client_2
     WHERE pit_country_fg = 1
      AND deleted_fg = 0
      AND reject_fg = 0
      AND current_fg = 1
     GROUP BY client_id)
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(sub_item_grp_sid AS STRING) ORDER BY dwh_updated IS NULL DESC,
        dwh_updated DESC)) = 1) AS t3
 INNER JOIN (SELECT client_id,
   sub_item_grp_sid,
   LAST_VALUE(item_grp_int_sid) OVER (PARTITION BY CAST(client_id AS STRING), CAST(sub_item_grp_sid AS STRING) ORDER BY
      dwh_valid_to IS NULL, dwh_valid_to RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS item_grp_int_sid
   ,
   dwh_valid_from,
   dwh_valid_to,
   deleted_fg,
   dwh_updated
  FROM ldl_p_lew_core.t_subitemgroup_hist_2
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(sub_item_grp_sid AS STRING), dwh_valid_from ORDER BY dwh_updated IS NULL
        DESC, dwh_updated DESC)) = 1) AS isg_hist ON t3.client_id = isg_hist.client_id AND t3.sub_item_grp_sid =
   isg_hist.sub_item_grp_sid
 INNER JOIN (SELECT country_sid,
   src_country_lidl_cd,
   src_lang_id,
   country_name,
   country_grp_sid,
   lang_sid,
   lang_cd,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM ldl_p_lew_core.t_country_2
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(country_sid AS STRING) ORDER BY dwh_updated IS NULL DESC, dwh_updated
        DESC)) = 1) AS t7 ON t3.client_id = t7.country_sid
 INNER JOIN (SELECT country_sid,
   src_country_lidl_cd,
   src_lang_id,
   country_name,
   country_grp_sid,
   lang_sid,
   lang_cd,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM ldl_p_lew_core.t_country_2
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(country_sid AS STRING) ORDER BY dwh_updated IS NULL DESC, dwh_updated
        DESC)) = 1) AS t9 ON t9.lang_cd = '@'
 LEFT JOIN (SELECT client_id,
   sub_item_grp_sid,
   lang_sid,
   lang_cd,
   sub_item_grp_descr,
   sub_item_grp_descr_long,
   sub_item_grp_descr_caps,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM ldl_p_lew_core.t_subitemgroup_descr_2
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(sub_item_grp_sid AS STRING), CAST(lang_sid AS STRING) ORDER BY
        dwh_updated IS NULL DESC, dwh_updated DESC)) = 1) AS t11 ON t3.client_id = t11.client_id AND t7.lang_sid = t11.lang_sid
     AND t3.sub_item_grp_sid = t11.sub_item_grp_sid
 LEFT JOIN (SELECT client_id,
   sub_item_grp_sid,
   lang_sid,
   lang_cd,
   sub_item_grp_descr,
   sub_item_grp_descr_long,
   sub_item_grp_descr_caps,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM ldl_p_lew_core.t_subitemgroup_descr_2
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(sub_item_grp_sid AS STRING), CAST(lang_sid AS STRING) ORDER BY
        dwh_updated IS NULL DESC, dwh_updated DESC)) = 1) AS t13 ON t3.client_id = t13.client_id AND t9.lang_sid = t13.lang_sid
     AND t3.sub_item_grp_sid = t13.sub_item_grp_sid
WHERE t3.src_subitemgrp_nr > 0;


