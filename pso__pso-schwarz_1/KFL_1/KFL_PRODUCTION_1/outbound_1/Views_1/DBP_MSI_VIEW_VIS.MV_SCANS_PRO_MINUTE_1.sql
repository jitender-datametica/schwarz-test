CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_scans_pro_minute_1 AS SELECT SPM.mandant_id,
 SPM.nb_id,
 SPM.wup_id,
 SPM.kassierer_nr,
 SPM.dat,
 ZEIT.kjwo,
 ZEIT.kjmo,
 SPM.anz_artikel AS anz_artikel_tag,
 SUM(SPM.anz_artikel) OVER (PARTITION BY CAST(SPM.mandant_id AS STRING), CAST(SPM.nb_id AS STRING), CAST(SPM.wup_id AS STRING)
    , SPM.kassierer_nr, CAST(SPM.kjwo AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
 anz_artikel_wo,
 SUM(SPM.anz_artikel) OVER (PARTITION BY CAST(SPM.mandant_id AS STRING), CAST(SPM.nb_id AS STRING), CAST(SPM.wup_id AS STRING)
    , SPM.kassierer_nr, CAST(ZEIT.kjmo AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
 anz_artikel_mo,
 SPM.registrierzeit,
  SPM.registrierzeit / 60.0000 AS scanzeit_tag,
   (SUM(SPM.registrierzeit) OVER (PARTITION BY CAST(SPM.mandant_id AS STRING), CAST(SPM.nb_id AS STRING), CAST(SPM.wup_id AS STRING)
      , SPM.kassierer_nr, CAST(SPM.kjwo AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / 60.0000
   AS scanzeit_wo,
   (SUM(SPM.registrierzeit) OVER (PARTITION BY CAST(SPM.mandant_id AS STRING), CAST(SPM.nb_id AS STRING), CAST(SPM.wup_id AS STRING)
      , SPM.kassierer_nr, CAST(ZEIT.kjmo AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) /
  60.0000 AS scanzeit_mo,
  SPM.anz_artikel / IF(SPM.registrierzeit / 60.0000 = 0, NULL, SPM.registrierzeit / 60.0000) AS scans_min_tag,
   (SUM(SPM.anz_artikel) OVER (PARTITION BY CAST(SPM.mandant_id AS STRING), CAST(SPM.nb_id AS STRING), CAST(SPM.wup_id AS STRING)
      , SPM.kassierer_nr, CAST(SPM.kjwo AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(SPM
       .registrierzeit) OVER (PARTITION BY CAST(SPM.mandant_id AS STRING), CAST(SPM.nb_id AS STRING), CAST(SPM.wup_id AS STRING)
         , SPM.kassierer_nr, CAST(SPM.kjwo AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) /
     60.0000 = 0, NULL, (SUM(SPM.registrierzeit) OVER (PARTITION BY CAST(SPM.mandant_id AS STRING), CAST(SPM.nb_id AS STRING)
        , CAST(SPM.wup_id AS STRING), SPM.kassierer_nr, CAST(SPM.kjwo AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING)) / 60.0000) AS scans_min_wo,
   (SUM(SPM.anz_artikel) OVER (PARTITION BY CAST(SPM.mandant_id AS STRING), CAST(SPM.nb_id AS STRING), CAST(SPM.wup_id AS STRING)
      , SPM.kassierer_nr, CAST(ZEIT.kjmo AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(SPM
       .registrierzeit) OVER (PARTITION BY CAST(SPM.mandant_id AS STRING), CAST(SPM.nb_id AS STRING), CAST(SPM.wup_id AS STRING)
         , SPM.kassierer_nr, CAST(ZEIT.kjmo AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) /
     60.0000 = 0, NULL, (SUM(SPM.registrierzeit) OVER (PARTITION BY CAST(SPM.mandant_id AS STRING), CAST(SPM.nb_id AS STRING)
        , CAST(SPM.wup_id AS STRING), SPM.kassierer_nr, CAST(ZEIT.kjmo AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING)) / 60.0000) AS scans_min_mo
FROM kfl_production_dbp_v_ods.v_scans_pro_minute_1 AS SPM
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS ZEIT_1 ON SPM.dat = ZEIT.dat;