CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_financial_account_target_1 (fiscal_year, fiscal_period,
cost_center_nr, acct_nr, internal_company_sid, ctrl_area_cd, acct_doc_posting_dt, posting_group_tgt_net_eur_val,
acct_document_tx, acct_doc_nr, ctrl_doc_nr, acct_doc_dt, acct_cost_type_cd, prod_variant_nr, group_acct_nr,
offsetting_acct_nr, internal_company_partner_sid, acct_data_src_name, acct_doc_type_cd, sender_cost_center_nr) AS SELECT
 IFNULL(A1.fiscal_year, 0) AS fiscal_year,
 IFNULL(A1.fiscal_period, 0) AS fiscal_period,
  CASE
  WHEN A1.cost_center_nr = ''
  THEN '-1'
  ELSE IFNULL(A1.cost_center_nr, '-1')
  END AS cost_center_nr,
  CASE
  WHEN A1.acct_nr = ''
  THEN '-1'
  ELSE IFNULL(A1.acct_nr, '-1')
  END AS acct_nr,
 IFNULL(A1.internal_company_sid, -1) AS internal_company_sid,
  CASE
  WHEN A1.ctrl_area_cd = ''
  THEN '-1'
  ELSE IFNULL(A1.ctrl_area_cd, '-1')
  END AS ctrl_area_cd,
 A1.posting_dt AS acct_doc_posting_dt,
 IFNULL(A1.posting_group_tgt_net_eur_val, 0) AS posting_group_tgt_net_eur_val,
 '-1' AS acct_document_tx,
 'dummy_1' AS acct_doc_nr,
 'dummy_1' AS ctrl_doc_nr,
 A1.posting_dt AS acct_doc_dt,
 '1' AS acct_cost_type_cd,
 '-1' AS prod_variant_nr,
  CASE
  WHEN A2.group_acct_nr = ''
  THEN '-1'
  ELSE IFNULL(A2.group_acct_nr, '-1')
  END AS group_acct_nr,
 '-1' AS offsetting_acct_nr,
 '-1' AS internal_company_partner_sid,
 'PLAN' AS acct_data_src_name,
 '-1' AS acct_doc_type_cd,
 '-1' AS sender_cost_center_nr
FROM ldl_dig_lec_share.v_fact_financial_account_target_1 AS A1
 LEFT JOIN (SELECT internal_company_sid,
   acct_nr,
   group_acct_nr
  FROM ldl_dig_lec_share.v_dim_financial_account_1
  WHERE dwh_valid_fg
   AND chart_of_accounts_cd = 'LDI1') AS A2 ON A1.internal_company_sid = A2.internal_company_sid AND A1.acct_nr = A2.acct_nr;