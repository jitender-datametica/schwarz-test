-- 20221602 richternic - Hinzufuegen Kostenstellenalter

CREATE OR REPLACE VIEW dbp_msi_view_shr.mv_kostenstelle_hierarchie AS WITH kst_ab AS (SELECT mandant_id,
   krk_id,
   kostenstelle_ebene1_id,
   kostenstelle_ebene15_id,
   MIN(kjmo) AS ab_kjmo
  FROM kfl_production_dbp_view.v_kostenstelle_hierarchie AS kst
  WHERE kostenstelle_ebene1_id IN ('KBG01', 'KDE01', 'KCZ01', 'KHR01', 'KPL01', 'KRO01', 'KSK01', 'KMD01')
  GROUP BY mandant_id,
   krk_id,
   kostenstelle_ebene1_id,
   kostenstelle_ebene15_id) (-- 

  -- FALL 1 Monat vor dem ab --> dies passiert durch den CROSS JOIN dass alle Monate dazugefuegt werden

  -- FALL 1 gleiches Jahr dann alles gut
 SELECT (SELECT MAX(kjmo)
    FROM kfl_production_dbp_view.v_kostenstelle_hierarchie) AS aktmonatjahr,
   v0.mandant_id,
   v0.krk_id,
   v1.kjmo,
    CASE
    WHEN v1.kjmo < t2.ab_kjmo
    THEN 0
    WHEN TRUNC(CAST(v1.kjmo / 100 AS BIGNUMERIC)) = TRUNC(CAST(t2.ab_kjmo / 100 AS BIGNUMERIC))
    THEN CAST(v1.kjmo - t2.ab_kjmo + 1 -- FALL 2 unter 12 Monate -> anderes Jahr
 AS FLOAT64)
    WHEN TRUNC(CAST(v1.kjmo / 100 AS BIGNUMERIC)) = TRUNC(CAST(t2.ab_kjmo / 100 AS BIGNUMERIC)) + 1 AND v1.kjmo < t2.ab_kjmo
        + 100
    THEN ROUND(12 - (t2.ab_kjmo - TRUNC(CAST(t2.ab_kjmo / 100 AS BIGNUMERIC)) * 100) + CAST(RIGHT(SUBSTR(CAST(v1.kjmo AS STRING)
          , 1, 10), 2) AS FLOAT64)) + 1
    ELSE 12
    END AS alter_kst,
   v0.kostenstelle_ebene1_id,
   v0.kostenstelle_ebene2_id,
   v0.kostenstelle_ebene3_id,
   v0.kostenstelle_ebene4_id,
   v0.kostenstelle_ebene5_id,
   v0.kostenstelle_ebene6_id,
   v0.kostenstelle_ebene7_id,
   v0.kostenstelle_ebene8_id,
   v0.kostenstelle_ebene9_id,
   v0.kostenstelle_ebene10_id,
   v0.kostenstelle_ebene11_id,
   v0.kostenstelle_ebene12_id,
   v0.kostenstelle_ebene13_id,
   v0.kostenstelle_ebene14_id,
   v0.kostenstelle_ebene15_id,
   v0.kostenstelle_ebene1_bez,
   v0.kostenstelle_ebene2_bez,
   v0.kostenstelle_ebene3_bez,
   v0.kostenstelle_ebene4_bez,
   v0.kostenstelle_ebene5_bez,
   v0.kostenstelle_ebene6_bez,
   v0.kostenstelle_ebene7_bez,
   v0.kostenstelle_ebene8_bez,
   v0.kostenstelle_ebene9_bez,
   v0.kostenstelle_ebene10_bez,
   v0.kostenstelle_ebene11_bez,
   v0.kostenstelle_ebene12_bez,
   v0.kostenstelle_ebene13_bez,
   v0.kostenstelle_ebene14_bez,
   v0.kostenstelle_ebene15_bez
  FROM kfl_production_dbp_view.v_kostenstelle_hierarchie AS v0
   INNER JOIN kst_ab AS t2 ON v0.mandant_id = t2.mandant_id AND v0.krk_id = t2.krk_id AND v0.kostenstelle_ebene1_id = t2
      .kostenstelle_ebene1_id AND v0.kostenstelle_ebene15_id = t2.kostenstelle_ebene15_id
   INNER JOIN (SELECT DISTINCT kjmo
    FROM kfl_production_dbp_view.v_kostenstelle_hierarchie) AS v1 ON TRUE
  WHERE v0.kostenstelle_ebene1_id IN ('KBG01', 'KDE01', 'KCZ01', 'KHR01', 'KPL01', 'KRO01', 'KSK01', 'KMD01')
   AND v0.kjmo = (SELECT MAX(kjmo)
     FROM kfl_production_dbp_view.v_kostenstelle_hierarchie));