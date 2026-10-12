CREATE OR REPLACE VIEW kfl_production_dbp_etl_process.v_ais_clean_row_cancellation_1 (mandant_id, wup_id, bon_dat, bon_id
, kl_art_id, umsatz_brutto, bon_zeile, talon_id) AS (((((((((((((((((((SELECT a.mandant_id,
                    a.wup_id,
                    a.bon_dat,
                    a.bon_id,
                    a.kl_art_id,
                    a.umsatz_brutto,
                    a.bon_zeile,
                    a.talon_id
                   FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1 AS a
                    INNER JOIN (SELECT mandant_id,
                      wup_id,
                      bon_dat,
                      bon_id,
                      kl_art_id,
                      ean_kasse,
                      umsatz_brutto,
                      COUNT(*) AS anzahl
                     FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1
                     WHERE menge < 0
                      AND talon_id <> 0
                     GROUP BY mandant_id,
                      wup_id,
                      bon_dat,
                      kl_art_id,
                      ean_kasse,
                      umsatz_brutto,
                      bon_id) AS b ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id AND a.bon_dat = b.bon_dat AND
                         a.bon_id = b.bon_id AND a.kl_art_id = b.kl_art_id AND a.ean_kasse = b.ean_kasse AND - 1 * a.umsatz_brutto
                        = CASE
                       WHEN b.anzahl >= 1
                       THEN b.umsatz_brutto
                       ELSE NULL
                       END
                   QUALIFY (ROW_NUMBER() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat, a.bon_id, a.kl_art_id, CAST(a.umsatz_brutto AS STRING)
                         ORDER BY a.bon_zeile IS NULL DESC, a.bon_zeile DESC)) = 1
                   UNION DISTINCT
                   SELECT a.mandant_id,
                    a.wup_id,
                    a.bon_dat,
                    a.bon_id,
                    a.kl_art_id,
                    a.umsatz_brutto,
                    a.bon_zeile,
                    a.talon_id
                   FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1 AS a
                    INNER JOIN (SELECT mandant_id,
                      wup_id,
                      bon_dat,
                      bon_id,
                      kl_art_id,
                      ean_kasse,
                      umsatz_brutto,
                      COUNT(*) AS anzahl
                     FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1
                     WHERE menge < 0
                      AND talon_id <> 0
                     GROUP BY mandant_id,
                      wup_id,
                      bon_dat,
                      kl_art_id,
                      ean_kasse,
                      umsatz_brutto,
                      bon_id) AS b ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id AND a.bon_dat = b.bon_dat AND
                         a.bon_id = b.bon_id AND a.kl_art_id = b.kl_art_id AND a.ean_kasse = b.ean_kasse AND - 1 * a.umsatz_brutto
                        = CASE
                       WHEN b.anzahl >= 2
                       THEN b.umsatz_brutto
                       ELSE NULL
                       END
                   QUALIFY (ROW_NUMBER() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat, a.bon_id, a.kl_art_id, CAST(a.umsatz_brutto AS STRING)
                         ORDER BY a.bon_zeile IS NULL DESC, a.bon_zeile DESC)) = 2)
                  UNION DISTINCT
                  SELECT a.mandant_id,
                   a.wup_id,
                   a.bon_dat,
                   a.bon_id,
                   a.kl_art_id,
                   a.umsatz_brutto,
                   a.bon_zeile,
                   a.talon_id
                  FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1 AS a
                   INNER JOIN (SELECT mandant_id,
                     wup_id,
                     bon_dat,
                     bon_id,
                     kl_art_id,
                     ean_kasse,
                     umsatz_brutto,
                     COUNT(*) AS anzahl
                    FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1
                    WHERE menge < 0
                     AND talon_id <> 0
                    GROUP BY mandant_id,
                     wup_id,
                     bon_dat,
                     kl_art_id,
                     ean_kasse,
                     umsatz_brutto,
                     bon_id) AS b ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id AND a.bon_dat = b.bon_dat AND a
                        .bon_id = b.bon_id AND a.kl_art_id = b.kl_art_id AND a.ean_kasse = b.ean_kasse AND - 1 * a.umsatz_brutto
                       = CASE
                      WHEN b.anzahl >= 3
                      THEN b.umsatz_brutto
                      ELSE NULL
                      END
                  QUALIFY (ROW_NUMBER() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat, a.bon_id, a.kl_art_id, CAST(a.umsatz_brutto AS STRING)
                        ORDER BY a.bon_zeile IS NULL DESC, a.bon_zeile DESC)) = 3)
                 UNION DISTINCT
                 SELECT a.mandant_id,
                  a.wup_id,
                  a.bon_dat,
                  a.bon_id,
                  a.kl_art_id,
                  a.umsatz_brutto,
                  a.bon_zeile,
                  a.talon_id
                 FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1 AS a
                  INNER JOIN (SELECT mandant_id,
                    wup_id,
                    bon_dat,
                    bon_id,
                    kl_art_id,
                    ean_kasse,
                    umsatz_brutto,
                    COUNT(*) AS anzahl
                   FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1
                   WHERE menge < 0
                    AND talon_id <> 0
                   GROUP BY mandant_id,
                    wup_id,
                    bon_dat,
                    kl_art_id,
                    ean_kasse,
                    umsatz_brutto,
                    bon_id) AS b ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id AND a.bon_dat = b.bon_dat AND a
                       .bon_id = b.bon_id AND a.kl_art_id = b.kl_art_id AND a.ean_kasse = b.ean_kasse AND - 1 * a.umsatz_brutto
                      = CASE
                     WHEN b.anzahl >= 4
                     THEN b.umsatz_brutto
                     ELSE NULL
                     END
                 QUALIFY (ROW_NUMBER() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat, a.bon_id, a.kl_art_id, CAST(a.umsatz_brutto AS STRING)
                       ORDER BY a.bon_zeile IS NULL DESC, a.bon_zeile DESC)) = 4)
                UNION DISTINCT
                SELECT a.mandant_id,
                 a.wup_id,
                 a.bon_dat,
                 a.bon_id,
                 a.kl_art_id,
                 a.umsatz_brutto,
                 a.bon_zeile,
                 a.talon_id
                FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1 AS a
                 INNER JOIN (SELECT mandant_id,
                   wup_id,
                   bon_dat,
                   bon_id,
                   kl_art_id,
                   ean_kasse,
                   umsatz_brutto,
                   COUNT(*) AS anzahl
                  FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1
                  WHERE menge < 0
                   AND talon_id <> 0
                  GROUP BY mandant_id,
                   wup_id,
                   bon_dat,
                   kl_art_id,
                   ean_kasse,
                   umsatz_brutto,
                   bon_id) AS b ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id AND a.bon_dat = b.bon_dat AND a.bon_id
                       = b.bon_id AND a.kl_art_id = b.kl_art_id AND a.ean_kasse = b.ean_kasse AND - 1 * a.umsatz_brutto
                   = CASE
                    WHEN b.anzahl >= 5
                    THEN b.umsatz_brutto
                    ELSE NULL
                    END
                QUALIFY (ROW_NUMBER() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat, a.bon_id, a.kl_art_id, CAST(a.umsatz_brutto AS STRING)
                      ORDER BY a.bon_zeile IS NULL DESC, a.bon_zeile DESC)) = 5)
               UNION DISTINCT
               SELECT a.mandant_id,
                a.wup_id,
                a.bon_dat,
                a.bon_id,
                a.kl_art_id,
                a.umsatz_brutto,
                a.bon_zeile,
                a.talon_id
               FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1 AS a
                INNER JOIN (SELECT mandant_id,
                  wup_id,
                  bon_dat,
                  bon_id,
                  kl_art_id,
                  ean_kasse,
                  umsatz_brutto,
                  COUNT(*) AS anzahl
                 FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1
                 WHERE menge < 0
                  AND talon_id <> 0
                 GROUP BY mandant_id,
                  wup_id,
                  bon_dat,
                  kl_art_id,
                  ean_kasse,
                  umsatz_brutto,
                  bon_id) AS b ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id AND a.bon_dat = b.bon_dat AND a.bon_id
                      = b.bon_id AND a.kl_art_id = b.kl_art_id AND a.ean_kasse = b.ean_kasse AND - 1 * a.umsatz_brutto =
                   CASE
                   WHEN b.anzahl >= 6
                   THEN b.umsatz_brutto
                   ELSE NULL
                   END
               QUALIFY (ROW_NUMBER() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat, a.bon_id, a.kl_art_id, CAST(a.umsatz_brutto AS STRING)
                     ORDER BY a.bon_zeile IS NULL DESC, a.bon_zeile DESC)) = 6)
              UNION DISTINCT
              SELECT a.mandant_id,
               a.wup_id,
               a.bon_dat,
               a.bon_id,
               a.kl_art_id,
               a.umsatz_brutto,
               a.bon_zeile,
               a.talon_id
              FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1 AS a
               INNER JOIN (SELECT mandant_id,
                 wup_id,
                 bon_dat,
                 bon_id,
                 kl_art_id,
                 ean_kasse,
                 umsatz_brutto,
                 COUNT(*) AS anzahl
                FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1
                WHERE menge < 0
                 AND talon_id <> 0
                GROUP BY mandant_id,
                 wup_id,
                 bon_dat,
                 kl_art_id,
                 ean_kasse,
                 umsatz_brutto,
                 bon_id) AS b ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id AND a.bon_dat = b.bon_dat AND a.bon_id
                     = b.bon_id AND a.kl_art_id = b.kl_art_id AND a.ean_kasse = b.ean_kasse AND - 1 * a.umsatz_brutto =
                  CASE
                  WHEN b.anzahl >= 7
                  THEN b.umsatz_brutto
                  ELSE NULL
                  END
              QUALIFY (ROW_NUMBER() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat, a.bon_id, a.kl_art_id, CAST(a.umsatz_brutto AS STRING)
                    ORDER BY a.bon_zeile IS NULL DESC, a.bon_zeile DESC)) = 7)
             UNION DISTINCT
             SELECT a.mandant_id,
              a.wup_id,
              a.bon_dat,
              a.bon_id,
              a.kl_art_id,
              a.umsatz_brutto,
              a.bon_zeile,
              a.talon_id
             FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1 AS a
              INNER JOIN (SELECT mandant_id,
                wup_id,
                bon_dat,
                bon_id,
                kl_art_id,
                ean_kasse,
                umsatz_brutto,
                COUNT(*) AS anzahl
               FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1
               WHERE menge < 0
                AND talon_id <> 0
               GROUP BY mandant_id,
                wup_id,
                bon_dat,
                kl_art_id,
                ean_kasse,
                umsatz_brutto,
                bon_id) AS b ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id AND a.bon_dat = b.bon_dat AND a.bon_id
                    = b.bon_id AND a.kl_art_id = b.kl_art_id AND a.ean_kasse = b.ean_kasse AND - 1 * a.umsatz_brutto =
                 CASE
                 WHEN b.anzahl >= 8
                 THEN b.umsatz_brutto
                 ELSE NULL
                 END
             QUALIFY (ROW_NUMBER() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat, a.bon_id, a.kl_art_id, CAST(a.umsatz_brutto AS STRING)
                   ORDER BY a.bon_zeile IS NULL DESC, a.bon_zeile DESC)) = 8)
            UNION DISTINCT
            SELECT a.mandant_id,
             a.wup_id,
             a.bon_dat,
             a.bon_id,
             a.kl_art_id,
             a.umsatz_brutto,
             a.bon_zeile,
             a.talon_id
            FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1 AS a
             INNER JOIN (SELECT mandant_id,
               wup_id,
               bon_dat,
               bon_id,
               kl_art_id,
               ean_kasse,
               umsatz_brutto,
               COUNT(*) AS anzahl
              FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1
              WHERE menge < 0
               AND talon_id <> 0
              GROUP BY mandant_id,
               wup_id,
               bon_dat,
               kl_art_id,
               ean_kasse,
               umsatz_brutto,
               bon_id) AS b ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id AND a.bon_dat = b.bon_dat AND a.bon_id
                   = b.bon_id AND a.kl_art_id = b.kl_art_id AND a.ean_kasse = b.ean_kasse AND - 1 * a.umsatz_brutto =
                CASE
                WHEN b.anzahl >= 9
                THEN b.umsatz_brutto
                ELSE NULL
                END
            QUALIFY (ROW_NUMBER() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat, a.bon_id, a.kl_art_id, CAST(a.umsatz_brutto AS STRING)
                  ORDER BY a.bon_zeile IS NULL DESC, a.bon_zeile DESC)) = 9)
           UNION DISTINCT
           SELECT a.mandant_id,
            a.wup_id,
            a.bon_dat,
            a.bon_id,
            a.kl_art_id,
            a.umsatz_brutto,
            a.bon_zeile,
            a.talon_id
           FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1 AS a
            INNER JOIN (SELECT mandant_id,
              wup_id,
              bon_dat,
              bon_id,
              kl_art_id,
              ean_kasse,
              umsatz_brutto,
              COUNT(*) AS anzahl
             FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1
             WHERE menge < 0
              AND talon_id <> 0
             GROUP BY mandant_id,
              wup_id,
              bon_dat,
              kl_art_id,
              ean_kasse,
              umsatz_brutto,
              bon_id) AS b ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id AND a.bon_dat = b.bon_dat AND a.bon_id
                  = b.bon_id AND a.kl_art_id = b.kl_art_id AND a.ean_kasse = b.ean_kasse AND - 1 * a.umsatz_brutto =
               CASE
               WHEN b.anzahl >= 10
               THEN b.umsatz_brutto
               ELSE NULL
               END
           QUALIFY (ROW_NUMBER() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat, a.bon_id, a.kl_art_id, CAST(a.umsatz_brutto AS STRING)
                 ORDER BY a.bon_zeile IS NULL DESC, a.bon_zeile DESC)) = 10)
          UNION DISTINCT
          SELECT a.mandant_id,
           a.wup_id,
           a.bon_dat,
           a.bon_id,
           a.kl_art_id,
           a.umsatz_brutto,
           a.bon_zeile,
           a.talon_id
          FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1 AS a
           INNER JOIN (SELECT mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
             COUNT(*) AS anzahl
            FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1
            WHERE menge < 0
             AND talon_id <> 0
            GROUP BY mandant_id,
             wup_id,
             bon_dat,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
             bon_id) AS b ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id AND a.bon_dat = b.bon_dat AND a.bon_id
                = b.bon_id AND a.kl_art_id = b.kl_art_id AND a.ean_kasse = b.ean_kasse AND - 1 * a.umsatz_brutto = CASE
              WHEN b.anzahl >= 11
              THEN b.umsatz_brutto
              ELSE NULL
              END
          QUALIFY (ROW_NUMBER() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat, a.bon_id, a.kl_art_id, CAST(a.umsatz_brutto AS STRING)
                ORDER BY a.bon_zeile IS NULL DESC, a.bon_zeile DESC)) = 11)
         UNION DISTINCT
         SELECT a.mandant_id,
          a.wup_id,
          a.bon_dat,
          a.bon_id,
          a.kl_art_id,
          a.umsatz_brutto,
          a.bon_zeile,
          a.talon_id
         FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1 AS a
          INNER JOIN (SELECT mandant_id,
            wup_id,
            bon_dat,
            bon_id,
            kl_art_id,
            ean_kasse,
            umsatz_brutto,
            COUNT(*) AS anzahl
           FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1
           WHERE menge < 0
            AND talon_id <> 0
           GROUP BY mandant_id,
            wup_id,
            bon_dat,
            kl_art_id,
            ean_kasse,
            umsatz_brutto,
            bon_id) AS b ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id AND a.bon_dat = b.bon_dat AND a.bon_id =
               b.bon_id AND a.kl_art_id = b.kl_art_id AND a.ean_kasse = b.ean_kasse AND - 1 * a.umsatz_brutto = CASE
             WHEN b.anzahl >= 12
             THEN b.umsatz_brutto
             ELSE NULL
             END
         QUALIFY (ROW_NUMBER() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat, a.bon_id, a.kl_art_id, CAST(a.umsatz_brutto AS STRING)
               ORDER BY a.bon_zeile IS NULL DESC, a.bon_zeile DESC)) = 12)
        UNION DISTINCT
        SELECT a.mandant_id,
         a.wup_id,
         a.bon_dat,
         a.bon_id,
         a.kl_art_id,
         a.umsatz_brutto,
         a.bon_zeile,
         a.talon_id
        FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1 AS a
         INNER JOIN (SELECT mandant_id,
           wup_id,
           bon_dat,
           bon_id,
           kl_art_id,
           ean_kasse,
           umsatz_brutto,
           COUNT(*) AS anzahl
          FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1
          WHERE menge < 0
           AND talon_id <> 0
          GROUP BY mandant_id,
           wup_id,
           bon_dat,
           kl_art_id,
           ean_kasse,
           umsatz_brutto,
           bon_id) AS b ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id AND a.bon_dat = b.bon_dat AND a.bon_id =
              b.bon_id AND a.kl_art_id = b.kl_art_id AND a.ean_kasse = b.ean_kasse AND - 1 * a.umsatz_brutto = CASE
            WHEN b.anzahl >= 13
            THEN b.umsatz_brutto
            ELSE NULL
            END
        QUALIFY (ROW_NUMBER() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat, a.bon_id, a.kl_art_id, CAST(a.umsatz_brutto AS STRING)
              ORDER BY a.bon_zeile IS NULL DESC, a.bon_zeile DESC)) = 13)
       UNION DISTINCT
       SELECT a.mandant_id,
        a.wup_id,
        a.bon_dat,
        a.bon_id,
        a.kl_art_id,
        a.umsatz_brutto,
        a.bon_zeile,
        a.talon_id
       FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1 AS a
        INNER JOIN (SELECT mandant_id,
          wup_id,
          bon_dat,
          bon_id,
          kl_art_id,
          ean_kasse,
          umsatz_brutto,
          COUNT(*) AS anzahl
         FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1
         WHERE menge < 0
          AND talon_id <> 0
         GROUP BY mandant_id,
          wup_id,
          bon_dat,
          kl_art_id,
          ean_kasse,
          umsatz_brutto,
          bon_id) AS b ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id AND a.bon_dat = b.bon_dat AND a.bon_id = b
             .bon_id AND a.kl_art_id = b.kl_art_id AND a.ean_kasse = b.ean_kasse AND - 1 * a.umsatz_brutto = CASE
           WHEN b.anzahl >= 14
           THEN b.umsatz_brutto
           ELSE NULL
           END
       QUALIFY (ROW_NUMBER() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat, a.bon_id, a.kl_art_id, CAST(a.umsatz_brutto AS STRING)
             ORDER BY a.bon_zeile IS NULL DESC, a.bon_zeile DESC)) = 14)
      UNION DISTINCT
      SELECT a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
       a.umsatz_brutto,
       a.bon_zeile,
       a.talon_id
      FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1 AS a
       INNER JOIN (SELECT mandant_id,
         wup_id,
         bon_dat,
         bon_id,
         kl_art_id,
         ean_kasse,
         umsatz_brutto,
         COUNT(*) AS anzahl
        FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1
        WHERE menge < 0
         AND talon_id <> 0
        GROUP BY mandant_id,
         wup_id,
         bon_dat,
         kl_art_id,
         ean_kasse,
         umsatz_brutto,
         bon_id) AS b ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id AND a.bon_dat = b.bon_dat AND a.bon_id = b
            .bon_id AND a.kl_art_id = b.kl_art_id AND a.ean_kasse = b.ean_kasse AND - 1 * a.umsatz_brutto = CASE
          WHEN b.anzahl >= 15
          THEN b.umsatz_brutto
          ELSE NULL
          END
      QUALIFY (ROW_NUMBER() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat, a.bon_id, a.kl_art_id, CAST(a.umsatz_brutto AS STRING)
            ORDER BY a.bon_zeile IS NULL DESC, a.bon_zeile DESC)) = 15)
     UNION DISTINCT
     SELECT a.mandant_id,
      a.wup_id,
      a.bon_dat,
      a.bon_id,
      a.kl_art_id,
      a.umsatz_brutto,
      a.bon_zeile,
      a.talon_id
     FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1 AS a
      INNER JOIN (SELECT mandant_id,
        wup_id,
        bon_dat,
        bon_id,
        kl_art_id,
        ean_kasse,
        umsatz_brutto,
        COUNT(*) AS anzahl
       FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1
       WHERE menge < 0
        AND talon_id <> 0
       GROUP BY mandant_id,
        wup_id,
        bon_dat,
        kl_art_id,
        ean_kasse,
        umsatz_brutto,
        bon_id) AS b ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id AND a.bon_dat = b.bon_dat AND a.bon_id = b.bon_id
            AND a.kl_art_id = b.kl_art_id AND a.ean_kasse = b.ean_kasse AND - 1 * a.umsatz_brutto = CASE
         WHEN b.anzahl >= 16
         THEN b.umsatz_brutto
         ELSE NULL
         END
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat, a.bon_id, a.kl_art_id, CAST(a.umsatz_brutto AS STRING)
           ORDER BY a.bon_zeile IS NULL DESC, a.bon_zeile DESC)) = 16)
    UNION DISTINCT
    SELECT a.mandant_id,
     a.wup_id,
     a.bon_dat,
     a.bon_id,
     a.kl_art_id,
     a.umsatz_brutto,
     a.bon_zeile,
     a.talon_id
    FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1 AS a
     INNER JOIN (SELECT mandant_id,
       wup_id,
       bon_dat,
       bon_id,
       kl_art_id,
       ean_kasse,
       umsatz_brutto,
       COUNT(*) AS anzahl
      FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1
      WHERE menge < 0
       AND talon_id <> 0
      GROUP BY mandant_id,
       wup_id,
       bon_dat,
       kl_art_id,
       ean_kasse,
       umsatz_brutto,
       bon_id) AS b ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id AND a.bon_dat = b.bon_dat AND a.bon_id = b.bon_id
           AND a.kl_art_id = b.kl_art_id AND a.ean_kasse = b.ean_kasse AND - 1 * a.umsatz_brutto = CASE
        WHEN b.anzahl >= 17
        THEN b.umsatz_brutto
        ELSE NULL
        END
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat, a.bon_id, a.kl_art_id, CAST(a.umsatz_brutto AS STRING)
          ORDER BY a.bon_zeile IS NULL DESC, a.bon_zeile DESC)) = 17)
   UNION DISTINCT
   SELECT a.mandant_id,
    a.wup_id,
    a.bon_dat,
    a.bon_id,
    a.kl_art_id,
    a.umsatz_brutto,
    a.bon_zeile,
    a.talon_id
   FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1 AS a
    INNER JOIN (SELECT mandant_id,
      wup_id,
      bon_dat,
      bon_id,
      kl_art_id,
      ean_kasse,
      umsatz_brutto,
      COUNT(*) AS anzahl
     FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1
     WHERE menge < 0
      AND talon_id <> 0
     GROUP BY mandant_id,
      wup_id,
      bon_dat,
      kl_art_id,
      ean_kasse,
      umsatz_brutto,
      bon_id) AS b ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id AND a.bon_dat = b.bon_dat AND a.bon_id = b.bon_id
          AND a.kl_art_id = b.kl_art_id AND a.ean_kasse = b.ean_kasse AND - 1 * a.umsatz_brutto = CASE
       WHEN b.anzahl >= 18
       THEN b.umsatz_brutto
       ELSE NULL
       END
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat, a.bon_id, a.kl_art_id, CAST(a.umsatz_brutto AS STRING)
         ORDER BY a.bon_zeile IS NULL DESC, a.bon_zeile DESC)) = 18)
  UNION DISTINCT
  SELECT a.mandant_id,
   a.wup_id,
   a.bon_dat,
   a.bon_id,
   a.kl_art_id,
   a.umsatz_brutto,
   a.bon_zeile,
   a.talon_id
  FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1 AS a
   INNER JOIN (SELECT mandant_id,
     wup_id,
     bon_dat,
     bon_id,
     kl_art_id,
     ean_kasse,
     umsatz_brutto,
     COUNT(*) AS anzahl
    FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1
    WHERE menge < 0
     AND talon_id <> 0
    GROUP BY mandant_id,
     wup_id,
     bon_dat,
     kl_art_id,
     ean_kasse,
     umsatz_brutto,
     bon_id) AS b ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id AND a.bon_dat = b.bon_dat AND a.bon_id = b.bon_id
         AND a.kl_art_id = b.kl_art_id AND a.ean_kasse = b.ean_kasse AND - 1 * a.umsatz_brutto = CASE
      WHEN b.anzahl >= 19
      THEN b.umsatz_brutto
      ELSE NULL
      END
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat, a.bon_id, a.kl_art_id, CAST(a.umsatz_brutto AS STRING)
        ORDER BY a.bon_zeile IS NULL DESC, a.bon_zeile DESC)) = 19)
 UNION DISTINCT
 SELECT a.mandant_id,
  a.wup_id,
  a.bon_dat,
  a.bon_id,
  a.kl_art_id,
  a.umsatz_brutto,
  a.bon_zeile,
  a.talon_id
 FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1 AS a
  INNER JOIN (SELECT mandant_id,
    wup_id,
    bon_dat,
    bon_id,
    kl_art_id,
    ean_kasse,
    umsatz_brutto,
    COUNT(*) AS anzahl
   FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1
   WHERE menge < 0
    AND talon_id <> 0
   GROUP BY mandant_id,
    wup_id,
    bon_dat,
    kl_art_id,
    ean_kasse,
    umsatz_brutto,
    bon_id) AS b ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id AND a.bon_dat = b.bon_dat AND a.bon_id = b.bon_id
        AND a.kl_art_id = b.kl_art_id AND a.ean_kasse = b.ean_kasse AND - 1 * a.umsatz_brutto = CASE
     WHEN b.anzahl >= 20
     THEN b.umsatz_brutto
     ELSE NULL
     END
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat, a.bon_id, a.kl_art_id, CAST(a.umsatz_brutto AS STRING)
       ORDER BY a.bon_zeile IS NULL DESC, a.bon_zeile DESC)) = 20)
UNION DISTINCT
SELECT mandant_id,
 wup_id,
 bon_dat,
 bon_id,
 kl_art_id,
 umsatz_brutto,
 bon_zeile,
 talon_id
FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_1
WHERE menge < 0
 AND talon_id <> 0;