/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_mat_apt_mainitemgroupdesc_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_mat_apt_mainitemgroupdesc_1
(
    client_id
  , country_iso_cd
  , dat_valid_from
  , dat_valid_to
  , mainitemgroup_id
  , language_iso_cd
  , main_item_grp_name
  , dwh_updated
  , dwh_created
  , dwh_load_id
  , load_id
  , src_id
)
AS
   SELECT
   a.client_id,
   t.src_country_lidl_cd       AS country_iso_cd,
   a.dwh_created               AS dat_valid_from,
   DATE'9999-12-31'            AS dat_valid_to,
   a.src_mainitemgrp_id        AS mainitemgroup_id,
   l.language_iso_cd,
   a.main_item_grp_name,
   a.dwh_updated,
   a.dwh_created,
   a.dwh_load_id,
   CAST(-1 AS INTEGER)         AS load_id,
   2                           AS src_id
   FROM p_lew_core_ac.v_mainitemgroup_1 a
   INNER JOIN p_lew_core_ac.v_client_1 c
   ON a.client_id = c.client_id
   INNER JOIN p_lew_core_ac.v_country_1 t
   ON c.country_sid = t.country_sid
   INNER JOIN p_lew_core_ac.v_map_lang_spras_1 l
   ON l.sap_lang_cd = t.lang_cd
   AND (l.sap_lang_cd = '@' OR l.language_id = a.client_id)
   ;


