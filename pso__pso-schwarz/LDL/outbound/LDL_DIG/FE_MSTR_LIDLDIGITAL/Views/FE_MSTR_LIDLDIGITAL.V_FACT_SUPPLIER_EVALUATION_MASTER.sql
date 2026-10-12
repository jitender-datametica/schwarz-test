CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_supplier_evaluation_master (supplier_order_nr,
supplier_order_pos_nr, supplier_order_dt, supplier_order_type_cd, supplier_sid, booking_dt, purchase_prod_qty,
supplier_order_confirm_dt, supplier_prod_qty, tgt_prod_delivery_dt, delivered_prod_qty, wh_sid, storage_loc_cd,
prod_variant_sid, prod_variant_nr, prod_price_vat_pct, prod_price_vat_val, prod_price_net_local_val,
prod_price_gross_local_val, curr_cd, delivery_src_type_cd, is_delivery_completed_fg, deletion_in_purch_doc_fg,
order_status_fg, gtin_lidl, gtin_manufacturer, gtin_supplier) AS SELECT IFNULL(FACT_SOL.supplier_order_nr, '-1') AS
 supplier_order_nr,
 IFNULL(FACT_SOL.supplier_order_pos_nr, -1) AS supplier_order_pos_nr,
 IFNULL(FACT_SOL.supplier_order_dt, DATE('9999-12-31')) AS supplier_order_dt,
 IFNULL(FACT_SOL.supplier_order_type_cd, '-1') AS supplier_order_type_cd,
 IFNULL(FACT_SOL.supplier_sid, -1) AS supplier_sid,
 IFNULL(t1.booking_dt, DATE('9999-12-31')) AS booking_dt,
 t1.prod_qty AS purchase_prod_qty,
 IFNULL(FACT_SOL.supplier_order_confirm_dt, DATE('9999-12-31')) AS supplier_order_confirm_dt,
 FACT_SOL.prod_qty AS supplier_prod_qty,
 IFNULL(FACT_SOL.tgt_prod_delivery_dt, DATE('9999-12-31')) AS tgt_prod_delivery_dt,
 FACT_SOL.delivered_prod_qty,
 IFNULL(FACT_SOL.wh_sid, -1) AS wh_sid,
 IFNULL(t8.storage_loc_cd, '-1') AS storage_loc_cd,
 IFNULL(FACT_SOL.prod_variant_sid, -1) AS prod_variant_sid,
 IFNULL(t1.prod_variant_nr, '-1') AS prod_variant_nr,
 FACT_SOL.prod_price_vat_pct,
  FACT_SOL.prod_price_net_local_val * FACT_SOL.prod_price_vat_pct AS prod_price_vat_val,
 FACT_SOL.prod_price_net_local_val,
  FACT_SOL.prod_price_net_local_val * (1 + FACT_SOL.prod_price_vat_pct) AS prod_price_gross_local_val,
 IFNULL(FACT_SOL.curr_cd, '-1') AS curr_cd,
 IFNULL(t1.delivery_src_type_cd, '-1') AS delivery_src_type_cd,
 FACT_SOL.is_delivery_completed_fg,
 FACT_SOL.deletion_in_purch_doc_fg,
  CASE
  WHEN FACT_SOL.is_delivery_completed_fg OR FACT_SOL.deletion_in_purch_doc_fg
  THEN '1'
  ELSE '0'
  END AS order_status_fg,
 REL_PVAN.gtin_lidl,
 REL_PVAN.gtin_manufacturer,
 REL_PVAN.gtin_supplier
FROM ldl_dig_lec_share.v_fact_supplier_order_line AS FACT_SOL
 LEFT JOIN (SELECT supplier_order_nr,
   supplier_order_pos_nr,
   prod_variant_nr,
   material_doc_mov_type_cd,
   delivery_src_type_cd,
   MAX(booking_dt) AS booking_dt,
   SUM(prod_qty) AS prod_qty
  FROM ldl_dig_lec_share.v_fact_material_document_line
  WHERE material_doc_mov_type_cd = '101'
  GROUP BY material_doc_mov_type_cd,
   supplier_order_nr,
   supplier_order_pos_nr,
   delivery_src_type_cd,
   prod_variant_nr) AS t1 ON FACT_SOL.supplier_order_nr = t1.supplier_order_nr AND FACT_SOL.supplier_order_pos_nr = t1.supplier_order_pos_nr
   
 LEFT JOIN (SELECT supplier_order_nr,
   supplier_order_pos_nr,
   storage_loc_cd
  FROM ldl_dig_lec_share.v_fact_goods_movement
  WHERE goods_mov_cat_group_cd = 'WE'
   AND (supplier_order_nr, supplier_order_pos_nr, goods_mov_actual_tmsp) IN (SELECT (supplier_order_nr,
       supplier_order_pos_nr, MAX(goods_mov_actual_tmsp))
     FROM ldl_dig_lec_share.v_fact_goods_movement
     WHERE goods_mov_cat_group_cd = 'WE'
     GROUP BY supplier_order_nr,
      supplier_order_pos_nr)
  GROUP BY storage_loc_cd,
   supplier_order_nr,
   supplier_order_pos_nr) AS t8 ON FACT_SOL.supplier_order_nr = t8.supplier_order_nr AND FACT_SOL.supplier_order_pos_nr
   = t8.supplier_order_pos_nr
 LEFT JOIN (SELECT prod_variant_sid,
   MAX(gtin_lidl) AS gtin_lidl,
   MAX(gtin_manufacturer) AS gtin_manufacturer,
   MAX(gtin_supplier) AS gtin_supplier
  FROM (SELECT prod_variant_sid,
      CASE
      WHEN prod_add_nr_type_cd = 'LI'
      THEN MAX(prod_add_nr)
      ELSE NULL
      END AS gtin_lidl,
      CASE
      WHEN prod_add_nr_type_cd = 'HE'
      THEN MAX(prod_add_nr)
      ELSE NULL
      END AS gtin_manufacturer,
      CASE
      WHEN prod_add_nr_type_cd = 'SO'
      THEN MAX(prod_add_nr)
      ELSE NULL
      END AS gtin_supplier
    FROM ldl_dig_lec_share.v_rel_product_variant_additional_number
    WHERE dwh_valid_fg
    GROUP BY prod_variant_sid,
     prod_add_nr_type_cd) AS t11
  GROUP BY prod_variant_sid) AS REL_PVAN ON FACT_SOL.prod_variant_sid = REL_PVAN.prod_variant_sid
WHERE FACT_SOL.dwh_valid_fg
 AND FACT_SOL.supplier_order_type_cd IN ('NB', 'ZNBD', 'ZAKO', 'ZAKB', 'ZLDI', 'ZNPH', 'ZNPL', 'ZUB', 'ZUB2', 'ZUB3',
   'ZUB5');