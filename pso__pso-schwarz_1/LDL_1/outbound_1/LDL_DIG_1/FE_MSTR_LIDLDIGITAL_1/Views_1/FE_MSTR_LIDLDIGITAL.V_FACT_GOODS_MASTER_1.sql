/* 09.01.2025 ABA: joins deleted:      AND (FACT_GM.CUST_ORDER_POS_NR = REL_OP.CUST_ORDER_POS_NR
      OR  FACT_GM.IC_ORDER_POS_NR = REL_OP.IC_ORDER_POS_NR)     
    --> CROSS JOIN on order pos not needed */


CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_goods_master_1 (pack_sid, pack_pos_nr, deliv_prod_qty,
deliv_prod_price, deliv_prod_val, pack_order_nr, pack_tracking_nr, pack_tracking_url, ewm_pack_nr,
pack_order_actual_create_tmsp, pack_material_nr, pack_volume_uom_sid, pack_volume_meas, pack_volume_str,
pack_volume_meas_standard, pack_volume_meas_standard_uom_cd, pack_height_uom_sid, pack_height_meas, pack_height_str,
pack_height_meas_standard, pack_height_meas_standard_uom_cd, pack_weight_uom_sid, pack_weight_meas, pack_weight_str,
pack_weight_meas_standard, pack_weight_meas_standard_uom_cd, pack_width_uom_sid, pack_width_meas, pack_width_str,
pack_width_meas_standard, pack_width_meas_standard_uom_cd, pack_longest_length_meas, pack_shortest_length_meas,
pack_mean_length_meas, pack_length_uom_sid, pack_length_meas, pack_mean_length_str, pack_mean_length_meas_standard,
pack_shortest_length_str, pack_shortest_length_meas_standard, pack_longest_length_str, pack_longest_length_meas_standard
, pack_length_meas_standard_uom_cd, pack_girth_uom_sid, pack_girth_east_meas, pack_girth_west_meas, pack_girth_west_str
, pack_girth_west_meas_standard, pack_girth_east_str, pack_girth_east_meas_standard, pack_girth_meas_standard_uom_cd,
is_productsize_used_fg, wshop_cd, dist_channel_cd, delivery_order_sid, delivery_order_nr, delivery_order_pos_nr,
goods_mov_cat_cd, goods_mov_cat_group_cd, goods_mov_actual_tmsp, prod_variant_sid, delivery_type_cd, delivery_route_cd,
recipient_country_cd, stock_placement_cd, stock_removal_cd, cust_order_sid, cust_order_pos_nr, cust_sid, ic_order_sid,
ic_order_pos_nr, ic_order_nr, delivery_addr_sid, wh_sid, storage_loc_cd, wh_leave_actual_tmsp, wh_leave_actual_dt,
wh_leave_tgt_tmsp, wh_leave_tgt_dt, wh_arrive_actual_dt, sale_doc_type_cd, delivery_tgt_dt, order_item_category_cd,
supplier_order_nr, supplier_order_pos_nr, dropshipment_order_fg, prod_variant_nr, cust_order_nr) AS -- PARKSIDE

-- ,FACT_GM.DELIVERY_PROD_QTY AS DELIVERY_PROD_QTY -- not a useful quantity in this aggregation
 -- PARKSIDE

