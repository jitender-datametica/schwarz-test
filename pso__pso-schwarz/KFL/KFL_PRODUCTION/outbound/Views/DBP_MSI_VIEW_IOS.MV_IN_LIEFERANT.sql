CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_in_lieferant (in_lief_id, mandant_id, in_lief_nr, lief_name_1
, lief_name_2) AS SELECT in_lief_id,
 mandant_id,
  CASE
  WHEN ROUND(SAFE_CAST(in_lief_nr AS BIGNUMERIC), 0) IS NULL
  THEN in_lief_nr
  ELSE CAST(ROUND(CAST(in_lief_nr AS BIGNUMERIC), 0) AS STRING)
  END AS in_lief_nr,
 lief_name_1,
 lief_name_2
FROM kfl_production_dbp_view.v_in_lieferant AS V01;