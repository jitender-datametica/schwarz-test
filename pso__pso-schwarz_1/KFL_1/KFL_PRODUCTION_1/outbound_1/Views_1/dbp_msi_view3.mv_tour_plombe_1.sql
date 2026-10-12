CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_tour_plombe_1(MANDANT_ID, WUP_ID, NB_ID, TOUR_ID, PLOMBE_ID, MANDANT_ID_KUNDE, KUNDE_ID, STATUS_TOUR, CD_FG, TOUR_KUNDE_ID, DAT_SCAN, MAX_DAT_SCAN, ZEIT_SCAN, SCAN_DT, MAX_SCAN_DT, PLOMBE_PROZESS_ID, PLOMBE_PROZESS_BEZ, DAT_PLAN_ANKUNFT, ZEIT_PLAN_ANKUNFT, DIFF_PLAN_SCAN_MINUTEN, DIFF_PLAN_SCAN_MINUTEN_KARENZ, NACHTFENSTER_FLG, TAGANLIEFERUNG_FG, TOUR_ENTHAELT_OUG, START_ZEIT, ENDE_ZEIT, ZEIT_RELEVANT_FG) AS SELECT
    -- Ermittelt die Differenz zwischen Plombenentwertung (Ist-Ankunft) und Planankunft
    -- 22.07.2016, AP0002648, srom0404, Anlieferpünklichkeit
    -- 10.10.2016, SPEC0015247, srom0404, Zeitverschiebung Anlieferpünktlichkeit für RO, BG +1 Stunde
    -- 14.05.2018, AP0011752, srom0404, Anpassung Zeitverschiebung Moldau
    -- 16.07.2018, AP0032009, SPEC0040130, mkub1811, Erweiterung um max_dat_scan, max_zeit_scan, max_oug_tour_fg, umwandeln nicht-numerisch auf numerisch jetzt mit TRYCAST
    -- 07.01.2019, AP0032009, SPEC0040130, srom0404, Anpassung WHERE Bedingung bei tour_enthaelt_oug Zweig
    -- 21.10.2020, Cloud Mig, nwag2310, Anpassung TIME Felder f�r Snow Flake
    -- 2024-01-31, INC7963291, dknop, change kunde_id
    -- 2024-08-01,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
    -- 2024-09-09, dknop, change to left join with dbp_view.v_wup_1
    DT1.MANDANT_ID,
    DT1.WUP_ID,
    DT1.NB_ID,
    DT1.TOUR_ID,
    DT1.PLOMBE_ID,
    DT1.MANDANT_ID_KUNDE,
    CASE
      WHEN DT1.KUNDE_ID IS NULL THEN -NUMERIC '3'
      ELSE V05.AKTUELL_WUP_ID
    END AS KUNDE_ID,
    -- CASE WHEN TRY_CAST(dt1.kunde_id AS INTEGER) IS NULL THEN -3 ELSE TRY_CAST(dt1.kunde_id AS INTEGER) END AS kunde_id,
    -- CASE WHEN TRY_CAST(dt1.kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(dt1.kunde_id AS INTEGER) END,
    DT1.STATUS_TOUR,
    DT1.CD_FG,
    DT1.TOUR_KUNDE_ID,
    DT1.DAT_SCAN,
    max(DT1.DAT_SCAN) OVER (PARTITION BY DT1.WUP_ID, DT1.TOUR_ID, DT1.KUNDE_ID),
    DT1.ZEIT_SCAN,
    DATETIME(DATE(DT1.DAT_SCAN), cast(coalesce(substr(CAST(DT1.ZEIT_SCAN as STRING), 1, 8), '00:00:00')as time)) AS SCAN_DT,
    DATETIME(cast(max(DT1.MAX_DAT_SCAN) OVER (PARTITION BY DT1.WUP_ID, DT1.TOUR_ID, DT1.KUNDE_ID)as date), cast(coalesce(substr(CAST(max(DT1.ENDE_ZEIT) OVER (PARTITION BY DT1.WUP_ID, DT1.TOUR_ID, DT1.KUNDE_ID) as STRING), 1, 8), '00:00:00')as time)) AS MAX_SCAN_DT,
    DT1.PLOMBE_PROZESS_ID,
    DT1.PLOMBE_PROZESS_BEZ,
    DT1.DAT_PLAN_ANKUNFT,
    DT1.ZEIT_PLAN_ANKUNFT,
    DT1.DIFF_PLAN_SCAN_MINUTEN,
    DT1.DIFF_PLAN_SCAN_MINUTEN_KARENZ,
    DT1.NACHTFENSTER_FLG,
    DT1.TAGANLIEFERUNG_FG,
    DT1.TOUR_ENTHAELT_OUG,
    DT1.START_ZEIT,
    DT1.ENDE_ZEIT,
    DT1.ZEIT_RELEVANT_FG
    -- dt1
  FROM
    (
      SELECT
          V01.MANDANT_ID,
          V01.WUP_ID,
          V01.NB_ID,
          V01.TOUR_ID,
          V02.PLOMBE_ID,
          V01.MANDANT_ID_KUNDE,
          V01.KUNDE_ID,
          V01.STATUS_TOUR,
          V01.CD_FG,
          concat(trim(cast(V01.MANDANT_ID as string), ' '), trim(cast(V01.TOUR_ID as string), ' '), trim(cast(V01.MANDANT_ID_KUNDE as string), ' '), trim(V01.KUNDE_ID, ' ')) AS TOUR_KUNDE_ID,
          V02.DAT_SCAN,
          V02.MAX_DAT_SCAN,
          parse_time('%I:%M:%S', V02.ZEIT_SCAN) AS ZEIT_SCAN,
          V02.PLOMBE_PROZESS_ID,
          CASE
            WHEN V02.PLOMBE_PROZESS_ID IN(
              NUMERIC '1', NUMERIC '3'
            ) THEN 'Plombe'
            WHEN V02.PLOMBE_PROZESS_ID = NUMERIC '2' THEN 'WE-Palette'
          END AS PLOMBE_PROZESS_BEZ,
          V01.DAT_TOUR AS DAT_PLAN_ANKUNFT,
          time(V01.ZEIT_PLAN_ANKUNFT) AS ZEIT_PLAN_ANKUNFT,
          V02.TIMESTAMP_SCAN,
          V01.TIMESTAMP_PLAN_ANKUNFT AS TIMESTAMP_PLAN_ANKUNFT_,
          diff_plan_scan_minuten AS DIFF_PLAN_SCAN_MINUTEN,
          diff_plan_scan_minuten - NUMERIC '15' AS DIFF_PLAN_SCAN_MINUTEN_KARENZ,
          timestamp_nacht_start AS TIMESTAMP_NACHT_START,
          timestamp_nacht_ende AS TIMESTAMP_NACHT_ENDE,
          CASE
            WHEN V01.TIMESTAMP_PLAN_ANKUNFT IS NOT NULL THEN CASE
              WHEN V01.TIMESTAMP_PLAN_ANKUNFT BETWEEN timestamp_nacht_start AND timestamp_nacht_ende THEN NUMERIC '1'
              ELSE NUMERIC '0'
            END
          END AS NACHTFENSTER_FLG,
          CASE
            WHEN V01.MANDANT_ID = NUMERIC '1'
             AND snowconvert_public.time_to_int_udf(V01.ZEIT_PLAN_ANKUNFT) BETWEEN NUMERIC '54500' AND NUMERIC '220000' THEN NUMERIC '1'
            WHEN V01.MANDANT_ID <> NUMERIC '1' THEN NUMERIC '1'
            ELSE NUMERIC '0'
          END AS TAGANLIEFERUNG_FG,
          V01A.TOUR_ENTHAELT_OUG,
          V02.START_ZEIT,
          V02.ENDE_ZEIT,
          V01.ZEIT_RELEVANT_FG
          -- v01
        FROM
          (
            SELECT
                V011.MANDANT_ID,
                V011.NB_ID,
                V011.WUP_ID,
                V011.TOUR_ID,
                V011.KUNDE_ID,
                V011.MANDANT_ID_KUNDE,
                V011.STATUS_TOUR,
                V011.CD_FG,
                V011.ZEIT_PLAN_ANKUNFT,
                V011.DAT_TOUR,
                -- TO_TIMESTAMP(CAST(v011.dat_tour AS CHAR(11))||CAST(v011.zeit_plan_ankunft AS CHAR(8)), 'YYYY/MM_1/DD HH:MI:SS') AS timestamp_plan_ankunft,
                datetime(V011.DAT_TOUR, CAST(CAST(V011.ZEIT_PLAN_ANKUNFT as STRING) as TIME)) AS TIMESTAMP_PLAN_ANKUNFT,
                V011.ZEIT_RELEVANT_FG
              FROM
                kfl_production_dbp_view.v_tour_det_zlv_vttkl_1 AS V011
              WHERE V011.ZEIT_RELEVANT_FG = NUMERIC '1'
          ) AS V01
          LEFT OUTER JOIN (
            SELECT DISTINCT
                V011.MANDANT_ID,
                V011.NB_ID,
                V011.WUP_ID,
                V011.TOUR_ID,
                V011.KUNDE_ID,
                V011.MANDANT_ID_KUNDE,
                max(V012.OUG_FG) AS TOUR_ENTHAELT_OUG
              FROM
                kfl_production_dbp_view.v_tour_det_zlv_vttkl_1 AS V011
                INNER JOIN kfl_production_dbp_view.v_l_lagernummer_1 AS V012 ON V011.MANDANT_ID = V012.MANDANT_ID
                 AND V011.LAGERNUMMER_ID = V012.LAGERNUMMER_ID
              WHERE V011.MENGE_STP_GERAEUMT <> NUMERIC '0'
              GROUP BY 1, 2, 3, 4, 5, 6
          ) AS V01A ON V01.MANDANT_ID = V01A.MANDANT_ID
           AND V01.TOUR_ID = V01A.TOUR_ID
           AND V01.WUP_ID = V01A.WUP_ID
           AND V01.KUNDE_ID = V01A.KUNDE_ID /* v01a*/
          LEFT OUTER JOIN (
            SELECT
                V021.MANDANT_ID,
                V021.TOUR_ID,
                V021.PLOMBE_ID,
                V021.WUP_ID,
                V021.NB_ID,
                V021.DAT_SCAN_ AS DAT_SCAN,
                V021.MAX_DAT_SCAN_ AS MAX_DAT_SCAN,
                CASE
                  WHEN substr(CAST(V021.START_ZEIT_ as STRING), 1, 8) < CAST( V021.ZEIT_SCAN_ as STRING) THEN substr(CAST(V021.START_ZEIT_ as STRING), 1, 8)
                  ELSE CAST( V021.ZEIT_SCAN_ as STRING)
                END AS ZEIT_SCAN,
                V021.START_ZEIT_ AS START_ZEIT,
                V021.ENDE_ZEIT_ AS ENDE_ZEIT,
                V021.PLOMBE_PROZESS_ID,
                V021.PLOMBE_AKTIVITAET,
                V021.INFO_CODE,
                V021.TIMESTAMP_SCAN_ AS TIMESTAMP_SCAN
              FROM
                (
                  SELECT
                      cw_win_ss.MANDANT_ID,
                      cw_win_ss.TOUR_ID,
                      cw_win_ss.PLOMBE_ID,
                      cw_win_ss.WUP_ID,
                      cw_win_ss.NB_ID,
                      cw_win_ss.PLOMBE_PROZESS_ID,
                      cw_win_ss.PLOMBE_AKTIVITAET,
                      cw_win_ss.INFO_CODE,
                      cw_win_ss.DAT_SCAN_,
                      cw_win_ss.ZEIT_SCAN__,
                      cw_win_ss.ZEIT_SCAN_,
                      cw_win_ss.TIMESTAMP_SCAN_,
                      min(min(CASE
                        WHEN cw_win_ss.MIN_TIMESTAMP_SCAN_ IS NOT NULL THEN DATETIME(DATE(cw_win_ss.MIN_TIMESTAMP_SCAN_), TIME(cw_win_ss.MIN_TIMESTAMP_SCAN_))
                        ELSE NULL
                      END)) OVER (PARTITION BY cw_win_ss.MANDANT_ID, cw_win_ss.TOUR_ID, cw_win_ss.WUP_ID) AS MIN_TIMESTAMP_SCAN_,
                      max(cw_win_ss.DAT_SCAN_) OVER (PARTITION BY cw_win_ss.MANDANT_ID, cw_win_ss.TOUR_ID, cw_win_ss.WUP_ID) AS MAX_DAT_SCAN_,
                      CAST(min(min(CASE
                        WHEN cw_win_ss.MIN_TIMESTAMP_SCAN_ IS NOT NULL THEN DATETIME(DATE(cw_win_ss.MIN_TIMESTAMP_SCAN_), TIME(cw_win_ss.MIN_TIMESTAMP_SCAN_))
                        ELSE NULL
                      END)) OVER (PARTITION BY cw_win_ss.MANDANT_ID, cw_win_ss.TOUR_ID, cw_win_ss.WUP_ID) as TIME) AS START_ZEIT_,
                      max(CASE
                        WHEN cw_win_ss.PLOMBE_PROZESS_ID = NUMERIC '2' THEN min(CASE
                          WHEN cw_win_ss.MIN_TIMESTAMP_SCAN_ IS NOT NULL THEN DATETIME(DATE(cw_win_ss.MIN_TIMESTAMP_SCAN_), TIME(cw_win_ss.MIN_TIMESTAMP_SCAN_))
                          ELSE NULL
                        END)
                        ELSE NULL
                      END) OVER (PARTITION BY cw_win_ss.MANDANT_ID, cw_win_ss.TOUR_ID, cw_win_ss.WUP_ID) AS TMP_MAX_2,
                      max(CASE
                        WHEN cw_win_ss.PLOMBE_PROZESS_ID = NUMERIC '3' THEN min(CASE
                          WHEN cw_win_ss.MIN_TIMESTAMP_SCAN_ IS NOT NULL THEN DATETIME(DATE(cw_win_ss.MIN_TIMESTAMP_SCAN_), TIME(cw_win_ss.MIN_TIMESTAMP_SCAN_))
                          ELSE NULL
                        END)
                        ELSE NULL
                      END) OVER (PARTITION BY cw_win_ss.MANDANT_ID, cw_win_ss.TOUR_ID, cw_win_ss.WUP_ID) AS TMP_MAX_3,
                      sum(cw_win_ss.TMP_ANZ_PID_2) OVER (PARTITION BY cw_win_ss.MANDANT_ID, cw_win_ss.TOUR_ID, cw_win_ss.WUP_ID) AS TMP_ANZ_PID_2a,
                      CAST(CASE
                        WHEN sum(cw_win_ss.TMP_ANZ_PID_2) OVER (PARTITION BY cw_win_ss.MANDANT_ID, cw_win_ss.TOUR_ID, cw_win_ss.WUP_ID) > NUMERIC '0' THEN max(CASE
                          WHEN cw_win_ss.PLOMBE_PROZESS_ID = NUMERIC '2' THEN min(CASE
                            WHEN cw_win_ss.MIN_TIMESTAMP_SCAN_ IS NOT NULL THEN DATETIME(DATE(cw_win_ss.MIN_TIMESTAMP_SCAN_), TIME(cw_win_ss.MIN_TIMESTAMP_SCAN_))
                            ELSE NULL
                          END)
                          ELSE NULL
                        END) OVER (PARTITION BY cw_win_ss.MANDANT_ID, cw_win_ss.TOUR_ID, cw_win_ss.WUP_ID)
                        ELSE max(CASE
                          WHEN cw_win_ss.PLOMBE_PROZESS_ID = NUMERIC '3' THEN min(CASE
                            WHEN cw_win_ss.MIN_TIMESTAMP_SCAN_ IS NOT NULL THEN DATETIME(DATE(cw_win_ss.MIN_TIMESTAMP_SCAN_), TIME(cw_win_ss.MIN_TIMESTAMP_SCAN_))
                            ELSE NULL
                          END)
                          ELSE NULL
                        END) OVER (PARTITION BY cw_win_ss.MANDANT_ID, cw_win_ss.TOUR_ID, cw_win_ss.WUP_ID)
                      END as TIME) AS ENDE_ZEIT_
                    FROM
                      (
                        SELECT
                            V022.MANDANT_ID,
                            V022.TOUR_ID,
                            V022.PLOMBE_ID,
                            V022.WUP_ID,
                            V022.NB_ID,
                            V022.PLOMBE_PROZESS_ID,
                            V022.PLOMBE_AKTIVITAET,
                            V022.INFO_CODE,
                            dat_scan_ AS DAT_SCAN_,
                            zeit_scan__ AS zeit_scan__,
                            zeit_scan__ AS zeit_scan_,
                            min(CASE
                              WHEN dat_scan_ IS NOT NULL THEN DATETIME(DATE(dat_scan_), TIME(zeit_scan__))
                              ELSE NULL
                            END) AS TIMESTAMP_SCAN_,
                            DAT_SCAN_ AS MIN_TIMESTAMP_SCAN_,
                            ZEIT_SCAN__ AS MIN_TIMESTAMP_SCAN__0,
                            CASE
                              WHEN V022.PLOMBE_PROZESS_ID = NUMERIC '2'
                               AND dat_scan_ IS NOT NULL THEN NUMERIC '1'
                              ELSE NUMERIC '0'
                            END AS TMP_ANZ_PID_2
                          FROM
                            kfl_production_dbp_view.v_tour_plombe_ziel_1 AS V022
                            CROSS JOIN UNNEST(ARRAY[
                              CASE
                                WHEN V022.MANDANT_ID IN(
                                  NUMERIC '4', NUMERIC '7', NUMERIC '8'
                                )
                                 AND coalesce(snowconvert_public.time_to_int_udf(V022.ZEIT_SCAN), NUMERIC '0') >= NUMERIC '230000' THEN V022.DAT_SCAN + INTERVAL 1 DAY
                                ELSE V022.DAT_SCAN
                              END
                            ]) AS dat_scan_
                            CROSS JOIN UNNEST(ARRAY[
                              CASE
                                WHEN V022.MANDANT_ID IN(
                                  NUMERIC '4', NUMERIC '7', NUMERIC '8'
                                ) THEN CASE
                                  WHEN coalesce(snowconvert_public.time_to_int_udf(V022.ZEIT_SCAN), NUMERIC '0') >= NUMERIC '230000' 
                                  THEN snowconvert_public.int_to_time_udf(snowconvert_public.time_to_int_udf(V022.ZEIT_SCAN) - NUMERIC '230000')
                                  ELSE snowconvert_public.int_to_time_udf(snowconvert_public.time_to_int_udf(V022.ZEIT_SCAN) + NUMERIC '10000')
                                END
                                ELSE V022.ZEIT_SCAN
                              END
                            ]) AS zeit_scan__
                          WHERE V022.DAT_SCAN IS NOT NULL
                          -- Bei Aktivität 13 sind nur -1 / 0 gültig, Alle anderen Aktivitäten sind immer gültig
                           AND NOT (V022.PLOMBE_AKTIVITAET = NUMERIC '13'
                           AND V022.INFO_CODE > NUMERIC '0')
                          GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
                      ) AS cw_win_ss
                      GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,12,TMP_ANZ_PID_2
                ) AS V021
              WHERE V021.DAT_SCAN_ IS NOT NULL
              -- AND NOT (v021.plombe_aktivitaet = 13 AND v021.info_code > 0) -- Bei Aktivität 13 sind nur -1 / 0 gültig, Alle anderen Aktivitäten sind immer gültig
              QUALIFY row_number() OVER (PARTITION BY V021.MANDANT_ID, V021.TOUR_ID, V021.WUP_ID, V021.NB_ID ORDER BY if(TIMESTAMP_SCAN IS NULL, 0, 1) DESC, TIMESTAMP_SCAN, if(V021.PLOMBE_PROZESS_ID IS NULL, 0, 1) DESC, V021.PLOMBE_PROZESS_ID) = NUMERIC '1'
          ) AS V02 ON V01.MANDANT_ID_KUNDE = V02.MANDANT_ID
           AND V01.TOUR_ID = V02.TOUR_ID
           AND round(CAST(substr(V01.KUNDE_ID, 7, 4) as BIGNUMERIC), 0) = V02.WUP_ID /* v02*/
          CROSS JOIN UNNEST(ARRAY[
            datetime(V01.DAT_TOUR, CAST('06:00:00' as TIME))
          ]) AS timestamp_nacht_ende
          CROSS JOIN UNNEST(ARRAY[
            datetime(date(datetime_sub(V01.DAT_TOUR, interval 1 DAY)), time'23:59:59')
          ]) AS timestamp_nacht_start
          CROSS JOIN UNNEST(ARRAY[
            CASE
              WHEN DATE(V01.TIMESTAMP_PLAN_ANKUNFT) = CAST('9999-12-31' as DATE) THEN NULL
              ELSE CASE
                WHEN V01.TIMESTAMP_PLAN_ANKUNFT IS NOT NULL
                 AND V02.TIMESTAMP_SCAN IS NOT NULL THEN trunc(datetime_diff(CAST(V02.TIMESTAMP_SCAN as DATETIME), V01.TIMESTAMP_PLAN_ANKUNFT, SECOND) / NUMERIC '60')
                ELSE NULL
              END
            END
          ]) AS diff_plan_scan_minuten
    ) AS DT1
    LEFT OUTER JOIN kfl_production_dbp_view.v_wup_1 AS V05 ON V05.MANDANT_ID = CASE
      WHEN DT1.MANDANT_ID_KUNDE IS NULL
       OR DT1.MANDANT_ID_KUNDE = NUMERIC '0' THEN DT1.MANDANT_ID
      ELSE DT1.MANDANT_ID_KUNDE
    END
     AND cast(V05.WUP_ID as string) = CASE
      WHEN DT1.KUNDE_ID =  '0' THEN NULL
      ELSE DT1.KUNDE_ID
    END
     AND (V05.NB_ID IN(
      NUMERIC '2', NUMERIC '0', -NUMERIC '111'
    )
     AND V05.WUP_ID > NUMERIC '0'
     OR V05.NB_ID = -NUMERIC '1'
     AND V05.WUP_ID = NUMERIC '0')
;
