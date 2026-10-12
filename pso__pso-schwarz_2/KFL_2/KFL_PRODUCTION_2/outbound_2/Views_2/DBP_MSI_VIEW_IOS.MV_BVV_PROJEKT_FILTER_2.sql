CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_bvv_projekt_filter_2 AS SELECT CAST(akt_tag AS BIGNUMERIC) AS
 projekt_filter_id,
 CAST(CASE
   WHEN CAST(akt_tag AS BIGNUMERIC) = 0
   THEN 'Aktuell'
   WHEN CAST(akt_tag AS BIGNUMERIC) = 1
   THEN 'Abgeschlossen'
   WHEN CAST(akt_tag AS BIGNUMERIC) = 2
   THEN 'Abgebrochen'
   WHEN CAST(akt_tag AS BIGNUMERIC) = 3
   THEN 'Unvollstaendig'
   ELSE NULL
   END AS STRING) AS projekt_filter_bez
FROM kfl_production_dbp_view.v_tag_2
WHERE akt_tag BETWEEN 0 AND 3;