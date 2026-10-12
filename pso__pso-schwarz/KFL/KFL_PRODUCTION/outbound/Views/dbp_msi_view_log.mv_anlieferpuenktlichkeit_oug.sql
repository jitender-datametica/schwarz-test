
-- 2023-11-02,AP0194349,SPEC0222332 dknop, initial
 -- 2024-11-14, AP0240092, nwag, add KJ_TRANSPORTATION_UNIT

-- 2025-09-19, nwag, INC11675222
 -- 2024-10-22, AP0210954_SPEC0239355, dknop, also display TDL+tourart for WANKO Tours

-- 2024-11-20, AP0240092, dat tour TRANSPORTATION_UNIT_KUNDE can differ

-- 2024-07-19,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic

-- 2024-09-18, dknop, limiting to t_unit.dat_tour >= 01.01.2022 because of transportation_unit duplication

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_anlieferpuenktlichkeit_oug (mandant_id, wup_id, dat_tour,
transportation_unit_id, kj_transportation_unit, mandant_id_kunde, kunde_id, lagernummer_id, distribution_abr_fg,
dat_plan_ankunft_orig, zeit_plan_ankunft_orig, vorlieferung_fg, dat_plan_ankunft, zeit_anlieferung_og,
datzeit_anlieferung_og, dat_scan, zeit_scan, datzeit_scan, datzeit_scan_karenz, zeit_scan_karenz,
diff_plan_scan_minuten_karenz, og_intime_fg, punktlichkeit_ankunft_markt, punktlichkeit_ankunft_vz,
punktlichkeit_abfahrt_vz, datzeit_start_plan, datzeit_start_ist, datzeit_ende_plan, datzeit_ende_ist,
aktivitaet_richtung_id, tms, belos_adresse_spedition_id, tdl_id, tour_service_id, plombe_prozess_id,
transportation_unit_anzahl, anzahl_stellplatz_ewm_parent_lsort2, fg, rank_1, rank_2) AS -- ,hu_s.kunde_id
 -- 

