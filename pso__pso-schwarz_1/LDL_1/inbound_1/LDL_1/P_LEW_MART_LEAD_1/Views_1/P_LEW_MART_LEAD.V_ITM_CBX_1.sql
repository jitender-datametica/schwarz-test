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
# 1.0  2024-11-26   Aleksander Bialek    Initial version, view delivering the cbx item_1 <-> item_1 predecessor relationship info. Needed for VKP/EKP implementation (ADWI:703109)
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_ITM_CBX_1
AS
WITH cte_item_mdm_link
AS 
(
SELECT 
client_id
,item_sid
,mdm_item_sid 
FROM p_lew_core.T_ITEM_MDM_LINK_1
GROUP BY 1,2,3
)
, cte_mdm_pred_hist 
AS (
SELECT 
    client_id
  , mdm_item_sid
  , mdm_item_sid_related
  , ITEM_REL_TYPE_CD
FROM p_lew_core.t_mdm_item_related_item_hist_1
WHERE 
(ITEM_REL_TYPE_CD LIKE 'PRED1' OR ITEM_REL_TYPE_CD LIKE 'PRED2'
)
/* t_mdm_item_related_item_hist_1 is historized, only the current records are representing the correct information as of Today, so you have to filter here */
AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
AND deleted_fg=0
GROUP BY 1,2,3,4
)
SELECT 
  b.client_id
, b.item_sid
, c.item_sid AS item_sid_pred
, item_rel_type_cd
FROM cte_mdm_pred_hist a
JOIN cte_item_mdm_link b
ON  a.mdm_item_sid = b.mdm_item_sid
JOIN cte_item_mdm_link c
ON a.mdm_item_sid_related = c.mdm_item_sid
AND b.client_id = c.client_id
WHERE b.item_sid <> c.item_sid
GROUP BY 1,2,3,4;