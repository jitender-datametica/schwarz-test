CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_werbewoche_kl (mandant_id, dat, akt_kjwo_ww, kjwo_ww,
mandant_kjwo_ww, dat_von, dat_bis) AS SELECT mandant_id,
 dat,
 akt_kjwo_ww,
 kjwo_ww,
   TRIM(SUBSTR(CAST(mandant_id AS STRING), 1, 3)) || '_' || SUBSTR(CAST(kjwo_ww AS STRING), 1, 6) AS mandant_kjwo_ww,
 MIN(dat) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo_ww AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS dat_von,
 MAX(dat) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo_ww AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS dat_bis
FROM kfl_production_dbp_view.v_werbewoche_kl AS V01;