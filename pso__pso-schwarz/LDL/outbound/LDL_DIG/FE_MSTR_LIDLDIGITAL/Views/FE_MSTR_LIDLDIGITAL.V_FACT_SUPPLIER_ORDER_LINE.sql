CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_supplier_order_line AS SELECT CASE
  WHEN supplier_order_nr = ''
  THEN '-1'
  ELSE IFNULL(supplier_order_nr, '-1')
  END AS supplier_order_nr,
 IFNULL(supplier_order_pos_nr, -1) AS supplier_order_pos_nr,
  CASE
  WHEN supplier_order_type_cd = ''
  THEN '-1'
  ELSE IFNULL(supplier_order_type_cd, '-1')
  END AS supplier_order_type_cd,
 IFNULL(prod_variant_sid, -1) AS prod_variant_sid,
 supplier_order_dt,
 IFNULL(supplier_sid, -1) AS supplier_sid,
 prod_qty,
 dropshipment_order_fg,
 IFNULL(cust_order_sid, -1) AS cust_order_sid,
  CASE
  WHEN cust_order_nr = ''
  THEN '-1'
  ELSE IFNULL(cust_order_nr, '-1')
  END AS cust_order_nr,
 IFNULL(cust_order_pos_nr, -1) AS cust_order_pos_nr,
 IFNULL(prod_variant_nr, '-1') AS prod_variant_nr,
 IFNULL(supplier_nr, '-1') AS supplier_nr,
 supplier_order_cancel_dt
FROM ldl_dig_lec_share.v_fact_supplier_order_line
WHERE dwh_valid_fg;