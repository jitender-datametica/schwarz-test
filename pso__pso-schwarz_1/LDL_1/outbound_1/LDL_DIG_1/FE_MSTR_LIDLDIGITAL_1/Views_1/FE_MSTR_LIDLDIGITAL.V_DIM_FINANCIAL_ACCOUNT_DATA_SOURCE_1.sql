CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_financial_account_data_source_1 (acct_data_src_id,
acct_data_src_name) AS SELECT entry_no AS acct_data_src_id,
 parameter_value_char AS acct_data_src_name
FROM ldl_dig_lec_share.v_meta_report_parameter_1
WHERE report = 'KER'
 AND parameter_type = 'dim'
 AND parameter_name = 'acct_data_src_name';