CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_product_price_supplier_document_line_2 (supplier_sid,
prod_variant_sid, booking_dt, material_doc_receipt_type_cd, curr_cd, material_doc_mov_type_cd, prod_qty,
prod_net_local_val, ekp_price_val) AS SELECT IFNULL(FSOL.supplier_sid, - 1) AS supplier_sid,
 IFNULL(FMDL.prod_variant_sid, - 1) AS prod_variant_sid,
 IFNULL(FMDL.booking_dt, DATE '1900-01-01') AS booking_dt,
 ANY_VALUE(FMDL.material_doc_receipt_type_cd) AS material_doc_receipt_type_cd,
 ANY_VALUE(FMDL.curr_cd) AS curr_cd,
  CASE
  WHEN FMDL.material_doc_mov_type_cd = ''
  THEN '-1'
  ELSE IFNULL(FMDL.material_doc_mov_type_cd, '-1')
  END AS material_doc_mov_type_cd,
 SUM(FMDL.prod_qty * IF(FMDL.material_doc_debit_credit_cd = 'H', - 1, 1)) AS prod_qty,
 SUM(FMDL.prod_net_local_val * IF(FMDL.material_doc_debit_credit_cd = 'H', - 1, 1)) AS prod_net_local_val,
 IF(SUM(FMDL.prod_qty) = 0, 0, SAFE_DIVIDE(SUM(FMDL.prod_net_local_val), SUM(FMDL.prod_qty))) AS ekp_price_val
FROM ldl_dig_lec_share.v_fact_material_document_line_2 AS FMDL
 INNER JOIN ldl_dig_lec_share.v_fact_supplier_order_line_2 AS FSOL ON FMDL.supplier_order_nr = FSOL.supplier_order_nr AND
   FMDL.supplier_order_pos_nr = FSOL.supplier_order_pos_nr
WHERE FSOL.dwh_valid_fg
GROUP BY FSOL.supplier_sid,
 FMDL.prod_variant_sid,
 FMDL.booking_dt,
 FMDL.material_doc_mov_type_cd;