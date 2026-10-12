-- 03.01.2020, [nw] - Added kj(_lief_beleg)
 -- 2024-01-31, INC7963291, dknop, change kunde_id

-- 15.11.2016, AP0006317 - Vor- und Nachlaufpaletten, srom0404 Neuerstellung

-- 09.02.2021, AP0078007, SPEC0101516, srom0404, lief_pal_typ_id auf STRING

-- 2023-05-26, dknop, adding filter lief_typ_id in ('YM','YU','YNOT','NL','ZLFI','ZLCC','YCD2','ZDD') to v04

-- 2024-08-01,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic

-- 2024-09-09, dknop, change to left join with dbp_view.v_wup_1

-- 29.05.2017, AP0006317 - COALESCE(v03.werbeware_id, '.') es sollen auch die NULL durch den Berichtsfilter <> 'W' angezeigt werden

-- 04.04.2017, AP0006317 - Ergänzung: Erste Tour_1 des Tages Flag
 -- 2025-05-27, nwag, changes for WANKO

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_tour_vorlauf_nachlauf_1 (mandant_id, wup_id, nb_id, dat_tour,
tour_id, belos_tourstatus_id, distribution_abr_fg, mandant_id_kunde, kunde_id, lagernummer_id, lief_beleg_id,
dat_lief_soll, kj, lief_pal_typ_id, werbeware_id, cd_kz, handling_unit_id_ext, hu_status_id, traegertyp_bez, oug_tour_fg
, erste_tour_des_tages_fg, hu_stellplatz_faktor, hu_stellplatz_faktor_o_aufgepackt, hu_stellplatz_faktor_gt_0_fg,
abweichung_in_tagen, abweichung_in_tagen_bereinigt, stellplaetze_vorlauf, stellplaetze_nachlauf_eq_1tag_ok_oug,
stellplaetze_nachlauf_eq_1tag_nok, stellplaetze_nachlauf_gt_1tag_nok, stellplaetze_tour_eq_liefer_datum,
schwellwert_vorlauf, schwellwert_nachlauf) AS -- 'AUFGEPACKT'

-- Abweichung soll nur für Datensätze mit hu_stellplatz_faktor_o_aufgepackt > 0

-- erste Tour_1 des Tages (sollte die O&G Tour_1 sein, muss aber nicht immer) wird auch betrachtet

-- Anzahl Märkte mit Fehler Vorlaufpaletten. Um Anzahl als Summe abzubilden, wird eine_1 1 weggeschrieben

-- Diese kann dann im Bericht aufsummiert werden.
 -- Metrik hat MAX in der Definitionen und SUM bei Aggregation

-- Auch wenn ein Markt mehrere Fehler pro Tag_1 in verschiedenen Touren hat, wird das pro Tag_1 nur 1x gezählt

-- ,CASE WHEN SUM(CASE WHEN stellplaetze_vorlauf > 0 THEN stellplaetze_vorlauf ELSE 0 END) OVER (PARTITION BY t1.mandant_id, t1.wup_id, t1.mandant_id_kunde, t1.kunde_id, t1.dat_tour)

-- > schwellwert_vorlauf THEN 1
 -- ELSE 0
 -- END AS fehler_vorlauf_fg

-- Anzahl Märkte mit Fehler Vorlaufpaletten. Um Anzahl als Summe abzubilden, wird eine_1 1 weggeschrieben

-- Diese kann dann im Bericht aufsummiert werden.
 -- Metrik hat MAX in der Definitionen und SUM bei Aggregation

-- Auch wenn ein Markt mehrere Fehler pro Tag_1 in verschiedenen Touren hat, wird das pro Tag_1 nur 1x gezählt

-- ,CASE WHEN SUM(CASE WHEN stellplaetze_nachlauf_eq_1tag_ok_oug > 0 THEN stellplaetze_nachlauf_eq_1tag_ok_oug ELSE 0 END) OVER (PARTITION BY t1.mandant_id, t1.wup_id, t1.mandant_id_kunde, t1.kunde_id, t1.dat_tour)

-- > schwellwert_nachlauf
 -- OR stellplaetze_nachlauf_eq_1tag_nok > 0 OR stellplaetze_nachlauf_gt_1tag_nok > 0 THEN 1

-- ELSE 0
 -- END AS fehler_nachlauf_fg
 -- t1_1
 -- t001_1
 -- t01

