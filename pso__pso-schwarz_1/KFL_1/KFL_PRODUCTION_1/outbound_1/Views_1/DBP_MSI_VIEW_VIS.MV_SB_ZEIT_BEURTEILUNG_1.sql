CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sb_zeit_beurteilung_1 AS SELECT V01.zeit_stunde,
 v02.zeit_stunde_von,
 v02.zeit_stunde_bis2 AS zeit_stunde_bis,
 TIME(CAST(TRIM(CAST(v02.zeit_stunde_von AS STRING) || ':00:00') AS TIME)) AS sb_zeit_von,
 TIME(CAST(TRIM(CAST(v02.zeit_stunde_bis2 AS STRING) || ':59:59') AS TIME)) AS sb_zeit_bis,
    CAST(SUBSTR(SUBSTR(CAST(TIME(CAST(TRIM(CAST(v02.zeit_stunde_von AS STRING) || ':00:00') AS TIME)) AS STRING), 1, 8)
      , 1, 2) AS STRING) || ':00 - ' || CAST(SUBSTR(SUBSTR(CAST(TIME(CAST(TRIM(CAST(v02.zeit_stunde_bis2 AS STRING) ||
           ':00:00') AS TIME)) AS STRING), 1, 8), 1, 2) AS STRING) || ':59' AS sb_zeit_bez
FROM kfl_production_dbp_view.v_zeit_1 AS V01
 INNER JOIN (SELECT DISTINCT zeit_stunde_von,
   zeit_stunde_bis,
    CASE
    WHEN zeit_stunde_bis = 24
    THEN 23
    ELSE zeit_stunde_bis
    END AS zeit_stunde_bis2
  FROM kfl_production_dbp_view.v_sb_schwellwert_zeit_1) AS v02 ON V01.zeit_stunde BETWEEN v02.zeit_stunde_von AND v02.zeit_stunde_bis2
  
WHERE V01.zeit_minute = 0;