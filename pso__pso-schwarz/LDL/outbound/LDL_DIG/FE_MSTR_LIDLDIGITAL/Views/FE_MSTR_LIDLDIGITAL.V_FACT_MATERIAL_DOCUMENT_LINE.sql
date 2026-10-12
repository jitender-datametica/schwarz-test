CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_material_document_line (material_doc_nr, material_doc_year,
material_doc_pos_nr, wh_sid, prod_variant_sid, storage_loc_cd, booking_dt, batch_nr, curr_cd, prod_gross_val, prod_qty,
material_doc_stock_type_cd, material_doc_mov_type_cd, material_doc_special_stock_type_cd, material_doc_mov_reason_cd,
material_doc_consum_type_cd, material_doc_receipt_type_cd, material_doc_debit_credit_cd, delivery_order_sid,
delivery_order_pos_nr, uom_sid, entry_prod_qty, entry_uom_sid, wh_cd, cust_sid, supplier_order_nr, supplier_order_pos_nr
, pack_material_nr, delivery_src_type_cd, gc_lc_cd) AS SELECT CASE
  WHEN material_doc_nr = ''
  THEN '-1'
  ELSE IFNULL(material_doc_nr, '-1')
  END AS material_doc_nr,
 IFNULL(material_doc_year, -1) AS material_doc_year,
  CASE
  WHEN material_doc_pos_nr = ''
  THEN '-1'
  ELSE IFNULL(material_doc_pos_nr, '-1')
  END AS material_doc_pos_nr,
 IFNULL(wh_sid, -1) AS wh_sid,
 IFNULL(prod_variant_sid, -1) AS prod_variant_sid,
  CASE
  WHEN storage_loc_cd = ''
  THEN '-1'
  ELSE IFNULL(storage_loc_cd, '-1')
  END AS storage_loc_cd,
 booking_dt,
 batch_nr,
  CASE
  WHEN curr_cd = ''
  THEN '-1'
  ELSE IFNULL(curr_cd, '-1')
  END AS curr_cd,
  prod_gross_loc_val * IF(material_doc_debit_credit_cd = 'H', - 1, 1) AS prod_gross_val,
  prod_qty * IF(material_doc_debit_credit_cd = 'H', - 1, 1) AS prod_qty,
  CASE
  WHEN material_doc_stock_type_cd = ''
  THEN '-1'
  ELSE IFNULL(material_doc_stock_type_cd, '-1')
  END AS material_doc_stock_type_cd,
  CASE
  WHEN material_doc_mov_type_cd = ''
  THEN '-1'
  ELSE IFNULL(material_doc_mov_type_cd, '-1')
  END AS material_doc_mov_type_cd,
  CASE
  WHEN material_doc_special_stock_type_cd = ''
  THEN '-1'
  ELSE IFNULL(material_doc_special_stock_type_cd, '-1')
  END AS material_doc_special_stock_type_cd,
  CASE
  WHEN material_doc_mov_reason_cd = ''
  THEN '-1'
  ELSE IFNULL(material_doc_mov_reason_cd, '-1')
  END AS material_doc_mov_reason_cd,
  CASE
  WHEN material_doc_consum_type_cd = ''
  THEN '-1'
  ELSE IFNULL(material_doc_consum_type_cd, '-1')
  END AS material_doc_consum_type_cd,
  CASE
  WHEN material_doc_receipt_type_cd = ''
  THEN '-1'
  ELSE IFNULL(material_doc_receipt_type_cd, '-1')
  END AS material_doc_receipt_type_cd,
  CASE
  WHEN material_doc_debit_credit_cd = ''
  THEN '-1'
  ELSE IFNULL(material_doc_debit_credit_cd, '-1')
  END AS material_doc_debit_credit_cd,
 IFNULL(delivery_order_sid, -1) AS delivery_order_sid,
 IFNULL(delivery_order_pos_nr, -1) AS delivery_order_pos_nr,
 IFNULL(uom_sid, -1) AS uom_sid,
 entry_prod_qty,
 IFNULL(entry_uom_sid, -1) AS entry_uom_sid,
  CASE
  WHEN wh_cd = ''
  THEN '-1'
  ELSE IFNULL(wh_cd, '-1')
  END AS wh_cd,
 IFNULL(cust_sid, -1) AS cust_sid,
  CASE
  WHEN supplier_order_nr = ''
  THEN '-1'
  ELSE IFNULL(supplier_order_nr, '-1')
  END AS supplier_order_nr,
 IFNULL(supplier_order_pos_nr, -1) AS supplier_order_pos_nr,
 IFNULL(pack_material_nr, '-1') AS pack_material_nr,
 IFNULL(delivery_src_type_cd, '-1') AS delivery_src_type_cd,
 'GC' AS gc_lc_cd
FROM ldl_dig_lec_share.v_fact_material_document_line AS MDL_FACT;