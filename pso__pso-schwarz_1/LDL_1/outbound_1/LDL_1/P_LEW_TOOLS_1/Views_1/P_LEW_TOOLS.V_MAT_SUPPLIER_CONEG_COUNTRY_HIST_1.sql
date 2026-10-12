CREATE OR REPLACE VIEW ldl_p_lew_tools.v_mat_supplier_coneg_country_hist_1 AS SELECT client_id,
 sup_sid,
 country_sid_conegot_list,
 country_cd_conegot_list,
 country_sid_conegot_list_01,
 country_cd_conegot_list_01,
 country_sid_conegot_list_02,
 country_cd_conegot_list_02,
 country_sid_conegot_list_03,
 country_cd_conegot_list_03,
 country_sid_conegot_list_04,
 country_cd_conegot_list_04,
 country_sid_conegot_list_05,
 country_cd_conegot_list_05,
 country_sid_conegot_list_06,
 country_cd_conegot_list_06,
 country_sid_conegot_list_07,
 country_cd_conegot_list_07,
 country_sid_conegot_list_08,
 country_cd_conegot_list_08,
 country_sid_conegot_list_09,
 country_cd_conegot_list_09,
 country_sid_conegot_list_10,
 country_cd_conegot_list_10,
 deleted_fg,
 DATE(SUBSTR(peri, 1, 10)) AS dwh_valid_from,
 DATE(SUBSTR(peri, 12, 10)) AS dwh_valid_to,
  CASE
  WHEN CURRENT_DATE BETWEEN DATE(SUBSTR(peri, 1, 10)) AND (DATE(SUBSTR(peri, 12, 10)))
  THEN 1
  ELSE 0
  END AS dwh_actual_fg