-- AND w.wup_id = CASE WHEN TRY_CAST(hu_s.kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(hu_s.kunde_id AS INTEGER) END

SELECT t11.mandant_id,
 t11.wup_id,
 t11.dat_plan_ankunft_orig AS dat_tour,
 t11.transportation_unit_id,
 t11.kj_transportation_unit,
 t11.mandant_id_kunde
 -- ,CASE WHEN TRY_CAST(hu_s.kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END kunde_id_

 ,
 t11.kunde_id_,
 t11.lagernummer_id,
 t11.distribution_abr_fg,
 t11.dat_plan_ankunft_orig,
 t11.zeit_plan_ankunft_orig,
  CASE
  WHEN t11.zeit_plan_ankunft_orig BETWEEN TIME '19:00:00' AND TIME '23:59:59'
  THEN 1
  ELSE 0
  END AS vorlieferung_fg,
  CASE
  WHEN CASE
    WHEN t11.zeit_plan_ankunft_orig BETWEEN TIME '19:00:00' AND TIME '23:59:59'
    THEN 1
    ELSE 0
    END = 1
  THEN DATE_ADD(t11.dat_plan_ankunft_orig, INTERVAL 1 DAY)
  ELSE t11.dat_plan_ankunft_orig
  END AS dat_plan_ankunft,
 COALESCE(t11.zeit_anlieferung, TIME '06:00:00') AS zeit_anlieferung_og_,
 DATETIME(CASE
   WHEN CASE
     WHEN t11.zeit_plan_ankunft_orig BETWEEN TIME '19:00:00' AND TIME '23:59:59'
     THEN 1
     ELSE 0
     END = 1
   THEN DATE_ADD(t11.dat_plan_ankunft_orig, INTERVAL 1 DAY)
   ELSE t11.dat_plan_ankunft_orig
   END, COALESCE(t11.zeit_anlieferung, TIME '06:00:00')) AS datzeit_anlieferung_og,
  CASE
  WHEN t11.mandant_id7 IN (4, 7, 8) AND COALESCE(CAST(snowconvert_public.time_to_int_udf(t11.zeit_scan) AS BIGNUMERIC),
     0) >= 230000
  THEN DATE_ADD(t11.dat_scan, INTERVAL 1 DAY)
  ELSE t11.dat_scan
  END AS dat_scan_,
  CASE
  WHEN t11.mandant_id7 IN (4, 7, 8)
  THEN CASE
   WHEN COALESCE(CAST(snowconvert_public.time_to_int_udf(t11.zeit_scan) AS BIGNUMERIC), 0) >= 230000
   THEN snowconvert_public.int_to_time_udf(snowconvert_public.time_to_int_udf(t11.zeit_scan) - 230000)
   ELSE snowconvert_public.int_to_time_udf(snowconvert_public.time_to_int_udf(t11.zeit_scan) + 10000)
   END
  ELSE t11.zeit_scan
  END AS zeit_scan,
 t11.datzeit_scan,
 DATETIME_ADD(DATETIME(CASE
    WHEN t11.mandant_id7 IN (4, 7, 8) AND COALESCE(CAST(snowconvert_public.time_to_int_udf(t11.zeit_scan) AS BIGNUMERIC)
       , 0) >= 230000
    THEN DATE_ADD(t11.dat_scan, INTERVAL 1 DAY)
    ELSE t11.dat_scan
    END, t11.zeit_scan), INTERVAL - 15 MINUTE) AS datzeit_scan_karenz,
 TIME(DATETIME_ADD(DATETIME(CASE
     WHEN t11.mandant_id7 IN (4, 7, 8) AND COALESCE(CAST(snowconvert_public.time_to_int_udf(t11.zeit_scan) AS BIGNUMERIC)
        , 0) >= 230000
     THEN DATE_ADD(t11.dat_scan, INTERVAL 1 DAY)
     ELSE t11.dat_scan
     END, t11.zeit_scan), INTERVAL - 15 MINUTE)) AS zeit_scan_karenz,
 DATETIME_DIFF(DATETIME(CASE
    WHEN CASE
      WHEN t11.zeit_plan_ankunft_orig BETWEEN TIME '19:00:00' AND TIME '23:59:59'
      THEN 1
      ELSE 0
      END = 1
    THEN DATE_ADD(t11.dat_plan_ankunft_orig, INTERVAL 1 DAY)
    ELSE t11.dat_plan_ankunft_orig
    END, COALESCE(t11.zeit_anlieferung, TIME '06:00:00')), DATETIME_ADD(DATETIME(CASE
     WHEN t11.mandant_id7 IN (4, 7, 8) AND COALESCE(CAST(snowconvert_public.time_to_int_udf(t11.zeit_scan) AS BIGNUMERIC)
        , 0) >= 230000
     THEN DATE_ADD(t11.dat_scan, INTERVAL 1 DAY)
     ELSE t11.dat_scan
     END, t11.zeit_scan), INTERVAL - 15 MINUTE), MINUTE) AS diff_plan_scan_minuten_karenz,
  CASE
  WHEN t11.zeit_scan IS NULL OR DATETIME_DIFF(DATETIME(CASE
       WHEN CASE
         WHEN t11.zeit_plan_ankunft_orig BETWEEN TIME '19:00:00' AND TIME '23:59:59'
         THEN 1
         ELSE 0
         END = 1
       THEN DATE_ADD(t11.dat_plan_ankunft_orig, INTERVAL 1 DAY)
       ELSE t11.dat_plan_ankunft_orig
       END, COALESCE(t11.zeit_anlieferung, TIME '06:00:00')), DATETIME_ADD(DATETIME(CASE
        WHEN t11.mandant_id7 IN (4, 7, 8) AND COALESCE(CAST(snowconvert_public.time_to_int_udf(t11.zeit_scan) AS BIGNUMERIC)
           , 0) >= 230000
        THEN DATE_ADD(t11.dat_scan, INTERVAL 1 DAY)
        ELSE t11.dat_scan
        END, t11.zeit_scan), INTERVAL - 15 MINUTE), MINUTE) >= 0
  THEN 1
  ELSE 0
  END AS og_intime_fg,
  CASE
  WHEN CASE
    WHEN t11.zeit_scan IS NULL OR DATETIME_DIFF(DATETIME(CASE
         WHEN CASE
           WHEN t11.zeit_plan_ankunft_orig BETWEEN TIME '19:00:00' AND TIME '23:59:59'
           THEN 1
           ELSE 0
           END = 1
         THEN DATE_ADD(t11.dat_plan_ankunft_orig, INTERVAL 1 DAY)
         ELSE t11.dat_plan_ankunft_orig
         END, COALESCE(t11.zeit_anlieferung, TIME '06:00:00')), DATETIME_ADD(DATETIME(CASE
          WHEN t11.mandant_id7 IN (4, 7, 8) AND COALESCE(CAST(snowconvert_public.time_to_int_udf(t11.zeit_scan) AS BIGNUMERIC)
             , 0) >= 230000
          THEN DATE_ADD(t11.dat_scan, INTERVAL 1 DAY)
          ELSE t11.dat_scan
          END, t11.zeit_scan), INTERVAL - 15 MINUTE), MINUTE) >= 0
    THEN 1
    ELSE 0
    END = 1
  THEN 1
  ELSE 0
  END AS punktlichkeit_ankunft_markt,
 t11.punktlichkeit_ankunft_vz,
 t11.punktlichkeit_abfahrt_vz,
 PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(t11.datzeit_start_plan AS STRING), 1, 6)) AS datzeit_start_plan,
 PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(t11.datzeit_start_ist AS STRING), 1, 6)) AS datzeit_start_ist,
 PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(t11.datzeit_ende_plan AS STRING), 1, 6)) AS datzeit_ende_plan,
 PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(t11.datzeit_ende_ist AS STRING), 1, 6)) AS datzeit_ende_ist,
 t11.aktivitaet_richtung_id -- ,t_unit.belos_adresse_spedition_id ---to be removed
