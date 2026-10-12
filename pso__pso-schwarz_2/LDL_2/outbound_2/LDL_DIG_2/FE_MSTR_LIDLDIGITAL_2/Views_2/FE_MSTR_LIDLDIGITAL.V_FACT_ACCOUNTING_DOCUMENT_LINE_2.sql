CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_accounting_document_line_2 (ledger_cd, internal_company_cd,
fiscal_year, acct_doc_nr, acct_doc_line_nr, fin_acct_sid, internal_company_sid, internal_company_partner_sid, acct_nr,
acct_doc_dt, acct_doc_type_cd, acct_doc_posting_dt, acct_doc_status, ctrl_doc_nr, fiscal_period, curr_cd,
posting_local_val, posting_group_val, ctrl_area_cd, cost_center_nr, sender_cost_center_nr, posting_tmsp, ref_doc_nr,
accounted_module_cd, debit_credit_cd, gl_acct_type, offsetting_acct_nr, acct_document_tx, acct_trans_type_cd,
acct_cost_type_cd, prod_variant_nr, prod_variant_sid, chart_of_accounts_cd, group_acct_nr, acct_curr_cd,
acct_data_src_name) AS SELECT A1.ledger_cd,
  CASE
  WHEN A1.internal_company_cd = ''
  THEN '-1'
  ELSE IFNULL(A1.internal_company_cd, '-1')
  END AS internal_company_cd,
 A1.fiscal_year,
 A1.acct_doc_nr,
 A1.acct_doc_line_nr,
 IFNULL(A1.fin_acct_sid, -1) AS fin_acct_sid,
 IFNULL(A1.internal_company_sid, -1) AS internal_company_sid,
 IFNULL(A1.internal_company_partner_sid, -1) AS internal_company_partner_sid,
  CASE
  WHEN A1.acct_nr = ''
  THEN '-1'
  ELSE IFNULL(A1.acct_nr, '-1')
  END AS acct_nr,
 A1.acct_doc_dt,
  CASE
  WHEN A1.acct_doc_type_cd = ''
  THEN '-1'
  ELSE IFNULL(A1.acct_doc_type_cd, '-1')
  END AS acct_doc_type_cd,
 A1.acct_doc_posting_dt,
 A1.acct_doc_status,
 A1.ctrl_doc_nr,
 IFNULL(A1.fiscal_period_nr, -1) AS fiscal_period,
  CASE
  WHEN A1.curr_cd = ''
  THEN '-1'
  ELSE IFNULL(A1.curr_cd, '-1')
  END AS curr_cd,
 A1.posting_local_val,
 A1.posting_group_val,
  CASE
  WHEN A1.ctrl_area_cd = ''
  THEN '-1'
  ELSE IFNULL(A1.ctrl_area_cd, '-1')
  END AS ctrl_area_cd,
  CASE
  WHEN A1.cost_center_nr = ''
  THEN '-1'
  ELSE IFNULL(A1.cost_center_nr, '-1')
  END AS cost_center_nr,
 COALESCE(NULLIF(A1.sender_cost_center_nr, ''), NULLIF(A1.cost_center_nr, ''), '-1') AS sender_cost_center_nr,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(A1.posting_tmsp AS TIMESTAMP), 'Europe/Berlin')) AS DATETIME)
 AS posting_tmsp,
 A1.ref_doc_nr,
  CASE
  WHEN A1.accounted_module_cd = ''
  THEN '-1'
  ELSE IFNULL(A1.accounted_module_cd, '-1')
  END AS accounted_module_cd,
  CASE
  WHEN A1.debit_credit_cd = ''
  THEN '-1'
  ELSE IFNULL(A1.debit_credit_cd, '-1')
  END AS debit_credit_cd,
 A1.gl_acct_type,
  CASE
  WHEN A1.offsetting_acct_nr = ''
  THEN '-1'
  ELSE IFNULL(A1.offsetting_acct_nr, '-1')
  END AS offsetting_acct_nr,
  CASE
  WHEN A1.acct_document_tx = ''
  THEN '-1'
  ELSE IFNULL(A1.acct_document_tx, '-1')
  END AS acct_document_tx,
  CASE
  WHEN A1.acct_trans_type_cd = ''
  THEN '-1'
  ELSE IFNULL(A1.acct_trans_type_cd, '-1')
  END AS acct_trans_type_cd,
  CASE
  WHEN A1.acct_cost_type_cd = ''
  THEN '-1'
  ELSE IFNULL(A1.acct_cost_type_cd, '-1')
  END AS acct_cost_type_cd,
  CASE
  WHEN A1.prod_variant_nr = ''
  THEN '-1'
  ELSE IFNULL(A1.prod_variant_nr, '-1')
  END AS prod_variant_nr,
 IFNULL(A1.prod_variant_sid, -1) AS prod_variant_sid,
  CASE
  WHEN A2.chart_of_accounts_cd = ''
  THEN '-1'
  ELSE IFNULL(A2.chart_of_accounts_cd, '-1')
  END AS chart_of_accounts_cd,
  CASE
  WHEN A2.group_acct_nr = ''
  THEN '-1'
  ELSE IFNULL(A2.group_acct_nr, '-1')
  END AS group_acct_nr,
 A2.curr_cd AS acct_curr_cd,
 'IST SAP' AS acct_data_src_name
FROM ldl_dig_lec_share.v_fact_accounting_document_line_2 AS A1
 LEFT JOIN (SELECT fin_acct_sid,
   chart_of_accounts_cd,
   group_acct_nr,
    CASE
    WHEN curr_cd = ''
    THEN '-1'
    ELSE IFNULL(curr_cd, '-1')
    END AS curr_cd
  FROM ldl_dig_lec_share.v_dim_financial_account_2
  WHERE dwh_valid_fg
   AND chart_of_accounts_cd = 'LDI1') AS A2 ON A1.fin_acct_sid = A2.fin_acct_sid;