-- PARKSIDE
 -- PARKSIDE
 SELECT IFNULL(REL_OP.pack_sid, -1) AS pack_sid,
 IFNULL(REL_OP.pack_pos_nr, '-1') AS pack_pos_nr,
  CASE
  WHEN REL_OP.deliv_prod_qty IS NOT NULL
  THEN REL_OP.deliv_prod_qty
  ELSE FACT_GM.delivery_prod_qty
  END AS deliv_prod_qty,
 REL_OP.deliv_prod_price,
 REL_OP.deliv_prod_val,
 IFNULL(FACT_GPS.pack_order_nr, '-1') AS pack_order_nr,
 FACT_GPS.pack_tracking_nr,
 FACT_GPS.pack_tracking_url,
 FACT_GPS.ewm_pack_nr,
 FACT_GPS.pack_order_actual_create_tmsp,
 IFNULL(FACT_GPS.pack_material_nr, '-1') AS pack_material_nr,
 IFNULL(FACT_GPS.pack_volume_uom_sid, -1) AS pack_volume_uom_sid,
 FACT_GPS.pack_volume_meas,
 FACT_GPS.pack_volume_str,
 FACT_GPS.pack_volume_meas_standard,
 IFNULL(FACT_GPS.pack_volume_meas_standard_uom_cd, '-1') AS pack_volume_meas_standard_uom_cd,
 IFNULL(FACT_GPS.pack_height_uom_sid, -1) AS pack_height_uom_sid,
 FACT_GPS.pack_height_meas,
 FACT_GPS.pack_height_str,
 FACT_GPS.pack_height_meas_standard,
 IFNULL(FACT_GPS.pack_height_meas_standard_uom_cd, '-1') AS pack_height_meas_standard_uom_cd,
 IFNULL(FACT_GPS.pack_weight_uom_sid, -1) AS pack_weight_uom_sid,
 FACT_GPS.pack_weight_meas,
 FACT_GPS.pack_weight_str,
 FACT_GPS.pack_weight_meas_standard,
 IFNULL(FACT_GPS.pack_weight_meas_standard_uom_cd, '-1') AS pack_weight_meas_standard_uom_cd,
 IFNULL(FACT_GPS.pack_width_uom_sid, -1) AS pack_width_uom_sid,
 FACT_GPS.pack_width_meas,
 FACT_GPS.pack_width_str,
 FACT_GPS.pack_width_meas_standard,
 IFNULL(FACT_GPS.pack_width_meas_standard_uom_cd, '-1') AS pack_width_meas_standard_uom_cd,
 FACT_GPS.pack_longest_length_meas,
 FACT_GPS.pack_shortest_length_meas,
 FACT_GPS.pack_mean_length_meas,
 IFNULL(FACT_GPS.pack_length_uom_sid, -1) AS pack_length_uom_sid,
 FACT_GPS.pack_length_meas,
 FACT_GPS.pack_mean_length_str,
 FACT_GPS.pack_mean_length_meas_standard,
 FACT_GPS.pack_shortest_length_str,
 FACT_GPS.pack_shortest_length_meas_standard,
 FACT_GPS.pack_longest_length_str,
 FACT_GPS.pack_longest_length_meas_standard,
 IFNULL(FACT_GPS.pack_length_meas_standard_uom_cd, '-1') AS pack_length_meas_standard_uom_cd,
 IFNULL(FACT_GPS.pack_girth_uom_sid, -1) AS pack_girth_uom_sid,
 FACT_GPS.pack_girth_east_meas,
 FACT_GPS.pack_girth_west_meas,
 FACT_GPS.pack_girth_west_str,
 FACT_GPS.pack_girth_west_meas_standard,
 FACT_GPS.pack_girth_east_str,
 FACT_GPS.pack_girth_east_meas_standard,
 IFNULL(FACT_GPS.pack_girth_meas_standard_uom_cd, '-1') AS pack_girth_meas_standard_uom_cd,
 FACT_GPS.is_productsize_used_fg,
 IFNULL(FACT_GM.wshop_cd, '-1') AS wshop_cd,
 IFNULL(FACT_GM.dist_channel_cd, '-1') AS dist_channel_cd,
 IFNULL(COALESCE(FACT_GM.delivery_order_sid, REL_OP.delivery_order_sid), -1) AS delivery_order_sid,
 IFNULL(COALESCE(FACT_GM.delivery_order_nr, REL_OP.delivery_order_nr), '-1') AS delivery_order_nr,
 IFNULL(COALESCE(FACT_GM.delivery_order_pos_nr, REL_OP.delivery_order_pos_nr), -1) AS delivery_order_pos_nr,
 IFNULL(FACT_GM.goods_mov_cat_cd, '-1') AS goods_mov_cat_cd,
 IFNULL(FACT_GM.goods_mov_cat_group_cd, '-1') AS goods_mov_cat_group_cd,
 FACT_GM.goods_mov_actual_tmsp,
 IFNULL(COALESCE(FACT_GM.prod_variant_sid, REL_OP.prod_variant_sid), -1) AS prod_variant_sid,
 IFNULL(FACT_GM.delivery_type_cd, '-1') AS delivery_type_cd,
 IFNULL(FACT_GM.delivery_route_cd, '-1') AS delivery_route_cd,
 IFNULL(FACT_GM.recipient_country_cd, '-1') AS recipient_country_cd,
 IFNULL(FACT_GM.stock_placement_cd, '-1') AS stock_placement_cd,
 IFNULL(FACT_GM.stock_removal_cd, '-1') AS stock_removal_cd,
 IFNULL(COALESCE(FACT_GM.delivery_order_sid, REL_OP.delivery_order_sid), -1) AS cust_order_sid,
 IFNULL(COALESCE(FACT_GM.cust_order_pos_nr, REL_OP.cust_order_pos_nr), -1) AS cust_order_pos_nr,
 IFNULL(FACT_GM.cust_sid, -1) AS cust_sid,
 IFNULL(FACT_GM.ic_order_sid, -1) AS ic_order_sid,
 IFNULL(FACT_GM.ic_order_pos_nr, -1) AS ic_order_pos_nr,
 IFNULL(FACT_GM.ic_order_nr, '-1') AS ic_order_nr,
 IFNULL(FACT_GM.delivery_addr_sid, -1) AS delivery_addr_sid,
 IFNULL(FACT_GM.wh_sid, -1) AS wh_sid,
 IFNULL(FACT_GM.storage_loc_cd, '-1') AS storage_loc_cd,
 FACT_GM.wh_leave_actual_tmsp,
 IFNULL(FACT_GM.wh_leave_actual_dt, DATE('1900-01-01')) AS wh_leave_actual_dt,
 FACT_GM.wh_leave_tgt_tmsp,
 FACT_GM.wh_leave_tgt_dt,
  CASE
  WHEN FACT_GM.goods_mov_cat_group_cd = 'WE'
  THEN IFNULL(FACT_GM.wh_arrive_actual_dt, DATE('1900-01-01'))
  ELSE IFNULL(FACT_GM.wh_leave_actual_dt, DATE('1900-01-01'))
  END AS wh_arrive_actual_dt,
 IFNULL(FACT_GM.sale_doc_type_cd, '-1') AS sale_doc_type_cd,
 FACT_GM.delivery_tgt_dt,
 FACT_GM.order_item_category_cd,
 FACT_GM.supplier_order_nr,
 FACT_GM.supplier_order_pos_nr,
 FACT_GM.dropshipment_order_fg,
 FACT_GM.prod_variant_nr,
 FACT_GM.cust_order_nr
FROM ldl_dig_fe_mstr_lidldigital.v_fact_goods_movement_1 AS FACT_GM
 LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_rel_order_packaging_1 AS REL_OP ON FACT_GM.delivery_order_pos_nr = REL_OP.delivery_order_pos_nr
    AND FACT_GM.delivery_order_nr = REL_OP.delivery_order_nr
 LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_fact_goods_package_shipment_1 AS FACT_GPS ON REL_OP.pack_sid = FACT_GPS.pack_sid;