,
 t11.tms,
  CASE
  WHEN t11.tms = 'WANKO'
  THEN SUBSTR(CAST(t11.distribution_abr_fg AS STRING), 1, 40)
  ELSE COALESCE(t11.belos_adresse_spedition_id, '-1')
  END AS belos_adresse_spedition_id,
  CASE
  WHEN t11.tms = 'WANKO'
  THEN SUBSTR(CAST(t11.distribution_abr_fg AS STRING), 1, 40)
  ELSE COALESCE(t11.belos_adresse_spedition_id, '-1')
  END AS tdl_id,
 t11.tour_service_id,
 COALESCE(CASE
   WHEN t11.plombe_prozess_id IN (1, 3)
   THEN 1
   WHEN t11.plombe_prozess_id = 2
   THEN 2
   ELSE - 1
   END, - 1) AS plombe_prozess_id_,
 t11.transportation_unit_anzahl,
 t11.anzahl_stellplatz_ewm_ext_parent_lsort2_,
  CASE
  WHEN (SUM(t11.anzahl_stellplatz_ewm_ext_parent_lsort2_) OVER (PARTITION BY CAST(t11.mandant_id1 AS STRING), CAST(t11.kunde_id AS STRING)
        , CAST(t11.transportation_unit_id0 AS STRING), t11.dat_tour RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING)) / 2 = t11.anzahl_stellplatz_ewm_ext_parent_lsort2_
  THEN 1
  ELSE 0
  END AS fg,
  CASE
  WHEN CASE
    WHEN (SUM(t11.anzahl_stellplatz_ewm_ext_parent_lsort2_) OVER (PARTITION BY CAST(t11.mandant_id1 AS STRING), CAST(t11.kunde_id AS STRING)
          , CAST(t11.transportation_unit_id0 AS STRING), t11.dat_tour RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING)) / 2 = t11.anzahl_stellplatz_ewm_ext_parent_lsort2_
    THEN 1
    ELSE 0
    END = 1
  THEN 1
  ELSE CAST(ROW_NUMBER() OVER (PARTITION BY CAST(t11.mandant_id1 AS STRING), CAST(t11.kunde_id AS STRING), t11.dat_tour
    ORDER BY t11.anzahl_stellplatz_ewm_ext_parent_lsort2_ IS NULL DESC, t11.anzahl_stellplatz_ewm_ext_parent_lsort2_
      DESC) AS INTEGER)
  END AS rank_1,
  CASE
  WHEN CASE
    WHEN (SUM(t11.anzahl_stellplatz_ewm_ext_parent_lsort2_) OVER (PARTITION BY CAST(t11.mandant_id1 AS STRING), CAST(t11.kunde_id AS STRING)
          , CAST(t11.transportation_unit_id0 AS STRING), t11.dat_tour RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING)) / 2 = t11.anzahl_stellplatz_ewm_ext_parent_lsort2_
    THEN 1
    ELSE 0
    END = 1
  THEN CAST(ROW_NUMBER() OVER (PARTITION BY CAST(t11.mandant_id1 AS STRING), CAST(t11.kunde_id AS STRING), CAST(t11.transportation_unit_id0 AS STRING)
      ORDER BY t11.zeit_plan_ankunft_orig IS NULL, t11.zeit_plan_ankunft_orig) AS INTEGER)
  ELSE 1
  END AS rank_2
