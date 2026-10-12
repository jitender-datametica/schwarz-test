/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL
#----------------------------------------------------------------------------
# History:
#  1.0  03.03.2022    Bachmann, Torsten        Initial version for SortimentsModularity
#  1.1  19.05.2022    Bialek, Aleksander       Adding additional join to "T_SM_CONTAINER_CONT_ART_REL_1" as Part of SOMO AP2, Ek-Wa_SoMo_AP2_SF_objects, BBT-3832, AD Work Item_1: 291570
#  1.2  26.04.2023    Bachmann, Torsten        Adjust Join to T_SM_CONTAINER_CONT_ART_REL_1 to LEFT OUTER JOIN
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_SM_CONTAINER_1 COMMENT = 'Main View for Sortimentsmodularity Container Attribute'
(
  client_id            COMMENT 'delivering WAWI client'
, container_id         COMMENT 'surrogate key based on T1041_ITEMCONTAINER_HEAD.C1041_COUNTRY and T1041_ITEMCONTAINER_HEAD.C1041_CONT_ID_LOCAL'
, local_container_id   COMMENT 'WAWI: T1041_ITEMCONTAINER_HEAD.C1041_CONT_ID_LOCAL'
, container_int_desc   COMMENT 'WAWI: T1041_ITEMCONTAINER_HEAD.C1041_DESC_INT'
, container_desc       COMMENT 'WAWI: T1041_ITEMCONTAINER_HEAD.C1041_DESC_NAT'
, container_status_fg  COMMENT 'WAWI: T1041_ITEMCONTAINER_HEAD.C1041_STATUS'
, country_cd           COMMENT 'WAWI: T1041_ITEMCONTAINER_HEAD.C1041_COUNTRY'
, cont_art_id          COMMENT 'CONTAINER_ART id (BBT-3832, AD Work Item_1: 291570)'
, cont_art_gr_id       COMMENT 'CONTAINER_ART_GROESSE id (BBT-3832, AD Work Item_1: 291570)'
, cont_art_sb_id       COMMENT 'CONTAINER_ART_SORTIMENTSBEREICH id (BBT-3832, AD Work Item_1: 291570)'
, cont_sb_id           COMMENT 'CONTAINER_SORTIMENTSBEREICH id (BBT-3832, AD Work Item_1: 291570)'
)
AS
WITH base_view AS (
SELECT
  acch.client_id
, acch.assortment_container_sid       AS container_id
, ac.assortment_container_nr          AS local_container_id
, ach.assortment_container_int_name   AS container_int_desc
, acch.assortment_container_name      AS container_desc
, ach.active_fg                       AS container_status_fg
, c.src_country_lidl_cd               AS country_cd
FROM P_LEW_CORE_AC.V_ASSORTMENT_CONTAINER_CLIENT_HIST_1 acch
  INNER JOIN P_LEW_CORE_AC.V_ASSORTMENT_CONTAINER_HIST_1 ach
    ON acch.assortment_container_sid = ach.assortment_container_sid
   AND CURRENT_DATE BETWEEN acch.dwh_valid_from AND acch.dwh_valid_to
   AND CURRENT_DATE BETWEEN ach.dwh_valid_from AND ach.dwh_valid_to
  INNER JOIN P_LEW_CORE_AC.V_ASSORTMENT_CONTAINER_1 ac
    ON acch.assortment_container_sid = ac.assortment_container_sid
  INNER JOIN P_LEW_CORE_AC.v_client_1 c
    ON ac.container_client_id = c.client_id
  UNION ALL
SELECT
  client_id
, -99                        AS container_id
, -99                        AS local_container_id
, 'Ohne Container-Zuordnung' AS container_int_desc
, 'Ohne Container-Zuordnung' AS container_desc
, 1                          AS container_status_fg
, src_country_lidl_cd        AS country_cd
FROM P_LEW_CORE_AC.v_client_1
WHERE client_online_fg = 0
)

SELECT
  bv.client_id
, bv.container_id
, bv.local_container_id
, bv.container_int_desc
, bv.container_desc
, bv.container_status_fg
, bv.country_cd
, COALESCE (c_art.cont_art_id, -99)    AS cont_art_id
, COALESCE (c_art.cont_art_gr_id, -99) AS cont_art_gr_id
, COALESCE (c_art.cont_art_sb_id, -99) AS cont_art_sb_id
, COALESCE (c_art.cont_sb_id, -99)     AS cont_sb_id
FROM base_view bv
  LEFT OUTER JOIN P_LEW_MART_LEAD.T_SM_CONTAINER_CONT_ART_REL_1 c_art
ON bv.container_id = c_art.container_id
;
