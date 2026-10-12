
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_PICKING_PLANHEAD_2

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT
   a.client_id,
   wh.src_wh_id AS wh_id,
   a.pick_list_id AS picking_receipt_nr,
   a.pick_area_id AS picking_area_nr_pp,
   a.pick_order_cd AS order_nr,
   a.loc_sid_store AS planning_customer_nr,
   a.store_order_tmsp AS timestamp_customer_order,
   a.plan_method_cd    AS planning_method,
   a.plan_status_cd    AS planning_status,
   a.plan_host_status_cd AS planning_hoststatus,
   a.merged_fg AS action_merged,
   a.performance_statistic_avail_cd    AS performance_statistic_cd,
   a.pick_priority_id AS picking_priority,
   a.tour_client_cd AS tour_client_id,
   a.tour_cd AS tour_nr,
   a.destination_field_cd AS destination_field,
   a.chain_cd AS chain_id,
   a.chain_seq AS chain_sequence,
   a.chain_logic_id,
   a.delivery_tmsp AS timestamp_delivery,
   a.supply_tmsp AS timestamp_supply,
   a.pick_target_start_tmsp    AS timestamp_target_start,
   a.pick_start_dt AS dat_picking_start,
   a.pick_start_tmsp AS timestamp_picking_start,
   a.pick_end_tmsp AS timestamp_picking_end,
   a.target_pick_time_cnt AS picking_target_time_detail,
   a.act_pick_time_cnt AS picking_actual_time,
   a.position_cnt AS cnt_position,
   a.position_processed_cnt AS cnt_processed_position,
   a.target_pick_case_qty AS qty_target_case,
   a.act_pick_case_qty AS qty_actual_case,
   a.target_pick_te_qty    AS qty_target_te,
   a.act_pick_te_qty AS qty_actual_te,
   a.dwh_cal_dt AS dat_dayend,
   a.dwh_load_id AS load_id
   FROM p_lew_core_ac.v_pick_list_2 AS a
   INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh
   ON wh.client_id = a.client_id
   AND wh.loc_sid_wh =  a.loc_sid
   AND wh.dwh_actual_fg = 1
;