FROM (SELECT HU_S.mandant_id,
   HU_S.wup_id,
   T_UNIT.dat_tour,
   HU_S.transportation_unit_id,
   T_UNIT.kj_transportation_unit,
   HU_S.mandant_id_kunde,
   W.aktuell_wup_id AS kunde_id_,
   HU_S.lagernummer_id,
   COALESCE(t6.distribution_abr_fg, v021.distribution_abr_fg, 1) AS distribution_abr_fg,
   TU_K.dat_tour AS dat_plan_ankunft_orig,
   TU_K.zeit_plan_ankunft AS zeit_plan_ankunft_orig,
   TS_W_ZA.zeit_anlieferung,
   t_pz.dat_scan,
   t_pz.mandant_id AS mandant_id7,
   t_pz.zeit_scan,
    CASE
    WHEN TIMESTAMP_DIFF(CAST(T_UNIT.datzeit_ende_plan AS DATETIME), CAST(T_UNIT.datzeit_ende_ist AS DATETIME), SECOND)
     >= 0
    THEN '1'
    ELSE '0'
    END AS punktlichkeit_abfahrt_vz,
    CASE
    WHEN TIMESTAMP_DIFF(CAST(T_UNIT.datzeit_start_plan AS DATETIME), CAST(T_UNIT.datzeit_start_ist AS DATETIME), SECOND)
     >= 0
    THEN '1'
    ELSE '0'
    END AS punktlichkeit_ankunft_vz,
   T_UNIT.datzeit_start_plan,
   T_UNIT.datzeit_start_ist,
   T_UNIT.datzeit_ende_plan,
   T_UNIT.datzeit_ende_ist,
   T_UNIT.aktivitaet_richtung_id,
   T_UNIT.belos_adresse_spedition_id,
    CASE
    WHEN T_UNIT.dat_tour >= b_w_sw.dat_tms_wanko
    THEN 'WANKO'
    ELSE 'BELOS'
    END AS tms,
    CASE
    WHEN CASE
      WHEN T_UNIT.dat_tour >= b_w_sw.dat_tms_wanko
      THEN 'WANKO'
      ELSE 'BELOS'
      END = 'WANKO'
    THEN COALESCE(v021.spedition_tms_gp_id, '-1')
    ELSE COALESCE(T_UNIT.belos_adresse_spedition_id, '-1')
    END AS tdl_id,
    CASE
    WHEN CASE
      WHEN T_UNIT.dat_tour >= b_w_sw.dat_tms_wanko
      THEN 'WANKO'
      ELSE 'BELOS'
      END = 'WANKO'
    THEN COALESCE(v021.temperaturgruppe_id, T_UNIT.belos_sonderabwicklung_id, '-1')
    ELSE COALESCE(T_UNIT.belos_sonderabwicklung_id, '-1')
    END AS tour_service_id,
   T_PZ_PR.plombe_prozess_id,
   a_st_lsort2.mandant_id AS mandant_id1,
   a_st_lsort2.kunde_id,
   a_st_lsort2.transportation_unit_id AS transportation_unit_id0,
   MIN(DATETIME(CASE
      WHEN t_pz.mandant_id IN (4, 7, 8) AND COALESCE(CAST(snowconvert_public.time_to_int_udf(t_pz.zeit_scan) AS BIGNUMERIC)
         , 0) >= 230000
      THEN DATE_ADD(t_pz.dat_scan, INTERVAL 1 DAY)
      ELSE t_pz.dat_scan
      END, t_pz.zeit_scan)) AS datzeit_scan,
   COUNT(DISTINCT HU_S.transportation_unit_id) AS transportation_unit_anzahl,
   AVG(a_st_lsort2.anzahl_stellplatz_ewm_ext_parent_lsort2) AS anzahl_stellplatz_ewm_ext_parent_lsort2_
  FROM kfl_production_dbp_view.v_besch_lief_wa_hu_sum AS HU_S
   INNER JOIN kfl_production_dbp_view.v_wup AS W ON W.mandant_id = CASE
       WHEN HU_S.mandant_id_kunde IS NULL OR HU_S.mandant_id_kunde = 0
       THEN HU_S.mandant_id
       ELSE HU_S.mandant_id_kunde
       END AND HU_S.kunde_id = W.wup_id AND (W.nb_id IN (2, 0, - 111) AND W.wup_id > 0 OR W.nb_id = - 1 AND W.wup_id = 0
        )
   INNER JOIN (SELECT mandant_id,
     lagernummer_id,
     transportation_unit_id,
     dat_tour,
     kunde_id,
     SUM(CASE
       WHEN lagersortiment_id = '2'
       THEN anzahl_stellplatz_ewm_ext_parent
       ELSE 0
       END) AS anzahl_stellplatz_ewm_ext_parent_lsort2
    FROM kfl_production_dbp_view.v_besch_lief_wa_hu_sum
    GROUP BY mandant_id,
     lagernummer_id,
     transportation_unit_id,
     dat_tour,
     kunde_id) AS a_st_lsort2 ON HU_S.mandant_id = a_st_lsort2.mandant_id AND HU_S.lagernummer_id = a_st_lsort2.lagernummer_id
          AND HU_S.transportation_unit_id = a_st_lsort2.transportation_unit_id AND HU_S.dat_tour = a_st_lsort2.dat_tour
     AND HU_S.kunde_id = a_st_lsort2.kunde_id AND a_st_lsort2.anzahl_stellplatz_ewm_ext_parent_lsort2 > 0
   INNER JOIN kfl_production_dbp_view.v_transportation_unit_aktivitaet AS T_UNIT ON T_UNIT.aktivitaet_richtung_id = '2'
       AND HU_S.handling_unit_id > 0 AND HU_S.mandant_id = T_UNIT.mandant_id AND HU_S.transportation_unit_id = T_UNIT.transportation_unit_id
       AND HU_S.dat_tour
     -- if there's any delivery for this store on a given date, this is considered an normal day (not sunday/holiday)
 =
     T_UNIT.dat_tour
   LEFT JOIN (SELECT mandant_id,
     lagernummer_id,
     MIN(dat_tms_wanko) AS dat_tms_wanko
    FROM kfl_production_dbp_msi_v_view.v_ts_lagernummer_sortierung_scm
    WHERE dat_tms_wanko IS NOT NULL
    GROUP BY mandant_id,
     lagernummer_id) AS b_w_sw ON T_UNIT.mandant_id = b_w_sw.mandant_id AND T_UNIT.lagernummer_id = b_w_sw.lagernummer_id
     
   LEFT JOIN (SELECT DISTINCT T.mandant_id,
     TU.transportation_unit_id,
     T.dat_tour,
      CASE
      WHEN T.tms_tourtyp_id = 105
      THEN 0
      ELSE 1
      END AS distribution_abr_fg,
     T.spedition_tms_gp_id,
     T.temperaturgruppe_id,
     T.tms_tourtyp_id,
     T.tms_tourart_id
    FROM kfl_production_dbp_data.tms_tour AS T
     INNER JOIN kfl_production_dbp_view.v_tag AS D ON T.dat_tour = D.dat AND D.akt_kj >= - 2
     INNER JOIN kfl_production_dbp_view.v_transportation_unit AS TU ON T.mandant_id = TU.mandant_id AND T.transportation_unit_id_ext
        = TU.transportation_unit_id_ext) AS v021 ON T_UNIT.mandant_id = v021.mandant_id AND T_UNIT.transportation_unit_id
       = v021.transportation_unit_id AND T_UNIT.dat_tour = v021.dat_tour
   LEFT JOIN (SELECT mandant_id,
     tour_id,
     dat_leistung,
     MAX(distribution_abr_fg) AS distribution_abr_fg
    FROM kfl_production_dbp_view.v_belos_vorgang
    GROUP BY mandant_id,
     dat_leistung,
     tour_id) AS t6 ON T_UNIT.mandant_id = t6.mandant_id AND T_UNIT.transportation_unit_id = t6.tour_id AND T_UNIT.dat_tour
      = t6.dat_leistung
   LEFT JOIN kfl_production_dbp_view.v_transportation_unit_kunde AS TU_K ON HU_S.transportation_unit_id = TU_K.transportation_unit_id
        AND ABS(DATE_DIFF(TU_K.dat_tour, HU_S.dat_tour, DAY)) < 90 AND HU_S.mandant_id = TU_K.mandant_id AND HU_S.kunde_id
      = ROUND(SAFE_CAST(TU_K.kunde_id AS BIGNUMERIC), 0)
   LEFT JOIN (SELECT mandant_id,
     wup_id,
     tour_id,
     dat_scan,
     MIN(zeit_scan) AS zeit_scan
    FROM kfl_production_dbp_view.v_tour_plombe_ziel
    WHERE dat_scan IS NOT NULL
     AND (plombe_aktivitaet <> 13 OR info_code <= 0)
    GROUP BY mandant_id,
     wup_id,
     tour_id,
     dat_scan) AS t_pz ON HU_S.transportation_unit_id = t_pz.tour_id AND HU_S.mandant_id = t_pz.mandant_id AND HU_S.kunde_id
       = t_pz.wup_id AND HU_S.dat_tour = t_pz.dat_scan -- keine diff?

   LEFT JOIN kfl_production_dbp_view.v_tour_plombe_ziel AS T_PZ_PR ON t_pz.tour_id = T_PZ_PR.tour_id AND t_pz.mandant_id
         = T_PZ_PR.mandant_id AND t_pz.wup_id = T_PZ_PR.wup_id AND t_pz.dat_scan = T_PZ_PR.dat_scan AND t_pz.zeit_scan =
     T_PZ_PR.zeit_scan
   LEFT JOIN kfl_production_dbp_msi_data.ts_wup_zeit_anlieferung_per AS TS_W_ZA ON HU_S.mandant_id = TS_W_ZA.mandant_id
      AND HU_S.kunde_id = TS_W_ZA.wup_id AND CAST(TS_W_ZA.transportsortiment_id AS FLOAT64) = 27 AND T_UNIT.dat_tour
     BETWEEN TS_W_ZA.dat_von AND TS_W_ZA.dat_bis
  WHERE EXTRACT(YEAR FROM T_UNIT.dat_tour) >= EXTRACT(YEAR FROM CURRENT_DATE) - 2
  GROUP BY HU_S.mandant_id,
   HU_S.wup_id,
   T_UNIT.dat_tour,
   HU_S.transportation_unit_id,
   T_UNIT.kj_transportation_unit,
   HU_S.mandant_id_kunde,
   kunde_id_,
   HU_S.lagernummer_id,
   distribution_abr_fg,
   dat_plan_ankunft_orig,
   zeit_plan_ankunft_orig,
   TS_W_ZA.zeit_anlieferung,
   t_pz.dat_scan,
   mandant_id7,
   t_pz.zeit_scan,
   punktlichkeit_abfahrt_vz,
   punktlichkeit_ankunft_vz,
   T_UNIT.datzeit_start_plan,
   T_UNIT.datzeit_start_ist,
   T_UNIT.datzeit_ende_plan,
   T_UNIT.datzeit_ende_ist,
   T_UNIT.aktivitaet_richtung_id,
   T_UNIT.belos_adresse_spedition_id,
   tms,
   tdl_id,
   tour_service_id,
   T_PZ_PR.plombe_prozess_id,
   mandant_id1,
   a_st_lsort2.kunde_id,
   transportation_unit_id0) AS t11
