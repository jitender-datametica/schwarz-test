/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL
#----------------------------------------------------------------------------
# History:
#  1.0  03.03.2022    Bachmann, Torsten        Initial version for SortimentsModularity
#  1.1  19.05.2022    Bialek, Aleksander       Adding additional join to "T_SM_CONTAINER_CONT_ART_REL" as Part of SOMO AP2, Ek-Wa_SoMo_AP2_SF_objects, BBT-3832, AD Work Item: 291570
#  1.2  26.04.2023    Bachmann, Torsten        Adjust Join to T_SM_CONTAINER_CONT_ART_REL to LEFT OUTER JOIN
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_sm_container (client_id OPTIONS(description='delivering WAWI client'),
container_id
OPTIONS(description='surrogate key based on T1041_ITEMCONTAINER_HEAD.C1041_COUNTRY and T1041_ITEMCONTAINER_HEAD.C1041_CONT_ID_LOCAL'),
local_container_id OPTIONS(description='WAWI: T1041_ITEMCONTAINER_HEAD.C1041_CONT_ID_LOCAL'), container_int_desc
OPTIONS(description='WAWI: T1041_ITEMCONTAINER_HEAD.C1041_DESC_INT'), container_desc
OPTIONS(description='WAWI: T1041_ITEMCONTAINER_HEAD.C1041_DESC_NAT'), container_status_fg
OPTIONS(description='WAWI: T1041_ITEMCONTAINER_HEAD.C1041_STATUS'), country_cd
OPTIONS(description='WAWI: T1041_ITEMCONTAINER_HEAD.C1041_COUNTRY'), cont_art_id
OPTIONS(description='CONTAINER_ART id (BBT-3832, AD Work Item: 291570)'), cont_art_gr_id
OPTIONS(description='CONTAINER_ART_GROESSE id (BBT-3832, AD Work Item: 291570)'), cont_art_sb_id
OPTIONS(description='CONTAINER_ART_SORTIMENTSBEREICH id (BBT-3832, AD Work Item: 291570)'), cont_sb_id
OPTIONS(description='CONTAINER_SORTIMENTSBEREICH id (BBT-3832, AD Work Item: 291570)'))
OPTIONS(DESCRIPTION = `Main View for Sortimentsmodularity Container Attribute`) AS WITH BASE_VIEW AS (SELECT ACCH.client_id
    ,
    ACCH.assortment_container_sid AS container_id,
    AC.assortment_container_nr AS local_container_id,
    ACH.assortment_container_int_name AS container_int_desc,
    ACCH.assortment_container_name AS container_desc,
    ACH.active_fg AS container_status_fg,
    C.src_country_lidl_cd AS country_cd
   FROM ldl_p_lew_core_ac.v_assortment_container_client_hist AS ACCH
    INNER JOIN ldl_p_lew_core_ac.v_assortment_container_hist AS ACH ON ACCH.assortment_container_sid = ACH.assortment_container_sid
        AND CURRENT_DATE BETWEEN ACCH.dwh_valid_from AND ACCH.dwh_valid_to AND CURRENT_DATE BETWEEN ACH.dwh_valid_from
      AND ACH.dwh_valid_to
    INNER JOIN ldl_p_lew_core_ac.v_assortment_container AS AC ON ACCH.assortment_container_sid = AC.assortment_container_sid
     
    INNER JOIN ldl_p_lew_core_ac.v_client AS C ON AC.container_client_id = C.client_id
   UNION ALL
   SELECT client_id,
    - 99 AS container_id,
    - 99 AS local_container_id,
    'Ohne Container-Zuordnung' AS container_int_desc,
    'Ohne Container-Zuordnung' AS container_desc,
    1 AS container_status_fg,
    src_country_lidl_cd AS country_cd
   FROM ldl_p_lew_core_ac.v_client
   WHERE client_online_fg = 0) (SELECT bv.client_id,
   bv.container_id,
   bv.local_container_id,
   bv.container_int_desc,
   bv.container_desc,
   bv.container_status_fg,
   bv.country_cd,
   COALESCE(C_ART.cont_art_id, - 99) AS cont_art_id,
   COALESCE(C_ART.cont_art_gr_id, - 99) AS cont_art_gr_id,
   COALESCE(C_ART.cont_art_sb_id, - 99) AS cont_art_sb_id,
   COALESCE(C_ART.cont_sb_id, - 99) AS cont_sb_id
  FROM BASE_VIEW AS bv
   LEFT JOIN ldl_p_lew_mart_lead.t_sm_container_cont_art_rel AS C_ART ON bv.container_id = C_ART.container_id);