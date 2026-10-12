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


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_we_wh_day_item (client_id, supplier_id, loc_sid_wh, wh_id, item_id,
dat_formdate, dat_entry_rcv, receivetype_id, receipt_pos_marginrel_fg, currency_iso_cd, val_buying_rcv,
val_net_retail_rcv, val_retail_rcv, val_net_retail_fa_rcv, val_buying_fa_rcv, qty_total_rcv_with_logic,
val_net_retail_rcv_with_logic, qty_case_rcv_with_logic, val_buying_suppl_rcv)
OPTIONS(DESCRIPTION = `AGGREGATE ON TOP OF BIL.T_MOV_ITEM_RECEIVE_WH`) AS SELECT WE.client_id,
 WE.sup_sid AS supplier_id,
 WE.loc_sid_wh,
 LOC_WH.src_wh_id AS wh_id,
 ITMP.item_sid_map AS item_id,
 WE.dwh_cal_dt AS dat_formdate,
 WE.entry_dt AS dat_entry_rcv,
 WE.receipt_type_id AS receivetype_id,
 WE.receipt_pos_margin_rel_fg AS receipt_pos_marginrel_fg,
 WE.curr_cd_from AS currency_iso_cd,
 WE.buying_val AS val_buying_rcv,
 WE.retail_net_val AS val_net_retail_rcv,
 WE.retail_val AS val_retail_rcv,
 WE.retail_net_fa_val AS val_net_retail_fa_rcv,
 WE.buying_fa_val AS val_buying_fa_rcv,
 WE.receive_piece_with_logic_qty AS qty_total_rcv_with_logic,
 WE.retail_net_with_logic_val AS val_net_retail_rcv_with_logic,
 WE.receive_case_with_logic_qty AS qty_case_rcv_with_logic,
 WE.val_buying_suppl_rcv
FROM ldl_p_lew_mart_lead.t_agg_we_wh_day_item AS WE
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key AS ITMP ON WE.client_id = ITMP.client_id AND WE.item_sid = ITMP.item_sid
 INNER JOIN ldl_p_lew_core_ac.v_location AS LOC_WH ON WE.client_id = LOC_WH.client_id AND WE.loc_sid_wh = LOC_WH.loc_sid
     AND UPPER(LOC_WH.wh_store_mark) = 'B' /* WHs */;