/*
#-------------------------------------------------------------------------------
#  LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: Individual load SQL for loading of aggregate t_agg_prc_dvlp_wh_day_itm
#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
# Subversion Infostamp End
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.0  2024-11-26   Aleksander Bialek    Initial version, view delivering the cbx item_2 <-> item_2 predecessor relationship info. Needed for VKP/EKP implementation (ADWI:703109)
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_itm_cbx_2 AS WITH CTE_MDM_PRED_HIST AS (SELECT client_id,
   mdm_item_sid,
   mdm_item_sid_related,
   item_rel_type_cd
  FROM ldl_p_lew_core.t_mdm_item_related_item_hist_2
  WHERE (item_rel_type_cd LIKE 'PRED1' OR item_rel_type_cd LIKE 'PRED2')
   AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND deleted_fg = 0
  GROUP BY client_id,
   mdm_item_sid,
   mdm_item_sid_related,
   item_rel_type_cd), CTE_ITEM_MDM_LINK AS (SELECT client_id,
   item_sid,
   mdm_item_sid
  FROM ldl_p_lew_core.t_item_mdm_link_2
  GROUP BY client_id,
   item_sid,
   mdm_item_sid) (SELECT b.client_id,
   b.item_sid,
   c.item_sid AS item_sid_pred,
   a.item_rel_type_cd
  FROM CTE_MDM_PRED_HIST AS a
   INNER JOIN CTE_ITEM_MDM_LINK AS b ON a.mdm_item_sid = b.mdm_item_sid
   INNER JOIN CTE_ITEM_MDM_LINK AS c ON a.mdm_item_sid_related = c.mdm_item_sid AND b.client_id = c.client_id
  WHERE b.item_sid <> c.item_sid
  GROUP BY b.client_id,
   b.item_sid,
   item_sid_pred,
   a.item_rel_type_cd);