-- new: only consider relevant deliveries (e.g. no store returns to DC):
 -- v08, ermittelt die erste Tour_1 des Tages

-- Nur nach Zeit_1 sortieren ist nicht eindeutig. Es kann mehrere Touren zur gleichen Zeit_1 geben. Daher noch die tour_id als Hilfskonstrukt genommen

-- tour_id ist eine_1 fortlaufende Nummer und daher ist dann wohl bei gleichen Zeiten die kleinere tour_id, die erste Tour_1

SELECT t1.mandant_id,
 t1.wup_id,
 t1.nb_id,
 t1.dat_tour,
 t1.tour_id,
 t1.belos_tourstatus_id,
 t1.distribution_abr_fg,
 t1.mandant_id_kunde
 -- ,CASE WHEN TRY_CAST(SUBSTR(kunde_id,7,4) AS INTEGER) IS NULL THEN -3 ELSE TRY_CAST(SUBSTR(kunde_id,7,4) AS INTEGER) END AS kunde_id

 ,
 V05.aktuell_wup_id AS kunde_id,
 t1.lagernummer_id,
 t1.lief_beleg_id,
 t1.dat_lief_soll,
 t1.kj,
 t1.lief_pal_typ_id,
 t1.werbeware_id,
 t1.cd_kz,
 t1.handling_unit_id_ext,
 t1.hu_status_id,
  CASE
  WHEN t1.versandeinheit_id NOT IN (1, - 1)
  THEN 'AUFGEPACKT'
  WHEN t1.versandeinheit_id = - 1
  THEN 'NORMAL'
  WHEN t1.versandeinheit_id = 1
  THEN 'TRÄGER'
  ELSE NULL
  END AS traegertyp_bez,
 t1.oug_tour_fg,
 t1.erste_tour_des_tages_fg,
 t1.hu_stellplatz_faktor,
  CASE
  WHEN t1.versandeinheit_id IN (- 1, 1)
  THEN t1.hu_stellplatz_faktor -- 'NORMAL', 'TRÄGER'

  ELSE 0
  END AS hu_stellplatz_faktor_o_aufgepackt,
  CASE
  WHEN CASE
    WHEN t1.versandeinheit_id IN (- 1, 1)
    THEN t1.hu_stellplatz_faktor
    ELSE 0
    END > 0
  THEN 1
  ELSE 0
  END AS hu_stellplatz_faktor_gt_0_fg,
   CASE
   WHEN CASE
     WHEN t1.versandeinheit_id IN (- 1, 1)
     THEN t1.hu_stellplatz_faktor
     ELSE 0
     END > 0
   THEN 1
   ELSE 0
   END * DATE_DIFF(t1.dat_tour, t1.dat_lief_soll, DAY) AS abweichung_in_tagen,
   CASE
   WHEN CASE
     WHEN t1.versandeinheit_id IN (- 1, 1)
     THEN t1.hu_stellplatz_faktor
     ELSE 0
     END > 0
   THEN 1
   ELSE 0
   END * t1.abweichung_in_tagen_bereinigt AS abweichung_in_tagen_bereinigt,
   CASE
   WHEN CASE
     WHEN t1.versandeinheit_id IN (- 1, 1)
     THEN t1.hu_stellplatz_faktor
     ELSE 0
     END > 0
   THEN 1
   ELSE 0
   END * CASE
   WHEN t1.abweichung_in_tagen_bereinigt < 0
   THEN CASE
    WHEN t1.versandeinheit_id IN (- 1, 1)
    THEN t1.hu_stellplatz_faktor
    ELSE 0
    END
   ELSE 0
   END AS stellplaetze_vorlauf,
   CASE
   WHEN CASE
     WHEN t1.versandeinheit_id IN (- 1, 1)
     THEN t1.hu_stellplatz_faktor
     ELSE 0
     END > 0
   THEN 1
   ELSE 0
   END * CASE
   WHEN t1.abweichung_in_tagen_bereinigt = 1 AND (t1.oug_tour_fg = 1 OR t1.erste_tour_des_tages_fg = 1)
   THEN CASE
    WHEN t1.versandeinheit_id IN (- 1, 1)
    THEN t1.hu_stellplatz_faktor
    ELSE 0
    END
   ELSE 0
   END AS stellplaetze_nachlauf_eq_1tag_ok_oug,
   CASE
   WHEN CASE
     WHEN t1.versandeinheit_id IN (- 1, 1)
     THEN t1.hu_stellplatz_faktor
     ELSE 0
     END > 0
   THEN 1
   ELSE 0
   END * CASE
   WHEN t1.abweichung_in_tagen_bereinigt = 1 AND t1.oug_tour_fg = 0 AND t1.erste_tour_des_tages_fg = 0
   THEN CASE
    WHEN t1.versandeinheit_id IN (- 1, 1)
    THEN t1.hu_stellplatz_faktor
    ELSE 0
    END
   ELSE 0
   END AS stellplaetze_nachlauf_eq_1tag_nok,
   CASE
   WHEN CASE
     WHEN t1.versandeinheit_id IN (- 1, 1)
     THEN t1.hu_stellplatz_faktor
     ELSE 0
     END > 0
   THEN 1
   ELSE 0
   END * CASE
   WHEN t1.abweichung_in_tagen_bereinigt > 1
   THEN CASE
    WHEN t1.versandeinheit_id IN (- 1, 1)
    THEN t1.hu_stellplatz_faktor
    ELSE 0
    END
   ELSE 0
   END AS stellplaetze_nachlauf_gt_1tag_nok,
   CASE
   WHEN CASE
     WHEN t1.versandeinheit_id IN (- 1, 1)
     THEN t1.hu_stellplatz_faktor
     ELSE 0
     END > 0
   THEN 1
   ELSE 0
   END * CASE
   WHEN t1.abweichung_in_tagen_bereinigt = 0
   THEN CASE
    WHEN t1.versandeinheit_id IN (- 1, 1)
    THEN t1.hu_stellplatz_faktor
    ELSE 0
    END
   ELSE 0
   END AS stellplaetze_tour_eq_liefer_datum,
 v09.schwellwert_vorlauf,
 v10.schwellwert_nachlauf
