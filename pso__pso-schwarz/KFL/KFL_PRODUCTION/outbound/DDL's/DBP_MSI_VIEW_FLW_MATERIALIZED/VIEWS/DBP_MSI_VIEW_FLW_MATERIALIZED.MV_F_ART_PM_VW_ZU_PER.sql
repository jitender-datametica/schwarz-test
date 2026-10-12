CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_art_pm_vw_zu_per (art_id, pm_id, vw_id,
mandant_id, dat_bis, dat_von, preistyp_id, vk_brutto) AS SELECT V01.art_id,
 V01.pm_id,
 V01.vw_id,
 V01.mandant_id,
 pm.dat_von AS dat_bis,
 pm.dat_von,
 V01.preistyp_id,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN V01.vk_brutto * V500.umrechnungskurs
   WHEN V200.wrg_typ_id = 1
   THEN V01.vk_brutto
   ELSE NULL
   END AS NUMERIC) AS vk_brutto
FROM kfl_production_dbp_view.v_art_pm_vw_zu_per AS V01
 INNER JOIN (SELECT art_id,
   mandant_id,
   dat_von
  FROM kfl_production_dbp_view.v_art_pm_vw_zu_per AS V01
  WHERE preistyp_id = 0
  GROUP BY art_id,
   mandant_id,
   dat_von) AS pm ON V01.art_id = pm.art_id AND V01.mandant_id = pm.mandant_id AND pm.dat_von BETWEEN V01.dat_von AND
    V01.dat_bis AND V01.vk_brutto IS NOT NULL
 INNER JOIN kfl_production_dbp_view.v_mandant AS V100 ON V01.mandant_id = V100.mandant_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu AS V300 ON TRUE
 LEFT JOIN kfl_production_dbp_view.v_kurs AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V100.default_wrg = V500.von_wrg_id
     AND V01.dat_von BETWEEN V500.dat_von AND V500.dat_bis
WHERE V500.nach_wrg_id = 'EUR'
 AND V01.preistyp_id = 0
UNION ALL
SELECT V011.art_id,
 V011.pm_id,
 V011.vw_id,
 V011.mandant_id,
 pm.dat_bis,
 pm.dat_von,
 v02.preistyp_id,
 MAX(CAST(CASE
    WHEN V2000.wrg_typ_id = 0
    THEN v02.vk_brutto * V5000.umrechnungskurs
    WHEN V2000.wrg_typ_id = 1
    THEN v02.vk_brutto
    ELSE NULL
    END AS NUMERIC)) AS vk_brutto
FROM kfl_production_dbp_view.v_art_pm_vw_zu_per AS V011
 INNER JOIN (SELECT art_id,
   mandant_id,
   dat_von,
   COALESCE(DATE_SUB(MAX(dat_von) OVER (PARTITION BY art_id, mandant_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1
      FOLLOWING AND 1 FOLLOWING), INTERVAL 1 DAY), MAX(dat_bis)) AS dat_bis
  FROM kfl_production_dbp_view.v_art_pm_vw_zu_per AS V01
  WHERE preistyp_id = 0
  GROUP BY art_id,
   mandant_id,
   dat_von) AS pm ON V011.art_id = pm.art_id AND V011.mandant_id = pm.mandant_id AND pm.dat_von BETWEEN V011.dat_von AND
   V011.dat_bis
 INNER JOIN (SELECT Z01.art_id,
   Z01.pm_id,
   Z01.vw_id,
   Z01.mandant_id,
   Z01.dat_bis,
   Z01.dat_von,
   T.dat,
   Z01.preistyp_id,
   Z01.vk_brutto
  FROM kfl_production_dbp_view.v_art_pm_vw_zu_per AS Z01
   INNER JOIN kfl_production_dbp_view.v_tag AS T ON T.dat BETWEEN Z01.dat_von AND Z01.dat_bis
  WHERE Z01.preistyp_id = 1
   AND Z01.vk_brutto IS NOT NULL) AS v02 ON V011.art_id = v02.art_id AND V011.pm_id = v02.pm_id AND V011.vw_id = v02.vw_id
      AND V011.mandant_id = v02.mandant_id AND v02.dat BETWEEN pm.dat_von AND pm.dat_bis
 INNER JOIN kfl_production_dbp_view.v_mandant AS V1000 ON V011.mandant_id = V1000.mandant_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V2000 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu AS V3000 ON TRUE
 LEFT JOIN kfl_production_dbp_view.v_kurs AS V5000 ON V3000.kurstyp_id = V5000.kurstyp_id AND V1000.default_wrg = V5000
    .von_wrg_id AND V011.dat_von BETWEEN V5000.dat_von AND V5000.dat_bis
