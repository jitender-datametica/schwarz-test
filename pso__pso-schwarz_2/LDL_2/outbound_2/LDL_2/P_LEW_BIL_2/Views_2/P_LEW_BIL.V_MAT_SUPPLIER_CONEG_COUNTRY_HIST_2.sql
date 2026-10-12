/* #DescStart#
* Jens Thole (c) 05.07.2018
* Erstellung der historisierten Zielstruktur, die nun nur noch Suppliergranular ist. Die vorher im Core vorhandenen Granularität (SUP, CONEG-COUNTRY_2)
* wird projiziert auf den Supplier_2, indem die in jedem Zeitintervall vorkommenden Kombinationen als Liste erstellt wird.
* Zudem, werden die ersten 10 EKS-Nummern in Feldern pivotiert.
*
* Es wird der in V_MAT0 gebildete Schalter MAP_TYPE (MULTIPLE|UNIQUE|NOT RELEVANT) benutzt 
,* um die Verarbeitung zu splitten und die aufwendige Listenbildung nur für die Zeilen durchzuführen, die dies auch benötigen.
* So kann der Prozeß viel leichtgewichtiger bzgl CPU-LAst aufgebaut werden.
*
* Yucel Cesmeli 19.09.2021
* Teradata Normalize function has been adapted to Snowflake by using Window functions.
#DescEnd#
**************************************************************************************** */
CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat_supplier_coneg_country_hist_2 AS
-- TODO: check if one day has to be substracted (PERIOD datatype makes last day exclusive)
 SELECT client_id,
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
 DATE_ADD(MIN(schnitt_peri_start), INTERVAL 1 DAY) AS dwh_valid_from,
 MAX(schnitt_peri_end) AS dwh_valid_to,
  CASE
  WHEN CURRENT_DATE BETWEEN DATE_ADD(MIN(schnitt_peri_start), INTERVAL 1 DAY) AND (MAX(schnitt_peri_end))
  THEN 1
  ELSE 0
  END AS dwh_actual_fg
