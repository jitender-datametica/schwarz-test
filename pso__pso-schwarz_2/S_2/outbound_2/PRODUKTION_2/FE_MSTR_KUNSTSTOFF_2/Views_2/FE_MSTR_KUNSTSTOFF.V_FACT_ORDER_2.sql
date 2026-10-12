CREATE OR REPLACE VIEW produktion_fe_mstr_kunststoff.v_fact_order_2 (order_id, production_line_resource_item_sid,
material_resource_item_sid, order_start_dt, order_end_dt, order_nr, order_start_tmsp, order_end_tmsp,
production_line_start_tmsp, production_line_end_tmsp, order_amount_plan_qty, order_amount_actual_qty,
nominal_capacity_qty, dwh_src_1_tmsp) AS SELECT ORDFA1.order_id,
 PRL1.production_line_id AS production_line_resource_item_sid,
 MATR1.material_id AS material_resource_item_sid,
 ORDFA1.order_start_dt,
 ORDFA1.order_end_dt,
 ORDFA1.order_nr,
 ORDFA1.order_start_tmsp,
 ORDFA1.order_end_tmsp,
 ORDFA1.production_line_start_tmsp,
 ORDFA1.production_line_end_tmsp,
 ORDFA1.order_amount_plan_qty,
 ORDFA1.order_amount_actual_qty,
 ORDFA1.nominal_capacity_qty,
 ORDFA1.dwh_src_1_tmsp
FROM produktion_core.t_fact_order_2 AS ORDFA1
 INNER JOIN produktion_core.t_dim_material_2 AS MATR1 ON ORDFA1.material_resource_item_sid = MATR1.resource_item_sid
 INNER JOIN produktion_core.t_dim_production_line_2 AS PRL1 ON ORDFA1.production_line_resource_item_sid = PRL1.resource_item_sid;