CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_accounting_transaction_type AS SELECT acct_trans_type_cd,
 acct_trans_type_name_en,
 acct_trans_type_name_de
FROM ldl_dig_lec_share.v_dim_accounting_transaction_type
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1,
 '' AS dm__operand2;