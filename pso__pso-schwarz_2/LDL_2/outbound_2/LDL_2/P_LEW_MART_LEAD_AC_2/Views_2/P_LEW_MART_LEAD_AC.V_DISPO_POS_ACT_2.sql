/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for _LEW_MART_LEAD.V_DISPO_POS_ACT_2
#----------------------------------------------------------------------------
# History:
#  1.0  20.09.2022    Bachmann, Torsten        Initial version for Liefertreue (Prototype)
#  1.1  27.09.2022    Bachmann, Torsten        Added some columns
#  1.2  06.10.2022    Bachmann, Torsten        wh_id, sup_sid added
#  1.3  17.11.2022    Bachmann, Torsten        init values now are stored in order_pos_version_nr = 0
#  1.4  10.01.2023    Bachmann, Torsten        added week columns, temporary add also some dummy_2 EKS columns in german
#  1.5  06.03.2023    Bachmann, Torsten        added reason_cd from T_REPLENISH_ORDER_WH_RECORD_POS_CHANGELOG_2
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_dispo_pos_act_2 (client_id, loc_sid, wh_id, supplier_id, order_record_id,
item_sid, order_pos_version_nr, dwh_valid_from, deleted_fg, delivery_dt, delivery_week, order_status_cd, part_fg,
order_qty_type_cd, transportweg_kurz, transportweg_lang, einkaeuferkuerzel, einkaeufer, order_qty,
order_delivered_case_qty, case_factor, order_case_qty, real_case_size, init_order_qty_type_cd, init_order_qty,
init_case_factor, init_order_case_qty, delta_order_case_qty, order_status_cd_override, init_delivery_dt,
init_delivery_week, min_rcv_dt, max_rcv_dt, max_rcv_week, qty_case_rcv_ontime, qty_case_rcv_ahead_schedule,
qty_case_rcv_delay_1_day, qty_case_rcv_delay_2_days, qty_case_rcv_delay_3_days, qty_case_rcv_delay_ge_4_days,
qty_case_rcv, cnt_days_delayed, cnt_rcv, orig_receipt_id_rcv, mapping_pos_nr, order_pos_created_tmsp,
order_pos_updated_tmsp, delivery_tmsp, all_reason_cd, first_reason_cd, last_reason_cd, dwh_load_id, dwh_created,
dwh_updated) AS SELECT client_id,
 loc_sid,
 wh_id,
 sup_sid AS supplier_id,
 order_record_id,
 item_sid,
 order_pos_version_nr,
 dwh_valid_from,
 deleted_fg,
 delivery_dt,
   EXTRACT(ISOYEAR FROM delivery_dt) * 100 + EXTRACT(ISOWEEK FROM delivery_dt) AS delivery_week,
 order_status_cd,
 part_fg,
 order_qty_type_cd,
 '-1' AS transportweg_kurz,
 '-1' AS transportweg_lang,
 '-1' AS einkaeuferkuerzel,
 '-1' AS einkaeufer,
 order_qty,
 order_delivered_case_qty,
 case_factor,
  order_qty * case_factor AS order_case_qty,
 real_case_size
 /* show init values which are stored in order_pos_version_nr = 0, so that we can sum it up in the report */,
  CASE
  WHEN order_pos_version_nr = 0
  THEN order_qty_type_cd
  ELSE 0
  END AS init_order_qty_type_cd,
  CASE
  WHEN order_pos_version_nr = 0
  THEN order_qty
  ELSE 0
  END AS init_order_qty,
  CASE
  WHEN order_pos_version_nr = 0
  THEN case_factor
  ELSE 0
  END AS init_case_factor,
  CASE
  WHEN order_pos_version_nr = 0
  THEN order_qty * case_factor
  ELSE 0
  END AS init_order_case_qty,
 delta_order_case_qty,
 order_status_cd_override,
 init_delivery_dt,
   EXTRACT(ISOYEAR FROM init_delivery_dt) * 100 + EXTRACT(ISOWEEK FROM init_delivery_dt) AS init_delivery_week,
 min_rcv_dt,
 max_rcv_dt,
   EXTRACT(ISOYEAR FROM max_rcv_dt) * 100 + EXTRACT(ISOWEEK FROM max_rcv_dt) AS max_rcv_week,
 qty_case_rcv_ontime,
 qty_case_rcv_ahead_schedule,
 qty_case_rcv_delay_1_day,
 qty_case_rcv_delay_2_days,
 qty_case_rcv_delay_3_days,
 qty_case_rcv_delay_ge_4_days,
      qty_case_rcv_ontime + qty_case_rcv_ahead_schedule + qty_case_rcv_delay_1_day + qty_case_rcv_delay_2_days +
   qty_case_rcv_delay_3_days + qty_case_rcv_delay_ge_4_days AS qty_case_rcv,
 cnt_days_delayed,
 cnt_rcv,
 COALESCE(orig_receipt_id_rcv, '-1') AS orig_receipt_id_rcv,
 COALESCE(mapping_pos_nr, - 1) AS mapping_pos_nr,
 order_pos_created_tmsp,
 order_pos_updated_tmsp,
 delivery_tmsp,
 COALESCE(all_reason_cd, '') AS all_reason_cd,
 COALESCE(first_reason_cd, 0) AS first_reason_cd,
 COALESCE(last_reason_cd, 0) AS last_reason_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lead.v_dispo_pos_act_2;