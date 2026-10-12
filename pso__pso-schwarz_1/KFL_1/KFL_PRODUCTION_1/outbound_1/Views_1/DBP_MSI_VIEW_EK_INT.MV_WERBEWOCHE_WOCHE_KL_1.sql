CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_werbewoche_woche_kl_1 AS SELECT DISTINCT mandant_id,
 akt_kjwo_ww,
 akt_kjwo_ww_komplett,
 kjwo_ww,
  kjwo_ww - 100 AS kjwo_ww_vj,
 SUBSTR(CAST(kjwo_ww AS STRING), 5, 2) AS wo_ww,
 MIN(dat) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo_ww AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS ww_dat_von,
 MAX(dat) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo_ww AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS ww_dat_bis,
   EXTRACT(YEAR FROM MIN(dat) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo_ww AS STRING) RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * 100 + EXTRACT(MONTH FROM MIN(dat) OVER (PARTITION BY CAST(mandant_id AS STRING)
      , CAST(kjwo_ww AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS ww_mo
FROM kfl_production_dbp_msi_view_ek_int.mv_werbewoche_kl_1;