-- AND v99.ma_austritt_kz in (1,3)
 -- mit Lohnart 2704

-- ,CASE WHEN SUBSTR(v04.kostenstelle_id,1,4) <> SUBSTR(kostenstelle_id_ ,1,4)
 -- AND V99.ma_eintritt_kz = 1

-- THEN 1 ELSE 0 END AS kst_wechsel

-- K.Kaiser 20140827 -- hier werden nur die Austritte intern pro MA und Monat_1 ermittelt

-- (falls vorhanden) mit der alten Kostenstelle_id

-- K.Kaiser 20140827 -- hier werden die normalen Kostenstellen_ids pro MA und Monat_1 ermittelt

-- AND v04.kostenstelle_id IS NOT NULL
 -- AND haupt_kst_fg_ = 1

CREATE OR REPLACE VIEW dbp_msi_view_shr.mv_ma_kostenstelle_zu_per_1 (mandant_id, mitarbeiter_id, kjmo, kostenstelle_id,
kostenstelle_id_alt, haupt_kst_fg, stunden_lohnart_2704, kst_wechsel, austritt_intern) AS SELECT t7.mandant_id,
 t7.mitarbeiter_id,
 t7.kjmo,
 t7.kostenstelle_id_ AS kostenstelle_id,
 t7.kostenstelle_id_alt,
 t7.haupt_kst_fg_ AS haupt_kst_fg,
 t7.stunden_lohnart_2704,
 t7.kst_wechsel,
 0 AS austritt_intern
FROM (SELECT v01.mandant_id,
   v01.mitarbeiter_id,
   COALESCE(v02.kjmo, v01.kjmo) AS kjmo,
   COALESCE(v02.kostenstelle_id, v01.kostenstelle_id, '0000-000') AS kostenstelle_id_,
   COALESCE(v04.kostenstelle_id, '0000-000') AS kostenstelle_id_alt,
   COALESCE(v02.haupt_kst_fg, 1) AS haupt_kst_fg_,
    CASE
    WHEN COALESCE(v02.haupt_kst_fg, 1) = 1 AND v99.ma_austritt_kz IN (1, 3) AND v99.ma_eintritt_kz = 1 AND v04.kostenstelle_id
     IS NOT NULL
    THEN 1
    ELSE 0
    END AS kst_wechsel,
   SUM(v02.stunden_lohnart_2704) AS stunden_lohnart_2704
  FROM kfl_production_dbp_view.v_ma_kostenstelle_zu_per_1 AS v01
   LEFT JOIN (SELECT mandant_id,
      mitarbeiter_id,
      kjmo,
      kostenstelle_id,
      stunden_lohnart AS stunden_lohnart_2704,
      0 AS haupt_kst_fg
     FROM kfl_production_dbp_view.v_ma_lohnart_zu_per_1 AS v11
     WHERE lohnart_id = '2704'
     UNION ALL
     SELECT v01.mandant_id,
      v01.mitarbeiter_id,
      v01.kjmo,
      v02.kostenstelle_id,
      SUM(v01.stunden_lohnart * - 1) AS stunden_lohnart_2704,
      1 AS haupt_kst_fg
     FROM kfl_production_dbp_view.v_ma_lohnart_zu_per_1 AS v01
      LEFT JOIN kfl_production_dbp_view.v_ma_kostenstelle_zu_per_1 AS v02 ON v01.mandant_id = v02.mandant_id AND v01.mitarbeiter_id
          = v02.mitarbeiter_id AND v01.kjmo = v02.kjmo
     WHERE v01.lohnart_id = '2704'
     GROUP BY v01.mandant_id,
      v01.mitarbeiter_id,
      v01.kjmo,
      v02.kostenstelle_id,
      haupt_kst_fg) AS v02 ON v01.mandant_id = v02.mandant_id AND v01.mitarbeiter_id = v02.mitarbeiter_id AND v01.kjmo =
     v02.kjmo
   INNER JOIN dbp_msi_view_shr.mv_monat_1 AS v03 ON v01.kjmo = v03.kjmo
   LEFT JOIN kfl_production_dbp_view.v_ma_kostenstelle_zu_per_1 AS v04 ON v01.mitarbeiter_id = v04.mitarbeiter_id AND v03
      .kjmo_vm = v04.kjmo AND v01.mandant_id = v04.mandant_id
   LEFT JOIN kfl_production_dbp_view.v_mitarbeiterbew_1 AS v99 ON v01.mitarbeiter_id = v99.mitarbeiter_id AND v03.kjmo =
      v99.kjmo AND v01.mandant_id = v99.mandant_id
  GROUP BY v01.mandant_id,
   v01.mitarbeiter_id,
   kjmo,
   kostenstelle_id_,
   kostenstelle_id_alt,
   haupt_kst_fg_,
   kst_wechsel) AS t7
UNION ALL
SELECT mandant_id,
 mitarbeiter_id,
 kjmo,
 kostenstelle_id,
 '9999-999' AS kostenstelle_id_alt,
 0 AS haupt_kst_fg,
 CAST(NULL AS NUMERIC) AS stunden_lohnart_2704,
 1 AS kst_wechsel,
 austritt_intern
FROM dbp_msi_view_shr.mv_ma_kostenstelle_austr_int_1 AS v05
GROUP BY mandant_id,
 mitarbeiter_id,
 kjmo,
 kostenstelle_id,
 kostenstelle_id_alt,
 haupt_kst_fg,
 kst_wechsel,
 austritt_intern;