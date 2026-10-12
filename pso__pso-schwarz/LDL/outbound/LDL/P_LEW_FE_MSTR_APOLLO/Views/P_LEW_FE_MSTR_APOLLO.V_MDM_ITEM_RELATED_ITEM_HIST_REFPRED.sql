/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_MDM_ITEM_RELATED_ITEM_HIST_REFPRED
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski Michal           Initial Version
#----------------------------------------------------------------------------
*/


-- Vorgänger-Nr. INTEGER
 CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_apollo.v_mdm_item_related_item_hist_refpred (client_id
, mdm_item_sid, item_rel_type_cd, mdm_item_sid_related, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id,
dwh_created, dwh_updated, mdm_item_sid_ref_pred) AS SELECT RIH1.client_id,
 RIH1.mdm_item_sid,
 RIH1.item_rel_type_cd,
 RIH1.mdm_item_sid_related,
 RIH1.deleted_fg,
 RIH1.dwh_valid_from,
 RIH1.dwh_valid_to,
 RIH1.dwh_load_id,
 RIH1.dwh_created,
 RIH1.dwh_updated,
 RI1.item_ian AS mdm_item_sid_ref_pred
FROM ldl_p_lew_core_ac.v_mdm_item_related_item_hist AS RIH1
 LEFT JOIN ldl_p_lew_core.t_mdm_item AS RI1 ON RIH1.mdm_item_sid_related = RI1.mdm_item_sid
WHERE CURRENT_DATE BETWEEN RIH1.dwh_valid_from AND RIH1.dwh_valid_to
 AND RIH1.deleted_fg = 0
 AND RIH1.item_rel_type_cd = 'REF_PRED';