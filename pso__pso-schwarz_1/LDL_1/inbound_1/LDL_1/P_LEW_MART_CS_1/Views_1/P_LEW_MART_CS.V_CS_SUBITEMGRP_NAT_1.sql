/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_CS_SUBITEMGRP_NAT_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_CS_SUBITEMGRP_NAT_1
(
client_id
, src_subitemgrp_cd
, language_id
, valid_from
, valid_until
, sortkey
, descr_short
, descr_long
, last_refresh
)
AS
   SELECT
        a.client_id                       AS client_id,
   a.src_subitemgrp_cd             AS src_subitemgrp_cd,
   d.language_id                   AS language_id,
   b.dwh_valid_from                AS valid_from,
   DATE'9999-12-31'                AS valid_until,
   CAST(NULL AS INTEGER)           AS sortkey,
   c.sub_item_grp_descr            AS descr_short,
   c.sub_item_grp_descr            AS descr_long,
   CURRENT_DATE                    AS last_refresh
  FROM p_lew_core_ac.v_subitemgroup_1 a
   INNER JOIN p_lew_core_ac.v_subitemgroup_hist_1 b
   ON b.client_id = a.client_id
   AND b.sub_item_grp_sid = a.sub_item_grp_sid
   AND CURRENT_DATE BETWEEN b.dwh_valid_from AND b.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_subitemgroup_descr_1 c
   ON c.client_id = a.client_id
   AND c.sub_item_grp_sid = a.sub_item_grp_sid
   INNER JOIN p_lew_core_ac.v_map_lang_spras_1 d
   ON d.sap_lang_cd = c.lang_cd
   AND (d.sap_lang_cd = '@' OR d.language_id = c.client_id)
   ;