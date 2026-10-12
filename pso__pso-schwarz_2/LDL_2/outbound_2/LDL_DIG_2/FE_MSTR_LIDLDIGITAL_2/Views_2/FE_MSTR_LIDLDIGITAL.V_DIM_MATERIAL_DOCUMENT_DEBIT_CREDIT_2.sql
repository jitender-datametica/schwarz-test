CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_material_document_debit_credit_2 AS SELECT CASE
  WHEN material_doc_debit_credit_cd = ''
  THEN '-1'
  ELSE IFNULL(material_doc_debit_credit_cd, '-1')
  END AS material_doc_debit_credit_cd,
 material_doc_debit_credit_descr
FROM ldl_dig_lec_share.v_dim_material_document_debit_credit_2
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1;