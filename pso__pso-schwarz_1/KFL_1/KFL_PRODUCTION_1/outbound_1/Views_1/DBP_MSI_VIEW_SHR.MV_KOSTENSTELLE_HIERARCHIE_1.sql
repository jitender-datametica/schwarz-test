CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_kostenstelle_hierarchie_1 AS WITH KST_AB AS (SELECT mandant_id,
   krk_id,
   kostenstelle_ebene1_id,
   kostenstelle_ebene15_id,
   MIN(kjmo) AS ab_kjmo
  FROM kfl_production_dbp_view.v_kostenstelle_hierarchie_1 AS KST
  WHERE kostenstelle_ebene1_id IN ('KBG01', 'KDE01', 'KCZ01', 'KHR01', 'KPL01', 'KRO01', 'KSK01', 'KMD01')
  GROUP BY mandant_id,
   krk_id,
   kostenstelle_ebene1_id,
   kostenstelle_ebene15_id) (SELECT (SELECT MAX(kjmo)
    FROM kfl_production_dbp_view.v_kostenstelle_hierarchie_1) AS aktmonatjahr,
   V0.mandant_id,
   V0.krk_id,
   v1.kjmo,
    CASE
    WHEN v1.kjmo < t2.ab_kjmo
    THEN 0
    WHEN TRUNC(CAST(v1.kjmo / 100 AS BIGNUMERIC)) = TRUNC(CAST(t2.ab_kjmo / 100 AS BIGNUMERIC))
    THEN CAST(v1.kjmo - t2.ab_kjmo + 1 AS FLOAT64)
    WHEN TRUNC(CAST(v1.kjmo / 100 AS BIGNUMERIC)) = TRUNC(CAST(t2.ab_kjmo / 100 AS BIGNUMERIC)) + 1 AND v1.kjmo < t2.ab_kjmo
        + 100
    THEN ROUND(12 - (t2.ab_kjmo - TRUNC(CAST(t2.ab_kjmo / 100 AS BIGNUMERIC)) * 100) + CAST(RIGHT(SUBSTR(CAST(v1.kjmo AS STRING)
          , 1, 10), 2) AS FLOAT64)) + 1
    ELSE 12
    END AS alter_kst,
   V0.kostenstelle_ebene1_id,
   V0.kostenstelle_ebene2_id,
   V0.kostenstelle_ebene3_id,
   V0.kostenstelle_ebene4_id,
   V0.kostenstelle_ebene5_id,
   V0.kostenstelle_ebene6_id,
   V0.kostenstelle_ebene7_id,
   V0.kostenstelle_ebene8_id,
   V0.kostenstelle_ebene9_id,
   V0.kostenstelle_ebene10_id,
   V0.kostenstelle_ebene11_id,
   V0.kostenstelle_ebene12_id,
   V0.kostenstelle_ebene13_id,
   V0.kostenstelle_ebene14_id,
   V0.kostenstelle_ebene15_id,
   V0.kostenstelle_ebene1_bez,
   V0.kostenstelle_ebene2_bez,
   V0.kostenstelle_ebene3_bez,
   V0.kostenstelle_ebene4_bez,
   V0.kostenstelle_ebene5_bez,
   V0.kostenstelle_ebene6_bez,
   V0.kostenstelle_ebene7_bez,
   V0.kostenstelle_ebene8_bez,
   V0.kostenstelle_ebene9_bez,
   V0.kostenstelle_ebene10_bez,
   V0.kostenstelle_ebene11_bez,
   V0.kostenstelle_ebene12_bez,
   V0.kostenstelle_ebene13_bez,
   V0.kostenstelle_ebene14_bez,
   V0.kostenstelle_ebene15_bez
  FROM kfl_production_dbp_view.v_kostenstelle_hierarchie_1 AS V0
   INNER JOIN KST_AB AS t2 ON V0.mandant_id = t2.mandant_id AND V0.krk_id = t2.krk_id AND V0.kostenstelle_ebene1_id = t2
      .kostenstelle_ebene1_id AND V0.kostenstelle_ebene15_id = t2.kostenstelle_ebene15_id
   INNER JOIN (SELECT DISTINCT kjmo
    FROM kfl_production_dbp_view.v_kostenstelle_hierarchie_1) AS v1 ON TRUE
  WHERE V0.kostenstelle_ebene1_id IN ('KBG01', 'KDE01', 'KCZ01', 'KHR01', 'KPL01', 'KRO01', 'KSK01', 'KMD01')
   AND V0.kjmo = (SELECT MAX(kjmo)
     FROM kfl_production_dbp_view.v_kostenstelle_hierarchie_1));