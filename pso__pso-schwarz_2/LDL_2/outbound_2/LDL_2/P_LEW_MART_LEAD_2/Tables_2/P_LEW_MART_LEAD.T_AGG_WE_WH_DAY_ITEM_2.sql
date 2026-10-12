/*
#-------------------------------------------------------------------------------
#  LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: Aggregate for WE data on day level
#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
# Subversion Infostamp End
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.0  2024-04-17   Torsten Bachmann    Initial version, AP0162679, NRV base KPI
#
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_we_wh_day_item_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
sup_sid BIGNUMERIC(38,0),
loc_sid_wh BIGNUMERIC(38,0),
item_sid BIGNUMERIC(38,0),
dwh_cal_dt DATE NOT NULL,
entry_dt DATE,
receipt_type_id BIGNUMERIC(38,0),
receipt_pos_margin_rel_fg BIGNUMERIC(38,0),
curr_cd_from STRING(20) COLLATE 'und:ci',
receive_piece_with_logic_qty NUMERIC(18,5),
buying_val NUMERIC(18,5),
retail_net_val NUMERIC(18,5),
retail_val NUMERIC(18,5),
retail_net_fa_val NUMERIC(18,5),
buying_fa_val NUMERIC(18,5),
retail_net_with_logic_val NUMERIC(18,5),
receive_case_with_logic_qty NUMERIC(18,5),
val_buying_suppl_rcv NUMERIC(18,5),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL
);