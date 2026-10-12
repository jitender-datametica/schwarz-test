CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_offsetting_accounts_1 AS SELECT DISTINCT FACT.offsetting_acct_nr
 ,
 DIM.short_name_en,
 DIM.long_name_en,
 COALESCE(DIM2.short_name_de, DIM.short_name_de) AS short_name_de,
 DIM.long_name_de
FROM ldl_dig_lec_share.v_fact_accounting_document_line_1 AS FACT
 LEFT JOIN (SELECT acct_nr,
   MAX(short_name_en) AS short_name_en,
   MAX(long_name_en) AS long_name_en,
   MAX(short_name_de) AS short_name_de,
   MAX(long_name_de) AS long_name_de
  FROM ldl_dig_lec_share.v_dim_financial_account_1
  WHERE dwh_valid_fg
   AND chart_of_accounts_cd = 'LDI1'
  GROUP BY acct_nr) AS DIM ON FACT.offsetting_acct_nr = DIM.acct_nr
 LEFT JOIN (SELECT supplier_nr,
   '' AS short_name_en,
   '' AS long_name_en,
   supplier_name AS short_name_de,
   '' AS long_name_de
  FROM ldl_dig_lec_share.v_dim_supplier_1
  WHERE dwh_valid_fg) AS DIM2 ON FACT.offsetting_acct_nr = DIM2.supplier_nr
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1,
 '' AS dm__operand2,
 '' AS dm__operand3,
 '' AS dm__operand4;