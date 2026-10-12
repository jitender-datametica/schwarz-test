/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for _LEW_MART_LEAD.V_DISPO_POS_HIST
#----------------------------------------------------------------------------
# History:
#  1.0  20.09.2022    Bachmann, Torsten        Initial version for Liefertreue (Prototype)
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_DISPO_POS_HIST (
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
  dis.client_id
, dis.loc_sid
, dis.order_record_id
, itmp.item_sid_map         AS item_sid
, dis.order_pos_version_nr
, dis.dwh_valid_from
, dis.dwh_valid_to
, dis.deleted_fg
, dis.delivery_dt
, dis.order_status_cd
, dis.part_fg
, dis.order_qty_type_cd
, dis.order_qty
, dis.order_delivered_case_qty
, dis.case_factor
, dis.real_case_size
, dis.init_order_qty_type_cd
, dis.init_order_qty
, dis.init_case_factor
, dis.delta_order_case_qty
, dis.order_pos_created_tmsp
, dis.order_pos_updated_tmsp
, dis.delivery_tmsp
, dis.dwh_cal_dt
, dis.dwh_load_id
, dis.dwh_created
, dis.dwh_updated
FROM P_LEW_MART_LEAD.T_DISPO_POS_HIST dis
  INNER JOIN p_lew_core_ac.v_item_map_key itmp
    ON itmp.client_id = dis.client_id
   AND itmp.item_sid  = dis.item_sid
;