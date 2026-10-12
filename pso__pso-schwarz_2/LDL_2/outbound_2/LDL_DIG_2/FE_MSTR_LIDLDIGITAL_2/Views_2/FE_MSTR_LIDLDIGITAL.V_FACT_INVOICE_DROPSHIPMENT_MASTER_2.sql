CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_invoice_dropshipment_master_2 (supplier_order_nr,
supplier_order_pos_nr, supplier_order_dt, supplier_order_type_cd, prod_price_vat_pct, prod_price_vat_val,
prod_price_gross_local_val, supplier_sid, supplier_nr, booking_dt, prod_variant_sid, prod_variant_nr, cust_order_nr,
delivery_src_type_cd, material_doc_mov_type_cd, wh_leave_actual_dt, purch_invoice_nr, purch_invoice_pos_nr,
purch_amt_net_local_val, invoice_prod_qty, prod_variant_descr, price_val, price_val_total, gc_lc_cd) AS SELECT IFNULL(FACT_SOL
  .supplier_order_nr, '-1') AS supplier_order_nr,
 IFNULL(FACT_SOL.supplier_order_pos_nr, -1) AS supplier_order_pos_nr,
 IFNULL(FACT_SOL.supplier_order_dt, CAST('-1' AS DATE)) AS supplier_order_dt,
 IFNULL(FACT_SOL.supplier_order_type_cd, '-1') AS supplier_order_type_cd,
 FACT_SOL.prod_price_vat_pct,
  FACT_PIL.purch_amt_net_local_val * FACT_SOL.prod_price_vat_pct AS prod_price_vat_val,
  FACT_PIL.purch_amt_net_local_val * (1 + FACT_SOL.prod_price_vat_pct) AS prod_price_gross_local_val,
 IFNULL(FACT_SOL.supplier_sid, -1) AS supplier_sid,
 IFNULL(FACT_SOL.supplier_nr, '-1') AS supplier_nr,
 IFNULL(FACT_MDL.booking_dt, CAST('-1' AS DATE)) AS booking_dt,
 IFNULL(FACT_MDL.prod_variant_sid, -1) AS prod_variant_sid,
 IFNULL(FACT_MDL.prod_variant_nr, '-1') AS prod_variant_nr,
 IFNULL(FACT_MDL.cust_order_nr, '-1') AS cust_order_nr,
 IFNULL(FACT_MDL.delivery_src_type_cd, '-1') AS delivery_src_type_cd,
 IFNULL(FACT_MDL.material_doc_mov_type_cd, '-1') AS material_doc_mov_type_cd,
 IFNULL(DATE(FACT_GM.wh_leave_actual_tmsp), CAST('-1' AS DATE)) AS wh_leave_actual_dt,
 IFNULL(FACT_PIL.purch_invoice_nr, '-1') AS purch_invoice_nr,
 IFNULL(FACT_PIL.purch_invoice_pos_nr, -1) AS purch_invoice_pos_nr,
 FACT_PIL.purch_amt_net_local_val,
 FACT_PIL.prod_qty AS invoice_prod_qty,
 IFNULL(DIM_PV.prod_variant_descr, '-1') AS prod_variant_descr,
 FACT_PPS.price_val,
  FACT_PIL.prod_qty * FACT_PPS.price_val AS price_val_total,
 'GC' AS gc_lc_cd
FROM ldl_dig_lec_share.v_fact_material_document_line_2 AS FACT_MDL
 LEFT JOIN ldl_dig_lec_share.v_fact_supplier_order_line_2 AS FACT_SOL ON FACT_MDL.supplier_order_nr = FACT_SOL.supplier_order_nr
    AND FACT_MDL.supplier_order_pos_nr = FACT_SOL.supplier_order_pos_nr
 LEFT JOIN ldl_dig_lec_share.v_fact_purchase_invoice_line_2 AS FACT_PIL ON FACT_MDL.ref_doc_nr = FACT_PIL.ref_doc_nr AND
   FACT_MDL.ref_doc_pos_nr = FACT_PIL.ref_doc_pos_nr
 LEFT JOIN (SELECT T2.wshop_cd,
   T1.supplier_order_nr,
   MAX(T1.wh_leave_actual_tmsp) AS wh_leave_actual_tmsp
  FROM ldl_dig_lec_share.v_fact_goods_movement_2 AS T1_2
   LEFT JOIN ldl_dig_lec_share.v_fact_customer_order_line_2 AS T2 ON T1.cust_order_sid = T2.cust_order_sid AND T1.cust_order_pos_nr
      = T2.cust_order_pos_nr
  GROUP BY T1.supplier_order_nr,
   T2.wshop_cd) AS FACT_GM ON FACT_MDL.supplier_order_nr = FACT_GM.supplier_order_nr
 LEFT JOIN ldl_dig_lec_share.v_dim_product_variant_2 AS DIM_PV ON FACT_MDL.prod_variant_sid = DIM_PV.prod_variant_sid
 LEFT JOIN ldl_dig_lec_share.v_fact_product_price_supplier_2 AS FACT_PPS ON FACT_GM.wshop_cd = FACT_PPS.wshop_cd AND
     FACT_MDL.prod_variant_sid = FACT_PPS.prod_variant_sid AND DIM_PV.main_supplier_sid = FACT_PPS.supplier_sid AND
   FACT_MDL.booking_dt BETWEEN CAST(FACT_PPS.active_from_tmsp AS DATE) AND (CAST(FACT_PPS.active_to_tmsp AS DATE))
WHERE FACT_PPS.price_type_cd = 'FKZ'
 AND FACT_MDL.material_doc_mov_type_cd = '101'
 AND DIM_PV.dwh_valid_fg
 AND FACT_SOL.dwh_valid_fg
 AND FACT_MDL.ref_doc_nr IS NOT NULL;