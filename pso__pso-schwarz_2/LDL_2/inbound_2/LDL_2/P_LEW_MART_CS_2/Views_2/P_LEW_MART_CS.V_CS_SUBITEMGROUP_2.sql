/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_cs_subitemgroup_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_cs_subitemgroup_2
(
client_id
, subitemgroup_sid
, subitemgroup_cd
, mainitemgroup_cd
, int_itemgroup_cd
, language_id
, language_iso_cd
, country_iso_cd
, descr_short
, descr_long
, dwh_valid_from
, dwh_valid_to
, dwh_updated
, dwh_created
, dwh_load_id
)
AS
   SELECT
   a.client_id                     AS client_id,
   a.sub_item_grp_sid              AS subitemgroup_sid,
   a.src_subitemgrp_cd             AS subitemgroup_cd,
   b.main_item_grp_cd              AS mainitemgroup_cd,
   b.item_grp_int_cd               AS int_itemgroup_cd,
   d.language_id                   AS language_id,
   d.language_iso_cd               AS language_iso_cd,
   t.src_country_lidl_cd           AS country_iso_cd,
   c.sub_item_grp_descr            AS descr_short,
   c.sub_item_grp_descr            AS descr_long,
   b.dwh_valid_from                AS dwh_valid_from,
   b.dwh_valid_to                  AS dwh_valid_to,
   b.dwh_updated                   AS dwh_updated,
   b.dwh_created                   AS dwh_created,
   b.dwh_load_id                   AS dwh_load_id
   FROM p_lew_core_ac.v_subitemgroup_2 a
   INNER JOIN p_lew_core_ac.v_subitemgroup_hist_2 b
   ON b.client_id = a.client_id
   AND b.sub_item_grp_sid = a.sub_item_grp_sid
   AND CURRENT_DATE BETWEEN b.dwh_valid_from AND b.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_subitemgroup_descr_2 c
   ON c.client_id = a.client_id
   AND c.sub_item_grp_sid = a.sub_item_grp_sid
   INNER JOIN p_lew_core_ac.v_map_lang_spras_2 d
   ON d.sap_lang_cd = c.lang_cd
   AND (d.sap_lang_cd = '@' OR d.language_id = c.client_id)
   INNER JOIN p_lew_core_ac.v_client_2 cl
   ON a.client_id = cl.client_id
   INNER JOIN p_lew_core_ac.v_country_2 t
   ON cl.country_sid = t.country_sid
   ;


