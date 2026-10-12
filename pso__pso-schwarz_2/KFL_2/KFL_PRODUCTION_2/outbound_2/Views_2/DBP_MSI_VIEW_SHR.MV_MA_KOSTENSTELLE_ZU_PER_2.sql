-- AND v99.ma_austritt_kz in (1,3)
 -- AND haupt_kst_fg_ = 1

-- K.Kaiser 20140827 -- hier werden nur die Austritte intern pro MA und Monat_2 ermittelt

-- K.Kaiser 20140829 -- Änderung: KST_Wechsel wird nur noch über mitarbeiterbew_2 geprüft

-- ,CASE WHEN SUBSTR(v04.kostenstelle_id,1,4) <> SUBSTR(kostenstelle_id_ ,1,4)
 -- 
 -- AND V99.ma_eintritt_kz = 1

-- K.Kaiser 20140827 -- hier werden die normalen Kostenstellen_ids pro MA und Monat_2 ermittelt
 -- mit Lohnart 2704

-- THEN 1 ELSE 0 END AS kst_wechsel
 -- AND v04.kostenstelle_id IS NOT NULL

-- (falls vorhanden) mit der alten Kostenstelle_id

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_ma_kostenstelle_zu_per_2 (mandant_id, mitarbeiter_id, kjmo,
kostenstelle_id, kostenstelle_id_alt, haupt_kst_fg, stunden_lohnart_2704, kst_wechsel, austritt_intern) AS SELECT t7.mandant_id
 ,
 t7.mitarbeiter_id,
 t7.kjmo,
 t7.kostenstelle_id_ AS kostenstelle_id,
 t7.kostenstelle_id_alt,
 t7.haupt_kst_fg_ AS haupt_kst_fg,
 t7.stunden_lohnart_2704,
 t7.kst_wechsel,
 0 AS austritt_intern
FROM (SELECT V01.mandant_id,
   V01.mitarbeiter_id,
   COALESCE(v02.kjmo, V01.kjmo) AS kjmo,
   COALESCE(v02.kostenstelle_id, V01.kostenstelle_id, '0000-000') AS kostenstelle_id_,
   COALESCE(V04.kostenstelle_id, '0000-000') AS kostenstelle_id_alt,
   COALESCE(v02.haupt_kst_fg, 1) AS haupt_kst_fg_,
    CASE
    WHEN V04.kostenstelle_id IS NOT NULL AND COALESCE(v02.haupt_kst_fg, 1) = 1 AND V99.ma_austritt_kz IN (1, 3) AND V99
      .ma_eintritt_kz = 1
    THEN 1
    ELSE 0
    END AS kst_wechsel,
   SUM(v02.stunden_lohnart_2704) AS stunden_lohnart_2704
  FROM kfl_production_dbp_view.v_ma_kostenstelle_zu_per_2 AS V01
   LEFT JOIN (SELECT mandant_id,
      mitarbeiter_id,
      kjmo,
      kostenstelle_id,
      stunden_lohnart AS stunden_lohnart_2704,
      0 AS haupt_kst_fg
     FROM kfl_production_dbp_view.v_ma_lohnart_zu_per_2 AS V11
     WHERE lohnart_id = '2704'
     UNION ALL
     SELECT V01.mandant_id,
      V01.mitarbeiter_id,
      V01.kjmo,
      V02.kostenstelle_id,
      SUM(V01.stunden_lohnart * - 1) AS stunden_lohnart_2704,
      1 AS haupt_kst_fg
     FROM kfl_production_dbp_view.v_ma_lohnart_zu_per_2 AS V01
      LEFT JOIN kfl_production_dbp_view.v_ma_kostenstelle_zu_per_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.mitarbeiter_id
          = V02.mitarbeiter_id AND V01.kjmo = V02.kjmo
     WHERE V01.lohnart_id = '2704'
     GROUP BY V01.mandant_id,
      V01.mitarbeiter_id,
      V01.kjmo,
      V02.kostenstelle_id,
      haupt_kst_fg) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.mitarbeiter_id = v02.mitarbeiter_id AND V01.kjmo =
     v02.kjmo
   INNER JOIN kfl_production_dbp_msi_view_shr.mv_monat_2 AS V03 ON V01.kjmo = V03.kjmo
   LEFT JOIN kfl_production_dbp_view.v_ma_kostenstelle_zu_per_2 AS V04 ON V01.mitarbeiter_id = V04.mitarbeiter_id AND V03
      .kjmo_vm = V04.kjmo AND V01.mandant_id = V04.mandant_id
   LEFT JOIN kfl_production_dbp_view.v_mitarbeiterbew_2 AS V99 ON V01.mitarbeiter_id = V99.mitarbeiter_id AND V03.kjmo =
      V99.kjmo AND V01.mandant_id = V99.mandant_id
  GROUP BY V01.mandant_id,
   V01.mitarbeiter_id,
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
FROM kfl_production_dbp_msi_view_shr.mv_ma_kostenstelle_austr_int_2 AS V05
GROUP BY mandant_id,
 mitarbeiter_id,
 kjmo,
 kostenstelle_id,
 kostenstelle_id_alt,
 haupt_kst_fg,
 kst_wechsel,
 austritt_intern;