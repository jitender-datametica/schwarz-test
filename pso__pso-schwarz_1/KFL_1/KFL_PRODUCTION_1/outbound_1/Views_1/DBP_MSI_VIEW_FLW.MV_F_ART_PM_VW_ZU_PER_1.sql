CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_art_pm_vw_zu_per_1 AS SELECT V01.art_id,
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
FROM kfl_production_dbp_view.v_art_pm_vw_zu_per_1 AS V01
 INNER JOIN (SELECT art_id,
   mandant_id,
   dat_von
  FROM kfl_production_dbp_view.v_art_pm_vw_zu_per_1 AS V01
  WHERE preistyp_id = 0
  GROUP BY art_id,
   mandant_id,
   dat_von) AS pm_1 ON V01.art_id = pm.art_id AND V01.mandant_id = pm.mandant_id AND pm.dat_von BETWEEN V01.dat_von AND
    V01.dat_bis AND V01.vk_brutto IS NOT NULL
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V100 ON V01.mandant_id = V100.mandant_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_1 AS V300 ON TRUE
 LEFT JOIN kfl_production_dbp_view.v_kurs_1 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V100.default_wrg = V500.von_wrg_id
     AND V01.dat_von BETWEEN V500.dat_von AND V500.dat_bis
WHERE V500.nach_wrg_id = 'EUR'
 AND V01.preistyp_id = 0
UNION ALL
SELECT V01.art_id,
 V01.pm_id,
 V01.vw_id,
 V01.mandant_id,
 pm.dat_bis,
 pm.dat_von,
 v02.preistyp_id,
 MAX(CAST(CASE
    WHEN V200.wrg_typ_id = 0
    THEN v02.vk_brutto * V500.umrechnungskurs
    WHEN V200.wrg_typ_id = 1
    THEN v02.vk_brutto
    ELSE NULL
    END AS NUMERIC)) AS vk_brutto
FROM kfl_production_dbp_view.v_art_pm_vw_zu_per_1 AS V01
 INNER JOIN (SELECT art_id,
   mandant_id,
   dat_von,
   COALESCE(DATE_SUB(MAX(dat_von) OVER (PARTITION BY CAST(art_id AS STRING), CAST(mandant_id AS STRING) ORDER BY dat_von
        IS NULL, dat_von ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING), INTERVAL 1 DAY), MAX(dat_bis)) AS dat_bis
  FROM kfl_production_dbp_view.v_art_pm_vw_zu_per_1 AS V01
  WHERE preistyp_id = 0
  GROUP BY art_id,
   mandant_id,
   dat_von) AS pm_1 ON V01.art_id = pm.art_id AND V01.mandant_id = pm.mandant_id AND pm.dat_von BETWEEN V01.dat_von AND
   V01.dat_bis
 INNER JOIN (SELECT Z01.art_id,
   Z01.pm_id,
   Z01.vw_id,
   Z01.mandant_id,
   Z01.dat_bis,
   Z01.dat_von,
   T.dat,
   Z01.preistyp_id,
   Z01.vk_brutto
  FROM kfl_production_dbp_view.v_art_pm_vw_zu_per_1 AS Z01
   INNER JOIN kfl_production_dbp_view.v_tag_1 AS T ON T.dat BETWEEN Z01.dat_von AND Z01.dat_bis
  WHERE Z01.preistyp_id = 1
   AND Z01.vk_brutto IS NOT NULL) AS v02 ON V01.art_id = v02.art_id AND V01.pm_id = v02.pm_id AND V01.vw_id = v02.vw_id
   AND V01.mandant_id = v02.mandant_id AND v02.dat BETWEEN pm.dat_von AND pm.dat_bis
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V100 ON V01.mandant_id = V100.mandant_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_1 AS V300 ON TRUE
 LEFT JOIN kfl_production_dbp_view.v_kurs_1 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V100.default_wrg = V500.von_wrg_id
     AND V01.dat_von BETWEEN V500.dat_von AND V500.dat_bis
WHERE V500.nach_wrg_id = 'EUR'
 AND V01.preistyp_id = 0
GROUP BY V01.art_id,
 V01.pm_id,
 V01.vw_id,
 V01.mandant_id,
 pm.dat_bis,
 pm.dat_von,
 v02.preistyp_id
UNION ALL
SELECT V01.art_id,
 V01.pm_id,
 V01.vw_id,
 V01.mandant_id,
 pm.dat_bis,
 pm.dat_von,
 v02.preistyp_id,
 MAX(CAST(CASE
    WHEN V200.wrg_typ_id = 0
    THEN v02.vk_brutto * V500.umrechnungskurs
    WHEN V200.wrg_typ_id = 1
    THEN v02.vk_brutto
    ELSE NULL
    END AS NUMERIC)) AS vk_brutto
FROM kfl_production_dbp_view.v_art_pm_vw_zu_per_1 AS V01
 INNER JOIN (SELECT art_id,
   mandant_id,
   dat_von,
   COALESCE(DATE_SUB(MAX(dat_von) OVER (PARTITION BY CAST(art_id AS STRING), CAST(mandant_id AS STRING) ORDER BY dat_von
        IS NULL, dat_von ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING), INTERVAL 1 DAY), MAX(dat_bis)) AS dat_bis
  FROM kfl_production_dbp_view.v_art_pm_vw_zu_per_1 AS V01
  WHERE preistyp_id = 0
  GROUP BY art_id,
   mandant_id,
   dat_von) AS pm_1 ON V01.art_id = pm.art_id AND V01.mandant_id = pm.mandant_id AND pm.dat_von BETWEEN V01.dat_von AND
   V01.dat_bis
 INNER JOIN (SELECT Z01.art_id,
   Z01.pm_id,
   Z01.vw_id,
   Z01.mandant_id,
   Z01.dat_bis,
   Z01.dat_von,
   T.dat,
   Z01.preistyp_id,
   Z01.vk_brutto
  FROM kfl_production_dbp_view.v_art_pm_vw_zu_per_1 AS Z01
   INNER JOIN kfl_production_dbp_view.v_tag_1 AS T ON T.dat BETWEEN Z01.dat_von AND Z01.dat_bis
  WHERE Z01.preistyp_id = 2
   AND Z01.vk_brutto IS NOT NULL) AS v02 ON V01.art_id = v02.art_id AND V01.pm_id = v02.pm_id AND V01.vw_id = v02.vw_id
   AND V01.mandant_id = v02.mandant_id AND v02.dat BETWEEN pm.dat_von AND pm.dat_bis
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V100 ON V01.mandant_id = V100.mandant_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_1 AS V300 ON TRUE
 LEFT JOIN kfl_production_dbp_view.v_kurs_1 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V100.default_wrg = V500.von_wrg_id
     AND V01.dat_von BETWEEN V500.dat_von AND V500.dat_bis
WHERE V500.nach_wrg_id = 'EUR'
 AND V01.preistyp_id = 0
GROUP BY V01.art_id,
 V01.pm_id,
 V01.vw_id,
 V01.mandant_id,
 pm.dat_bis,
 pm.dat_von,
 v02.preistyp_id;