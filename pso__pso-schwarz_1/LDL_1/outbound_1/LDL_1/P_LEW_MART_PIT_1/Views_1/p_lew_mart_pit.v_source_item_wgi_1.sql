/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW fOR V_SOURCE_ITEM_WGI_1
#-------------------------------------------------------------------------------
# Description: CREATE VIEW fOR V_SOURCE_ITEM_WGI_1 (item_1 group international)
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli     Initial version
#  1.1  2021-09-09 Mike Davis          Refinement
#  1.2  2021-09-17 Mike Davis          Formatting
#  1.3  2021-09-29 Dirk Hering         Use example role added, data types added, column order, formatting
#  1.4  2021-10-12 Dirk Hering         Deduplication from source (Qualify Row Number = 1); iig.dwh_updated
#  1.5  2022-07-21 Prasanna Ranjan     Added SCD_KEY_MD
#-------------------------------------------------------------------------------
*/
/*
---------------------------------------------------------------------
0.   CREATE VIEW in V_SOURCE_ITEM_WGI_1
     Merge the coure sources: t_itemgroup_international_1, t_itemgroup_international_descr_1
     Note: history table not necessary
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_item_wgi_1 OPTIONS(DESCRIPTION = `V_SOURCE_ITEM_WGI_1`) AS SELECT CAST(iig.client_id AS BIGNUMERIC)
 AS client_id,
 CAST(iig.item_grp_int_sid AS BIGNUMERIC) AS item_grp_int_sid,
 CAST(iig.src_itemgrp_int_cd AS STRING) AS item_grp_int_src_cd,
 CAST(COALESCE(iig.item_grp_int_name, id_int.item_grp_int_descr, id_local.item_grp_int_descr, 'N/A') AS STRING) AS
 item_grp_int_name,
 CAST(COALESCE(id_local.item_grp_int_descr, iig.item_grp_int_name, id_int.item_grp_int_descr, 'N/A') AS STRING) AS
 item_grp_int_descr,
 CAST(COALESCE(id_int.item_grp_int_descr, id_local.item_grp_int_descr, iig.item_grp_int_name, 'N/A') AS STRING) AS
 item_grp_int_int_descr,
 TO_HEX(MD5(COALESCE(CAST(COALESCE(iig.item_grp_int_name, id_int.item_grp_int_descr, id_local.item_grp_int_descr, 'N/A') AS STRING)
      , '') || COALESCE(CAST(COALESCE(id_local.item_grp_int_descr, iig.item_grp_int_name, id_int.item_grp_int_descr, 'N/A') AS STRING)
      , '') || COALESCE(CAST(COALESCE(id_int.item_grp_int_descr, id_local.item_grp_int_descr, iig.item_grp_int_name, 'N/A') AS STRING)
     , ''))) AS scd_key_md,
 DATE('1900-01-01') AS valid_from_dt,
 DATE('9999-12-31') AS valid_to_dt,
 0 AS deleted_fg,
 iig.dwh_updated AS dwh_updated_ts
FROM (SELECT *
  FROM ldl_p_lew_core.t_itemgroup_international_1
  WHERE client_id IN (SELECT client_id
     FROM ldl_p_lew_mart_pit.t_dim_client_1
     WHERE pit_country_fg = 1
      AND deleted_fg = 0
      AND reject_fg = 0
      AND current_fg = 1
     GROUP BY client_id)
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(item_grp_int_sid AS STRING) ORDER BY dwh_updated IS NULL DESC,
        dwh_updated DESC)) = 1) AS iig
 INNER JOIN (SELECT *
  FROM ldl_p_lew_core.t_country_1
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(country_sid AS STRING) ORDER BY dwh_updated IS NULL DESC, dwh_updated
        DESC)) = 1) AS c_local ON iig.client_id = c_local.country_sid
 INNER JOIN (SELECT *
  FROM ldl_p_lew_core.t_country_1
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(country_sid AS STRING) ORDER BY dwh_updated IS NULL DESC, dwh_updated
        DESC)) = 1) AS c_int ON c_int.lang_cd = '@'
 LEFT JOIN (SELECT *
  FROM ldl_p_lew_core.t_itemgroup_international_descr_1
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(item_grp_int_sid AS STRING), CAST(lang_sid AS STRING) ORDER BY
        dwh_updated IS NULL DESC, dwh_updated DESC)) = 1) AS id_local ON iig.client_id = id_local.client_id AND c_local
    .lang_sid = id_local.lang_sid AND iig.item_grp_int_sid = id_local.item_grp_int_sid
 LEFT JOIN (SELECT *
  FROM ldl_p_lew_core.t_itemgroup_international_descr_1
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(item_grp_int_sid AS STRING), CAST(lang_sid AS STRING) ORDER BY
        dwh_updated IS NULL DESC, dwh_updated DESC)) = 1) AS id_int ON iig.client_id = id_int.client_id AND c_int.lang_sid
     = id_int.lang_sid AND iig.item_grp_int_sid = id_int.item_grp_int_sid;