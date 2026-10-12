/*
#-------------------------------------------------------------------------------
#  LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: Individual load SQL for loading of aggregate t_agg_sell_prc_dvlp_wh_day_itm_1
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


CREATE TABLE P_LEW_MART_LEAD.T_AGG_SELL_PRC_DVLP_CTRY_DAY_ITM_1
(
  client_id              INTEGER,
  item_sid               INTEGER,
  dat_formdate           DATE,
  sales_volume_val       NUMBER(38,8),
  sales_piece_qty   	 NUMBER(38,8),
  sales_volume_val_py    NUMBER(38,8),
  sales_piece_qty_py     NUMBER(38,8),
  sales_volume_val_swpy  NUMBER(38,8),
  sales_piece_qty_swpy   NUMBER(38,8)
)
; 