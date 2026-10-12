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


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_itm_cbx_1 (client_id, item_sid, item_sid_pred, item_rel_type_cd) AS SELECT
 *
FROM ldl_p_lew_mart_lead.v_itm_cbx_1;