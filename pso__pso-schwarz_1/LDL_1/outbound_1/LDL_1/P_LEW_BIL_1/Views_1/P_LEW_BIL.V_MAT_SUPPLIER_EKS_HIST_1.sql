/* * Jens Thole (c) 05.07.2018
* Erstellung der historisierten Zielstruktur, die nun nur noch Suppliergranular ist. die vorher im Core vorhandenen Granularität (SUP, EKS)
* wird projiziert auf den Supplier_1, indem die in jedem Zeitintervall vorkommenden Kombinationen als Liste erstellt weird.
* Zudem, werden die ersten 10 EKS-Nummern in Feldern pivotiert.
*
* Es wird der in V_MAT0 gebildete Schalter MAP_TYPE (MULTIPLE|UNIQUE|NOT RELEVANT) benutzt ,
* um die Verarbeitung zu splitten und die aufwendige Listenbildung nur für die Zeilen durchzuführen, die dies auch benötigen.
* So kann der Prozeß viel leichtgewichtiger bzgl CPU-LAst aufgebaut werden.
**************************************************************************************** */
CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat_supplier_eks_hist_1 AS
-- TODO: check if one day has to be substracted (PERIOD datatype makes last day exclusive)                ..
 SELECT
 client_id,
 sup_sid,
 eks_no_list,
 eks_no_01,
 eks_no_02,
 eks_no_03,
 eks_no_04,
 eks_no_05,
 eks_no_06,
 eks_no_07,
 eks_no_08,
 eks_no_09,
 eks_no_10,
 deleted_fg,
 DATE_ADD(schnitt_peri_start, INTERVAL 1 DAY) AS dwh_valid_from,
 schnitt_peri_end AS dwh_valid_to,
  CASE
  WHEN CURRENT_DATE BETWEEN DATE_ADD(schnitt_peri_start, INTERVAL 1 DAY) AND schnitt_peri_end
  THEN 1
  ELSE 0
  END AS dwh_actual_fg
