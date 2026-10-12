CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_sales_document_type (sale_doc_type_cd, sale_doc_type_descr) AS
SELECT sale_doc_type_cd,
 sale_doc_type_descr
FROM ldl_dig_lec_share.v_dim_sales_document_type
UNION ALL
SELECT '-1',
 '';