WHERE V5000.nach_wrg_id = 'EUR'
 AND V011.preistyp_id = 0
GROUP BY V011.art_id,
 V011.pm_id,
 V011.vw_id,
 V011.mandant_id,
 pm.dat_bis,
 pm.dat_von,
 v02.preistyp_id
UNION ALL
SELECT V013.art_id,
 V013.pm_id,
 V013.vw_id,
 V013.mandant_id,
 pm.dat_bis,
 pm.dat_von,
 v02.preistyp_id,
 MAX(CAST(CASE
    WHEN V2001.wrg_typ_id = 0
    THEN v02.vk_brutto * V5001.umrechnungskurs
    WHEN V2001.wrg_typ_id = 1
    THEN v02.vk_brutto
    ELSE NULL
    END AS NUMERIC)) AS vk_brutto
FROM kfl_production_dbp_view.v_art_pm_vw_zu_per AS V013
 INNER JOIN (SELECT art_id,
   mandant_id,
   dat_von,
   COALESCE(DATE_SUB(MAX(dat_von) OVER (PARTITION BY art_id, mandant_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1
      FOLLOWING AND 1 FOLLOWING), INTERVAL 1 DAY), MAX(dat_bis)) AS dat_bis
  FROM kfl_production_dbp_view.v_art_pm_vw_zu_per AS V01
  WHERE preistyp_id = 0
  GROUP BY art_id,
   mandant_id,
   dat_von) AS pm ON V013.art_id = pm.art_id AND V013.mandant_id = pm.mandant_id AND pm.dat_von BETWEEN V013.dat_von AND
   V013.dat_bis
 INNER JOIN (SELECT Z010.art_id,
   Z010.pm_id,
   Z010.vw_id,
   Z010.mandant_id,
   Z010.dat_bis,
   Z010.dat_von,
   T0.dat,
   Z010.preistyp_id,
   Z010.vk_brutto
  FROM kfl_production_dbp_view.v_art_pm_vw_zu_per AS Z010
   INNER JOIN kfl_production_dbp_view.v_tag AS T0 ON T0.dat BETWEEN Z010.dat_von AND Z010.dat_bis
  WHERE Z010.preistyp_id = 2
   AND Z010.vk_brutto IS NOT NULL) AS v02 ON V013.art_id = v02.art_id AND V013.pm_id = v02.pm_id AND V013.vw_id = v02.vw_id
      AND V013.mandant_id = v02.mandant_id AND v02.dat BETWEEN pm.dat_von AND pm.dat_bis
 INNER JOIN kfl_production_dbp_view.v_mandant AS V1001 ON V013.mandant_id = V1001.mandant_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V2001 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu AS V3001 ON TRUE
 LEFT JOIN kfl_production_dbp_view.v_kurs AS V5001 ON V3001.kurstyp_id = V5001.kurstyp_id AND V1001.default_wrg = V5001
    .von_wrg_id AND V013.dat_von BETWEEN V5001.dat_von AND V5001.dat_bis
WHERE V5001.nach_wrg_id = 'EUR'
 AND V013.preistyp_id = 0
GROUP BY V013.art_id,
 V013.pm_id,
 V013.vw_id,
 V013.mandant_id,
 pm.dat_bis,
 pm.dat_von,
 v02.preistyp_id;