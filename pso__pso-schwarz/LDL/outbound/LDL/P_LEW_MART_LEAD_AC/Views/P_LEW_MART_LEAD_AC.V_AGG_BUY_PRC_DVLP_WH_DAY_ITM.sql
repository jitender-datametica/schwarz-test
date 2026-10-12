/*
#-------------------------------------------------------------------------------
#  LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: Individual load SQL for loading of aggregate t_agg_buy_prc_dvlp_wh_day_itm
#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
# Subversion Infostamp End
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.0  2022-09-14   Aleksander Bialek    Initial version, wh-day-itm level aggregation view for price development metrics.
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_buy_prc_dvlp_wh_day_itm (client_id, wh_id, item_sid, sup_sid,
dat_formdate, buying_volume_val, receive_piece_qty, retail_net_val, buying_volume_val_py, receive_piece_qty_py,
retail_net_val_py, buying_volume_val_swpy, receive_piece_qty_swpy, retail_net_val_swpy, currency_iso_cd) AS SELECT AGG.client_id
 ,
 AGG.wh_id,
 AGG.item_sid,
 AGG.sup_sid,
 AGG.dat_formdate,
 AGG.buying_volume_val,
 AGG.receive_piece_qty,
 AGG.retail_net_val,
 AGG.buying_volume_val_py,
 AGG.receive_piece_qty_py,
 AGG.retail_net_val_py,
 AGG.buying_volume_val_swpy,
 AGG.receive_piece_qty_swpy,
 AGG.retail_net_val_swpy,
 CRY.currency_iso_cd
FROM ldl_p_lew_mart_lead.t_agg_buy_prc_dvlp_wh_day_itm AS AGG
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS CRY ON AGG.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end;