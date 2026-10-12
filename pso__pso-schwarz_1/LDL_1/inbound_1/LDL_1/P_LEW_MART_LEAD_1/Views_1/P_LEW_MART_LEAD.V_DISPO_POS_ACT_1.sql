/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for _LEW_MART_LEAD.V_DISPO_POS_ACT_1
#----------------------------------------------------------------------------
# History:
#  1.0  20.09.2022    Bachmann, Torsten        Initial version for Liefertreue (Prototype)
#  1.1  27.09.2022    Bachmann, Torsten        Added some columns
#  1.2  06.10.2022    Bachmann, Torsten        wh_id, sup_sid added
#  1.3  17.11.2022    Bachmann, Torsten        init-columns not needed any more, init values now stored in order_pos_version_nr = 0
#  1.4  06.03.2023    Bachmann, Torsten        added reason_cd from T_REPLENISH_ORDER_WH_RECORD_POS_CHANGELOG_1
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_DISPO_POS_ACT_1 (
  client_id
, loc_sid
, wh_id
, sup_sid
, order_record_id
, item_sid
, order_pos_version_nr
, dwh_valid_from
, deleted_fg
, delivery_dt
, order_status_cd
, part_fg
, order_qty_type_cd
, order_qty
, order_delivered_case_qty
, case_factor
, real_case_size
, delta_order_case_qty
, order_status_cd_override
, init_delivery_dt
, min_rcv_dt
, max_rcv_dt
, qty_case_rcv_ontime
, qty_case_rcv_ahead_schedule
, qty_case_rcv_delay_1_day
, qty_case_rcv_delay_2_days
, qty_case_rcv_delay_3_days
, qty_case_rcv_delay_ge_4_days
, cnt_days_delayed
, cnt_rcv
, mapping_pos_nr
, orig_receipt_id_rcv
, order_pos_created_tmsp
, order_pos_updated_tmsp
, delivery_tmsp
, all_reason_cd
, first_reason_cd
, last_reason_cd
, dwh_load_id
, dwh_created
, dwh_updated
) AS
SELECT 
  dis.client_id
, dis.loc_sid
, wh.src_wh_id              AS wh_id
, dis.sup_sid
, dis.order_record_id
, itmp.item_sid_map         AS item_sid
, dis.order_pos_version_nr
, dis.dwh_valid_from
, dis.deleted_fg
, dis.delivery_dt
, dis.order_status_cd
, dis.part_fg
, dis.order_qty_type_cd
, dis.order_qty
, dis.order_delivered_case_qty
, dis.case_factor
, dis.real_case_size
, dis.delta_order_case_qty
, dis.order_status_cd_override
, dis.init_delivery_dt
, dis.min_rcv_dt
, dis.max_rcv_dt
, dis.qty_case_rcv_ontime
, dis.qty_case_rcv_ahead_schedule
, dis.qty_case_rcv_delay_1_day
, dis.qty_case_rcv_delay_2_days
, dis.qty_case_rcv_delay_3_days
, dis.qty_case_rcv_delay_ge_4_days
, dis.cnt_days_delayed
, dis.cnt_rcv
, dis.mapping_pos_nr
, dis.orig_receipt_id_rcv
, dis.order_pos_created_tmsp
, dis.order_pos_updated_tmsp
, dis.delivery_tmsp
, dis.all_reason_cd
, dis.first_reason_cd
, dis.last_reason_cd
, dis.dwh_load_id
, dis.dwh_created
, dis.dwh_updated
FROM P_LEW_MART_LEAD.T_DISPO_POS_ACT_1 dis
  INNER JOIN p_lew_core_ac.v_item_map_key_1 itmp
    ON itmp.client_id = dis.client_id
   AND itmp.item_sid  = dis.item_sid
  INNER JOIN p_lew_bil_ac.v_warehouse_1 wh
    ON dis.client_id = wh.client_id
   AND dis.loc_sid   = wh.loc_sid_wh
   AND wh.dwh_actual_fg = 1
WHERE dis.deleted_fg = 0
;