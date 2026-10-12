CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_accounting_document_type AS SELECT acct_doc_type_cd,
 acc_doc_type_name_en,
 acc_doc_type_name_de
FROM ldl_dig_lec_share.v_dim_accounting_document_type
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1,
 '' AS dm__operand2;