FROM (SELECT client_id,
    sup_sid,
    NULLIF(country_sid_conegot_list, '') AS country_sid_conegot_list,
    NULLIF(country_cd_conegot_list, '') AS country_cd_conegot_list,
     CASE
     WHEN ROUND(CAST(REGEXP_EXTRACT_ALL(',' || country_sid_conegot_list, '[^,]+')[SAFE_OFFSET(0)] AS BIGNUMERIC), 0) = 0
      
     THEN NULL
     ELSE ROUND(CAST(REGEXP_EXTRACT_ALL(',' || country_sid_conegot_list, '[^,]+')[SAFE_OFFSET(0)] AS BIGNUMERIC), 0)
     END AS country_sid_conegot_list_01,
    NULLIF(REGEXP_EXTRACT_ALL(',' || country_cd_conegot_list, '[^,]+')[SAFE_OFFSET(0)], '') AS
    country_cd_conegot_list_01,
    ROUND(CAST(REGEXP_EXTRACT_ALL(',' || country_sid_conegot_list, '[^,]+')[SAFE_OFFSET(1)] AS BIGNUMERIC), 0) AS
    country_sid_conegot_list_02,
    REGEXP_EXTRACT_ALL(',' || country_cd_conegot_list, '[^,]+')[SAFE_OFFSET(1)] AS country_cd_conegot_list_02,
    ROUND(CAST(REGEXP_EXTRACT_ALL(',' || country_sid_conegot_list, '[^,]+')[SAFE_OFFSET(2)] AS BIGNUMERIC), 0) AS
    country_sid_conegot_list_03,
    REGEXP_EXTRACT_ALL(',' || country_cd_conegot_list, '[^,]+')[SAFE_OFFSET(2)] AS country_cd_conegot_list_03,
    ROUND(CAST(REGEXP_EXTRACT_ALL(',' || country_sid_conegot_list, '[^,]+')[SAFE_OFFSET(3)] AS BIGNUMERIC), 0) AS
    country_sid_conegot_list_04,
    REGEXP_EXTRACT_ALL(',' || country_cd_conegot_list, '[^,]+')[SAFE_OFFSET(3)] AS country_cd_conegot_list_04,
    ROUND(CAST(REGEXP_EXTRACT_ALL(',' || country_sid_conegot_list, '[^,]+')[SAFE_OFFSET(4)] AS BIGNUMERIC), 0) AS
    country_sid_conegot_list_05,
    REGEXP_EXTRACT_ALL(',' || country_cd_conegot_list, '[^,]+')[SAFE_OFFSET(4)] AS country_cd_conegot_list_05,
    ROUND(CAST(REGEXP_EXTRACT_ALL(',' || country_sid_conegot_list, '[^,]+')[SAFE_OFFSET(5)] AS BIGNUMERIC), 0) AS
    country_sid_conegot_list_06,
    REGEXP_EXTRACT_ALL(',' || country_cd_conegot_list, '[^,]+')[SAFE_OFFSET(5)] AS country_cd_conegot_list_06,
    ROUND(CAST(REGEXP_EXTRACT_ALL(',' || country_sid_conegot_list, '[^,]+')[SAFE_OFFSET(6)] AS BIGNUMERIC), 0) AS
    country_sid_conegot_list_07,
    REGEXP_EXTRACT_ALL(',' || country_cd_conegot_list, '[^,]+')[SAFE_OFFSET(6)] AS country_cd_conegot_list_07,
    ROUND(CAST(REGEXP_EXTRACT_ALL(',' || country_sid_conegot_list, '[^,]+')[SAFE_OFFSET(7)] AS BIGNUMERIC), 0) AS
    country_sid_conegot_list_08,
    REGEXP_EXTRACT_ALL(',' || country_cd_conegot_list, '[^,]+')[SAFE_OFFSET(7)] AS country_cd_conegot_list_08,
    ROUND(CAST(REGEXP_EXTRACT_ALL(',' || country_sid_conegot_list, '[^,]+')[SAFE_OFFSET(8)] AS BIGNUMERIC), 0) AS
    country_sid_conegot_list_09,
    REGEXP_EXTRACT_ALL(',' || country_cd_conegot_list, '[^,]+')[SAFE_OFFSET(8)] AS country_cd_conegot_list_09,
    ROUND(CAST(REGEXP_EXTRACT_ALL(',' || country_sid_conegot_list, '[^,]+')[SAFE_OFFSET(9)] AS BIGNUMERIC), 0) AS
    country_sid_conegot_list_10,
    REGEXP_EXTRACT_ALL(',' || country_cd_conegot_list, '[^,]+')[SAFE_OFFSET(9)] AS country_cd_conegot_list_10,
    deleted_fg,
    peri
   FROM (SELECT client_id,
      sup_sid,
      REPLACE(TRIM(STRING_AGG(country_sid_conegot_vc || ',' ORDER BY order_crit IS NULL, order_crit)), ' ', '') AS
      country_sid_conegot_list,
      REPLACE(TRIM(STRING_AGG(country_cd_conegot_vc || ',' ORDER BY order_crit IS NULL, order_crit)), ' ', '') AS
      country_cd_conegot_list,
       CASE
       WHEN NULLIF(REPLACE(TRIM(STRING_AGG(country_sid_conegot_vc || ',' ORDER BY order_crit IS NULL, order_crit)), ' '
         , ''), '') IS NULL
       THEN 1
       ELSE MIN(deleted_fg)
       END AS deleted_fg,
      peri
     FROM ldl_p_lew_tools.v_mat0_supplier_coneg_country_hist_1
     WHERE map_type = 'MULTIPLE'
     GROUP BY client_id,
      sup_sid,
      peri) AS multi_rows
   UNION ALL
   SELECT client_id,
    sup_sid,
    NULLIF(country_sid_conegot_vc, '') AS country_sid_conegot_list,
    NULLIF(country_cd_conegot_vc, '') AS country_cd_conegot_list,
     CASE
     WHEN ROUND(CAST(country_sid_conegot_vc AS BIGNUMERIC), 0) = 0
     THEN NULL
     ELSE ROUND(CAST(country_sid_conegot_vc AS BIGNUMERIC), 0)
     END AS country_sid_conegot_list_01,
    NULLIF(CAST(country_cd_conegot_vc AS STRING), '') AS country_cd_conegot_list_01,
    CAST(NULL AS BIGNUMERIC) AS country_sid_conegot_list_02,
    CAST(NULL AS STRING) AS country_cd_conegot_list_02,
    CAST(NULL AS BIGNUMERIC) AS country_sid_conegot_list_03,
    CAST(NULL AS STRING) AS country_cd_conegot_list_03,
    CAST(NULL AS BIGNUMERIC) AS country_sid_conegot_list_04,
    CAST(NULL AS STRING) AS country_cd_conegot_list_04,
    CAST(NULL AS BIGNUMERIC) AS country_sid_conegot_list_05,
    CAST(NULL AS STRING) AS country_cd_conegot_list_05,
    CAST(NULL AS BIGNUMERIC) AS country_sid_conegot_list_06,
    CAST(NULL AS STRING) AS country_cd_conegot_list_06,
    CAST(NULL AS BIGNUMERIC) AS country_sid_conegot_list_07,
    CAST(NULL AS STRING) AS country_cd_conegot_list_07,
    CAST(NULL AS BIGNUMERIC) AS country_sid_conegot_list_08,
    CAST(NULL AS STRING) AS country_cd_conegot_list_08,
    CAST(NULL AS BIGNUMERIC) AS country_sid_conegot_list_09,
    CAST(NULL AS STRING) AS country_cd_conegot_list_09,
    CAST(NULL AS BIGNUMERIC) AS country_sid_conegot_list_10,
    CAST(NULL AS STRING) AS country_cd_conegot_list_10,
     CASE
     WHEN NULLIF(country_sid_conegot_vc, '') IS NULL
     THEN 1
     ELSE deleted_fg
     END AS deleted_fg,
    peri
   FROM ldl_p_lew_tools.v_mat0_supplier_coneg_country_hist_1 AS UNQ_ROWS
   WHERE map_type = 'UNIQUE') AS tmprl_schrumpf
WHERE DATE_DIFF(DATE(SUBSTR(peri, 12, 10)), DATE(SUBSTR(peri, 1, 10)), DAY) <> 2958462
 OR deleted_fg <> 1;