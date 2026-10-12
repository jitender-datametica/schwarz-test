CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_werbewoche_kl_1 (mandant_id, dat, akt_kjwo_ww, akt_kjwo_ww_komplett
, kjwo_ww, angepasste_kjwo_ww, wo_ww, ww_dat_von, ww_dat_bis, ww_mo, ww_tag) AS SELECT mandant_id,
 dat,
 akt_kjwo_ww,
 akt_kjwo_ww_komplett,
 kjwo_ww,
 angepasste_kjwo_ww,
 SUBSTR(CAST(kjwo_ww AS STRING), 5, 2) AS wo_ww,
 MIN(dat) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo_ww AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS ww_dat_von,
 MAX(dat) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo_ww AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS ww_dat_bis,
   EXTRACT(YEAR FROM MIN(dat) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo_ww AS STRING) RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * 100 + EXTRACT(MONTH FROM MIN(dat) OVER (PARTITION BY CAST(mandant_id AS STRING)
      , CAST(kjwo_ww AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS ww_mo,
 RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo_ww AS STRING) ORDER BY dat IS NULL, dat) AS ww_tag
FROM kfl_production_dbp_data.werbewoche_kl_1
WHERE mandant_id = 1;