FROM (SELECT t001.mandant_id,
   t001.wup_id,
   t001.nb_id,
   t001.dat_tour,
   t001.tour_id,
   t001.belos_tourstatus_id,
   t001.distribution_abr_fg,
   t001.mandant_id_kunde,
   t001.kunde_id,
   t001.lagernummer_id,
   t001.lief_beleg_id,
   t001.dat_lief_soll,
   t001.kj,
   MAX(t001.abweichung_in_tagen_bereinigt) AS abweichung_in_tagen_bereinigt,
   t001.lief_pal_typ_id,
   t001.werbeware_id,
   t001.cd_kz,
   V07.handling_unit_id_ext,
   V07.hu_status_id,
   V07.versandeinheit_id,
   v08.oug_tour_fg,
   v08.erste_tour_des_tages_fg,
   V07.hu_stellplatz_faktor
  FROM (SELECT V01.mandant_id,
     V01.wup_id,
     V01.nb_id,
     V01.dat_tour,
     V01.tour_id,
      CASE
      WHEN v021.tms_tourstatus_id IN (10, 20)
      THEN CAST(- 1 AS BIGNUMERIC)
      WHEN v021.tms_tourstatus_id IN (30, 40)
      THEN 2
      WHEN v021.tms_tourstatus_id IN (50, 51)
      THEN 3
      ELSE COALESCE(V01.belos_tourstatus_id, - 1)
      END AS belos_tourstatus_id,
     COALESCE(v021.distribution_abr_fg, V01.distribution_abr_fg) AS distribution_abr_fg,
     V02.mandant_id_kunde,
     V02.kunde_id,
     V02.lagernummer_id,
     V02.lief_beleg_id,
     V03.dat_lief_soll,
     V03.kj,
     SUM(CASE
       WHEN V01.dat_tour < t6.dat_lief_soll
       THEN - 1
       WHEN V01.dat_tour > t6.dat_lief_soll
       THEN 1
       WHEN V01.dat_tour = t6.dat_lief_soll
       THEN 0
       ELSE NULL
       END) AS abweichung_in_tagen_bereinigt,
     CAST(V03.lief_pal_typ_id AS STRING) AS lief_pal_typ_id,
     COALESCE(V03.werbeware_id, '-') AS werbeware_id,
      CASE
      WHEN V03.cd_kz IS NULL OR V03.cd_kz = ''
      THEN '-1'
      ELSE V03.cd_kz
      END AS cd_kz
    FROM kfl_production_dbp_view.v_tour_1 AS V01
     INNER JOIN kfl_production_dbp_view.v_tour_det_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id
         AND V01.tour_id = V02.tour_id
     LEFT JOIN (SELECT DISTINCT mandant_id,
       ROUND(SAFE_CAST(startlager_tms_gp_id AS BIGNUMERIC), 0) AS wup_id,
       ROUND(SAFE_CAST(RIGHT(transportation_unit_id_ext, LENGTH(TRIM(transportation_unit_id_ext)) - 6) AS BIGNUMERIC), 0
        ) AS tour_id,
       dat_tour,
        CASE
        WHEN tms_tourtyp_id = 105
        THEN 0
        ELSE 1
        END AS distribution_abr_fg,
       tms_tourart_id,
       tms_tourstatus_id
      FROM kfl_production_dbp_data.tms_tour_1 AS TMS_TOUR_1
      WHERE LEFT(transportation_unit_id_ext, 3) = 'SAP'
       AND EXTRACT(YEAR FROM dat_tour) >= EXTRACT(YEAR FROM CURRENT_DATE) - 2
       AND EXISTS (SELECT 1
        FROM kfl_production_dbp_msi_data.ts_lagernummer_sortierung_scm_1 AS V022
        WHERE TMS_TOUR.dat_tour >= dat_tms_wanko
         AND TMS_TOUR.mandant_id = mandant_id
         AND ROUND(SAFE_CAST(TMS_TOUR.startlager_tms_gp_id AS BIGNUMERIC), 0) = wup_id)) AS v021 ON V01.mandant_id =
        v021.mandant_id AND V01.wup_id = v021.wup_id AND V01.tour_id = v021.tour_id
     INNER JOIN kfl_production_dbp_view.v_besch_lief_1 AS V03 ON V02.mandant_id_kunde = V03.mandant_id_kunde AND V02.kunde_id
          = V03.kunde_id AND V02.lief_beleg_id = V03.lief_beleg_id AND V02.kj_lief_beleg = V03.kj
       -- Änderung gegenüber Konzept. Man geht davon aus, das die Soll Liefertage keine Feiertage o.ä enthalten

       -- Alle Soll- Liefertage pro Kunde (unabhängig von der Lieferung) zeigen also die möglichen Liefertage

       -- Durch CROSS JOIN Between werden dann zusätzliche Sätze erzeugt. Das Flag abweichung_in_tagen_bereinigt pro erzeugten Satz kann aufsummiert werden

       -- und zeigt dann die Anzahl möglicher Liefertage zwischen Tourdatum und Soll-Lieferdatum

     LEFT JOIN (SELECT mandant_id_kunde,
       kunde_id,
       dat_lief_soll
      FROM kfl_production_dbp_view.v_besch_lief_1
      WHERE lief_typ_id IN ('YM', 'YU', 'YNOT', 'NL', 'ZLFI', 'ZLCC', 'YCD2', 'ZDD')
      GROUP BY dat_lief_soll,
       kunde_id,
       mandant_id_kunde) AS t6 ON V02.mandant_id_kunde = t6.mandant_id_kunde AND V02.kunde_id = t6.kunde_id AND (t6.dat_lief_soll
         BETWEEN V01.dat_tour AND V03.dat_lief_soll -- Lieferdatum nach Tourdatum
 OR t6.dat_lief_soll BETWEEN V03.dat_lief_soll
         AND V01.dat_tour -- Lieferdatum vor Tourdatum
)
    WHERE V02.loesch_fg = 0
    GROUP BY V01.mandant_id,
     V01.wup_id,
     V01.nb_id,
     V01.dat_tour,
     V01.tour_id,
     belos_tourstatus_id,
     distribution_abr_fg,
     V02.mandant_id_kunde,
     V02.kunde_id,
     V02.lagernummer_id,
     V02.lief_beleg_id,
     V03.dat_lief_soll,
     V03.kj,
     V03.lief_pal_typ_id,
     werbeware_id,
     cd_kz) AS t001_1
   INNER JOIN kfl_production_dbp_view.v_handling_unit_1 AS V07 ON t001.mandant_id = V07.mandant_id AND t001.wup_id = V07.wup_id
         AND t001.nb_id = V07.nb_id AND t001.lief_beleg_id = V07.lief_beleg_id AND t001.kj = V07.kj_lief_beleg
   LEFT JOIN (SELECT mandant_id,
     wup_id,
     nb_id,
     tour_id,
     mandant_id_kunde,
     kunde_id,
     MAX(oug_tour_fg) AS oug_tour_fg,
     MAX(erste_tour_des_tages_fg) AS erste_tour_des_tages_fg
    FROM (SELECT V081.mandant_id,
       V081.wup_id,
       V081.nb_id,
       V081.tour_id,
       V081.mandant_id_kunde,
       V081.kunde_id,
       V081.oug_tour_fg,
        CASE
        WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(V081.mandant_id AS STRING), CAST(V081.wup_id AS STRING), CAST(V081.mandant_id_kunde AS STRING)
             , V081.kunde_id, V081.dat_tour ORDER BY V082.distribution_abr_fg IS NULL, V082.distribution_abr_fg, CASE
              WHEN V081.zeit_plan_ankunft <> '00:00:00' AND V081.zeit_relevant_fg = 1
              THEN 1
              ELSE 0
              END IS NULL, CASE
              WHEN V081.zeit_plan_ankunft <> '00:00:00' AND V081.zeit_relevant_fg = 1
              THEN 1
              ELSE 0
              END, V081.zeit_plan_ankunft IS NULL, V081.zeit_plan_ankunft, V081.tour_id IS NULL, V081.tour_id)) = 1
        THEN 1
        ELSE 0
        END AS erste_tour_des_tages_fg
      FROM kfl_production_dbp_view.v_tour_det_zlv_vttkl_1 AS V081
       INNER JOIN kfl_production_dbp_view.v_tour_1 AS V082 ON V081.mandant_id = V082.mandant_id AND V081.wup_id = V082.wup_id
           AND V081.tour_id = V082.tour_id) AS v08a
    GROUP BY mandant_id,
     wup_id,
     nb_id,
     tour_id,
     mandant_id_kunde,
     kunde_id) AS v08 ON t001.mandant_id = v08.mandant_id AND t001.wup_id = v08.wup_id AND t001.nb_id = v08.nb_id AND
       t001.tour_id = v08.tour_id AND t001.mandant_id_kunde = v08.mandant_id_kunde AND t001.kunde_id = v08.kunde_id
  GROUP BY t001.mandant_id,
   t001.wup_id,
   t001.nb_id,
   t001.dat_tour,
   t001.tour_id,
   t001.belos_tourstatus_id,
   t001.distribution_abr_fg,
   t001.mandant_id_kunde,
   t001.kunde_id,
   t001.lagernummer_id,
   t001.lief_beleg_id,
   t001.dat_lief_soll,
   t001.kj,
   t001.lief_pal_typ_id,
   t001.werbeware_id,
   t001.cd_kz,
   V07.versandeinheit_id,
   V07.handling_unit_id_ext,
   V07.hu_status_id,
   V07.hu_stellplatz_faktor,
   v08.oug_tour_fg,
   v08.erste_tour_des_tages_fg) AS t1_1
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V05 ON V05.mandant_id = CASE
     WHEN t1.mandant_id_kunde IS NULL OR t1.mandant_id_kunde = 0
     THEN t1.mandant_id
     ELSE t1.mandant_id_kunde
     END AND V05.wup_id = CASE
     WHEN ROUND(SAFE_CAST(t1.kunde_id AS BIGNUMERIC), 0) = 0
     THEN NULL
     ELSE ROUND(SAFE_CAST(t1.kunde_id AS BIGNUMERIC), 0)
     END AND (V05.nb_id IN (2, 0, - 111) AND V05.wup_id > 0 OR V05.nb_id = - 1 AND V05.wup_id = 0)
 INNER JOIN (SELECT mandant_id,
   wup_id,
   nb_id,
   schwellwert AS schwellwert_vorlauf
  FROM kfl_production_dbp_msi_view3.ts_lis_schwellwerte_1
  WHERE schwellwert_typ_bez = '08.23 Vor und Nachlauf Vorlaufpaletten') AS v09 ON t1.mandant_id = v09.mandant_id AND t1_1
    .wup_id = v09.wup_id AND t1.nb_id = v09.nb_id
 INNER JOIN (SELECT mandant_id,
   wup_id,
   nb_id,
   schwellwert AS schwellwert_nachlauf
  FROM kfl_production_dbp_msi_view3.ts_lis_schwellwerte_1
  WHERE schwellwert_typ_bez = '08.23 Vor und Nachlauf Nachlauflaufpaletten') AS v10 ON t1.mandant_id = v10.mandant_id
   AND t1.wup_id = v10.wup_id AND t1.nb_id = v10.nb_id
WHERE EXTRACT(YEAR FROM t1.dat_tour) >= EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2;