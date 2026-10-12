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
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_APOLLO.V_MDM_ITEM_CLIENT_CONSOLIDATED_1
(
     mdm_item_sid
    ,client_id
    ,client_id_release_fg
    ,mdm_incoterm_name
    ,mdm_completion_type_name
) 
AS
SELECT
  ih.mdm_item_sid
  ,c.client_id
  ,CASE WHEN icr.client_id_release IS NULL THEN 0 ELSE 1 END client_id_released_fg
  ,COALESCE(ic.mdm_incoterm_name, 'UNDEFINED')         AS mdm_incoterm_name  
  ,COALESCE(ct.mdm_completion_type_name, 'UNDEFINED')  AS mdm_completion_type_name  
FROM p_lew_fe_mstr_apollo.v_mdm_client_1 c
INNER JOIN p_lew_core_ac.v_mdm_item_hist_1 ih
        ON (
            (c.src_country_cbx_cd='US' AND ih.market_sid=1)
             OR
            (c.src_country_cbx_cd<>'US' AND ih.market_sid=3)
             OR
            (ih.market_sid=2)
           )
  AND CURRENT_DATE BETWEEN ih.dwh_valid_from AND ih.dwh_valid_to
  AND ih.deleted_fg=0
LEFT OUTER JOIN p_lew_fe_mstr_apollo.v_mdm_item_client_release_1 icr
        ON c.client_id=icr.client_id_release
       AND ih.mdm_item_sid=icr.mdm_item_sid
       AND CURRENT_DATE BETWEEN icr.dwh_valid_from AND icr.dwh_valid_to
       AND icr.deleted_fg=0
LEFT OUTER JOIN p_lew_core_ac.v_mdm_item_market_hist_1 imh
        ON ih.mdm_item_sid=imh.mdm_item_sid
       AND (
             (c.src_country_cbx_cd='US' AND imh.market_sid=1)
            OR
             (c.src_country_cbx_cd<>'US' AND imh.market_sid=3)
            OR
             (imh.market_sid=2)
            )
       AND CURRENT_DATE BETWEEN imh.dwh_valid_from AND imh.dwh_valid_to
       AND imh.deleted_fg=0
LEFT OUTER JOIN p_lew_core_ac.v_ref_mdm_incoterm_1 ic
        ON imh.market_sid=ic.market_sid
       AND imh.mdm_incoterm_cd=ic.mdm_incoterm_cd
LEFT OUTER JOIN p_lew_core_ac.v_ref_mdm_completion_type_1 ct
        ON imh.market_sid=ct.market_sid
       AND imh.mdm_completion_type_cd=ct.mdm_completion_type_cd
;