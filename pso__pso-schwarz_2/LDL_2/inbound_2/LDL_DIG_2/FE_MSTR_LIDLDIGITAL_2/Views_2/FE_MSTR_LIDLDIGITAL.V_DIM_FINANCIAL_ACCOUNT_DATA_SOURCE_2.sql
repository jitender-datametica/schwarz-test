CREATE OR REPLACE VIEW fe_mstr_lidldigital.v_dim_financial_account_data_source_2 
(
    acct_data_src_id
    , acct_data_src_name
) 
AS 
SELECT
    entry_no                 AS acct_data_src_id
    , parameter_value_char   AS acct_data_src_name
FROM
    lec_share.v_meta_report_parameter_2
WHERE
        report = 'KER'
    AND parameter_type = 'dim'
    AND parameter_name = 'acct_data_src_name'
;