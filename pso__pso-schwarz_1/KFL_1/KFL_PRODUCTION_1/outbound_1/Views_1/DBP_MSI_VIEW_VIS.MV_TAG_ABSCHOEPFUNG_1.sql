CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_tag_abschoepfung_1 AS SELECT akt_tag AS sort_id,
 dat AS dat_von,
 dat AS dat_bis,
       CAST(CASE
         WHEN wtag_id = 1
         THEN 'Mo'
         WHEN wtag_id = 2
         THEN 'Di'
         WHEN wtag_id = 3
         THEN 'Mi'
         WHEN wtag_id = 4
         THEN 'Do'
         WHEN wtag_id = 5
         THEN 'Fr'
         WHEN wtag_id = 6
         THEN 'Sa'
         WHEN wtag_id = 7
         THEN 'So'
         ELSE ''
         END AS STRING) || ' ' || CAST(EXTRACT(DAY FROM dat) AS STRING FORMAT '00') || '.' || CAST(EXTRACT(MONTH FROM dat) AS STRING FORMAT '00')
     || '.' || CAST(CAST(EXTRACT(YEAR FROM dat) AS STRING FORMAT '0000') AS STRING) AS dat_bez
FROM kfl_production_dbp_view.v_tag_1
WHERE akt_tag BETWEEN - 6 AND 0
UNION ALL
SELECT 1 AS sort_id,
 MIN(dat) AS dat_von,
 MAX(dat) AS dat_bis,
 'Trend' AS dat_bez
FROM kfl_production_dbp_view.v_tag_1
WHERE akt_tag BETWEEN - 6 AND (- 0)
UNION ALL
SELECT 11 AS sort_id,
 MIN(dat) AS dat_von,
 MAX(dat) AS dat_bis,
          'Woche_1 ' || CAST(EXTRACT(DAY FROM MIN(dat)) AS STRING FORMAT '00') || '.' || CAST(EXTRACT(MONTH FROM MIN(dat)) AS STRING FORMAT '00')
         || '. - ' || CAST(EXTRACT(DAY FROM MAX(dat)) AS STRING FORMAT '00') || '.' || CAST(EXTRACT(MONTH FROM MAX(dat)) AS STRING FORMAT '00')
     || '.' || CAST(EXTRACT(YEAR FROM MAX(dat)) AS STRING FORMAT '0000') AS dat_bez
FROM kfl_production_dbp_view.v_tag_1
WHERE akt_tag BETWEEN - 6 AND 0
UNION ALL
SELECT 22 AS sort_id,
 MIN(dat) AS dat_von,
 MAX(dat) AS dat_bis,
          'Monat_1 aufg. ' || CAST(EXTRACT(DAY FROM MIN(dat)) AS STRING FORMAT '00') || '.' || CAST(EXTRACT(MONTH FROM MIN(dat)) AS STRING FORMAT '00')
         || '. - ' || CAST(EXTRACT(DAY FROM MAX(dat)) AS STRING FORMAT '00') || '.' || CAST(EXTRACT(MONTH FROM MAX(dat)) AS STRING FORMAT '00')
     || '.' || CAST(EXTRACT(YEAR FROM MAX(dat)) AS STRING FORMAT '0000') AS dat_bez
FROM kfl_production_dbp_view.v_tag_1
WHERE akt_mo = 0
 AND akt_tag <= 0;