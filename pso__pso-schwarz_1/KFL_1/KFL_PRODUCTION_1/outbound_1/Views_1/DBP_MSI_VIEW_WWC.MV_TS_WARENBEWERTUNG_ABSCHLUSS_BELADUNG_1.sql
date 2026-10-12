CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_ts_warenbewertung_abschluss_beladung_1 (mandant_id,
dat_aenderung, job_start_fg) AS SELECT V01.mandant_id,
 V02.dat AS dat_aenderung,
 V03.job_start_fg
FROM kfl_production_dbp_data.mandant_1 AS V01
 INNER JOIN (SELECT MAX(dat) AS dat,
   kjmo,
   akt_kj
  FROM kfl_production_dbp_data.tag_1
  WHERE akt_kj BETWEEN -2 AND 0
  GROUP BY kjmo,
   akt_kj) AS V02 ON TRUE
 LEFT JOIN kfl_production_dbp_msi_data.ts_warenbewertung_abschluss_beladung_1 AS V03 ON V01.mandant_id = V03.mandant_id
  AND V02.dat = V03.dat_aenderung
WHERE V01.mandant_id <> 1;