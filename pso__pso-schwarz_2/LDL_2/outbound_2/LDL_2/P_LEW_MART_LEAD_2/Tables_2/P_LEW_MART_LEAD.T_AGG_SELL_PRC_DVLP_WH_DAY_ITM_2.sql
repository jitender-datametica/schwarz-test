/*
#-------------------------------------------------------------------------------
#  LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: Individual load SQL for loading of aggregate t_agg_sell_prc_dvlp_wh_day_itm_2
#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
# Subversion Infostamp End
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.0  2022-09-14   Aleksander Bialek    Initial version, wh-day-itm level aggregation for price development metrics.
#
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_sell_prc_dvlp_wh_day_itm_2 (
client_id INTEGER,
wh_id INTEGER,
item_sid INTEGER,
dat_formdate DATE,
sales_volume_val BIGNUMERIC(38,8),
sales_piece_qty BIGNUMERIC(38,8),
sales_volume_val_py BIGNUMERIC(38,8),
sales_piece_qty_py BIGNUMERIC(38,8),
sales_volume_val_swpy BIGNUMERIC(38,8),
sales_piece_qty_swpy BIGNUMERIC(38,8)
);