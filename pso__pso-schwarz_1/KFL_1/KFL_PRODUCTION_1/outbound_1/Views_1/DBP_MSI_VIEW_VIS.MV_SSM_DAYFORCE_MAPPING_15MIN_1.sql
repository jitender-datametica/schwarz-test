CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ssm_dayforce_mapping_15min_1 (mandant_id, nb_id, wup_id,
wup_bereich_id, wup_abt_id, dayforce_minimal_mapping, dayforce_xrefcode, dat, zeit_stunde, zeit_15min, wert_gesamt,
wert_minimal, wert_aufgabe, wert_treiber, wert_treiber_faktor, wert_diff_faktor, wert_xref_faktor, sum_minimal,
sum_faktor, xfaktor, wert_diff_ohne, wert_xref_ohne, sum_ohne) AS SELECT SSM.mandant_id,
 SSM.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 SSM.wup_bereich_id,
 SSM.wup_abt_id,
 SSM.dayforce_minimal_mapping,
 SSM.dayforce_xrefcode,
 SSM.dat,
 SSM.zeit_stunde,
 SSM.zeit_15min,
 SSM.wert_gesamt,
 SSM.wert_minimal,
 SSM.wert_aufgabe,
 SSM.wert_treiber,
  SSM.wert_treiber * SWC.ssm_umsatz_faktor AS wert_treiber_faktor,
  CASE
  WHEN CASE
     WHEN SSM.dayforce_xrefcode = (MAX(SSM.dayforce_xrefcode) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
          , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
          , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING))
     THEN 1
     ELSE 0
     END * (SUM(SSM.wert_minimal) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING)
        , CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
        , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING)) > CASE
     WHEN SSM.dayforce_xrefcode = (MAX(SSM.dayforce_xrefcode) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
          , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
          , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING))
     THEN 1
     ELSE 0
     END * (SUM(SSM.wert_aufgabe + SSM.wert_treiber * SWC.ssm_umsatz_faktor) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING)
        , CAST(SSM.nb_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING)
        , CAST(SSM.dayforce_minimal_mapping AS STRING), SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
  THEN CASE
     WHEN SSM.dayforce_xrefcode = (MAX(SSM.dayforce_xrefcode) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
          , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
          , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING))
     THEN 1
     ELSE 0
     END * (SUM(SSM.wert_minimal) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING)
        , CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
        , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING)) - CASE
     WHEN SSM.dayforce_xrefcode = (MAX(SSM.dayforce_xrefcode) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
          , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
          , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING))
     THEN 1
     ELSE 0
     END * (SUM(SSM.wert_aufgabe + SSM.wert_treiber * SWC.ssm_umsatz_faktor) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING)
        , CAST(SSM.nb_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING)
        , CAST(SSM.dayforce_minimal_mapping AS STRING), SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
  ELSE 0.0000
  END AS wert_diff_faktor,
   SSM.wert_aufgabe + SSM.wert_treiber * SWC.ssm_umsatz_faktor + CASE
   WHEN CASE
      WHEN SSM.dayforce_xrefcode = (MAX(SSM.dayforce_xrefcode) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
           , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
           , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
         AND UNBOUNDED FOLLOWING))
      THEN 1
      ELSE 0
      END * (SUM(SSM.wert_minimal) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING)
         , CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
         , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
       AND UNBOUNDED FOLLOWING)) > CASE
      WHEN SSM.dayforce_xrefcode = (MAX(SSM.dayforce_xrefcode) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
           , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
           , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
         AND UNBOUNDED FOLLOWING))
      THEN 1
      ELSE 0
      END * (SUM(SSM.wert_aufgabe + SSM.wert_treiber * SWC.ssm_umsatz_faktor) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING)
         , CAST(SSM.nb_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING)
         , CAST(SSM.dayforce_minimal_mapping AS STRING), SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
   THEN CASE
      WHEN SSM.dayforce_xrefcode = (MAX(SSM.dayforce_xrefcode) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
           , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
           , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
         AND UNBOUNDED FOLLOWING))
      THEN 1
      ELSE 0
      END * (SUM(SSM.wert_minimal) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING)
         , CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
         , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
       AND UNBOUNDED FOLLOWING)) - CASE
      WHEN SSM.dayforce_xrefcode = (MAX(SSM.dayforce_xrefcode) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
           , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
           , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
         AND UNBOUNDED FOLLOWING))
      THEN 1
      ELSE 0
      END * (SUM(SSM.wert_aufgabe + SSM.wert_treiber * SWC.ssm_umsatz_faktor) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING)
         , CAST(SSM.nb_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING)
         , CAST(SSM.dayforce_minimal_mapping AS STRING), SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
   ELSE 0.0000
   END AS wert_xref_faktor,
   CASE
   WHEN SSM.dayforce_xrefcode = (MAX(SSM.dayforce_xrefcode) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
        , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
        , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING))
   THEN 1
   ELSE 0
   END * (SUM(SSM.wert_minimal) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING)
      , CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
      , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING)) AS sum_minimal,
   CASE
   WHEN SSM.dayforce_xrefcode = (MAX(SSM.dayforce_xrefcode) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
        , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
        , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING))
   THEN 1
   ELSE 0
   END * (SUM(SSM.wert_aufgabe + SSM.wert_treiber * SWC.ssm_umsatz_faktor) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING)
      , CAST(SSM.nb_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING)
      , CAST(SSM.dayforce_minimal_mapping AS STRING), SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS sum_faktor,
  CASE
  WHEN SSM.dayforce_xrefcode = (MAX(SSM.dayforce_xrefcode) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
       , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
       , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
     UNBOUNDED FOLLOWING))
  THEN 1
  ELSE 0
  END AS xfaktor,
  CASE
  WHEN CASE
     WHEN SSM.dayforce_xrefcode = (MAX(SSM.dayforce_xrefcode) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
          , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
          , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING))
     THEN 1
     ELSE 0
     END * (SUM(SSM.wert_minimal) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING)
        , CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
        , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING)) > CASE
     WHEN SSM.dayforce_xrefcode = (MAX(SSM.dayforce_xrefcode) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
          , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
          , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING))
     THEN 1
     ELSE 0
     END * (SUM(SSM.wert_aufgabe + SSM.wert_treiber) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
        , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
        , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING))
  THEN CASE
     WHEN SSM.dayforce_xrefcode = (MAX(SSM.dayforce_xrefcode) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
          , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
          , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING))
     THEN 1
     ELSE 0
     END * (SUM(SSM.wert_minimal) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING)
        , CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
        , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING)) - CASE
     WHEN SSM.dayforce_xrefcode = (MAX(SSM.dayforce_xrefcode) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
          , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
          , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING))
     THEN 1
     ELSE 0
     END * (SUM(SSM.wert_aufgabe + SSM.wert_treiber) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
        , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
        , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING))
  ELSE 0.0000
  END AS wert_diff_ohne,
   SSM.wert_aufgabe + SSM.wert_treiber + CASE
   WHEN CASE
      WHEN SSM.dayforce_xrefcode = (MAX(SSM.dayforce_xrefcode) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
           , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
           , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
         AND UNBOUNDED FOLLOWING))
      THEN 1
      ELSE 0
      END * (SUM(SSM.wert_minimal) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING)
         , CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
         , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
       AND UNBOUNDED FOLLOWING)) > CASE
      WHEN SSM.dayforce_xrefcode = (MAX(SSM.dayforce_xrefcode) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
           , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
           , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
         AND UNBOUNDED FOLLOWING))
      THEN 1
      ELSE 0
      END * (SUM(SSM.wert_aufgabe + SSM.wert_treiber) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
         , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
         , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
       AND UNBOUNDED FOLLOWING))
   THEN CASE
      WHEN SSM.dayforce_xrefcode = (MAX(SSM.dayforce_xrefcode) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
           , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
           , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
         AND UNBOUNDED FOLLOWING))
      THEN 1
      ELSE 0
      END * (SUM(SSM.wert_minimal) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING)
         , CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
         , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
       AND UNBOUNDED FOLLOWING)) - CASE
      WHEN SSM.dayforce_xrefcode = (MAX(SSM.dayforce_xrefcode) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
           , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
           , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
         AND UNBOUNDED FOLLOWING))
      THEN 1
      ELSE 0
      END * (SUM(SSM.wert_aufgabe + SSM.wert_treiber) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
         , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
         , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
       AND UNBOUNDED FOLLOWING))
   ELSE 0.0000
   END AS wert_xref_ohne,
   CASE
   WHEN SSM.dayforce_xrefcode = (MAX(SSM.dayforce_xrefcode) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
        , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
        , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING))
   THEN 1
   ELSE 0
   END * (SUM(SSM.wert_aufgabe + SSM.wert_treiber) OVER (PARTITION BY CAST(SSM.mandant_id AS STRING), CAST(SSM.nb_id AS STRING)
      , CAST(WUP.aktuell_wup_id AS STRING), CAST(SSM.wup_bereich_id AS STRING), CAST(SSM.wup_abt_id AS STRING), CAST(SSM.dayforce_minimal_mapping AS STRING)
      , SSM.dat, CAST(SSM.zeit_stunde AS STRING), CAST(SSM.zeit_15min AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING)) AS sum_ohne
FROM (SELECT SWTS.mandant_id,
   SWTS.nb_id,
   SWTS.wup_id,
   SWTS.wup_bereich_id,
   SWTS.wup_abt_id,
   LSP.dayforce_xrefcode,
   LSP.dayforce_minimal_mapping,
   LSP.oeffnung_laden_theken_fg,
   SWTS.dat,
   SWTS.zeit_stunde,
   SWTS.zeit_15min,
   SUM(CASE
     WHEN LSP.ssm_aufwand_typ_id = 1
     THEN SWTS.wert
     ELSE 0.0000
     END) AS wert_treiber,
   SUM(CASE
     WHEN LSP.ssm_aufwand_typ_id = 2
     THEN SWTS.wert
     ELSE 0.0000
     END) AS wert_aufgabe,
   SUM(CASE
     WHEN LSP.ssm_aufwand_typ_id = 3
     THEN SWTS.wert
     ELSE 0.0000
     END) AS wert_minimal,
   SUM(SWTS.wert) AS wert_gesamt,
   SUM(CASE
     WHEN LSP.ssm_aufwand_typ_id = 1
     THEN SWTS.wert_gerundet
     ELSE 0.0000
     END) AS wert_gerundet_treiber,
   SUM(CASE
     WHEN LSP.ssm_aufwand_typ_id = 2
     THEN SWTS.wert_gerundet
     ELSE 0.0000
     END) AS wert_gerundet_aufgabe,
   SUM(CASE
     WHEN LSP.ssm_aufwand_typ_id = 3
     THEN SWTS.wert_gerundet
     ELSE 0.0000
     END) AS wert_gerundet_minimal,
   SUM(SWTS.wert_gerundet) AS wert_gerundet_gesamt
  FROM kfl_production_dbp_view.v_ssm_wup_tag_stunde_1 AS SWTS
   INNER JOIN kfl_production_dbp_view.v_l_ssm_prozess_1 AS LSP ON SWTS.ssm_prozess_id = LSP.ssm_prozess_id AND SWTS.mandant_id
       = LSP.mandant_id AND LSP.dat_bis = DATE '9999-12-31'
  GROUP BY SWTS.mandant_id,
   SWTS.nb_id,
   SWTS.wup_id,
   SWTS.wup_bereich_id,
   SWTS.wup_abt_id,
   LSP.dayforce_xrefcode,
   LSP.dayforce_minimal_mapping,
   LSP.oeffnung_laden_theken_fg,
   SWTS.dat,
   SWTS.zeit_stunde,
   SWTS.zeit_15min) AS SSM
 INNER JOIN (SELECT mandant_id,
   wup_id,
   dat,
   ssm_umsatz_faktor
  FROM kfl_production_dbp_msi_view_vis.mv_ssm_wupcal_1 AS WC1) AS SWC ON SSM.mandant_id = SWC.mandant_id AND SSM.wup_id =
    SWC.wup_id AND SSM.dat = SWC.dat
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON SSM.mandant_id = WUP.mandant_id AND SSM.wup_id = WUP.wup_id;