/*
#-------------------------------------------------------------------------------
#  LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: Individual load SQL for loading of aggregate t_agg_buy_prc_dvlp_wh_day_itm_1
#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
# Subversion Infostamp End
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.0  2023-08-31   Aleksander Bialek    Initial version, ctry-day-itm level aggregation for price development metrics.
#
#----------------------------------------------------------------------------
*/


CREATE TABLE P_LEW_MART_LEAD.T_AGG_BUY_PRC_DVLP_CTRY_DAY_ITM_1
(
  client_id              INTEGER,
  item_sid               INTEGER,
  sup_sid                INTEGER,
  dat_formdate           DATE,
  buying_volume_val      NUMBER(38,8),
  receive_piece_qty      NUMBER(38,8),
  retail_net_val         NUMBER(38,8),
  buying_volume_val_py   NUMBER(38,8),
  receive_piece_qty_py   NUMBER(38,8),
  retail_net_val_py      NUMBER(38,8),
  buying_volume_val_swpy NUMBER(38,8),
  receive_piece_qty_swpy NUMBER(38,8),
  retail_net_val_swpy    NUMBER(38,8)
)
; 