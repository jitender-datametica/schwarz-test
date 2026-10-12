CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_jahr_gj_2 AS SELECT JG.gj,
 JG1.gj AS gj_1,
 JG.akt_gj,
 JG.akt_gj_komplett,
 PARSE_DATE('%F', CAST(JG.gj AS STRING) || '-03-01') AS dat_von,
 DATE_SUB(IF(PARSE_DATE('%F', SAFE_CAST(JG.gj as STRING) || '-03-01') = LAST_DAY(PARSE_DATE('%F', SAFE_CAST(JG.gj as STRING)
       || '-03-01')), LAST_DAY(DATE_ADD(PARSE_DATE('%F', SAFE_CAST(JG.gj as STRING) || '-03-01'), INTERVAL 12 MONTH)),
   DATE_ADD(PARSE_DATE('%F', SAFE_CAST(JG.gj as STRING) || '-03-01'), INTERVAL 12 MONTH)), INTERVAL 1 DAY) AS dat_bis,
  CASE
  WHEN DATE_SUB(IF(PARSE_DATE('%F', SAFE_CAST(JG.gj as STRING) || '-03-01') = LAST_DAY(PARSE_DATE('%F', SAFE_CAST(JG.gj
          as STRING) || '-03-01')), LAST_DAY(DATE_ADD(PARSE_DATE('%F', SAFE_CAST(JG.gj as STRING) || '-03-01'), INTERVAL
       12 MONTH)), DATE_ADD(PARSE_DATE('%F', SAFE_CAST(JG.gj as STRING) || '-03-01'), INTERVAL 12 MONTH)), INTERVAL 1
    DAY) > CURRENT_DATE
  THEN CURRENT_DATE
  ELSE DATE_SUB(IF(PARSE_DATE('%F', SAFE_CAST(JG.gj as STRING) || '-03-01') = LAST_DAY(PARSE_DATE('%F', SAFE_CAST(JG.gj
         as STRING) || '-03-01')), LAST_DAY(DATE_ADD(PARSE_DATE('%F', SAFE_CAST(JG.gj as STRING) || '-03-01'), INTERVAL
      12 MONTH)), DATE_ADD(PARSE_DATE('%F', SAFE_CAST(JG.gj as STRING) || '-03-01'), INTERVAL 12 MONTH)), INTERVAL 1 DAY
   )
  END AS dat_bis_heute,
  'GJ ' || CAST(TRIM(SUBSTR(CAST(JG.gj AS STRING), 1, 39)) AS STRING) AS gj_bez,
  'GJ ' || CAST(TRIM(SUBSTR(CAST(JG.gj AS STRING), 1, 39)) AS STRING) AS gj_bez_de,
  'GJ ' || CAST(TRIM(SUBSTR(CAST(JG.gj AS STRING), 1, 39)) AS STRING) AS gj_bez_cz,
  'RO ' || CAST(TRIM(SUBSTR(CAST(JG.gj AS STRING), 1, 39)) AS STRING) AS gj_bez_pl,
  'GJ ' || CAST(TRIM(SUBSTR(CAST(JG.gj AS STRING), 1, 39)) AS STRING) AS gj_bez_sk,
  'PG ' || CAST(TRIM(SUBSTR(CAST(JG.gj AS STRING), 1, 39)) AS STRING) AS gj_bez_hr,
  'AF ' || CAST(TRIM(SUBSTR(CAST(JG.gj AS STRING), 1, 39)) AS STRING) AS gj_bez_ro,
  'PG ' || CAST(TRIM(SUBSTR(CAST(JG.gj AS STRING), 1, 39)) AS STRING) AS gj_bez_bg,
   'GJ ' || TRIM(SUBSTR(CAST(JG.gj AS STRING), 1, 39)) || ' aufg.' AS gj_bez_aufg,
   'GJ ' || TRIM(SUBSTR(CAST(JG.gj AS STRING), 1, 39)) || ' aufg.' AS gj_bez_aufg_de,
   'GJ ' || TRIM(SUBSTR(CAST(JG.gj AS STRING), 1, 39)) || ' kum.' AS gj_bez_aufg_cz,
   'RO ' || TRIM(SUBSTR(CAST(JG.gj AS STRING), 1, 39)) || ' skum.' AS gj_bez_aufg_pl,
   'GJ ' || TRIM(SUBSTR(CAST(JG.gj AS STRING), 1, 39)) || ' kum.' AS gj_bez_aufg_sk,
   'PG ' || TRIM(SUBSTR(CAST(JG.gj AS STRING), 1, 39)) || ' kum.' AS gj_bez_aufg_hr,
   'AF ' || TRIM(SUBSTR(CAST(JG.gj AS STRING), 1, 39)) || ' cum.' AS gj_bez_aufg_ro,
   'PG ' || TRIM(SUBSTR(CAST(JG.gj AS STRING), 1, 39)) || ' kum.' AS gj_bez_aufg_bg
FROM kfl_production_dbp_view.v_jahr_gj_2 AS JG
 INNER JOIN kfl_production_dbp_view.v_jahr_gj_2 AS JG1 ON JG.gj = JG1.gj + 1;