CREATE OR REPLACE VIEW kfl_production_dbp_etl_process.v_ais_clean_row_cancellation_2 (mandant_id, wup_id, bon_dat, bon_id
, kl_art_id, umsatz_brutto, bon_zeile, talon_id) AS (((SELECT A.mandant_id,
    A.wup_id,
    A.bon_dat,
    A.bon_id,
    A.kl_art_id,
    A.umsatz_brutto,
    A.bon_zeile,
    A.talon_id
   FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2 AS A
    INNER JOIN (SELECT mandant_id,
      wup_id,
      bon_dat,
      bon_id,
      kl_art_id,
      ean_kasse,
      umsatz_brutto,
      COUNT(*) AS anzahl
     FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2
     WHERE menge < 0
      AND talon_id <> 0
     GROUP BY mandant_id,
      wup_id,
      bon_dat,
      kl_art_id,
      ean_kasse,
      umsatz_brutto,
      bon_id) AS b ON A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.bon_dat = b.bon_dat AND A.bon_id = b.bon_id
          AND A.kl_art_id = b.kl_art_id AND A.ean_kasse = b.ean_kasse AND -1 * A.umsatz_brutto = CASE
       WHEN b.anzahl >= 1
       THEN b.umsatz_brutto
       ELSE NULL
       END
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY A.mandant_id, A.wup_id, A.bon_dat, A.bon_id, A.kl_art_id, A.umsatz_brutto
       ORDER BY A.bon_zeile IS NULL DESC, A.bon_zeile DESC)) = 1
   UNION DISTINCT
   SELECT A0.mandant_id,
    A0.wup_id,
    A0.bon_dat,
    A0.bon_id,
    A0.kl_art_id,
    A0.umsatz_brutto,
    A0.bon_zeile,
    A0.talon_id
   FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2 AS A0
    INNER JOIN (SELECT mandant_id,
      wup_id,
      bon_dat,
      bon_id,
      kl_art_id,
      ean_kasse,
      umsatz_brutto,
      COUNT(*) AS anzahl
     FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2
     WHERE menge < 0
      AND talon_id <> 0
     GROUP BY mandant_id,
      wup_id,
      bon_dat,
      kl_art_id,
      ean_kasse,
      umsatz_brutto,
      bon_id) AS b ON A0.mandant_id = b.mandant_id AND A0.wup_id = b.wup_id AND A0.bon_dat = b.bon_dat AND A0.bon_id = b
         .bon_id AND A0.kl_art_id = b.kl_art_id AND A0.ean_kasse = b.ean_kasse AND -1 * A0.umsatz_brutto = CASE
       WHEN b.anzahl >= 2
       THEN b.umsatz_brutto
       ELSE NULL
       END
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY A0.mandant_id, A0.wup_id, A0.bon_dat, A0.bon_id, A0.kl_art_id, A0.umsatz_brutto
         ORDER BY A0.bon_zeile IS NULL DESC, A0.bon_zeile DESC)) = 2)
  UNION DISTINCT
  (SELECT A1.mandant_id,
    A1.wup_id,
    A1.bon_dat,
    A1.bon_id,
    A1.kl_art_id,
    A1.umsatz_brutto,
    A1.bon_zeile,
    A1.talon_id
   FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2 AS A1
    INNER JOIN (SELECT mandant_id,
      wup_id,
      bon_dat,
      bon_id,
      kl_art_id,
      ean_kasse,
      umsatz_brutto,
      COUNT(*) AS anzahl
     FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2
     WHERE menge < 0
      AND talon_id <> 0
     GROUP BY mandant_id,
      wup_id,
      bon_dat,
      kl_art_id,
      ean_kasse,
      umsatz_brutto,
      bon_id) AS b ON A1.mandant_id = b.mandant_id AND A1.wup_id = b.wup_id AND A1.bon_dat = b.bon_dat AND A1.bon_id = b
         .bon_id AND A1.kl_art_id = b.kl_art_id AND A1.ean_kasse = b.ean_kasse AND -1 * A1.umsatz_brutto = CASE
       WHEN b.anzahl >= 3
       THEN b.umsatz_brutto
       ELSE NULL
       END
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY A1.mandant_id, A1.wup_id, A1.bon_dat, A1.bon_id, A1.kl_art_id, A1.umsatz_brutto
         ORDER BY A1.bon_zeile IS NULL DESC, A1.bon_zeile DESC)) = 3
   UNION DISTINCT
   (SELECT A2.mandant_id,
     A2.wup_id,
     A2.bon_dat,
     A2.bon_id,
     A2.kl_art_id,
     A2.umsatz_brutto,
     A2.bon_zeile,
     A2.talon_id
    FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2 AS A2
     INNER JOIN (SELECT mandant_id,
       wup_id,
       bon_dat,
       bon_id,
       kl_art_id,
       ean_kasse,
       umsatz_brutto,
       COUNT(*) AS anzahl
      FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2
      WHERE menge < 0
       AND talon_id <> 0
      GROUP BY mandant_id,
       wup_id,
       bon_dat,
       kl_art_id,
       ean_kasse,
       umsatz_brutto,
       bon_id) AS b ON A2.mandant_id = b.mandant_id AND A2.wup_id = b.wup_id AND A2.bon_dat = b.bon_dat AND A2.bon_id =
          b.bon_id AND A2.kl_art_id = b.kl_art_id AND A2.ean_kasse = b.ean_kasse AND -1 * A2.umsatz_brutto = CASE
        WHEN b.anzahl >= 4
        THEN b.umsatz_brutto
        ELSE NULL
        END
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY A2.mandant_id, A2.wup_id, A2.bon_dat, A2.bon_id, A2.kl_art_id, A2.umsatz_brutto
          ORDER BY A2.bon_zeile IS NULL DESC, A2.bon_zeile DESC)) = 4
    UNION DISTINCT
    SELECT A3.mandant_id,
     A3.wup_id,
     A3.bon_dat,
     A3.bon_id,
     A3.kl_art_id,
     A3.umsatz_brutto,
     A3.bon_zeile,
     A3.talon_id
    FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2 AS A3
     INNER JOIN (SELECT mandant_id,
       wup_id,
       bon_dat,
       bon_id,
       kl_art_id,
       ean_kasse,
       umsatz_brutto,
       COUNT(*) AS anzahl
      FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2
      WHERE menge < 0
       AND talon_id <> 0
      GROUP BY mandant_id,
       wup_id,
       bon_dat,
       kl_art_id,
       ean_kasse,
       umsatz_brutto,
       bon_id) AS b ON A3.mandant_id = b.mandant_id AND A3.wup_id = b.wup_id AND A3.bon_dat = b.bon_dat AND A3.bon_id =
          b.bon_id AND A3.kl_art_id = b.kl_art_id AND A3.ean_kasse = b.ean_kasse AND -1 * A3.umsatz_brutto = CASE
        WHEN b.anzahl >= 5
        THEN b.umsatz_brutto
        ELSE NULL
        END
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY A3.mandant_id, A3.wup_id, A3.bon_dat, A3.bon_id, A3.kl_art_id, A3.umsatz_brutto
          ORDER BY A3.bon_zeile IS NULL DESC, A3.bon_zeile DESC)) = 5)))
 UNION DISTINCT
 ((SELECT A4.mandant_id,
    A4.wup_id,
    A4.bon_dat,
    A4.bon_id,
    A4.kl_art_id,
    A4.umsatz_brutto,
    A4.bon_zeile,
    A4.talon_id
   FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2 AS A4
    INNER JOIN (SELECT mandant_id,
      wup_id,
      bon_dat,
      bon_id,
      kl_art_id,
      ean_kasse,
      umsatz_brutto,
      COUNT(*) AS anzahl
     FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2
     WHERE menge < 0
      AND talon_id <> 0
     GROUP BY mandant_id,
      wup_id,
      bon_dat,
      kl_art_id,
      ean_kasse,
      umsatz_brutto,
      bon_id) AS b ON A4.mandant_id = b.mandant_id AND A4.wup_id = b.wup_id AND A4.bon_dat = b.bon_dat AND A4.bon_id = b
         .bon_id AND A4.kl_art_id = b.kl_art_id AND A4.ean_kasse = b.ean_kasse AND -1 * A4.umsatz_brutto = CASE
       WHEN b.anzahl >= 6
       THEN b.umsatz_brutto
       ELSE NULL
       END
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY A4.mandant_id, A4.wup_id, A4.bon_dat, A4.bon_id, A4.kl_art_id, A4.umsatz_brutto
         ORDER BY A4.bon_zeile IS NULL DESC, A4.bon_zeile DESC)) = 6
   UNION DISTINCT
   SELECT A5.mandant_id,
    A5.wup_id,
    A5.bon_dat,
    A5.bon_id,
    A5.kl_art_id,
    A5.umsatz_brutto,
    A5.bon_zeile,
    A5.talon_id
   FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2 AS A5
    INNER JOIN (SELECT mandant_id,
      wup_id,
      bon_dat,
      bon_id,
      kl_art_id,
      ean_kasse,
      umsatz_brutto,
      COUNT(*) AS anzahl
     FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2
     WHERE menge < 0
      AND talon_id <> 0
     GROUP BY mandant_id,
      wup_id,
      bon_dat,
      kl_art_id,
      ean_kasse,
      umsatz_brutto,
      bon_id) AS b ON A5.mandant_id = b.mandant_id AND A5.wup_id = b.wup_id AND A5.bon_dat = b.bon_dat AND A5.bon_id = b
         .bon_id AND A5.kl_art_id = b.kl_art_id AND A5.ean_kasse = b.ean_kasse AND -1 * A5.umsatz_brutto = CASE
       WHEN b.anzahl >= 7
       THEN b.umsatz_brutto
       ELSE NULL
       END
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY A5.mandant_id, A5.wup_id, A5.bon_dat, A5.bon_id, A5.kl_art_id, A5.umsatz_brutto
         ORDER BY A5.bon_zeile IS NULL DESC, A5.bon_zeile DESC)) = 7)
  UNION DISTINCT
  (SELECT A6.mandant_id,
    A6.wup_id,
    A6.bon_dat,
    A6.bon_id,
    A6.kl_art_id,
    A6.umsatz_brutto,
    A6.bon_zeile,
    A6.talon_id
   FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2 AS A6
    INNER JOIN (SELECT mandant_id,
      wup_id,
      bon_dat,
      bon_id,
      kl_art_id,
      ean_kasse,
      umsatz_brutto,
      COUNT(*) AS anzahl
     FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2
     WHERE menge < 0
      AND talon_id <> 0
     GROUP BY mandant_id,
      wup_id,
      bon_dat,
      kl_art_id,
      ean_kasse,
      umsatz_brutto,
      bon_id) AS b ON A6.mandant_id = b.mandant_id AND A6.wup_id = b.wup_id AND A6.bon_dat = b.bon_dat AND A6.bon_id = b
         .bon_id AND A6.kl_art_id = b.kl_art_id AND A6.ean_kasse = b.ean_kasse AND -1 * A6.umsatz_brutto = CASE
       WHEN b.anzahl >= 8
       THEN b.umsatz_brutto
       ELSE NULL
       END
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY A6.mandant_id, A6.wup_id, A6.bon_dat, A6.bon_id, A6.kl_art_id, A6.umsatz_brutto
         ORDER BY A6.bon_zeile IS NULL DESC, A6.bon_zeile DESC)) = 8
   UNION DISTINCT
   (SELECT A7.mandant_id,
     A7.wup_id,
     A7.bon_dat,
     A7.bon_id,
     A7.kl_art_id,
     A7.umsatz_brutto,
     A7.bon_zeile,
     A7.talon_id
    FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2 AS A7
     INNER JOIN (SELECT mandant_id,
       wup_id,
       bon_dat,
       bon_id,
       kl_art_id,
       ean_kasse,
       umsatz_brutto,
       COUNT(*) AS anzahl
      FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2
      WHERE menge < 0
       AND talon_id <> 0
      GROUP BY mandant_id,
       wup_id,
       bon_dat,
       kl_art_id,
       ean_kasse,
       umsatz_brutto,
       bon_id) AS b ON A7.mandant_id = b.mandant_id AND A7.wup_id = b.wup_id AND A7.bon_dat = b.bon_dat AND A7.bon_id =
          b.bon_id AND A7.kl_art_id = b.kl_art_id AND A7.ean_kasse = b.ean_kasse AND -1 * A7.umsatz_brutto = CASE
        WHEN b.anzahl >= 9
        THEN b.umsatz_brutto
        ELSE NULL
        END
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY A7.mandant_id, A7.wup_id, A7.bon_dat, A7.bon_id, A7.kl_art_id, A7.umsatz_brutto
          ORDER BY A7.bon_zeile IS NULL DESC, A7.bon_zeile DESC)) = 9
    UNION DISTINCT
    SELECT A8.mandant_id,
     A8.wup_id,
     A8.bon_dat,
     A8.bon_id,
     A8.kl_art_id,
     A8.umsatz_brutto,
     A8.bon_zeile,
     A8.talon_id
    FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2 AS A8
     INNER JOIN (SELECT mandant_id,
       wup_id,
       bon_dat,
       bon_id,
       kl_art_id,
       ean_kasse,
       umsatz_brutto,
       COUNT(*) AS anzahl
      FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2
      WHERE menge < 0
       AND talon_id <> 0
      GROUP BY mandant_id,
       wup_id,
       bon_dat,
       kl_art_id,
       ean_kasse,
       umsatz_brutto,
       bon_id) AS b ON A8.mandant_id = b.mandant_id AND A8.wup_id = b.wup_id AND A8.bon_dat = b.bon_dat AND A8.bon_id =
          b.bon_id AND A8.kl_art_id = b.kl_art_id AND A8.ean_kasse = b.ean_kasse AND -1 * A8.umsatz_brutto = CASE
        WHEN b.anzahl >= 10
        THEN b.umsatz_brutto
        ELSE NULL
        END
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY A8.mandant_id, A8.wup_id, A8.bon_dat, A8.bon_id, A8.kl_art_id, A8.umsatz_brutto
          ORDER BY A8.bon_zeile IS NULL DESC, A8.bon_zeile DESC)) = 10))))
