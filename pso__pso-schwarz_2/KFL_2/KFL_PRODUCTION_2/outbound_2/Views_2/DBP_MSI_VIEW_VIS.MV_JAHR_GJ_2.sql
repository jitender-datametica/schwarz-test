CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_jahr_gj_2 AS SELECT gj,
  gj - 1 AS gj_1,
 akt_gj,
 akt_gj_komplett,
  akt_gj + CASE
   WHEN EXTRACT(MONTH FROM DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) = 3
   THEN 1
   ELSE 0
   END AS akt_gj_mo,
  akt_gj_komplett + CASE
   WHEN EXTRACT(MONTH FROM DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) = 3
   THEN 1
   ELSE 0
   END AS akt_gj_mo_komplett,
 PARSE_DATE('%F', CAST(gj AS STRING) || '-03-01') AS dat_von,
 DATE_SUB(IF(PARSE_DATE('%F', SAFE_CAST(gj as STRING) || '-03-01') = LAST_DAY(PARSE_DATE('%F', SAFE_CAST(gj as STRING)
       || '-03-01')), LAST_DAY(DATE_ADD(PARSE_DATE('%F', SAFE_CAST(gj as STRING) || '-03-01'), INTERVAL 12 MONTH)),
   DATE_ADD(PARSE_DATE('%F', SAFE_CAST(gj as STRING) || '-03-01'), INTERVAL 12 MONTH)), INTERVAL 1 DAY) AS dat_bis,
  CASE
  WHEN DATE_SUB(IF(PARSE_DATE('%F', SAFE_CAST(gj as STRING) || '-03-01') = LAST_DAY(PARSE_DATE('%F', SAFE_CAST(gj as STRING)
         || '-03-01')), LAST_DAY(DATE_ADD(PARSE_DATE('%F', SAFE_CAST(gj as STRING) || '-03-01'), INTERVAL 12 MONTH)),
     DATE_ADD(PARSE_DATE('%F', SAFE_CAST(gj as STRING) || '-03-01'), INTERVAL 12 MONTH)), INTERVAL 1 DAY) > DATE_SUB(CURRENT_DATE
    ,INTERVAL 1 DAY)
  THEN DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
  ELSE DATE_SUB(IF(PARSE_DATE('%F', SAFE_CAST(gj as STRING) || '-03-01') = LAST_DAY(PARSE_DATE('%F', SAFE_CAST(gj as STRING)
        || '-03-01')), LAST_DAY(DATE_ADD(PARSE_DATE('%F', SAFE_CAST(gj as STRING) || '-03-01'), INTERVAL 12 MONTH)),
    DATE_ADD(PARSE_DATE('%F', SAFE_CAST(gj as STRING) || '-03-01'), INTERVAL 12 MONTH)), INTERVAL 1 DAY)
  END AS dat_bis_heute,
 DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) AS h0,
  CASE
  WHEN EXTRACT(MONTH FROM DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) = 3
  THEN 1
  ELSE 0
  END AS mo_fg,
  'GJ ' || CAST(TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) AS STRING) AS gj_bez,
  'GJ ' || CAST(TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) AS STRING) AS gj_bez_de,
  'GJ ' || CAST(TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) AS STRING) AS gj_bez_cz,
  'GJ ' || CAST(TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) AS STRING) AS gj_bez_sk,
  'PG ' || CAST(TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) AS STRING) AS gj_bez_hr,
  'RO ' || CAST(TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) AS STRING) AS gj_bez_pl,
  'AF ' || CAST(TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) AS STRING) AS gj_bez_ro,
  'ФГ ' || CAST(TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) AS STRING) AS gj_bez_bg,
   'GJ ' || TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) || ' aufg.' AS gj_bez_aufg,
   'GJ ' || TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) || ' aufg.' AS gj_bez_aufg_de,
   'GJ ' || TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) || ' kum.' AS gj_bez_aufg_cz,
   'GJ ' || TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) || ' kum.' AS gj_bez_aufg_sk,
   'PG ' || TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) || ' kum.' AS gj_bez_aufg_hr,
   'RO ' || TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) || ' skum.' AS gj_bez_aufg_pl,
   'AF ' || TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) || ' cum.' AS gj_bez_aufg_ro,
   'ФГ ' || TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) || ' кум.' AS gj_bez_aufg_bg,
 'GJ aufg.' AS gj_kbez_aufg,
 'GJ aufg.' AS gj_kbez_aufg_de,
 'GJ kum.' AS gj_kbez_aufg_cz,
 'GJ kum.' AS gj_kbez_aufg_sk,
 'PG kum.' AS gj_kbez_aufg_hr,
 'RO skum.' AS gj_kbez_aufg_pl,
 'AF cum.' AS gj_kbez_aufg_ro,
 'ФГ кум.' AS gj_kbez_aufg_bg,
   'GJ ' || TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) || ' akt.' AS gj_bez_akt,
   'GJ ' || TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) || ' akt.' AS gj_bez_akt_de,
   'GJ ' || TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) || ' akt.' AS gj_bez_akt_cz,
   'GJ ' || TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) || ' akt.' AS gj_bez_akt_sk,
   'PG ' || TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) || ' akt.' AS gj_bez_akt_hr,
   'RO ' || TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) || ' akt.' AS gj_bez_akt_pl,
   'AF ' || TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) || ' act.' AS gj_bez_akt_ro,
   'ФГ ' || TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) || ' акт.' AS gj_bez_akt_bg,
 'GJ akt.' AS gj_kbez_akt,
 'GJ akt.' AS gj_kbez_akt_de,
 'GJ akt.' AS gj_kbez_akt_cz,
 'GJ akt.' AS gj_kbez_akt_sk,
 'PG akt.' AS gj_kbez_akt_hr,
 'RO akt.' AS gj_kbez_akt_pl,
 'AF act.' AS gj_kbez_akt_ro,
 'ФГ акт.' AS gj_kbez_akt_bg
FROM kfl_production_dbp_view.v_jahr_gj_2 AS JGJ;