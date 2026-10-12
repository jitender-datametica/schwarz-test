/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for _LEW_MART_LEAD.V_DISPO_POS_ACT
#----------------------------------------------------------------------------
# History:
#  1.0  20.09.2022    Bachmann, Torsten        Initial version for Liefertreue (Prototype)
#  1.1  27.09.2022    Bachmann, Torsten        Added some columns
#  1.2  06.10.2022    Bachmann, Torsten        wh_id, sup_sid added
#  1.3  17.11.2022    Bachmann, Torsten        init-columns not needed any more, init values now stored in order_pos_version_nr = 0
#  1.4  06.03.2023    Bachmann, Torsten        added reason_cd from T_REPLENISH_ORDER_WH_RECORD_POS_CHANGELOG
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_dispo_pos_act (client_id, loc_sid, wh_id, sup_sid, order_record_id,
item_sid, order_pos_version_nr, dwh_valid_from, deleted_fg, delivery_dt, order_status_cd, part_fg, order_qty_type_cd,
order_qty, order_delivered_case_qty, case_factor, real_case_size, delta_order_case_qty, order_status_cd_override,
init_delivery_dt, min_rcv_dt, max_rcv_dt, qty_case_rcv_ontime, qty_case_rcv_ahead_schedule, qty_case_rcv_delay_1_day,
qty_case_rcv_delay_2_days, qty_case_rcv_delay_3_days, qty_case_rcv_delay_ge_4_days, cnt_days_delayed, cnt_rcv,
mapping_pos_nr, orig_receipt_id_rcv, order_pos_created_tmsp, order_pos_updated_tmsp, delivery_tmsp, all_reason_cd,
first_reason_cd, last_reason_cd, dwh_load_id, dwh_created, dwh_updated) AS SELECT DIS.client_id,
 DIS.loc_sid,
 WH.src_wh_id AS wh_id,
 DIS.sup_sid,
 DIS.order_record_id,
 ITMP.item_sid_map AS item_sid,
 DIS.order_pos_version_nr,
 DIS.dwh_valid_from,
 DIS.deleted_fg,
 DIS.delivery_dt,
 DIS.order_status_cd,
 DIS.part_fg,
 DIS.order_qty_type_cd,
 DIS.order_qty,
 DIS.order_delivered_case_qty,
 DIS.case_factor,
 DIS.real_case_size,
 DIS.delta_order_case_qty,
 DIS.order_status_cd_override,
 DIS.init_delivery_dt,
 DIS.min_rcv_dt,
 DIS.max_rcv_dt,
 DIS.qty_case_rcv_ontime,
 DIS.qty_case_rcv_ahead_schedule,
 DIS.qty_case_rcv_delay_1_day,
 DIS.qty_case_rcv_delay_2_days,
 DIS.qty_case_rcv_delay_3_days,
 DIS.qty_case_rcv_delay_ge_4_days,
 DIS.cnt_days_delayed,
 DIS.cnt_rcv,
 DIS.mapping_pos_nr,
 DIS.orig_receipt_id_rcv,
 DIS.order_pos_created_tmsp,
 DIS.order_pos_updated_tmsp,
 DIS.delivery_tmsp,
 DIS.all_reason_cd,
 DIS.first_reason_cd,
 DIS.last_reason_cd,
 DIS.dwh_load_id,
 DIS.dwh_created,
 DIS.dwh_updated
FROM ldl_p_lew_mart_lead.t_dispo_pos_act AS DIS
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key AS ITMP ON DIS.client_id = ITMP.client_id AND DIS.item_sid = ITMP.item_sid
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON DIS.client_id = WH.client_id AND DIS.loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1
WHERE DIS.deleted_fg = 0;