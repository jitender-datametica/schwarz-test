CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_material_document_line_no_gc_lc_1 (material_doc_nr,
material_doc_year, material_doc_pos_nr, wh_sid, prod_variant_sid, storage_loc_cd, booking_dt, batch_nr, curr_cd,
prod_gross_loc_val, prod_gross_eur_val, prod_qty, material_doc_stock_type_cd, material_doc_mov_type_cd,
material_doc_special_stock_type_cd, material_doc_mov_reason_cd, material_doc_consum_type_cd,
material_doc_receipt_type_cd, material_doc_debit_credit_cd, delivery_order_sid, delivery_order_pos_nr, uom_sid,
entry_prod_qty, entry_uom_sid, wh_cd, cust_sid, supplier_order_nr, supplier_order_pos_nr, pack_material_nr,
delivery_src_type_cd) AS SELECT CASE
  WHEN MDL_FACT.material_doc_nr = ''
  THEN '-1'
  ELSE IFNULL(MDL_FACT.material_doc_nr, '-1')
  END AS material_doc_nr,
 IFNULL(MDL_FACT.material_doc_year, -1) AS material_doc_year,
  CASE
  WHEN MDL_FACT.material_doc_pos_nr = ''
  THEN '-1'
  ELSE IFNULL(MDL_FACT.material_doc_pos_nr, '-1')
  END AS material_doc_pos_nr,
 IFNULL(MDL_FACT.wh_sid, -1) AS wh_sid,
 IFNULL(MDL_FACT.prod_variant_sid, -1) AS prod_variant_sid,
  CASE
  WHEN MDL_FACT.storage_loc_cd = ''
  THEN '-1'
  ELSE IFNULL(MDL_FACT.storage_loc_cd, '-1')
  END AS storage_loc_cd,
 MDL_FACT.booking_dt,
 MDL_FACT.batch_nr,
  CASE
  WHEN MDL_FACT.curr_cd = ''
  THEN '-1'
  ELSE IFNULL(MDL_FACT.curr_cd, '-1')
  END AS curr_cd,
  MDL_FACT.prod_gross_loc_val * IF(MDL_FACT.material_doc_debit_credit_cd = 'H', - 1, 1) AS prod_gross_loc_val,
   MDL_FACT.prod_gross_loc_val * IF(MDL_FACT.material_doc_debit_credit_cd = 'H', - 1, 1) / CER_FACT.exchange_rate AS
 prod_gross_eur_val,
  MDL_FACT.prod_qty * IF(MDL_FACT.material_doc_debit_credit_cd = 'H', - 1, 1) AS prod_qty,
  CASE
  WHEN MDL_FACT.material_doc_stock_type_cd = ''
  THEN '-1'
  ELSE IFNULL(MDL_FACT.material_doc_stock_type_cd, '-1')
  END AS material_doc_stock_type_cd,
  CASE
  WHEN MDL_FACT.material_doc_mov_type_cd = ''
  THEN '-1'
  ELSE IFNULL(MDL_FACT.material_doc_mov_type_cd, '-1')
  END AS material_doc_mov_type_cd,
  CASE
  WHEN MDL_FACT.material_doc_special_stock_type_cd = ''
  THEN '-1'
  ELSE IFNULL(MDL_FACT.material_doc_special_stock_type_cd, '-1')
  END AS material_doc_special_stock_type_cd,
  CASE
  WHEN MDL_FACT.material_doc_mov_reason_cd = ''
  THEN '-1'
  ELSE IFNULL(MDL_FACT.material_doc_mov_reason_cd, '-1')
  END AS material_doc_mov_reason_cd,
  CASE
  WHEN MDL_FACT.material_doc_consum_type_cd = ''
  THEN '-1'
  ELSE IFNULL(MDL_FACT.material_doc_consum_type_cd, '-1')
  END AS material_doc_consum_type_cd,
  CASE
  WHEN MDL_FACT.material_doc_receipt_type_cd = ''
  THEN '-1'
  ELSE IFNULL(MDL_FACT.material_doc_receipt_type_cd, '-1')
  END AS material_doc_receipt_type_cd,
  CASE
  WHEN MDL_FACT.material_doc_debit_credit_cd = ''
  THEN '-1'
  ELSE IFNULL(MDL_FACT.material_doc_debit_credit_cd, '-1')
  END AS material_doc_debit_credit_cd,
 IFNULL(MDL_FACT.delivery_order_sid, -1) AS delivery_order_sid,
 IFNULL(MDL_FACT.delivery_order_pos_nr, -1) AS delivery_order_pos_nr,
 IFNULL(MDL_FACT.uom_sid, -1) AS uom_sid,
 MDL_FACT.entry_prod_qty,
 IFNULL(MDL_FACT.entry_uom_sid, -1) AS entry_uom_sid,
  CASE
  WHEN MDL_FACT.wh_cd = ''
  THEN '-1'
  ELSE IFNULL(MDL_FACT.wh_cd, '-1')
  END AS wh_cd,
 IFNULL(MDL_FACT.cust_sid, -1) AS cust_sid,
  CASE
  WHEN MDL_FACT.supplier_order_nr = ''
  THEN '-1'
  ELSE IFNULL(MDL_FACT.supplier_order_nr, '-1')
  END AS supplier_order_nr,
 IFNULL(MDL_FACT.supplier_order_pos_nr, -1) AS supplier_order_pos_nr,
 IFNULL(MDL_FACT.pack_material_nr, '-1') AS pack_material_nr,
 IFNULL(MDL_FACT.delivery_src_type_cd, '-1') AS delivery_src_type_cd
FROM ldl_dig_lec_share.v_fact_material_document_line_1 AS MDL_FACT
 INNER JOIN ldl_dig_lec_share.v_fact_currency_exchange_rate_1 AS CER_FACT ON MDL_FACT.curr_cd = CER_FACT.from_curr_cd AND
   MDL_FACT.booking_dt BETWEEN CER_FACT.active_from_dt AND CER_FACT.active_to_dt
 INNER JOIN ldl_dig_lec_share.v_dim_currency_exchange_rate_type_1 AS CERT_DIM ON CER_FACT.curr_exchange_rate_type_cd =
   CERT_DIM.curr_exchange_rate_type_cd AND CERT_DIM.is_general_used_fg;