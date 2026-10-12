/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for _LEW_MART_LEAD.V_DISPO_POS_HIST_1
#----------------------------------------------------------------------------
# History:
#  1.0  20.09.2022    Bachmann, Torsten        Initial version for Liefertreue (Prototype)
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_dispo_pos_hist_1 (client_id, loc_sid, order_record_id, item_sid,
order_pos_version_nr, dwh_valid_from, dwh_valid_to, deleted_fg, delivery_dt, order_status_cd, part_fg, order_qty_type_cd
, order_qty, order_delivered_case_qty, case_factor, real_case_size, init_order_qty_type_cd, init_order_qty,
init_case_factor, delta_order_case_qty, order_pos_created_tmsp, order_pos_updated_tmsp, delivery_tmsp, dwh_cal_dt,
dwh_load_id, dwh_created, dwh_updated) AS SELECT DIS.client_id,
 DIS.loc_sid,
 DIS.order_record_id,
 ITMP.item_sid_map AS item_sid,
 DIS.order_pos_version_nr,
 DIS.dwh_valid_from,
 DIS.dwh_valid_to,
 DIS.deleted_fg,
 DIS.delivery_dt,
 DIS.order_status_cd,
 DIS.part_fg,
 DIS.order_qty_type_cd,
 DIS.order_qty,
 DIS.order_delivered_case_qty,
 DIS.case_factor,
 DIS.real_case_size,
 DIS.init_order_qty_type_cd,
 DIS.init_order_qty,
 DIS.init_case_factor,
 DIS.delta_order_case_qty,
 DIS.order_pos_created_tmsp,
 DIS.order_pos_updated_tmsp,
 DIS.delivery_tmsp,
 DIS.dwh_cal_dt,
 DIS.dwh_load_id,
 DIS.dwh_created,
 DIS.dwh_updated
FROM ldl_p_lew_mart_lead.t_dispo_pos_hist_1 AS DIS
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_1 AS ITMP ON DIS.client_id = ITMP.client_id AND DIS.item_sid = ITMP.item_sid;