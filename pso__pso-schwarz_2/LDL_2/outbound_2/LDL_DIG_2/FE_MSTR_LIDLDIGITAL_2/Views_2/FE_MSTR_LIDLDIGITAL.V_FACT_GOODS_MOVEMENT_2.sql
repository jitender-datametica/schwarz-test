CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_goods_movement_2 (wshop_cd, dist_channel_cd, delivery_order_sid
, delivery_order_nr, delivery_order_pos_nr, goods_mov_cat_cd, goods_mov_cat_group_cd, goods_mov_actual_tmsp,
prod_variant_sid, delivery_prod_qty, delivery_type_cd, delivery_route_cd, recipient_country_cd, stock_placement_cd,
stock_removal_cd, cust_order_sid, cust_order_pos_nr, cust_sid, ic_order_sid, ic_order_pos_nr, ic_order_nr,
delivery_addr_sid, wh_sid, wh_cd, storage_loc_cd, wh_leave_actual_tmsp, wh_leave_actual_dt, wh_leave_tgt_tmsp,
wh_leave_tgt_dt, order_item_category_cd, supplier_order_nr, supplier_order_pos_nr, dropshipment_order_fg,
wh_arrive_actual_dt, sale_doc_type_cd, delivery_tgt_dt, prod_variant_nr, cust_order_nr) AS SELECT IFNULL(wshop_cd, '-1'
  ) AS wshop_cd,
 IFNULL(dist_channel_cd, '-1') AS dist_channel_cd,
 IFNULL(delivery_order_sid, -1) AS delivery_order_sid,
 delivery_order_nr,
 delivery_order_pos_nr,
  CASE
  WHEN goods_mov_cat_cd = ''
  THEN '-1'
  ELSE IFNULL(goods_mov_cat_cd, '-1')
  END AS goods_mov_cat_cd,
  CASE
  WHEN goods_mov_cat_group_cd = ''
  THEN '-1'
  ELSE IFNULL(goods_mov_cat_group_cd, '-1')
  END AS goods_mov_cat_group_cd,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(goods_mov_actual_tmsp AS TIMESTAMP), 'Europe/Berlin')) AS DATETIME)
 AS goods_mov_actual_tmsp,
 IFNULL(prod_variant_sid, -1) AS prod_variant_sid,
 delivery_prod_qty,
  CASE
  WHEN delivery_type_cd = ''
  THEN '-1'
  ELSE IFNULL(delivery_type_cd, '-1')
  END AS delivery_type_cd,
  CASE
  WHEN delivery_route_cd = ''
  THEN '-1'
  ELSE IFNULL(delivery_route_cd, '-1')
  END AS delivery_route_cd,
  CASE
  WHEN recipient_country_cd = ''
  THEN '-1'
  ELSE IFNULL(recipient_country_cd, '-1')
  END AS recipient_country_cd,
  CASE
  WHEN stock_placement_cd = ''
  THEN '-1'
  ELSE IFNULL(stock_placement_cd, '-1')
  END AS stock_placement_cd,
  CASE
  WHEN stock_removal_cd = ''
  THEN '-1'
  ELSE IFNULL(stock_removal_cd, '-1')
  END AS stock_removal_cd,
 IFNULL(cust_order_sid, -1) AS cust_order_sid,
 cust_order_pos_nr,
 IFNULL(cust_sid, -1) AS cust_sid,
 IFNULL(ic_order_sid, -1) AS ic_order_sid,
 IFNULL(ic_order_pos_nr, -1) AS ic_order_pos_nr,
 IFNULL(ic_order_nr, '-1') AS ic_order_nr,
 IFNULL(delivery_addr_sid, -1) AS delivery_addr_sid,
 IFNULL(wh_sid, -1) AS wh_sid,
  CASE
  WHEN wh_cd = ''
  THEN '-1'
  ELSE IFNULL(wh_cd, '-1')
  END AS wh_cd,
  CASE
  WHEN storage_loc_cd = ''
  THEN '-1'
  ELSE IFNULL(storage_loc_cd, '-1')
  END AS storage_loc_cd,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(wh_leave_actual_tmsp AS TIMESTAMP), 'Europe/Berlin')) AS
  DATETIME) AS wh_leave_actual_tmsp,
 DATE(wh_leave_actual_tmsp) AS wh_leave_actual_dt,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(wh_leave_tgt_tmsp AS TIMESTAMP), 'Europe/Berlin')) AS
  DATETIME) AS wh_leave_tgt_tmsp,
 DATE(wh_leave_tgt_tmsp) AS wh_leave_tgt_dt,
  CASE
  WHEN order_item_category_cd = ''
  THEN '-1'
  ELSE IFNULL(order_item_category_cd, '-1')
  END AS order_item_category_cd,
  CASE
  WHEN supplier_order_nr = ''
  THEN '-1'
  ELSE IFNULL(supplier_order_nr, '-1')
  END AS supplier_order_nr,
 IFNULL(supplier_order_pos_nr, -1) AS supplier_order_pos_nr,
 dropshipment_order_fg,
 wh_arrive_actual_dt,
  CASE
  WHEN sale_doc_type_cd = ''
  THEN '-1'
  ELSE IFNULL(sale_doc_type_cd, '-1')
  END AS sale_doc_type_cd,
 delivery_tgt_dt,
 prod_variant_nr,
 cust_order_nr
FROM ldl_dig_lec_share.v_fact_goods_movement_2;