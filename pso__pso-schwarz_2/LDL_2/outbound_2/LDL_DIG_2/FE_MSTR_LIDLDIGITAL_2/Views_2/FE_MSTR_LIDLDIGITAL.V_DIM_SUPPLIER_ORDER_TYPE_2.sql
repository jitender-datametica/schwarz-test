CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_supplier_order_type_2 AS SELECT CASE
  WHEN supplier_order_type_cd = ''
  THEN '-1'
  ELSE IFNULL(supplier_order_type_cd, '-1')
  END AS supplier_order_type_cd,
 supplier_order_type_descr
FROM ldl_dig_lec_share.v_dim_supplier_order_type_2
UNION DISTINCT
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1;