FROM (SELECT client_id,
   sup_sid,
   eks_no_list,
   eks_no_01,
   eks_no_02,
   eks_no_03,
   eks_no_04,
   eks_no_05,
   eks_no_06,
   eks_no_07,
   eks_no_08,
   eks_no_09,
   eks_no_10,
   deleted_fg,
   MIN(schnitt_peri_start) AS schnitt_peri_start,
   MAX(schnitt_peri_end) AS schnitt_peri_end
  FROM (SELECT client_id,
     sup_sid,
     eks_no_list,
     eks_no_01,
     eks_no_02,
     eks_no_03,
     eks_no_04,
     eks_no_05,
     eks_no_06,
     eks_no_07,
     eks_no_08,
     eks_no_09,
     eks_no_10,
     deleted_fg,
     SUM(group_start_flag) OVER (PARTITION BY CAST(client_id AS STRING), CAST(sup_sid AS STRING), eks_no_list, CAST(eks_no_01 AS STRING)
        , CAST(eks_no_02 AS STRING), CAST(eks_no_03 AS STRING), CAST(eks_no_04 AS STRING), CAST(eks_no_05 AS STRING), CAST(eks_no_06 AS STRING)
        , CAST(eks_no_07 AS STRING), CAST(eks_no_08 AS STRING), CAST(eks_no_09 AS STRING), CAST(eks_no_10 AS STRING), CAST(deleted_fg AS STRING)
        ORDER BY schnitt_peri_start IS NULL, schnitt_peri_start ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
     group_id,
     schnitt_peri_start,
     schnitt_peri_end
    FROM (SELECT client_id,
       sup_sid,
       eks_no_list,
       eks_no_01,
       eks_no_02,
       eks_no_03,
       eks_no_04,
       eks_no_05,
       eks_no_06,
       eks_no_07,
       eks_no_08,
       eks_no_09,
       eks_no_10,
       deleted_fg,
       schnitt_peri_start,
       schnitt_peri_end,
        CASE
        WHEN schnitt_peri_start <= (LAG(schnitt_peri_end) OVER (PARTITION BY CAST(client_id AS STRING), CAST(sup_sid AS STRING)
             , eks_no_list, CAST(eks_no_01 AS STRING), CAST(eks_no_02 AS STRING), CAST(eks_no_03 AS STRING), CAST(eks_no_04 AS STRING)
             , CAST(eks_no_05 AS STRING), CAST(eks_no_06 AS STRING), CAST(eks_no_07 AS STRING), CAST(eks_no_08 AS STRING)
             , CAST(eks_no_09 AS STRING), CAST(eks_no_10 AS STRING), CAST(deleted_fg AS STRING) ORDER BY
             schnitt_peri_start IS NULL, schnitt_peri_start, schnitt_peri_end IS NULL, schnitt_peri_end))
        THEN 0
        ELSE 1
        END AS group_start_flag
      FROM (SELECT client_id,
          sup_sid,
          eks_no_list,
          IF(ROUND(CAST(REGEXP_EXTRACT_ALL(',' || eks_no_list, '[^,]+')[SAFE_OFFSET(0)] AS BIGNUMERIC), 0) = 0, NULL,
           ROUND(CAST(REGEXP_EXTRACT_ALL(',' || eks_no_list, '[^,]+')[SAFE_OFFSET(0)] AS BIGNUMERIC), 0)) AS eks_no_01,
          ROUND(CAST(REGEXP_EXTRACT_ALL(',' || eks_no_list, '[^,]+')[SAFE_OFFSET(1)] AS BIGNUMERIC), 0) AS eks_no_02,
          ROUND(CAST(REGEXP_EXTRACT_ALL(',' || eks_no_list, '[^,]+')[SAFE_OFFSET(2)] AS BIGNUMERIC), 0) AS eks_no_03,
          ROUND(CAST(REGEXP_EXTRACT_ALL(',' || eks_no_list, '[^,]+')[SAFE_OFFSET(3)] AS BIGNUMERIC), 0) AS eks_no_04,
          ROUND(CAST(REGEXP_EXTRACT_ALL(',' || eks_no_list, '[^,]+')[SAFE_OFFSET(4)] AS BIGNUMERIC), 0) AS eks_no_05,
          ROUND(CAST(REGEXP_EXTRACT_ALL(',' || eks_no_list, '[^,]+')[SAFE_OFFSET(5)] AS BIGNUMERIC), 0) AS eks_no_06,
          ROUND(CAST(REGEXP_EXTRACT_ALL(',' || eks_no_list, '[^,]+')[SAFE_OFFSET(6)] AS BIGNUMERIC), 0) AS eks_no_07,
          ROUND(CAST(REGEXP_EXTRACT_ALL(',' || eks_no_list, '[^,]+')[SAFE_OFFSET(7)] AS BIGNUMERIC), 0) AS eks_no_08,
          ROUND(CAST(REGEXP_EXTRACT_ALL(',' || eks_no_list, '[^,]+')[SAFE_OFFSET(8)] AS BIGNUMERIC), 0) AS eks_no_09,
          ROUND(CAST(REGEXP_EXTRACT_ALL(',' || eks_no_list, '[^,]+')[SAFE_OFFSET(9)] AS BIGNUMERIC), 0) AS eks_no_10,
          deleted_fg,
          schnitt_peri_start,
          schnitt_peri_end
         FROM (SELECT client_id,
            sup_sid,
            LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(STRING_AGG(TRIM(eks_vc) || ','), ' ', ''), ',,', ','), ',,', ','), ',')
             , ',') AS eks_no_list,
            MIN(deleted_fg) AS deleted_fg,
            schnitt_peri_start,
            schnitt_peri_end
           FROM ldl_p_lew_bil.v_mat0_supplier_eks_hist_1
           WHERE map_type = 'MULTIPLE'
           GROUP BY client_id,
            sup_sid,
            schnitt_peri_start,
            schnitt_peri_end) AS multi_rows
         UNION ALL
         SELECT client_id,
          sup_sid,
          CAST(NULLIF(eks_vc, '') AS STRING) AS eks_no_list,
          IF(ROUND(SAFE_CAST(eks_vc AS BIGNUMERIC), 0) = 0, NULL, ROUND(SAFE_CAST(eks_vc AS BIGNUMERIC), 0)) AS
          eks_no_01,
          CAST(NULL AS BIGNUMERIC) AS eks_no_02,
          CAST(NULL AS BIGNUMERIC) AS eks_no_03,
          CAST(NULL AS BIGNUMERIC) AS eks_no_04,
          CAST(NULL AS BIGNUMERIC) AS eks_no_05,
          CAST(NULL AS BIGNUMERIC) AS eks_no_06,
          CAST(NULL AS BIGNUMERIC) AS eks_no_07,
          CAST(NULL AS BIGNUMERIC) AS eks_no_08,
          CAST(NULL AS BIGNUMERIC) AS eks_no_09,
          CAST(NULL AS BIGNUMERIC) AS eks_no_10,
           CASE
           WHEN NULLIF(eks_vc, '') IS NULL
           THEN 1
           ELSE deleted_fg
           END AS deleted_fg,
          schnitt_peri_start,
          schnitt_peri_end
         FROM ldl_p_lew_bil.v_mat0_supplier_eks_hist_1 AS UNQ_ROWS
         WHERE map_type = 'UNIQUE') AS g1) AS g2) AS g3
  GROUP BY client_id,
   sup_sid,
   eks_no_list,
   eks_no_01,
   eks_no_02,
   eks_no_03,
   eks_no_04,
   eks_no_05,
   eks_no_06,
   eks_no_07,
   eks_no_08,
   eks_no_09,
   eks_no_10,
   deleted_fg,
   group_id) AS tmprl_schrumpf
WHERE DATE_DIFF(schnitt_peri_end, DATE_ADD(schnitt_peri_start, INTERVAL 1 DAY), DAY) <> 2958462
 OR deleted_fg <> 1;