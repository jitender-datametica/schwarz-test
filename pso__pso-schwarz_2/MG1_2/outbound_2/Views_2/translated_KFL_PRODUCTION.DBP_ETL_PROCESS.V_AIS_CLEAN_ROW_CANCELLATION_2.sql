CREATE OR REPLACE VIEW KFL_PRODUCTION_DBP_ETL_PROCESS.V_AIS_CLEAN_ROW_CANCELLATION_2 (MANDANT_ID, WUP_ID, BON_DAT, BON_ID
, KL_ART_ID, UMSATZ_BRUTTO, BON_ZEILE, TALON_ID) AS (((((((((((((((((((SELECT A.MANDANT_ID,
                    A.WUP_ID,
                    A.BON_DAT,
                    A.BON_ID,
                    A.KL_ART_ID,
                    A.UMSATZ_BRUTTO,
                    A.BON_ZEILE,
                    A.TALON_ID
                   FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2 AS A
                    INNER JOIN (SELECT MANDANT_ID,
                      WUP_ID,
                      BON_DAT,
                      BON_ID,
                      KL_ART_ID,
                      EAN_KASSE,
                      UMSATZ_BRUTTO,
                      COUNT(*) AS ANZAHL
                     FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2
                     WHERE MENGE < 0
                      AND TALON_ID <> 0
                     GROUP BY MANDANT_ID,
                      WUP_ID,
                      BON_DAT,
                      KL_ART_ID,
                      EAN_KASSE,
                      UMSATZ_BRUTTO,
                      BON_ID) AS t1_2 ON A.MANDANT_ID = t1.MANDANT_ID AND A.WUP_ID = t1.WUP_ID AND A.BON_DAT = t1.BON_DAT
                        AND A.BON_ID = t1.BON_ID AND A.KL_ART_ID = t1.KL_ART_ID AND A.EAN_KASSE = t1.EAN_KASSE AND - 1 *
                       A.UMSATZ_BRUTTO = CASE
                       WHEN t1.ANZAHL >= 1
                       THEN t1.UMSATZ_BRUTTO
                       ELSE NULL
                       END
                   QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.MANDANT_ID AS STRING), CAST(A.WUP_ID AS STRING), A.BON_DAT
                         , A.BON_ID, CAST(A.KL_ART_ID AS STRING), CAST(A.UMSATZ_BRUTTO AS STRING) ORDER BY A.BON_ZEILE
                         IS NULL DESC, A.BON_ZEILE DESC)) = 1
                   UNION DISTINCT
                   SELECT A.MANDANT_ID,
                    A.WUP_ID,
                    A.BON_DAT,
                    A.BON_ID,
                    A.KL_ART_ID,
                    A.UMSATZ_BRUTTO,
                    A.BON_ZEILE,
                    A.TALON_ID
                   FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2 AS A
                    INNER JOIN (SELECT MANDANT_ID,
                      WUP_ID,
                      BON_DAT,
                      BON_ID,
                      KL_ART_ID,
                      EAN_KASSE,
                      UMSATZ_BRUTTO,
                      COUNT(*) AS ANZAHL
                     FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2
                     WHERE MENGE < 0
                      AND TALON_ID <> 0
                     GROUP BY MANDANT_ID,
                      WUP_ID,
                      BON_DAT,
                      KL_ART_ID,
                      EAN_KASSE,
                      UMSATZ_BRUTTO,
                      BON_ID) AS t6 ON A.MANDANT_ID = t6.MANDANT_ID AND A.WUP_ID = t6.WUP_ID AND A.BON_DAT = t6.BON_DAT
                        AND A.BON_ID = t6.BON_ID AND A.KL_ART_ID = t6.KL_ART_ID AND A.EAN_KASSE = t6.EAN_KASSE AND - 1 *
                       A.UMSATZ_BRUTTO = CASE
                       WHEN t6.ANZAHL >= 2
                       THEN t6.UMSATZ_BRUTTO
                       ELSE NULL
                       END
                   QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.MANDANT_ID AS STRING), CAST(A.WUP_ID AS STRING), A.BON_DAT
                         , A.BON_ID, CAST(A.KL_ART_ID AS STRING), CAST(A.UMSATZ_BRUTTO AS STRING) ORDER BY A.BON_ZEILE
                         IS NULL DESC, A.BON_ZEILE DESC)) = 2)
                  UNION DISTINCT
                  SELECT A.MANDANT_ID,
                   A.WUP_ID,
                   A.BON_DAT,
                   A.BON_ID,
                   A.KL_ART_ID,
                   A.UMSATZ_BRUTTO,
                   A.BON_ZEILE,
                   A.TALON_ID
                  FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2 AS A
                   INNER JOIN (SELECT MANDANT_ID,
                     WUP_ID,
                     BON_DAT,
                     BON_ID,
                     KL_ART_ID,
                     EAN_KASSE,
                     UMSATZ_BRUTTO,
                     COUNT(*) AS ANZAHL
                    FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2
                    WHERE MENGE < 0
                     AND TALON_ID <> 0
                    GROUP BY MANDANT_ID,
                     WUP_ID,
                     BON_DAT,
                     KL_ART_ID,
                     EAN_KASSE,
                     UMSATZ_BRUTTO,
                     BON_ID) AS t11 ON A.MANDANT_ID = t11.MANDANT_ID AND A.WUP_ID = t11.WUP_ID AND A.BON_DAT = t11.BON_DAT
                          AND A.BON_ID = t11.BON_ID AND A.KL_ART_ID = t11.KL_ART_ID AND A.EAN_KASSE = t11.EAN_KASSE AND
                      - 1 * A.UMSATZ_BRUTTO = CASE
                      WHEN t11.ANZAHL >= 3
                      THEN t11.UMSATZ_BRUTTO
                      ELSE NULL
                      END
                  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.MANDANT_ID AS STRING), CAST(A.WUP_ID AS STRING), A.BON_DAT
                        , A.BON_ID, CAST(A.KL_ART_ID AS STRING), CAST(A.UMSATZ_BRUTTO AS STRING) ORDER BY A.BON_ZEILE
                        IS NULL DESC, A.BON_ZEILE DESC)) = 3)
                 UNION DISTINCT
                 SELECT A.MANDANT_ID,
                  A.WUP_ID,
                  A.BON_DAT,
                  A.BON_ID,
                  A.KL_ART_ID,
                  A.UMSATZ_BRUTTO,
                  A.BON_ZEILE,
                  A.TALON_ID
                 FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2 AS A
                  INNER JOIN (SELECT MANDANT_ID,
                    WUP_ID,
                    BON_DAT,
                    BON_ID,
                    KL_ART_ID,
                    EAN_KASSE,
                    UMSATZ_BRUTTO,
                    COUNT(*) AS ANZAHL
                   FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2
                   WHERE MENGE < 0
                    AND TALON_ID <> 0
                   GROUP BY MANDANT_ID,
                    WUP_ID,
                    BON_DAT,
                    KL_ART_ID,
                    EAN_KASSE,
                    UMSATZ_BRUTTO,
                    BON_ID) AS t16 ON A.MANDANT_ID = t16.MANDANT_ID AND A.WUP_ID = t16.WUP_ID AND A.BON_DAT = t16.BON_DAT
                         AND A.BON_ID = t16.BON_ID AND A.KL_ART_ID = t16.KL_ART_ID AND A.EAN_KASSE = t16.EAN_KASSE AND -
                     1 * A.UMSATZ_BRUTTO = CASE
                     WHEN t16.ANZAHL >= 4
                     THEN t16.UMSATZ_BRUTTO
                     ELSE NULL
                     END
                 QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.MANDANT_ID AS STRING), CAST(A.WUP_ID AS STRING), A.BON_DAT
                       , A.BON_ID, CAST(A.KL_ART_ID AS STRING), CAST(A.UMSATZ_BRUTTO AS STRING) ORDER BY A.BON_ZEILE
                       IS NULL DESC, A.BON_ZEILE DESC)) = 4)
                UNION DISTINCT
                SELECT A.MANDANT_ID,
                 A.WUP_ID,
                 A.BON_DAT,
                 A.BON_ID,
                 A.KL_ART_ID,
                 A.UMSATZ_BRUTTO,
                 A.BON_ZEILE,
                 A.TALON_ID
                FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2 AS A
                 INNER JOIN (SELECT MANDANT_ID,
                   WUP_ID,
                   BON_DAT,
                   BON_ID,
                   KL_ART_ID,
                   EAN_KASSE,
                   UMSATZ_BRUTTO,
                   COUNT(*) AS ANZAHL
                  FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2
                  WHERE MENGE < 0
                   AND TALON_ID <> 0
                  GROUP BY MANDANT_ID,
                   WUP_ID,
                   BON_DAT,
                   KL_ART_ID,
                   EAN_KASSE,
                   UMSATZ_BRUTTO,
                   BON_ID) AS t21 ON A.MANDANT_ID = t21.MANDANT_ID AND A.WUP_ID = t21.WUP_ID AND A.BON_DAT = t21.BON_DAT
                        AND A.BON_ID = t21.BON_ID AND A.KL_ART_ID = t21.KL_ART_ID AND A.EAN_KASSE = t21.EAN_KASSE AND -
                    1 * A.UMSATZ_BRUTTO = CASE
                    WHEN t21.ANZAHL >= 5
                    THEN t21.UMSATZ_BRUTTO
                    ELSE NULL
                    END
                QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.MANDANT_ID AS STRING), CAST(A.WUP_ID AS STRING), A.BON_DAT
                      , A.BON_ID, CAST(A.KL_ART_ID AS STRING), CAST(A.UMSATZ_BRUTTO AS STRING) ORDER BY A.BON_ZEILE
                      IS NULL DESC, A.BON_ZEILE DESC)) = 5)
               UNION DISTINCT
               SELECT A.MANDANT_ID,
                A.WUP_ID,
                A.BON_DAT,
                A.BON_ID,
                A.KL_ART_ID,
                A.UMSATZ_BRUTTO,
                A.BON_ZEILE,
                A.TALON_ID
               FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2 AS A
                INNER JOIN (SELECT MANDANT_ID,
                  WUP_ID,
                  BON_DAT,
                  BON_ID,
                  KL_ART_ID,
                  EAN_KASSE,
                  UMSATZ_BRUTTO,
                  COUNT(*) AS ANZAHL
                 FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2
                 WHERE MENGE < 0
                  AND TALON_ID <> 0
                 GROUP BY MANDANT_ID,
                  WUP_ID,
                  BON_DAT,
                  KL_ART_ID,
                  EAN_KASSE,
                  UMSATZ_BRUTTO,
                  BON_ID) AS t26 ON A.MANDANT_ID = t26.MANDANT_ID AND A.WUP_ID = t26.WUP_ID AND A.BON_DAT = t26.BON_DAT
                    AND A.BON_ID = t26.BON_ID AND A.KL_ART_ID = t26.KL_ART_ID AND A.EAN_KASSE = t26.EAN_KASSE AND - 1 *
                   A.UMSATZ_BRUTTO = CASE
                   WHEN t26.ANZAHL >= 6
                   THEN t26.UMSATZ_BRUTTO
                   ELSE NULL
                   END
               QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.MANDANT_ID AS STRING), CAST(A.WUP_ID AS STRING), A.BON_DAT
                     , A.BON_ID, CAST(A.KL_ART_ID AS STRING), CAST(A.UMSATZ_BRUTTO AS STRING) ORDER BY A.BON_ZEILE
                     IS NULL DESC, A.BON_ZEILE DESC)) = 6)
              UNION DISTINCT
              SELECT A.MANDANT_ID,
               A.WUP_ID,
               A.BON_DAT,
               A.BON_ID,
               A.KL_ART_ID,
               A.UMSATZ_BRUTTO,
               A.BON_ZEILE,
               A.TALON_ID
              FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2 AS A
               INNER JOIN (SELECT MANDANT_ID,
                 WUP_ID,
                 BON_DAT,
                 BON_ID,
                 KL_ART_ID,
                 EAN_KASSE,
                 UMSATZ_BRUTTO,
                 COUNT(*) AS ANZAHL
                FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2
                WHERE MENGE < 0
                 AND TALON_ID <> 0
                GROUP BY MANDANT_ID,
                 WUP_ID,
                 BON_DAT,
                 KL_ART_ID,
                 EAN_KASSE,
                 UMSATZ_BRUTTO,
                 BON_ID) AS t31 ON A.MANDANT_ID = t31.MANDANT_ID AND A.WUP_ID = t31.WUP_ID AND A.BON_DAT = t31.BON_DAT
                   AND A.BON_ID = t31.BON_ID AND A.KL_ART_ID = t31.KL_ART_ID AND A.EAN_KASSE = t31.EAN_KASSE AND - 1 * A
                  .UMSATZ_BRUTTO = CASE
                  WHEN t31.ANZAHL >= 7
                  THEN t31.UMSATZ_BRUTTO
                  ELSE NULL
                  END
              QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.MANDANT_ID AS STRING), CAST(A.WUP_ID AS STRING), A.BON_DAT
                    , A.BON_ID, CAST(A.KL_ART_ID AS STRING), CAST(A.UMSATZ_BRUTTO AS STRING) ORDER BY A.BON_ZEILE
                    IS NULL DESC, A.BON_ZEILE DESC)) = 7)
             UNION DISTINCT
             SELECT A.MANDANT_ID,
              A.WUP_ID,
              A.BON_DAT,
              A.BON_ID,
              A.KL_ART_ID,
              A.UMSATZ_BRUTTO,
              A.BON_ZEILE,
              A.TALON_ID
             FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2 AS A
              INNER JOIN (SELECT MANDANT_ID,
                WUP_ID,
                BON_DAT,
                BON_ID,
                KL_ART_ID,
                EAN_KASSE,
                UMSATZ_BRUTTO,
                COUNT(*) AS ANZAHL
               FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2
               WHERE MENGE < 0
                AND TALON_ID <> 0
               GROUP BY MANDANT_ID,
                WUP_ID,
                BON_DAT,
                KL_ART_ID,
                EAN_KASSE,
                UMSATZ_BRUTTO,
                BON_ID) AS t36 ON A.MANDANT_ID = t36.MANDANT_ID AND A.WUP_ID = t36.WUP_ID AND A.BON_DAT = t36.BON_DAT
                  AND A.BON_ID = t36.BON_ID AND A.KL_ART_ID = t36.KL_ART_ID AND A.EAN_KASSE = t36.EAN_KASSE AND - 1 * A
                 .UMSATZ_BRUTTO = CASE
                 WHEN t36.ANZAHL >= 8
                 THEN t36.UMSATZ_BRUTTO
                 ELSE NULL
                 END
             QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.MANDANT_ID AS STRING), CAST(A.WUP_ID AS STRING), A.BON_DAT
                   , A.BON_ID, CAST(A.KL_ART_ID AS STRING), CAST(A.UMSATZ_BRUTTO AS STRING) ORDER BY A.BON_ZEILE IS NULL
                   DESC, A.BON_ZEILE DESC)) = 8)
            UNION DISTINCT
            SELECT A.MANDANT_ID,
             A.WUP_ID,
             A.BON_DAT,
             A.BON_ID,
             A.KL_ART_ID,
             A.UMSATZ_BRUTTO,
             A.BON_ZEILE,
             A.TALON_ID
            FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2 AS A
             INNER JOIN (SELECT MANDANT_ID,
               WUP_ID,
               BON_DAT,
               BON_ID,
               KL_ART_ID,
               EAN_KASSE,
               UMSATZ_BRUTTO,
               COUNT(*) AS ANZAHL
              FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2
              WHERE MENGE < 0
               AND TALON_ID <> 0
              GROUP BY MANDANT_ID,
               WUP_ID,
               BON_DAT,
               KL_ART_ID,
               EAN_KASSE,
               UMSATZ_BRUTTO,
               BON_ID) AS t41 ON A.MANDANT_ID = t41.MANDANT_ID AND A.WUP_ID = t41.WUP_ID AND A.BON_DAT = t41.BON_DAT AND
                  A.BON_ID = t41.BON_ID AND A.KL_ART_ID = t41.KL_ART_ID AND A.EAN_KASSE = t41.EAN_KASSE AND - 1 * A.UMSATZ_BRUTTO
                 = CASE
                WHEN t41.ANZAHL >= 9
                THEN t41.UMSATZ_BRUTTO
                ELSE NULL
                END
            QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.MANDANT_ID AS STRING), CAST(A.WUP_ID AS STRING), A.BON_DAT,
                  A.BON_ID, CAST(A.KL_ART_ID AS STRING), CAST(A.UMSATZ_BRUTTO AS STRING) ORDER BY A.BON_ZEILE IS NULL
                  DESC, A.BON_ZEILE DESC)) = 9)
           UNION DISTINCT
           SELECT A.MANDANT_ID,
            A.WUP_ID,
            A.BON_DAT,
            A.BON_ID,
            A.KL_ART_ID,
            A.UMSATZ_BRUTTO,
            A.BON_ZEILE,
            A.TALON_ID
           FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2 AS A
            INNER JOIN (SELECT MANDANT_ID,
              WUP_ID,
              BON_DAT,
              BON_ID,
              KL_ART_ID,
              EAN_KASSE,
              UMSATZ_BRUTTO,
              COUNT(*) AS ANZAHL
             FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2
             WHERE MENGE < 0
              AND TALON_ID <> 0
             GROUP BY MANDANT_ID,
              WUP_ID,
              BON_DAT,
              KL_ART_ID,
              EAN_KASSE,
              UMSATZ_BRUTTO,
              BON_ID) AS t46 ON A.MANDANT_ID = t46.MANDANT_ID AND A.WUP_ID = t46.WUP_ID AND A.BON_DAT = t46.BON_DAT AND
                 A.BON_ID = t46.BON_ID AND A.KL_ART_ID = t46.KL_ART_ID AND A.EAN_KASSE = t46.EAN_KASSE AND - 1 * A.UMSATZ_BRUTTO
                = CASE
               WHEN t46.ANZAHL >= 10
               THEN t46.UMSATZ_BRUTTO
               ELSE NULL
               END
           QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.MANDANT_ID AS STRING), CAST(A.WUP_ID AS STRING), A.BON_DAT, A
                 .BON_ID, CAST(A.KL_ART_ID AS STRING), CAST(A.UMSATZ_BRUTTO AS STRING) ORDER BY A.BON_ZEILE IS NULL DESC
                 , A.BON_ZEILE DESC)) = 10)
          UNION DISTINCT
          SELECT A.MANDANT_ID,
           A.WUP_ID,
           A.BON_DAT,
           A.BON_ID,
           A.KL_ART_ID,
           A.UMSATZ_BRUTTO,
           A.BON_ZEILE,
           A.TALON_ID
          FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2 AS A
           INNER JOIN (SELECT MANDANT_ID,
             WUP_ID,
             BON_DAT,
             BON_ID,
             KL_ART_ID,
             EAN_KASSE,
             UMSATZ_BRUTTO,
             COUNT(*) AS ANZAHL
            FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2
            WHERE MENGE < 0
             AND TALON_ID <> 0
            GROUP BY MANDANT_ID,
             WUP_ID,
             BON_DAT,
             KL_ART_ID,
             EAN_KASSE,
             UMSATZ_BRUTTO,
             BON_ID) AS t51 ON A.MANDANT_ID = t51.MANDANT_ID AND A.WUP_ID = t51.WUP_ID AND A.BON_DAT = t51.BON_DAT AND A
                .BON_ID = t51.BON_ID AND A.KL_ART_ID = t51.KL_ART_ID AND A.EAN_KASSE = t51.EAN_KASSE AND - 1 * A.UMSATZ_BRUTTO
               = CASE
              WHEN t51.ANZAHL >= 11
              THEN t51.UMSATZ_BRUTTO
              ELSE NULL
              END
          QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.MANDANT_ID AS STRING), CAST(A.WUP_ID AS STRING), A.BON_DAT, A
                .BON_ID, CAST(A.KL_ART_ID AS STRING), CAST(A.UMSATZ_BRUTTO AS STRING) ORDER BY A.BON_ZEILE IS NULL DESC
                , A.BON_ZEILE DESC)) = 11)
         UNION DISTINCT
         SELECT A.MANDANT_ID,
          A.WUP_ID,
          A.BON_DAT,
          A.BON_ID,
          A.KL_ART_ID,
          A.UMSATZ_BRUTTO,
          A.BON_ZEILE,
          A.TALON_ID
         FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2 AS A
          INNER JOIN (SELECT MANDANT_ID,
            WUP_ID,
            BON_DAT,
            BON_ID,
            KL_ART_ID,
            EAN_KASSE,
            UMSATZ_BRUTTO,
            COUNT(*) AS ANZAHL
           FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2
           WHERE MENGE < 0
            AND TALON_ID <> 0
           GROUP BY MANDANT_ID,
            WUP_ID,
            BON_DAT,
            KL_ART_ID,
            EAN_KASSE,
            UMSATZ_BRUTTO,
            BON_ID) AS t56 ON A.MANDANT_ID = t56.MANDANT_ID AND A.WUP_ID = t56.WUP_ID AND A.BON_DAT = t56.BON_DAT AND A
               .BON_ID = t56.BON_ID AND A.KL_ART_ID = t56.KL_ART_ID AND A.EAN_KASSE = t56.EAN_KASSE AND - 1 * A.UMSATZ_BRUTTO
              = CASE
             WHEN t56.ANZAHL >= 12
             THEN t56.UMSATZ_BRUTTO
             ELSE NULL
             END
         QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.MANDANT_ID AS STRING), CAST(A.WUP_ID AS STRING), A.BON_DAT, A.BON_ID
               , CAST(A.KL_ART_ID AS STRING), CAST(A.UMSATZ_BRUTTO AS STRING) ORDER BY A.BON_ZEILE IS NULL DESC, A.BON_ZEILE
               DESC)) = 12)
        UNION DISTINCT
        SELECT A.MANDANT_ID,
         A.WUP_ID,
         A.BON_DAT,
         A.BON_ID,
         A.KL_ART_ID,
         A.UMSATZ_BRUTTO,
         A.BON_ZEILE,
         A.TALON_ID
        FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2 AS A
         INNER JOIN (SELECT MANDANT_ID,
           WUP_ID,
           BON_DAT,
           BON_ID,
           KL_ART_ID,
           EAN_KASSE,
           UMSATZ_BRUTTO,
           COUNT(*) AS ANZAHL
          FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2
          WHERE MENGE < 0
           AND TALON_ID <> 0
          GROUP BY MANDANT_ID,
           WUP_ID,
           BON_DAT,
           KL_ART_ID,
           EAN_KASSE,
           UMSATZ_BRUTTO,
           BON_ID) AS t61 ON A.MANDANT_ID = t61.MANDANT_ID AND A.WUP_ID = t61.WUP_ID AND A.BON_DAT = t61.BON_DAT AND A.BON_ID
               = t61.BON_ID AND A.KL_ART_ID = t61.KL_ART_ID AND A.EAN_KASSE = t61.EAN_KASSE AND - 1 * A.UMSATZ_BRUTTO =
            CASE
            WHEN t61.ANZAHL >= 13
            THEN t61.UMSATZ_BRUTTO
            ELSE NULL
            END
        QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.MANDANT_ID AS STRING), CAST(A.WUP_ID AS STRING), A.BON_DAT, A.BON_ID
              , CAST(A.KL_ART_ID AS STRING), CAST(A.UMSATZ_BRUTTO AS STRING) ORDER BY A.BON_ZEILE IS NULL DESC, A.BON_ZEILE
              DESC)) = 13)
       UNION DISTINCT
       SELECT A.MANDANT_ID,
        A.WUP_ID,
        A.BON_DAT,
        A.BON_ID,
        A.KL_ART_ID,
        A.UMSATZ_BRUTTO,
        A.BON_ZEILE,
        A.TALON_ID
       FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2 AS A
        INNER JOIN (SELECT MANDANT_ID,
          WUP_ID,
          BON_DAT,
          BON_ID,
          KL_ART_ID,
          EAN_KASSE,
          UMSATZ_BRUTTO,
          COUNT(*) AS ANZAHL
         FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2
         WHERE MENGE < 0
          AND TALON_ID <> 0
         GROUP BY MANDANT_ID,
          WUP_ID,
          BON_DAT,
          KL_ART_ID,
          EAN_KASSE,
          UMSATZ_BRUTTO,
          BON_ID) AS t66 ON A.MANDANT_ID = t66.MANDANT_ID AND A.WUP_ID = t66.WUP_ID AND A.BON_DAT = t66.BON_DAT AND A.BON_ID
              = t66.BON_ID AND A.KL_ART_ID = t66.KL_ART_ID AND A.EAN_KASSE = t66.EAN_KASSE AND - 1 * A.UMSATZ_BRUTTO =
           CASE
           WHEN t66.ANZAHL >= 14
           THEN t66.UMSATZ_BRUTTO
           ELSE NULL
           END
       QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.MANDANT_ID AS STRING), CAST(A.WUP_ID AS STRING), A.BON_DAT, A.BON_ID
             , CAST(A.KL_ART_ID AS STRING), CAST(A.UMSATZ_BRUTTO AS STRING) ORDER BY A.BON_ZEILE IS NULL DESC, A.BON_ZEILE
             DESC)) = 14)
      UNION DISTINCT
      SELECT A.MANDANT_ID,
       A.WUP_ID,
       A.BON_DAT,
       A.BON_ID,
       A.KL_ART_ID,
       A.UMSATZ_BRUTTO,
       A.BON_ZEILE,
       A.TALON_ID
      FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2 AS A
       INNER JOIN (SELECT MANDANT_ID,
         WUP_ID,
         BON_DAT,
         BON_ID,
         KL_ART_ID,
         EAN_KASSE,
         UMSATZ_BRUTTO,
         COUNT(*) AS ANZAHL
        FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2
        WHERE MENGE < 0
         AND TALON_ID <> 0
        GROUP BY MANDANT_ID,
         WUP_ID,
         BON_DAT,
         KL_ART_ID,
         EAN_KASSE,
         UMSATZ_BRUTTO,
         BON_ID) AS t71 ON A.MANDANT_ID = t71.MANDANT_ID AND A.WUP_ID = t71.WUP_ID AND A.BON_DAT = t71.BON_DAT AND A.BON_ID
             = t71.BON_ID AND A.KL_ART_ID = t71.KL_ART_ID AND A.EAN_KASSE = t71.EAN_KASSE AND - 1 * A.UMSATZ_BRUTTO =
          CASE
          WHEN t71.ANZAHL >= 15
          THEN t71.UMSATZ_BRUTTO
          ELSE NULL
          END
      QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.MANDANT_ID AS STRING), CAST(A.WUP_ID AS STRING), A.BON_DAT, A.BON_ID
            , CAST(A.KL_ART_ID AS STRING), CAST(A.UMSATZ_BRUTTO AS STRING) ORDER BY A.BON_ZEILE IS NULL DESC, A.BON_ZEILE
            DESC)) = 15)
     UNION DISTINCT
     SELECT A.MANDANT_ID,
      A.WUP_ID,
      A.BON_DAT,
      A.BON_ID,
      A.KL_ART_ID,
      A.UMSATZ_BRUTTO,
      A.BON_ZEILE,
      A.TALON_ID
     FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2 AS A
      INNER JOIN (SELECT MANDANT_ID,
        WUP_ID,
        BON_DAT,
        BON_ID,
        KL_ART_ID,
        EAN_KASSE,
        UMSATZ_BRUTTO,
        COUNT(*) AS ANZAHL
       FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2
       WHERE MENGE < 0
        AND TALON_ID <> 0
       GROUP BY MANDANT_ID,
        WUP_ID,
        BON_DAT,
        KL_ART_ID,
        EAN_KASSE,
        UMSATZ_BRUTTO,
        BON_ID) AS t76 ON A.MANDANT_ID = t76.MANDANT_ID AND A.WUP_ID = t76.WUP_ID AND A.BON_DAT = t76.BON_DAT AND A.BON_ID
            = t76.BON_ID AND A.KL_ART_ID = t76.KL_ART_ID AND A.EAN_KASSE = t76.EAN_KASSE AND - 1 * A.UMSATZ_BRUTTO =
         CASE
         WHEN t76.ANZAHL >= 16
         THEN t76.UMSATZ_BRUTTO
         ELSE NULL
         END
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.MANDANT_ID AS STRING), CAST(A.WUP_ID AS STRING), A.BON_DAT, A.BON_ID
           , CAST(A.KL_ART_ID AS STRING), CAST(A.UMSATZ_BRUTTO AS STRING) ORDER BY A.BON_ZEILE IS NULL DESC, A.BON_ZEILE
           DESC)) = 16)
    UNION DISTINCT
    SELECT A.MANDANT_ID,
     A.WUP_ID,
     A.BON_DAT,
     A.BON_ID,
     A.KL_ART_ID,
     A.UMSATZ_BRUTTO,
     A.BON_ZEILE,
     A.TALON_ID
    FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2 AS A
     INNER JOIN (SELECT MANDANT_ID,
       WUP_ID,
       BON_DAT,
       BON_ID,
       KL_ART_ID,
       EAN_KASSE,
       UMSATZ_BRUTTO,
       COUNT(*) AS ANZAHL
      FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2
      WHERE MENGE < 0
       AND TALON_ID <> 0
      GROUP BY MANDANT_ID,
       WUP_ID,
       BON_DAT,
       KL_ART_ID,
       EAN_KASSE,
       UMSATZ_BRUTTO,
       BON_ID) AS t81 ON A.MANDANT_ID = t81.MANDANT_ID AND A.WUP_ID = t81.WUP_ID AND A.BON_DAT = t81.BON_DAT AND A.BON_ID
           = t81.BON_ID AND A.KL_ART_ID = t81.KL_ART_ID AND A.EAN_KASSE = t81.EAN_KASSE AND - 1 * A.UMSATZ_BRUTTO = CASE
        WHEN t81.ANZAHL >= 17
        THEN t81.UMSATZ_BRUTTO
        ELSE NULL
        END
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.MANDANT_ID AS STRING), CAST(A.WUP_ID AS STRING), A.BON_DAT, A.BON_ID
          , CAST(A.KL_ART_ID AS STRING), CAST(A.UMSATZ_BRUTTO AS STRING) ORDER BY A.BON_ZEILE IS NULL DESC, A.BON_ZEILE
          DESC)) = 17)
   UNION DISTINCT
   SELECT A.MANDANT_ID,
    A.WUP_ID,
    A.BON_DAT,
    A.BON_ID,
    A.KL_ART_ID,
    A.UMSATZ_BRUTTO,
    A.BON_ZEILE,
    A.TALON_ID
   FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2 AS A
    INNER JOIN (SELECT MANDANT_ID,
      WUP_ID,
      BON_DAT,
      BON_ID,
      KL_ART_ID,
      EAN_KASSE,
      UMSATZ_BRUTTO,
      COUNT(*) AS ANZAHL
     FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2
     WHERE MENGE < 0
      AND TALON_ID <> 0
     GROUP BY MANDANT_ID,
      WUP_ID,
      BON_DAT,
      KL_ART_ID,
      EAN_KASSE,
      UMSATZ_BRUTTO,
      BON_ID) AS t86 ON A.MANDANT_ID = t86.MANDANT_ID AND A.WUP_ID = t86.WUP_ID AND A.BON_DAT = t86.BON_DAT AND A.BON_ID
          = t86.BON_ID AND A.KL_ART_ID = t86.KL_ART_ID AND A.EAN_KASSE = t86.EAN_KASSE AND - 1 * A.UMSATZ_BRUTTO = CASE
       WHEN t86.ANZAHL >= 18
       THEN t86.UMSATZ_BRUTTO
       ELSE NULL
       END
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.MANDANT_ID AS STRING), CAST(A.WUP_ID AS STRING), A.BON_DAT, A.BON_ID
         , CAST(A.KL_ART_ID AS STRING), CAST(A.UMSATZ_BRUTTO AS STRING) ORDER BY A.BON_ZEILE IS NULL DESC, A.BON_ZEILE
         DESC)) = 18)
  UNION DISTINCT
  SELECT A.MANDANT_ID,
   A.WUP_ID,
   A.BON_DAT,
   A.BON_ID,
   A.KL_ART_ID,
   A.UMSATZ_BRUTTO,
   A.BON_ZEILE,
   A.TALON_ID
  FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2 AS A
   INNER JOIN (SELECT MANDANT_ID,
     WUP_ID,
     BON_DAT,
     BON_ID,
     KL_ART_ID,
     EAN_KASSE,
     UMSATZ_BRUTTO,
     COUNT(*) AS ANZAHL
    FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2
    WHERE MENGE < 0
     AND TALON_ID <> 0
    GROUP BY MANDANT_ID,
     WUP_ID,
     BON_DAT,
     KL_ART_ID,
     EAN_KASSE,
     UMSATZ_BRUTTO,
     BON_ID) AS t91 ON A.MANDANT_ID = t91.MANDANT_ID AND A.WUP_ID = t91.WUP_ID AND A.BON_DAT = t91.BON_DAT AND A.BON_ID
        = t91.BON_ID AND A.KL_ART_ID = t91.KL_ART_ID AND A.EAN_KASSE = t91.EAN_KASSE AND - 1 * A.UMSATZ_BRUTTO = CASE
      WHEN t91.ANZAHL >= 19
      THEN t91.UMSATZ_BRUTTO
      ELSE NULL
      END
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.MANDANT_ID AS STRING), CAST(A.WUP_ID AS STRING), A.BON_DAT, A.BON_ID, CAST(A.KL_ART_ID AS STRING)
        , CAST(A.UMSATZ_BRUTTO AS STRING) ORDER BY A.BON_ZEILE IS NULL DESC, A.BON_ZEILE DESC)) = 19)
 UNION DISTINCT
 SELECT A.MANDANT_ID,
  A.WUP_ID,
  A.BON_DAT,
  A.BON_ID,
  A.KL_ART_ID,
  A.UMSATZ_BRUTTO,
  A.BON_ZEILE,
  A.TALON_ID
 FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2 AS A
  INNER JOIN (SELECT MANDANT_ID,
    WUP_ID,
    BON_DAT,
    BON_ID,
    KL_ART_ID,
    EAN_KASSE,
    UMSATZ_BRUTTO,
    COUNT(*) AS ANZAHL
   FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2
   WHERE MENGE < 0
    AND TALON_ID <> 0
   GROUP BY MANDANT_ID,
    WUP_ID,
    BON_DAT,
    KL_ART_ID,
    EAN_KASSE,
    UMSATZ_BRUTTO,
    BON_ID) AS t96 ON A.MANDANT_ID = t96.MANDANT_ID AND A.WUP_ID = t96.WUP_ID AND A.BON_DAT = t96.BON_DAT AND A.BON_ID =
       t96.BON_ID AND A.KL_ART_ID = t96.KL_ART_ID AND A.EAN_KASSE = t96.EAN_KASSE AND - 1 * A.UMSATZ_BRUTTO = CASE
     WHEN t96.ANZAHL >= 20
     THEN t96.UMSATZ_BRUTTO
     ELSE NULL
     END
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.MANDANT_ID AS STRING), CAST(A.WUP_ID AS STRING), A.BON_DAT, A.BON_ID, CAST(A.KL_ART_ID AS STRING)
       , CAST(A.UMSATZ_BRUTTO AS STRING) ORDER BY A.BON_ZEILE IS NULL DESC, A.BON_ZEILE DESC)) = 20)
UNION DISTINCT
SELECT MANDANT_ID,
 WUP_ID,
 BON_DAT,
 BON_ID,
 KL_ART_ID,
 UMSATZ_BRUTTO,
 BON_ZEILE,
 TALON_ID
FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_ZEILEN_STORNOS_2
WHERE MENGE < 0
 AND TALON_ID <> 0;