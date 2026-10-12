CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_meta_load_time_ker_1 (acct_data_src_name, fiscal_period, fiscal_year
, current_fiscal_period, is_current_fiscal_period_and_year_cd, previous_fiscal_period,
is_previous_fiscal_period_and_year_cd, max_dwh_updated_tmsp) AS SELECT 'IST SAP' AS acct_data_src_name,
 fiscal_period_nr AS fiscal_period,
 fiscal_year,
  CASE
  WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 2 = - 1
  THEN 11
  WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 2 = 0
  THEN 12
  ELSE CAST(EXTRACT(MONTH FROM CURRENT_DATE) - 2 AS INTEGER)
  END AS current_fiscal_period,
  CASE
  WHEN CASE
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 2 = - 1
     THEN 11
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 2 = 0
     THEN 12
     ELSE CAST(EXTRACT(MONTH FROM CURRENT_DATE) - 2 AS INTEGER)
     END = fiscal_period_nr AND CASE
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 2 = - 1
     THEN EXTRACT(YEAR FROM CURRENT_DATE) - 1
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 2 = 0
     THEN EXTRACT(YEAR FROM CURRENT_DATE) - 1
     ELSE EXTRACT(YEAR FROM CURRENT_DATE)
     END = fiscal_year
  THEN 1
  ELSE 0
  END AS is_current_fiscal_period_and_year_cd,
  CASE
  WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 3 = - 2
  THEN 10
  WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 3 = - 1
  THEN 11
  WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 3 = 0
  THEN 12
  ELSE CAST(EXTRACT(MONTH FROM CURRENT_DATE) - 3 AS INTEGER)
  END AS previous_fiscal_period,
  CASE
  WHEN CASE
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 3 = - 2
     THEN 10
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 3 = - 1
     THEN 11
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 3 = 0
     THEN 12
     ELSE CAST(EXTRACT(MONTH FROM CURRENT_DATE) - 3 AS INTEGER)
     END = fiscal_period_nr AND CASE
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 3 = - 2
     THEN EXTRACT(YEAR FROM CURRENT_DATE) - 1
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 3 = - 1
     THEN EXTRACT(YEAR FROM CURRENT_DATE) - 1
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 3 = 0
     THEN EXTRACT(YEAR FROM CURRENT_DATE) - 1
     ELSE EXTRACT(YEAR FROM CURRENT_DATE)
     END = fiscal_year
  THEN 1
  ELSE 0
  END AS is_previous_fiscal_period_and_year_cd,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(MAX(dwh_updated_tmsp) AS TIMESTAMP), 'Europe/Berlin')) AS
  DATETIME) AS max_dwh_updated_tmsp
FROM ldl_dig_lec_share.v_fact_accounting_document_line_1
GROUP BY acct_data_src_name,
 fiscal_period,
 fiscal_year,
 current_fiscal_period,
 is_current_fiscal_period_and_year_cd,
 previous_fiscal_period,
 is_previous_fiscal_period_and_year_cd
UNION DISTINCT
SELECT 'EXT' AS acct_data_src_name,
 fiscal_period,
 fiscal_year,
  CASE
  WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 2 = - 1
  THEN 11
  WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 2 = 0
  THEN 12
  ELSE CAST(EXTRACT(MONTH FROM CURRENT_DATE) - 2 AS INTEGER)
  END AS current_fiscal_period,
  CASE
  WHEN CASE
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 2 = - 1
     THEN 11
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 2 = 0
     THEN 12
     ELSE CAST(EXTRACT(MONTH FROM CURRENT_DATE) - 2 AS INTEGER)
     END = fiscal_period AND CASE
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 2 = - 1
     THEN EXTRACT(YEAR FROM CURRENT_DATE) - 1
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 2 = 0
     THEN EXTRACT(YEAR FROM CURRENT_DATE) - 1
     ELSE EXTRACT(YEAR FROM CURRENT_DATE)
     END = fiscal_year
  THEN 1
  ELSE 0
  END AS is_current_fiscal_period_and_year_cd,
  CASE
  WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 3 = - 2
  THEN 10
  WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 3 = - 1
  THEN 11
  WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 3 = 0
  THEN 12
  ELSE CAST(EXTRACT(MONTH FROM CURRENT_DATE) - 3 AS INTEGER)
  END AS previous_fiscal_period,
  CASE
  WHEN CASE
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 3 = - 2
     THEN 10
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 3 = - 1
     THEN 11
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 3 = 0
     THEN 12
     ELSE CAST(EXTRACT(MONTH FROM CURRENT_DATE) - 3 AS INTEGER)
     END = fiscal_period AND CASE
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 3 = - 2
     THEN EXTRACT(YEAR FROM CURRENT_DATE) - 1
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 3 = - 1
     THEN EXTRACT(YEAR FROM CURRENT_DATE) - 1
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) - 3 = 0
     THEN EXTRACT(YEAR FROM CURRENT_DATE) - 1
     ELSE EXTRACT(YEAR FROM CURRENT_DATE)
     END = fiscal_year
  THEN 1
  ELSE 0
  END AS is_previous_fiscal_period_and_year_cd,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(MAX(dwh_updated_tmsp) AS TIMESTAMP), 'Europe/Berlin')) AS
  DATETIME) AS max_dwh_updated_tmsp
FROM ldl_dig_lec_share.v_agg_financial_period_summary_1
WHERE acct_data_src_name = 'EXT'
GROUP BY acct_data_src_name,
 fiscal_period,
 fiscal_year,
 current_fiscal_period,
 is_current_fiscal_period_and_year_cd,
 previous_fiscal_period,
 is_previous_fiscal_period_and_year_cd;