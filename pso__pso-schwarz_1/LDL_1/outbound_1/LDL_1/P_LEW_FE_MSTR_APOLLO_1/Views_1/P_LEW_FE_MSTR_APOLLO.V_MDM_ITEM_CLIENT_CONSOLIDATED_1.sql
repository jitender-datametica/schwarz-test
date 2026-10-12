/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.v_brand_1
#----------------------------------------------------------------------------
# History:
#  1.0  23.03.2022    Ulrich Meister           Initial Version
#  1.1  17.02.2023    Ulrich Meister           t_mdm_ship_terms and t_mdm_item_ship_terms_hist replaced
#  1.2  08.03.2023    Aparna Rayanki           column name corrected from mdm_completiton_type_name to mdm_completion_type_name
#                                              and Nulls to UNDEFINED
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_apollo.v_mdm_item_client_consolidated_1 (mdm_item_sid, client_id,
client_id_release_fg, mdm_incoterm_name, mdm_completion_type_name) AS SELECT IH.mdm_item_sid,
 C.client_id,
  CASE
  WHEN ICR.client_id_release IS NULL
  THEN 0
  ELSE 1
  END AS client_id_released_fg,
 COALESCE(IC.mdm_incoterm_name, 'UNDEFINED') AS mdm_incoterm_name,
 COALESCE(CT.mdm_completion_type_name, 'UNDEFINED') AS mdm_completion_type_name
FROM ldl_p_lew_fe_mstr_apollo.v_mdm_client_1 AS C
 INNER JOIN ldl_p_lew_core_ac.v_mdm_item_hist_1 AS IH ON (C.src_country_cbx_cd = 'US' AND IH.market_sid = 1 OR C.src_country_cbx_cd
         <> 'US' AND IH.market_sid = 3 OR IH.market_sid = 2) AND CURRENT_DATE BETWEEN IH.dwh_valid_from AND IH.dwh_valid_to
     AND IH.deleted_fg = 0
 LEFT JOIN ldl_p_lew_fe_mstr_apollo.v_mdm_item_client_release_1 AS ICR ON C.client_id = ICR.client_id_release AND IH.mdm_item_sid
      = ICR.mdm_item_sid AND CURRENT_DATE BETWEEN ICR.dwh_valid_from AND ICR.dwh_valid_to AND ICR.deleted_fg = 0
 LEFT JOIN ldl_p_lew_core_ac.v_mdm_item_market_hist_1 AS IMH ON IH.mdm_item_sid = IMH.mdm_item_sid AND (C.src_country_cbx_cd
          = 'US' AND IMH.market_sid = 1 OR C.src_country_cbx_cd <> 'US' AND IMH.market_sid = 3 OR IMH.market_sid = 2)
   AND CURRENT_DATE BETWEEN IMH.dwh_valid_from AND IMH.dwh_valid_to AND IMH.deleted_fg = 0
 LEFT JOIN ldl_p_lew_core_ac.v_ref_mdm_incoterm_1 AS IC ON IMH.market_sid = IC.market_sid AND IMH.mdm_incoterm_cd = IC.mdm_incoterm_cd
   
 LEFT JOIN ldl_p_lew_core_ac.v_ref_mdm_completion_type_1 AS CT ON IMH.market_sid = CT.market_sid AND IMH.mdm_completion_type_cd
    = CT.mdm_completion_type_cd;