UNION DISTINCT
(((SELECT A9.mandant_id,
    A9.wup_id,
    A9.bon_dat,
    A9.bon_id,
    A9.kl_art_id,
    A9.umsatz_brutto,
    A9.bon_zeile,
    A9.talon_id
   FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2 AS A9
    INNER JOIN (SELECT mandant_id,
      wup_id,
      bon_dat,
      bon_id,
      kl_art_id,
      ean_kasse,
      umsatz_brutto,
      COUNT(*) AS anzahl
     FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2
     WHERE menge < 0
      AND talon_id <> 0
     GROUP BY mandant_id,
      wup_id,
      bon_dat,
      kl_art_id,
      ean_kasse,
      umsatz_brutto,
      bon_id) AS b ON A9.mandant_id = b.mandant_id AND A9.wup_id = b.wup_id AND A9.bon_dat = b.bon_dat AND A9.bon_id = b
         .bon_id AND A9.kl_art_id = b.kl_art_id AND A9.ean_kasse = b.ean_kasse AND -1 * A9.umsatz_brutto = CASE
       WHEN b.anzahl >= 11
       THEN b.umsatz_brutto
       ELSE NULL
       END
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY A9.mandant_id, A9.wup_id, A9.bon_dat, A9.bon_id, A9.kl_art_id, A9.umsatz_brutto
         ORDER BY A9.bon_zeile IS NULL DESC, A9.bon_zeile DESC)) = 11
   UNION DISTINCT
   SELECT A10.mandant_id,
    A10.wup_id,
    A10.bon_dat,
    A10.bon_id,
    A10.kl_art_id,
    A10.umsatz_brutto,
    A10.bon_zeile,
    A10.talon_id
   FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2 AS A10
    INNER JOIN (SELECT mandant_id,
      wup_id,
      bon_dat,
      bon_id,
      kl_art_id,
      ean_kasse,
      umsatz_brutto,
      COUNT(*) AS anzahl
     FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2
     WHERE menge < 0
      AND talon_id <> 0
     GROUP BY mandant_id,
      wup_id,
      bon_dat,
      kl_art_id,
      ean_kasse,
      umsatz_brutto,
      bon_id) AS b ON A10.mandant_id = b.mandant_id AND A10.wup_id = b.wup_id AND A10.bon_dat = b.bon_dat AND A10.bon_id
          = b.bon_id AND A10.kl_art_id = b.kl_art_id AND A10.ean_kasse = b.ean_kasse AND -1 * A10.umsatz_brutto = CASE
       WHEN b.anzahl >= 12
       THEN b.umsatz_brutto
       ELSE NULL
       END
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY A10.mandant_id, A10.wup_id, A10.bon_dat, A10.bon_id, A10.kl_art_id, A10.umsatz_brutto
         ORDER BY A10.bon_zeile IS NULL DESC, A10.bon_zeile DESC)) = 12)
  UNION DISTINCT
  (SELECT A11.mandant_id,
    A11.wup_id,
    A11.bon_dat,
    A11.bon_id,
    A11.kl_art_id,
    A11.umsatz_brutto,
    A11.bon_zeile,
    A11.talon_id
   FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2 AS A11
    INNER JOIN (SELECT mandant_id,
      wup_id,
      bon_dat,
      bon_id,
      kl_art_id,
      ean_kasse,
      umsatz_brutto,
      COUNT(*) AS anzahl
     FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2
     WHERE menge < 0
      AND talon_id <> 0
     GROUP BY mandant_id,
      wup_id,
      bon_dat,
      kl_art_id,
      ean_kasse,
      umsatz_brutto,
      bon_id) AS b ON A11.mandant_id = b.mandant_id AND A11.wup_id = b.wup_id AND A11.bon_dat = b.bon_dat AND A11.bon_id
          = b.bon_id AND A11.kl_art_id = b.kl_art_id AND A11.ean_kasse = b.ean_kasse AND -1 * A11.umsatz_brutto = CASE
       WHEN b.anzahl >= 13
       THEN b.umsatz_brutto
       ELSE NULL
       END
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY A11.mandant_id, A11.wup_id, A11.bon_dat, A11.bon_id, A11.kl_art_id, A11.umsatz_brutto
         ORDER BY A11.bon_zeile IS NULL DESC, A11.bon_zeile DESC)) = 13
   UNION DISTINCT
   (SELECT A12.mandant_id,
     A12.wup_id,
     A12.bon_dat,
     A12.bon_id,
     A12.kl_art_id,
     A12.umsatz_brutto,
     A12.bon_zeile,
     A12.talon_id
    FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2 AS A12
     INNER JOIN (SELECT mandant_id,
       wup_id,
       bon_dat,
       bon_id,
       kl_art_id,
       ean_kasse,
       umsatz_brutto,
       COUNT(*) AS anzahl
      FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2
      WHERE menge < 0
       AND talon_id <> 0
      GROUP BY mandant_id,
       wup_id,
       bon_dat,
       kl_art_id,
       ean_kasse,
       umsatz_brutto,
       bon_id) AS b ON A12.mandant_id = b.mandant_id AND A12.wup_id = b.wup_id AND A12.bon_dat = b.bon_dat AND A12.bon_id
           = b.bon_id AND A12.kl_art_id = b.kl_art_id AND A12.ean_kasse = b.ean_kasse AND -1 * A12.umsatz_brutto = CASE
        WHEN b.anzahl >= 14
        THEN b.umsatz_brutto
        ELSE NULL
        END
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY A12.mandant_id, A12.wup_id, A12.bon_dat, A12.bon_id, A12.kl_art_id, A12.umsatz_brutto
          ORDER BY A12.bon_zeile IS NULL DESC, A12.bon_zeile DESC)) = 14
    UNION DISTINCT
    SELECT A13.mandant_id,
     A13.wup_id,
     A13.bon_dat,
     A13.bon_id,
     A13.kl_art_id,
     A13.umsatz_brutto,
     A13.bon_zeile,
     A13.talon_id
    FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2 AS A13
     INNER JOIN (SELECT mandant_id,
       wup_id,
       bon_dat,
       bon_id,
       kl_art_id,
       ean_kasse,
       umsatz_brutto,
       COUNT(*) AS anzahl
      FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2
      WHERE menge < 0
       AND talon_id <> 0
      GROUP BY mandant_id,
       wup_id,
       bon_dat,
       kl_art_id,
       ean_kasse,
       umsatz_brutto,
       bon_id) AS b ON A13.mandant_id = b.mandant_id AND A13.wup_id = b.wup_id AND A13.bon_dat = b.bon_dat AND A13.bon_id
           = b.bon_id AND A13.kl_art_id = b.kl_art_id AND A13.ean_kasse = b.ean_kasse AND -1 * A13.umsatz_brutto = CASE
        WHEN b.anzahl >= 15
        THEN b.umsatz_brutto
        ELSE NULL
        END
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY A13.mandant_id, A13.wup_id, A13.bon_dat, A13.bon_id, A13.kl_art_id, A13.umsatz_brutto
          ORDER BY A13.bon_zeile IS NULL DESC, A13.bon_zeile DESC)) = 15)))
 UNION DISTINCT
 ((SELECT A14.mandant_id,
    A14.wup_id,
    A14.bon_dat,
    A14.bon_id,
    A14.kl_art_id,
    A14.umsatz_brutto,
    A14.bon_zeile,
    A14.talon_id
   FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2 AS A14
    INNER JOIN (SELECT mandant_id,
      wup_id,
      bon_dat,
      bon_id,
      kl_art_id,
      ean_kasse,
      umsatz_brutto,
      COUNT(*) AS anzahl
     FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2
     WHERE menge < 0
      AND talon_id <> 0
     GROUP BY mandant_id,
      wup_id,
      bon_dat,
      kl_art_id,
      ean_kasse,
      umsatz_brutto,
      bon_id) AS b ON A14.mandant_id = b.mandant_id AND A14.wup_id = b.wup_id AND A14.bon_dat = b.bon_dat AND A14.bon_id
          = b.bon_id AND A14.kl_art_id = b.kl_art_id AND A14.ean_kasse = b.ean_kasse AND -1 * A14.umsatz_brutto = CASE
       WHEN b.anzahl >= 16
       THEN b.umsatz_brutto
       ELSE NULL
       END
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY A14.mandant_id, A14.wup_id, A14.bon_dat, A14.bon_id, A14.kl_art_id, A14.umsatz_brutto
         ORDER BY A14.bon_zeile IS NULL DESC, A14.bon_zeile DESC)) = 16
   UNION DISTINCT
   (SELECT A15.mandant_id,
     A15.wup_id,
     A15.bon_dat,
     A15.bon_id,
     A15.kl_art_id,
     A15.umsatz_brutto,
     A15.bon_zeile,
     A15.talon_id
    FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2 AS A15
     INNER JOIN (SELECT mandant_id,
       wup_id,
       bon_dat,
       bon_id,
       kl_art_id,
       ean_kasse,
       umsatz_brutto,
       COUNT(*) AS anzahl
      FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2
      WHERE menge < 0
       AND talon_id <> 0
      GROUP BY mandant_id,
       wup_id,
       bon_dat,
       kl_art_id,
       ean_kasse,
       umsatz_brutto,
       bon_id) AS b ON A15.mandant_id = b.mandant_id AND A15.wup_id = b.wup_id AND A15.bon_dat = b.bon_dat AND A15.bon_id
           = b.bon_id AND A15.kl_art_id = b.kl_art_id AND A15.ean_kasse = b.ean_kasse AND -1 * A15.umsatz_brutto = CASE
        WHEN b.anzahl >= 17
        THEN b.umsatz_brutto
        ELSE NULL
        END
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY A15.mandant_id, A15.wup_id, A15.bon_dat, A15.bon_id, A15.kl_art_id, A15.umsatz_brutto
          ORDER BY A15.bon_zeile IS NULL DESC, A15.bon_zeile DESC)) = 17
    UNION DISTINCT
    SELECT A16.mandant_id,
     A16.wup_id,
     A16.bon_dat,
     A16.bon_id,
     A16.kl_art_id,
     A16.umsatz_brutto,
     A16.bon_zeile,
     A16.talon_id
    FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2 AS A16
     INNER JOIN (SELECT mandant_id,
       wup_id,
       bon_dat,
       bon_id,
       kl_art_id,
       ean_kasse,
       umsatz_brutto,
       COUNT(*) AS anzahl
      FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2
      WHERE menge < 0
       AND talon_id <> 0
      GROUP BY mandant_id,
       wup_id,
       bon_dat,
       kl_art_id,
       ean_kasse,
       umsatz_brutto,
       bon_id) AS b ON A16.mandant_id = b.mandant_id AND A16.wup_id = b.wup_id AND A16.bon_dat = b.bon_dat AND A16.bon_id
           = b.bon_id AND A16.kl_art_id = b.kl_art_id AND A16.ean_kasse = b.ean_kasse AND -1 * A16.umsatz_brutto = CASE
        WHEN b.anzahl >= 18
        THEN b.umsatz_brutto
        ELSE NULL
        END
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY A16.mandant_id, A16.wup_id, A16.bon_dat, A16.bon_id, A16.kl_art_id, A16.umsatz_brutto
          ORDER BY A16.bon_zeile IS NULL DESC, A16.bon_zeile DESC)) = 18))
  UNION DISTINCT
  (SELECT A17.mandant_id,
    A17.wup_id,
    A17.bon_dat,
    A17.bon_id,
    A17.kl_art_id,
    A17.umsatz_brutto,
    A17.bon_zeile,
    A17.talon_id
   FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2 AS A17
    INNER JOIN (SELECT mandant_id,
      wup_id,
      bon_dat,
      bon_id,
      kl_art_id,
      ean_kasse,
      umsatz_brutto,
      COUNT(*) AS anzahl
     FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2
     WHERE menge < 0
      AND talon_id <> 0
     GROUP BY mandant_id,
      wup_id,
      bon_dat,
      kl_art_id,
      ean_kasse,
      umsatz_brutto,
      bon_id) AS b ON A17.mandant_id = b.mandant_id AND A17.wup_id = b.wup_id AND A17.bon_dat = b.bon_dat AND A17.bon_id
          = b.bon_id AND A17.kl_art_id = b.kl_art_id AND A17.ean_kasse = b.ean_kasse AND -1 * A17.umsatz_brutto = CASE
       WHEN b.anzahl >= 19
       THEN b.umsatz_brutto
       ELSE NULL
       END
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY A17.mandant_id, A17.wup_id, A17.bon_dat, A17.bon_id, A17.kl_art_id, A17.umsatz_brutto
         ORDER BY A17.bon_zeile IS NULL DESC, A17.bon_zeile DESC)) = 19
   UNION DISTINCT
   (SELECT A18.mandant_id,
     A18.wup_id,
     A18.bon_dat,
     A18.bon_id,
     A18.kl_art_id,
     A18.umsatz_brutto,
     A18.bon_zeile,
     A18.talon_id
    FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2 AS A18
     INNER JOIN (SELECT mandant_id,
       wup_id,
       bon_dat,
       bon_id,
       kl_art_id,
       ean_kasse,
       umsatz_brutto,
       COUNT(*) AS anzahl
      FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2
      WHERE menge < 0
       AND talon_id <> 0
      GROUP BY mandant_id,
       wup_id,
       bon_dat,
       kl_art_id,
       ean_kasse,
       umsatz_brutto,
       bon_id) AS b ON A18.mandant_id = b.mandant_id AND A18.wup_id = b.wup_id AND A18.bon_dat = b.bon_dat AND A18.bon_id
           = b.bon_id AND A18.kl_art_id = b.kl_art_id AND A18.ean_kasse = b.ean_kasse AND -1 * A18.umsatz_brutto = CASE
        WHEN b.anzahl >= 20
        THEN b.umsatz_brutto
        ELSE NULL
        END
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY A18.mandant_id, A18.wup_id, A18.bon_dat, A18.bon_id, A18.kl_art_id, A18.umsatz_brutto
          ORDER BY A18.bon_zeile IS NULL DESC, A18.bon_zeile DESC)) = 20
    UNION DISTINCT
    SELECT mandant_id,
     wup_id,
     bon_dat,
     bon_id,
     kl_art_id,
     umsatz_brutto,
     bon_zeile,
     talon_id
    FROM kfl_production_dbp_etl_process.artbew_zeilen_stornos_2
    WHERE menge < 0
     AND talon_id <> 0))));