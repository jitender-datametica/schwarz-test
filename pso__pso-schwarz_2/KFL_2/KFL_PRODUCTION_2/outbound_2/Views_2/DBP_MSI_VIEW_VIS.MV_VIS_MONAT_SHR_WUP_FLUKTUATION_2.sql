CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_monat_shr_wup_fluktuation_2 AS SELECT sub_kstl.mandant_id,
 sub_kstl.nb_id,
 sub_kstl.wup_id,
 sub_kstl.wrg_id,
 sub_kstl.kjmo,
 COALESCE(sub_kstl.rank_kjmo, sub_kstl.akt_mo + 1) AS akt_mo_shr,
 COUNT(DISTINCT sub_ma.mitarbeiter_id) AS ma_count,
 SUM(sub_ma.ma_ein) AS ma_eintritt,
 SUM(sub_ma.ma_aus) AS ma_austritt,
 SUM(sub_ma.ma_knd) AS ma_kuendigung,
  COUNT(DISTINCT sub_ma.mitarbeiter_id) - SUM(sub_ma.ma_aus) AS ma_anzahl,
 SUM(sub_ma.aus_00_03) AS austritt_00_03,
 SUM(sub_ma.mo_00_03 - sub_ma.aus_00_03) AS monate_00_03,
 SUM(sub_ma.aus_03_06) AS austritt_03_06,
 SUM(sub_ma.mo_03_06 - sub_ma.aus_03_06) AS monate_03_06,
 SUM(sub_ma.aus_06_12) AS austritt_06_12,
 SUM(sub_ma.mo_06_12 - sub_ma.aus_06_12) AS monate_06_12,
 SUM(sub_ma.aus_12_36) AS austritt_12_36,
 SUM(sub_ma.mo_12_36 - sub_ma.aus_12_36) AS monate_12_36,
 SUM(sub_ma.aus_36x) AS austritt_36,
 SUM(sub_ma.mo_36x - sub_ma.aus_36x) AS monate_36
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   VIS.kjmo,
   VIS.akt_mo,
   shr_mo.rank_kjmo,
   kstl.kostenstelle_id
  FROM kfl_production_dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_2 AS VIS
   LEFT JOIN (SELECT kjmo,
      0 - (RANK() OVER (ORDER BY kjmo IS NULL, kjmo)) AS rank_kjmo
    FROM (SELECT DISTINCT kjmo
      FROM kfl_production_dbp_view.v_mitarbeiterbew_2) AS mabew) AS shr_mo ON VIS.kjmo = shr_mo.kjmo
   LEFT JOIN (SELECT mandant_id,
     kostenstelle_id,
     ROUND(CAST(geschaeftsbereich_id AS BIGNUMERIC), 0) AS gsb,
     ROUND(CAST(SUBSTR(pc_id, 3, 4) AS BIGNUMERIC), 0) AS pc,
     COALESCE(ROUND(CAST(geschaeftsbereich_id AS BIGNUMERIC), 0), ROUND(CAST(SUBSTR(pc_id, 3, 4) AS BIGNUMERIC), 0), 0)
     AS wup_id
    FROM kfl_production_dbp_view.v_in_kostenstelle_per_2
    WHERE (mandant_id, krk_id, kostenstelle_id, dat_von) IN (SELECT (mandant_id, krk_id, kostenstelle_id, MAX(dat_von))
       FROM kfl_production_dbp_view.v_in_kostenstelle_per_2
       GROUP BY mandant_id,
        krk_id,
        kostenstelle_id)) AS kstl ON VIS.mandant_id = kstl.mandant_id AND VIS.wup_id = kstl.wup_id
  WHERE VIS.nb_id IN (- 1, 0)
   AND MOD(CAST(VIS.kjmo AS BIGNUMERIC), 100) <> 13) AS sub_kstl
 LEFT JOIN (SELECT MAK.mandant_id,
   MAK.kostenstelle_id,
   MAK.kjmo,
   MAK.mitarbeiter_id,
   DATE_DIFF(DATE_ADD(DATE_SUB(IF(MAK.dat_von = LAST_DAY(MAK.dat_von), LAST_DAY(DATE_ADD(MAK.dat_von, INTERVAL 1 MONTH)
        ), DATE_ADD(MAK.dat_von, INTERVAL 1 MONTH)), INTERVAL 1 DAY), INTERVAL 1 DAY), mad.dat_von, DAY) AS
   ma_tage_check,
   DATE_DIFF(COALESCE(mahm.dat_von, DATE_ADD(DATE_SUB(IF(MAK.dat_von = LAST_DAY(MAK.dat_von), LAST_DAY(DATE_ADD(MAK.dat_von
          ,INTERVAL 1 MONTH)), DATE_ADD(MAK.dat_von, INTERVAL 1 MONTH)), INTERVAL 1 DAY), INTERVAL 1 DAY)), mad.dat_von
    ,DAY) AS ma_tage,
    CASE
    WHEN mad.dat_von BETWEEN MAK.dat_von AND (DATE_SUB(IF(MAK.dat_von = LAST_DAY(MAK.dat_von), LAST_DAY(DATE_ADD(MAK.dat_von
          ,INTERVAL 1 MONTH)), DATE_ADD(MAK.dat_von, INTERVAL 1 MONTH)), INTERVAL 1 DAY))
    THEN 1
    ELSE 0
    END AS ma_ein,
    CASE
    WHEN mad1.dat_von BETWEEN MAK.dat_von AND (DATE_SUB(IF(MAK.dat_von = LAST_DAY(MAK.dat_von), LAST_DAY(DATE_ADD(MAK.dat_von
          ,INTERVAL 1 MONTH)), DATE_ADD(MAK.dat_von, INTERVAL 1 MONTH)), INTERVAL 1 DAY))
    THEN 1
    ELSE 0
    END AS ma_knd,
    CASE
    WHEN mahm.hr_massnahme_id = '04'
    THEN 1
    ELSE 0
    END AS ma_aus,
    CASE
    WHEN DATE_DIFF(COALESCE(mahm.dat_von, DATE_ADD(DATE_SUB(IF(MAK.dat_von = LAST_DAY(MAK.dat_von), LAST_DAY(DATE_ADD(MAK
            .dat_von, INTERVAL 1 MONTH)), DATE_ADD(MAK.dat_von, INTERVAL 1 MONTH)), INTERVAL 1 DAY), INTERVAL 1 DAY)),
      mad.dat_von, DAY) < 90
    THEN 1
    ELSE 0
    END AS mo_00_03,
    CASE
    WHEN DATE_DIFF(COALESCE(mahm.dat_von, DATE_ADD(DATE_SUB(IF(MAK.dat_von = LAST_DAY(MAK.dat_von), LAST_DAY(DATE_ADD(MAK
            .dat_von, INTERVAL 1 MONTH)), DATE_ADD(MAK.dat_von, INTERVAL 1 MONTH)), INTERVAL 1 DAY), INTERVAL 1 DAY)),
      mad.dat_von, DAY) BETWEEN 90 AND 179
    THEN 1
    ELSE 0
    END AS mo_03_06,
    CASE
    WHEN DATE_DIFF(COALESCE(mahm.dat_von, DATE_ADD(DATE_SUB(IF(MAK.dat_von = LAST_DAY(MAK.dat_von), LAST_DAY(DATE_ADD(MAK
            .dat_von, INTERVAL 1 MONTH)), DATE_ADD(MAK.dat_von, INTERVAL 1 MONTH)), INTERVAL 1 DAY), INTERVAL 1 DAY)),
      mad.dat_von, DAY) BETWEEN 180 AND 359
    THEN 1
    ELSE 0
    END AS mo_06_12,
    CASE
    WHEN DATE_DIFF(COALESCE(mahm.dat_von, DATE_ADD(DATE_SUB(IF(MAK.dat_von = LAST_DAY(MAK.dat_von), LAST_DAY(DATE_ADD(MAK
            .dat_von, INTERVAL 1 MONTH)), DATE_ADD(MAK.dat_von, INTERVAL 1 MONTH)), INTERVAL 1 DAY), INTERVAL 1 DAY)),
      mad.dat_von, DAY) BETWEEN 360 AND 1079
    THEN 1
    ELSE 0
    END AS mo_12_36,
    CASE
    WHEN DATE_DIFF(COALESCE(mahm.dat_von, DATE_ADD(DATE_SUB(IF(MAK.dat_von = LAST_DAY(MAK.dat_von), LAST_DAY(DATE_ADD(MAK
            .dat_von, INTERVAL 1 MONTH)), DATE_ADD(MAK.dat_von, INTERVAL 1 MONTH)), INTERVAL 1 DAY), INTERVAL 1 DAY)),
      mad.dat_von, DAY) > 1079
    THEN 1
    ELSE 0
    END AS mo_36x,
     CASE
     WHEN DATE_DIFF(COALESCE(mahm.dat_von, DATE_ADD(DATE_SUB(IF(MAK.dat_von = LAST_DAY(MAK.dat_von), LAST_DAY(DATE_ADD(MAK
             .dat_von, INTERVAL 1 MONTH)), DATE_ADD(MAK.dat_von, INTERVAL 1 MONTH)), INTERVAL 1 DAY), INTERVAL 1 DAY)),
       mad.dat_von, DAY) < 90
     THEN 1
     ELSE 0
     END * CASE
     WHEN mahm.hr_massnahme_id = '04'
     THEN 1
     ELSE 0
     END AS aus_00_03,
     CASE
     WHEN DATE_DIFF(COALESCE(mahm.dat_von, DATE_ADD(DATE_SUB(IF(MAK.dat_von = LAST_DAY(MAK.dat_von), LAST_DAY(DATE_ADD(MAK
             .dat_von, INTERVAL 1 MONTH)), DATE_ADD(MAK.dat_von, INTERVAL 1 MONTH)), INTERVAL 1 DAY), INTERVAL 1 DAY)),
       mad.dat_von, DAY) BETWEEN 90 AND 179
     THEN 1
     ELSE 0
     END * CASE
     WHEN mahm.hr_massnahme_id = '04'
     THEN 1
     ELSE 0
     END AS aus_03_06,
     CASE
     WHEN DATE_DIFF(COALESCE(mahm.dat_von, DATE_ADD(DATE_SUB(IF(MAK.dat_von = LAST_DAY(MAK.dat_von), LAST_DAY(DATE_ADD(MAK
             .dat_von, INTERVAL 1 MONTH)), DATE_ADD(MAK.dat_von, INTERVAL 1 MONTH)), INTERVAL 1 DAY), INTERVAL 1 DAY)),
       mad.dat_von, DAY) BETWEEN 180 AND 359
     THEN 1
     ELSE 0
     END * CASE
     WHEN mahm.hr_massnahme_id = '04'
     THEN 1
     ELSE 0
     END AS aus_06_12,
     CASE
     WHEN DATE_DIFF(COALESCE(mahm.dat_von, DATE_ADD(DATE_SUB(IF(MAK.dat_von = LAST_DAY(MAK.dat_von), LAST_DAY(DATE_ADD(MAK
             .dat_von, INTERVAL 1 MONTH)), DATE_ADD(MAK.dat_von, INTERVAL 1 MONTH)), INTERVAL 1 DAY), INTERVAL 1 DAY)),
       mad.dat_von, DAY) BETWEEN 360 AND 1079
     THEN 1
     ELSE 0
     END * CASE
     WHEN mahm.hr_massnahme_id = '04'
     THEN 1
     ELSE 0
     END AS aus_12_36,
     CASE
     WHEN DATE_DIFF(COALESCE(mahm.dat_von, DATE_ADD(DATE_SUB(IF(MAK.dat_von = LAST_DAY(MAK.dat_von), LAST_DAY(DATE_ADD(MAK
             .dat_von, INTERVAL 1 MONTH)), DATE_ADD(MAK.dat_von, INTERVAL 1 MONTH)), INTERVAL 1 DAY), INTERVAL 1 DAY)),
       mad.dat_von, DAY) > 1079
     THEN 1
     ELSE 0
     END * CASE
     WHEN mahm.hr_massnahme_id = '04'
     THEN 1
     ELSE 0
     END AS aus_36x,
   MAK.dat_von AS dat_von_mo,
   DATE_SUB(IF(MAK.dat_von = LAST_DAY(MAK.dat_von), LAST_DAY(DATE_ADD(MAK.dat_von, INTERVAL 1 MONTH)), DATE_ADD(MAK.dat_von
      ,INTERVAL 1 MONTH)), INTERVAL 1 DAY) AS dat_bis_mo,
   mad.dat_von AS dat_eintritt,
   mahm.dat_von AS dat_austritt,
   mahm.hr_massnahme_grund_id,
   mahm.hr_massnahme_id,
   mad1.dat_von AS dat_kuendigung
  FROM kfl_production_dbp_view.v_ma_kostenstelle_zu_per_2 AS MAK
   LEFT JOIN (SELECT mandant_id,
     mitarbeiter_id,
     kjmo,
     datumsart_id,
     dat_von,
     dat_bis
    FROM kfl_production_dbp_view.v_ma_datumsart_zu_per_2 AS MAD
    WHERE datumsart_id IN ('02')) AS mad ON MAK.mandant_id = mad.mandant_id AND MAK.mitarbeiter_id = mad.mitarbeiter_id
    AND MAK.kjmo = mad.kjmo
   LEFT JOIN (SELECT mandant_id,
     mitarbeiter_id,
     kjmo,
     hr_massnahme_grund_id,
     hr_massnahme_id,
     dat_von,
     dat_bis
    FROM kfl_production_dbp_view.v_ma_hr_massnahme_zu_per_2 AS MAHM
    WHERE hr_massnahme_id IN ('04')) AS mahm ON MAK.mandant_id = mahm.mandant_id AND MAK.mitarbeiter_id = mahm.mitarbeiter_id
       AND MAK.kjmo = mahm.kjmo
   LEFT JOIN (SELECT mandant_id,
     mitarbeiter_id,
     kjmo,
     datumsart_id,
     dat_von,
     dat_bis
    FROM kfl_production_dbp_view.v_ma_datumsart_zu_per_2 AS MAD
    WHERE datumsart_id IN ('-1')) AS mad1 ON MAK.mandant_id = mad1.mandant_id AND MAK.mitarbeiter_id = mad1.mitarbeiter_id
       AND MAK.kjmo = mad1.kjmo) AS sub_ma ON sub_kstl.mandant_id = sub_ma.mandant_id AND sub_kstl.kostenstelle_id =
    sub_ma.kostenstelle_id AND sub_kstl.kjmo = sub_ma.kjmo
GROUP BY sub_kstl.mandant_id,
 sub_kstl.nb_id,
 sub_kstl.wup_id,
 sub_kstl.wrg_id,
 sub_kstl.kjmo,
 akt_mo_shr;