FROM (SELECT client_id,
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
   SUM(groupstartflag) OVER (PARTITION BY CAST(client_id AS STRING), CAST(sup_sid AS STRING), country_sid_conegot_list,
      country_cd_conegot_list, CAST(country_sid_conegot_list_01 AS STRING), country_cd_conegot_list_01, CAST(country_sid_conegot_list_02 AS STRING)
      , country_cd_conegot_list_02, CAST(country_sid_conegot_list_03 AS STRING), country_cd_conegot_list_03, CAST(country_sid_conegot_list_04 AS STRING)
      , country_cd_conegot_list_04, CAST(country_sid_conegot_list_05 AS STRING), country_cd_conegot_list_05, CAST(country_sid_conegot_list_06 AS STRING)
      , country_cd_conegot_list_06, CAST(country_sid_conegot_list_07 AS STRING), country_cd_conegot_list_07, CAST(country_sid_conegot_list_08 AS STRING)
      , country_cd_conegot_list_08, CAST(country_sid_conegot_list_09 AS STRING), country_cd_conegot_list_09, CAST(country_sid_conegot_list_10 AS STRING)
      , country_cd_conegot_list_10, CAST(deleted_fg AS STRING) ORDER BY schnitt_peri_start IS NULL, schnitt_peri_start,
      schnitt_peri_end IS NULL, schnitt_peri_end ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS groupid,
   schnitt_peri_start,
   schnitt_peri_end
  FROM (SELECT client_id,
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
     schnitt_peri_start,
     schnitt_peri_end,
      CASE
      WHEN schnitt_peri_start <= IFNULL(LAG(schnitt_peri_end) OVER (PARTITION BY CAST(client_id AS STRING), CAST(sup_sid AS STRING)
           , country_sid_conegot_list, country_cd_conegot_list, CAST(country_sid_conegot_list_01 AS STRING),
           country_cd_conegot_list_01, CAST(country_sid_conegot_list_02 AS STRING), country_cd_conegot_list_02, CAST(country_sid_conegot_list_03 AS STRING)
           , country_cd_conegot_list_03, CAST(country_sid_conegot_list_04 AS STRING), country_cd_conegot_list_04, CAST(country_sid_conegot_list_05 AS STRING)
           , country_cd_conegot_list_05, CAST(country_sid_conegot_list_06 AS STRING), country_cd_conegot_list_06, CAST(country_sid_conegot_list_07 AS STRING)
           , country_cd_conegot_list_07, CAST(country_sid_conegot_list_08 AS STRING), country_cd_conegot_list_08, CAST(country_sid_conegot_list_09 AS STRING)
           , country_cd_conegot_list_09, CAST(country_sid_conegot_list_10 AS STRING), country_cd_conegot_list_10, CAST(deleted_fg AS STRING)
           ORDER BY schnitt_peri_start IS NULL, schnitt_peri_start, schnitt_peri_end IS NULL, schnitt_peri_end),
        schnitt_peri_end)
      THEN 0
      ELSE 1
      END AS groupstartflag
    FROM (SELECT client_id,
        sup_sid,
        NULLIF(country_sid_conegot_list, '') AS country_sid_conegot_list,
        NULLIF(country_cd_conegot_list, '') AS country_cd_conegot_list,
        IF(ROUND(CAST(REGEXP_EXTRACT_ALL(',' || country_sid_conegot_list, '[^,]+')[SAFE_OFFSET(0)] AS BIGNUMERIC), 0) =
          0, NULL, ROUND(CAST(REGEXP_EXTRACT_ALL(',' || country_sid_conegot_list, '[^,]+')[SAFE_OFFSET(0)] AS BIGNUMERIC)
          , 0)) AS country_sid_conegot_list_01,
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
        schnitt_peri_start,
        schnitt_peri_end
       FROM (SELECT client_id,
          sup_sid,
          LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(STRING_AGG(TRIM(country_sid_conegot_vc) || ',' ORDER BY order_crit IS NULL
                 , order_crit), ' ', ''), ',,', ','), ',,', ','), ','), ',') AS country_sid_conegot_list,
          LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(STRING_AGG(TRIM(country_cd_conegot_vc) || ',' ORDER BY order_crit IS NULL
                 , order_crit), ' ', ''), ',,', ','), ',,', ','), ','), ',') AS country_cd_conegot_list,
           CASE
           WHEN NULLIF(LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(STRING_AGG(TRIM(country_sid_conegot_vc) || ',' ORDER BY
                   order_crit IS NULL, order_crit), ' ', ''), ',,', ','), ',,', ','), ','), ','), '') IS NULL
           THEN 1
           ELSE MIN(deleted_fg)
           END AS deleted_fg,
          schnitt_peri_start,
          schnitt_peri_end
         FROM ldl_p_lew_bil.v_mat0_supplier_coneg_country_hist_2
         WHERE map_type = 'MULTIPLE'
         GROUP BY client_id,
          sup_sid,
          schnitt_peri_start,
          schnitt_peri_end) AS multi_rows
       UNION ALL
       SELECT client_id,
        sup_sid,
        NULLIF(country_sid_conegot_vc, '') AS country_sid_conegot_list,
        NULLIF(country_cd_conegot_vc, '') AS country_cd_conegot_list,
        IF(ROUND(SAFE_CAST(country_sid_conegot_vc AS BIGNUMERIC), 0) = 0, NULL, ROUND(SAFE_CAST(country_sid_conegot_vc
           AS BIGNUMERIC), 0)) AS country_sid_conegot_list_01,
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
        schnitt_peri_start,
        schnitt_peri_end
       FROM ldl_p_lew_bil.v_mat0_supplier_coneg_country_hist_2 AS UNQ_ROWS
       WHERE map_type = 'UNIQUE') AS all_rows) AS all_rows_norm) AS tmprl_schrumpf
GROUP BY client_id,
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
 groupid
HAVING DATE_DIFF(dwh_valid_to, DATE_ADD(MIN(schnitt_peri_start), INTERVAL 1 DAY), DAY) <> 2958462 OR deleted_fg <> 1;