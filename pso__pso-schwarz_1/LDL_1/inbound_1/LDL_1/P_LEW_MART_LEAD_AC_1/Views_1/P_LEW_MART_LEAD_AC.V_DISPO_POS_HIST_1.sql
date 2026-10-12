/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for _LEW_MART_LEAD.V_DISPO_POS_HIST_1
#----------------------------------------------------------------------------
# History:
#  1.0  20.09.2022    Bachmann, Torsten        Initial version for Liefertreue (Prototype)
#  1.1  27.09.2022    Bachmann, Torsten        Rename column
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_DISPO_POS_HIST_1 (
  client_id
, loc_sid
, order_record_id
, item_sid
, order_pos_version_nr
, dwh_valid_from
, dwh_valid_to
, deleted_fg
, delivery_dt
, order_status_cd
, part_fg
, order_qty_type_cd
, order_qty
, order_delivered_case_qty
, case_factor
, real_case_size
, init_order_qty_type_cd
, init_order_qty
, init_case_factor
, delta_order_case_qty
, order_pos_created_tmsp
, order_pos_updated_tmsp
, delivery_tmsp
, dwh_cal_dt
, dwh_load_id
, dwh_created
, dwh_updated
) AS
SELECT 
  client_id
, loc_sid
, order_record_id
, item_sid
, order_pos_version_nr
, dwh_valid_from
, dwh_valid_to
, deleted_fg
, delivery_dt
, order_status_cd
, part_fg
, order_qty_type_cd
, order_qty
, order_delivered_case_qty
, case_factor
, real_case_size
, init_order_qty_type_cd
, init_order_qty
, init_case_factor
, delta_order_case_qty
, order_pos_created_tmsp
, order_pos_updated_tmsp
, delivery_tmsp
, dwh_cal_dt
, dwh_load_id
, dwh_created
, dwh_updated
FROM P_LEW_MART_LEAD.V_DISPO_POS_HIST_1
;