QUALIFY CASE
    WHEN CASE
      WHEN (SUM(t11.anzahl_stellplatz_ewm_ext_parent_lsort2_) OVER (PARTITION BY CAST(t11.mandant_id1 AS STRING), CAST(t11.kunde_id AS STRING)
            , CAST(t11.transportation_unit_id0 AS STRING), t11.dat_tour RANGE BETWEEN UNBOUNDED PRECEDING AND
          UNBOUNDED FOLLOWING)) / 2 = t11.anzahl_stellplatz_ewm_ext_parent_lsort2_
      THEN 1
      ELSE 0
      END = 1
    THEN 1
    ELSE CAST(ROW_NUMBER() OVER (PARTITION BY CAST(t11.mandant_id1 AS STRING), CAST(t11.kunde_id AS STRING), t11.dat_tour
        ORDER BY t11.anzahl_stellplatz_ewm_ext_parent_lsort2_ IS NULL DESC, t11.anzahl_stellplatz_ewm_ext_parent_lsort2_
        DESC) AS INTEGER)
    END = 1 AND CASE
    WHEN CASE
      WHEN (SUM(t11.anzahl_stellplatz_ewm_ext_parent_lsort2_) OVER (PARTITION BY CAST(t11.mandant_id1 AS STRING), CAST(t11.kunde_id AS STRING)
            , CAST(t11.transportation_unit_id0 AS STRING), t11.dat_tour RANGE BETWEEN UNBOUNDED PRECEDING AND
          UNBOUNDED FOLLOWING)) / 2 = t11.anzahl_stellplatz_ewm_ext_parent_lsort2_
      THEN 1
      ELSE 0
      END = 1
    THEN CAST(ROW_NUMBER() OVER (PARTITION BY CAST(t11.mandant_id1 AS STRING), CAST(t11.kunde_id AS STRING), CAST(t11.transportation_unit_id0 AS STRING)
        ORDER BY t11.zeit_plan_ankunft_orig IS NULL, t11.zeit_plan_ankunft_orig) AS INTEGER)
    ELSE 1
    END = 1;

