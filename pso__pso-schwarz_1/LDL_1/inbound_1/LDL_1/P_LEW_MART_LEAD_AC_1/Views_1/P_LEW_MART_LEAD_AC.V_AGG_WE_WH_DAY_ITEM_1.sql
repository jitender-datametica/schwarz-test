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

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_WE_WH_DAY_ITEM_1(
  CLIENT_ID,
  SUPPLIER_ID,
  LOC_SID_WH,
  WH_ID,
  ITEM_ID,
  DAT_FORMDATE,
  DAT_ENTRY_RCV,
  RECEIVETYPE_ID,
  RECEIPT_POS_MARGINREL_FG,
  CURRENCY_ISO_CD,
  VAL_BUYING_RCV,
  VAL_NET_RETAIL_RCV,
  VAL_RETAIL_RCV,
  VAL_NET_RETAIL_FA_RCV,
  VAL_BUYING_FA_RCV,
  QTY_TOTAL_RCV_WITH_LOGIC,
  VAL_NET_RETAIL_RCV_WITH_LOGIC,
  QTY_CASE_RCV_WITH_LOGIC,
  VAL_BUYING_SUPPL_RCV
)
COMMENT = 'Aggregate on top of BIL.T_MOV_ITEM_RECEIVE_WH_1'
AS
SELECT
  we.client_id
, we.sup_sid                    AS supplier_id
, we.loc_sid_wh
, loc_wh.src_wh_id              AS wh_id
, itmp.item_sid_map             AS item_id
, we.dwh_cal_dt                 AS dat_formdate
, we.entry_dt                   AS dat_entry_rcv
, we.receipt_type_id            AS receivetype_id
, we.receipt_pos_margin_rel_fg  AS receipt_pos_marginrel_fg
, we.curr_cd_from               AS currency_iso_cd
, we.buying_val                 AS val_buying_rcv
, we.retail_net_val             AS val_net_retail_rcv
, retail_val                    AS val_retail_rcv
, retail_net_fa_val             AS val_net_retail_fa_rcv
, buying_fa_val                 AS val_buying_fa_rcv
, receive_piece_with_logic_qty  AS qty_total_rcv_with_logic
, retail_net_with_logic_val     AS val_net_retail_rcv_with_logic
, receive_case_with_logic_qty   AS qty_case_rcv_with_logic
, val_buying_suppl_rcv          AS val_buying_suppl_rcv
FROM p_lew_mart_lead.t_agg_we_wh_day_item_1 we
  INNER JOIN P_LEW_CORE_AC.v_item_map_key_1 itmp
    ON itmp.client_id = we.client_id
   AND itmp.item_sid  = we.item_sid
  INNER JOIN P_LEW_CORE_AC.v_location_1 AS loc_wh
    ON we.client_id  = loc_wh.client_id
   AND we.loc_sid_wh = loc_wh.loc_sid
   AND Upper(loc_wh.wh_store_mark) = 'B' /* WHs */
;