/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW fOR V_SOURCE_ITEM_FAMILY_GROUP_2
#-------------------------------------------------------------------------------
# Describtion: CREATE VIEW fOR V_SOURCE_ITEM_FAMILY_GROUP_2
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli   Initial version
#  1.1  2021-09-07 Mike Davis        Refinement
#  1.2  2021-09-17 Mike Davis        Formatting
#  1.3  2021-09-29 Dirk Hering       Use example role added, data types added, column order, formatting
#  1.4  2021-10-08 Dirk Hering       try_to_number added for sub_item_grp_sid
#  1.5  2021-10-12 Dirk Hering       Deduplication from source (Qualify Row Number = 1); ifg_hist.dwh_updated
#  1.6  2022-01-18 Andreas Kurz		 Reworked the structure
#  1.7  2022-09-06 Prasanna Ranjan   Added SCD_KEY_MD
#  1.8	2023-04-27 Nikolai Toknov	 Use SUB_ITEM_GRP_SID as AS-IS. WA. The target solution requires changes in architecture and joining at the T_A_*-level
#  1.9	2024-09-23 Nikolai Toknov	 Add schema name for f_CleanValidToDate
#-------------------------------------------------------------------------------
*/

/*
---------------------------------------------------------------------
0.  Merge the coure sources: t_item_familygroup_2, t_item_familygroup_hist_2, t_item_familygroup_descr_2
------------------------------------------------------------------------
*/




CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_item_family_group_2
OPTIONS(DESCRIPTION = `SOURCE VIEW FAMILY GROUP (AF)`) AS SELECT CAST(ifg.client_id AS BIGNUMERIC) AS client_id,
 CAST(ifg.item_fam_grp_sid AS BIGNUMERIC) AS item_fam_grp_sid,
 CAST(ifg.src_familygrp_id AS BIGNUMERIC) AS item_fam_grp_src_id,
 CAST(ifg.src_familygrp_cd AS STRING) AS item_fam_grp_src_cd,
 CAST(COALESCE(ifg.item_fam_grp_name, id_int.item_fam_grp_descr, id_local.item_fam_grp_descr, 'N/A') AS STRING) AS
 item_fam_grp_name,
 CAST(COALESCE(id_local.item_fam_grp_descr, ifg.item_fam_grp_name, id_int.item_fam_grp_descr, 'N/A') AS STRING) AS
 item_fam_grp_descr,
 CAST(COALESCE(id_int.item_fam_grp_descr, id_local.item_fam_grp_descr, ifg.item_fam_grp_name, 'N/A') AS STRING) AS
 item_fam_grp_int_descr,
 COALESCE(ifg_hist.sub_item_grp_sid, - 1) AS sub_item_grp_sid,
 TO_HEX(MD5(COALESCE(CAST(CAST(ifg.src_familygrp_id AS BIGNUMERIC) AS STRING), '') || COALESCE(CAST(ifg.src_familygrp_cd AS STRING)
         , '') || COALESCE(CAST(COALESCE(ifg.item_fam_grp_name, id_int.item_fam_grp_descr, id_local.item_fam_grp_descr, 'N/A') AS STRING)
        , '') || COALESCE(CAST(COALESCE(id_local.item_fam_grp_descr, ifg.item_fam_grp_name, id_int.item_fam_grp_descr, 'N/A') AS STRING)
       , '') || COALESCE(CAST(COALESCE(id_int.item_fam_grp_descr, id_local.item_fam_grp_descr, ifg.item_fam_grp_name, 'N/A') AS STRING)
      , '') || COALESCE(CAST(COALESCE(ifg_hist.sub_item_grp_sid, - 1) AS STRING), ''))) AS scd_key_md,
 DATE(COALESCE(ifg_hist.dwh_valid_from, DATE('1900-01-01'))) AS valid_from_dt,
 ldl_p_lew_mart_pit.f_cleanvalidtodate(ifg_hist.dwh_valid_to) AS valid_to_dt,
 CAST(ifg_hist.deleted_fg AS BIGNUMERIC) AS deleted_fg,
 ifg_hist.dwh_updated AS dwh_updated_ts
FROM (SELECT *
  FROM ldl_p_lew_core.t_item_familygroup_2
  WHERE client_id IN (SELECT client_id
     FROM ldl_p_lew_mart_pit.t_dim_client_2
     WHERE pit_country_fg = 1
      AND deleted_fg = 0
      AND reject_fg = 0
      AND current_fg = 1
     GROUP BY client_id)
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(item_fam_grp_sid AS STRING) ORDER BY dwh_updated IS NULL DESC,
        dwh_updated DESC)) = 1) AS ifg
 INNER JOIN (SELECT LAST_VALUE(sub_item_grp_sid) OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_fam_grp_sid AS STRING)
      ORDER BY dwh_valid_to IS NULL, dwh_valid_to RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   sub_item_grp_sid,
   client_id,
   item_fam_grp_sid,
   deleted_fg,
   dwh_updated,
   dwh_valid_from,
   dwh_valid_to
  FROM ldl_p_lew_core.t_item_familygroup_hist_2
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(item_fam_grp_sid AS STRING), dwh_valid_from ORDER BY dwh_updated IS NULL
        DESC, dwh_updated DESC)) = 1) AS ifg_hist ON ifg.client_id = ifg_hist.client_id AND ifg.item_fam_grp_sid =
   ifg_hist.item_fam_grp_sid
 INNER JOIN (SELECT *
  FROM ldl_p_lew_core.t_country_2
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(country_sid AS STRING) ORDER BY dwh_updated IS NULL DESC, dwh_updated
        DESC)) = 1) AS c_local ON ifg.client_id = c_local.country_sid
 INNER JOIN (SELECT *
  FROM ldl_p_lew_core.t_country_2
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(country_sid AS STRING) ORDER BY dwh_updated IS NULL DESC, dwh_updated
        DESC)) = 1) AS c_int ON TRIM(c_int.lang_cd) = '@'
 LEFT JOIN (SELECT *
  FROM ldl_p_lew_core.t_item_familygroup_descr_2
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(item_fam_grp_sid AS STRING), CAST(lang_sid AS STRING) ORDER BY
        dwh_updated IS NULL DESC, dwh_updated DESC)) = 1) AS id_local ON ifg.client_id = id_local.client_id AND c_local
    .lang_sid = id_local.lang_sid AND ifg.item_fam_grp_sid = id_local.item_fam_grp_sid
 LEFT JOIN (SELECT *
  FROM ldl_p_lew_core.t_item_familygroup_descr_2
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(item_fam_grp_sid AS STRING), CAST(lang_sid AS STRING) ORDER BY
        dwh_updated IS NULL DESC, dwh_updated DESC)) = 1) AS id_int ON ifg.client_id = id_int.client_id AND c_int.lang_sid
     = id_int.lang_sid AND ifg.item_fam_grp_sid = id_int.item_fam_grp_sid;


