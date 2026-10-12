CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_lieferungskuerzung_spr_zu_2 (lieferungskuerzung_fg,
lieferungskuerzung_bez, lieferungskuerzung_bez_de, lieferungskuerzung_bez_cz, lieferungskuerzung_bez_sk,
lieferungskuerzung_bez_hr, lieferungskuerzung_bez_pl, lieferungskuerzung_bez_ro, lieferungskuerzung_bez_bg) AS (((((((((((SELECT
            0 AS lieferungskuerzung_fg,
            'Keine Kürzung' AS lieferungskuerzung_bez,
            MAX(CASE
              WHEN spr_id = 22
              THEN 'Bestellung ohne Kürzung generiert'
              ELSE NULL
              END) AS lieferungskuerzung_bez_de,
            MAX(CASE
              WHEN spr_id = 124
              THEN 'Order generated without shortening'
              ELSE NULL
              END) AS lieferungskuerzung_bez_cz,
            MAX(CASE
              WHEN spr_id = 108
              THEN 'Order generated without shortening'
              ELSE NULL
              END) AS lieferungskuerzung_bez_sk,
            MAX(CASE
              WHEN spr_id = 65
              THEN 'Order generated without shortening'
              ELSE NULL
              END) AS lieferungskuerzung_bez_hr,
            MAX(CASE
              WHEN spr_id = 90
              THEN 'Order generated without shortening'
              ELSE NULL
              END) AS lieferungskuerzung_bez_pl,
            MAX(CASE
              WHEN spr_id = 95
              THEN 'Order generated without shortening'
              ELSE NULL
              END) AS lieferungskuerzung_bez_ro,
            MAX(CASE
              WHEN spr_id = 18
              THEN 'Order generated without shortening'
              ELSE NULL
              END) AS lieferungskuerzung_bez_bg
           FROM kfl_production_dbp_view.v_spr_2 AS V01
           WHERE spr_id IN (22, 124, 108, 65, 90, 95, 18)
           GROUP BY lieferungskuerzung_fg,
            lieferungskuerzung_bez
           UNION DISTINCT
           SELECT 1 AS lieferungskuerzung_fg,
            'ZLDELMON_SHORT (ATP-Check)' AS lieferungskuerzung_bez,
            MAX(CASE
              WHEN spr_id = 22
              THEN 'ZLDELMON_SHORT (ATP-Check)'
              ELSE NULL
              END) AS lieferungskuerzung_bez_de,
            MAX(CASE
              WHEN spr_id = 124
              THEN 'ZLDELMON_SHORT (ATP-Check)'
              ELSE NULL
              END) AS lieferungskuerzung_bez_cz,
            MAX(CASE
              WHEN spr_id = 108
              THEN 'ZLDELMON_SHORT (ATP-Check)'
              ELSE NULL
              END) AS lieferungskuerzung_bez_sk,
            MAX(CASE
              WHEN spr_id = 65
              THEN 'ZLDELMON_SHORT (ATP-Check)'
              ELSE NULL
              END) AS lieferungskuerzung_bez_hr,
            MAX(CASE
              WHEN spr_id = 90
              THEN 'ZLDELMON_SHORT (ATP-Check)'
              ELSE NULL
              END) AS lieferungskuerzung_bez_pl,
            MAX(CASE
              WHEN spr_id = 95
              THEN 'ZLDELMON_SHORT (ATP-Check)'
              ELSE NULL
              END) AS lieferungskuerzung_bez_ro,
            MAX(CASE
              WHEN spr_id = 18
              THEN 'ZLDELMON_SHORT (ATP-Check)'
              ELSE NULL
              END) AS lieferungskuerzung_bez_bg
           FROM kfl_production_dbp_view.v_spr_2 AS V01
           WHERE spr_id IN (22, 124, 108, 65, 90, 95, 18)
           GROUP BY lieferungskuerzung_fg,
            lieferungskuerzung_bez)
          UNION DISTINCT
          SELECT 2 AS lieferungskuerzung_fg,
           'ZBLOCKBEST_SHORT' AS lieferungskuerzung_bez,
           MAX(CASE
             WHEN spr_id = 22
             THEN 'ZBLOCKBEST_SHORT'
             ELSE NULL
             END) AS lieferungskuerzung_bez_de,
           MAX(CASE
             WHEN spr_id = 124
             THEN 'ZBLOCKBEST_SHORT'
             ELSE NULL
             END) AS lieferungskuerzung_bez_cz,
           MAX(CASE
             WHEN spr_id = 108
             THEN 'ZBLOCKBEST_SHORT'
             ELSE NULL
             END) AS lieferungskuerzung_bez_sk,
           MAX(CASE
             WHEN spr_id = 65
             THEN 'ZBLOCKBEST_SHORT'
             ELSE NULL
             END) AS lieferungskuerzung_bez_hr,
           MAX(CASE
             WHEN spr_id = 90
             THEN 'ZBLOCKBEST_SHORT'
             ELSE NULL
             END) AS lieferungskuerzung_bez_pl,
           MAX(CASE
             WHEN spr_id = 95
             THEN 'ZBLOCKBEST_SHORT'
             ELSE NULL
             END) AS lieferungskuerzung_bez_ro,
           MAX(CASE
             WHEN spr_id = 18
             THEN 'ZBLOCKBEST_SHORT'
             ELSE NULL
             END) AS lieferungskuerzung_bez_bg
          FROM kfl_production_dbp_view.v_spr_2 AS V01
          WHERE spr_id IN (22, 124, 108, 65, 90, 95, 18)
          GROUP BY lieferungskuerzung_fg,
           lieferungskuerzung_bez)
         UNION DISTINCT
         SELECT 3 AS lieferungskuerzung_fg,
          'ZLV0BEST_SHORT' AS lieferungskuerzung_bez,
          MAX(CASE
            WHEN spr_id = 22
            THEN 'ZLV0BEST_SHORT'
            ELSE NULL
            END) AS lieferungskuerzung_bez_de,
          MAX(CASE
            WHEN spr_id = 124
            THEN 'ZLV0BEST_SHORT'
            ELSE NULL
            END) AS lieferungskuerzung_bez_cz,
          MAX(CASE
            WHEN spr_id = 108
            THEN 'ZLV0BEST_SHORT'
            ELSE NULL
            END) AS lieferungskuerzung_bez_sk,
          MAX(CASE
            WHEN spr_id = 65
            THEN 'ZLV0BEST_SHORT'
            ELSE NULL
            END) AS lieferungskuerzung_bez_hr,
          MAX(CASE
            WHEN spr_id = 90
            THEN 'ZLV0BEST_SHORT'
            ELSE NULL
            END) AS lieferungskuerzung_bez_pl,
          MAX(CASE
            WHEN spr_id = 95
            THEN 'ZLV0BEST_SHORT'
            ELSE NULL
            END) AS lieferungskuerzung_bez_ro,
          MAX(CASE
            WHEN spr_id = 18
            THEN 'ZLV0BEST_SHORT'
            ELSE NULL
            END) AS lieferungskuerzung_bez_bg
         FROM kfl_production_dbp_view.v_spr_2 AS V01
         WHERE spr_id IN (22, 124, 108, 65, 90, 95, 18)
         GROUP BY lieferungskuerzung_fg,
          lieferungskuerzung_bez)
        UNION DISTINCT
        SELECT 4 AS lieferungskuerzung_fg,
         'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT' AS lieferungskuerzung_bez,
         MAX(CASE
           WHEN spr_id = 22
           THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT'
           ELSE NULL
           END) AS lieferungskuerzung_bez_de,
         MAX(CASE
           WHEN spr_id = 124
           THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT'
           ELSE NULL
           END) AS lieferungskuerzung_bez_cz,
         MAX(CASE
           WHEN spr_id = 108
           THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT'
           ELSE NULL
           END) AS lieferungskuerzung_bez_sk,
         MAX(CASE
           WHEN spr_id = 65
           THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT'
           ELSE NULL
           END) AS lieferungskuerzung_bez_hr,
         MAX(CASE
           WHEN spr_id = 90
           THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT'
           ELSE NULL
           END) AS lieferungskuerzung_bez_pl,
         MAX(CASE
           WHEN spr_id = 95
           THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT'
           ELSE NULL
           END) AS lieferungskuerzung_bez_ro,
         MAX(CASE
           WHEN spr_id = 18
           THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT'
           ELSE NULL
           END) AS lieferungskuerzung_bez_bg
        FROM kfl_production_dbp_view.v_spr_2 AS V01
        WHERE spr_id IN (22, 124, 108, 65, 90, 95, 18)
        GROUP BY lieferungskuerzung_fg,
         lieferungskuerzung_bez)
       UNION DISTINCT
       SELECT 5 AS lieferungskuerzung_fg,
        'EKPO.LOEKZ = X jedoch Lieferposition vorhanden' AS lieferungskuerzung_bez,
        MAX(CASE
          WHEN spr_id = 22
          THEN 'EKPO.LOEKZ = X jedoch Lieferposition vorhanden (alt)'
          ELSE NULL
          END) AS lieferungskuerzung_bez_de,
        MAX(CASE
          WHEN spr_id = 124
          THEN 'EKPO.LOEKZ = X but delivery position exists (old)'
          ELSE NULL
          END) AS lieferungskuerzung_bez_cz,
        MAX(CASE
          WHEN spr_id = 108
          THEN 'EKPO.LOEKZ = X but delivery position exists (old)'
          ELSE NULL
          END) AS lieferungskuerzung_bez_sk,
        MAX(CASE
          WHEN spr_id = 65
          THEN 'EKPO.LOEKZ = X but delivery position exists (old)'
          ELSE NULL
          END) AS lieferungskuerzung_bez_hr,
        MAX(CASE
          WHEN spr_id = 90
          THEN 'EKPO.LOEKZ = X but delivery position exists (old)'
          ELSE NULL
          END) AS lieferungskuerzung_bez_pl,
        MAX(CASE
          WHEN spr_id = 95
          THEN 'EKPO.LOEKZ = X but delivery position exists (old)'
          ELSE NULL
          END) AS lieferungskuerzung_bez_ro,
        MAX(CASE
          WHEN spr_id = 18
          THEN 'EKPO.LOEKZ = X but delivery position exists (old)'
          ELSE NULL
          END) AS lieferungskuerzung_bez_bg
       FROM kfl_production_dbp_view.v_spr_2 AS V01
       WHERE spr_id IN (22, 124, 108, 65, 90, 95, 18)
       GROUP BY lieferungskuerzung_fg,
        lieferungskuerzung_bez)
      UNION DISTINCT
      SELECT - 2 AS lieferungskuerzung_fg,
       'ZBLOCKBEST_SHORT, EKPO.LOEKZ = X' AS lieferungskuerzung_bez,
       MAX(CASE
         WHEN spr_id = 22
         THEN 'ZBLOCKBEST_SHORT, EKPO.LOEKZ = X'
         ELSE NULL
         END) AS lieferungskuerzung_bez_de,
       MAX(CASE
         WHEN spr_id = 124
         THEN 'ZBLOCKBEST_SHORT, EKPO.LOEKZ = X'
         ELSE NULL
         END) AS lieferungskuerzung_bez_cz,
       MAX(CASE
         WHEN spr_id = 108
         THEN 'ZBLOCKBEST_SHORT, EKPO.LOEKZ = X'
         ELSE NULL
         END) AS lieferungskuerzung_bez_sk,
       MAX(CASE
         WHEN spr_id = 65
         THEN 'ZBLOCKBEST_SHORT, EKPO.LOEKZ = X'
         ELSE NULL
         END) AS lieferungskuerzung_bez_hr,
       MAX(CASE
         WHEN spr_id = 90
         THEN 'ZBLOCKBEST_SHORT, EKPO.LOEKZ = X'
         ELSE NULL
         END) AS lieferungskuerzung_bez_pl,
       MAX(CASE
         WHEN spr_id = 95
         THEN 'ZBLOCKBEST_SHORT, EKPO.LOEKZ = X'
         ELSE NULL
         END) AS lieferungskuerzung_bez_ro,
       MAX(CASE
         WHEN spr_id = 18
         THEN 'ZBLOCKBEST_SHORT, EKPO.LOEKZ = X'
         ELSE NULL
         END) AS lieferungskuerzung_bez_bg
      FROM kfl_production_dbp_view.v_spr_2 AS V01
      WHERE spr_id IN (22, 124, 108, 65, 90, 95, 18)
      GROUP BY lieferungskuerzung_fg,
       lieferungskuerzung_bez)
     UNION DISTINCT
     SELECT - 3 AS lieferungskuerzung_fg,
      'ZLV0BEST_SHORT, EKPO.LOEKZ = X' AS lieferungskuerzung_bez,
      MAX(CASE
        WHEN spr_id = 22
        THEN 'ZLV0BEST_SHORT, EKPO.LOEKZ = X'
        ELSE NULL
        END) AS lieferungskuerzung_bez_de,
      MAX(CASE
        WHEN spr_id = 124
        THEN 'ZLV0BEST_SHORT, EKPO.LOEKZ = X'
        ELSE NULL
        END) AS lieferungskuerzung_bez_cz,
      MAX(CASE
        WHEN spr_id = 108
        THEN 'ZLV0BEST_SHORT, EKPO.LOEKZ = X'
        ELSE NULL
        END) AS lieferungskuerzung_bez_sk,
      MAX(CASE
        WHEN spr_id = 65
        THEN 'ZLV0BEST_SHORT, EKPO.LOEKZ = X'
        ELSE NULL
        END) AS lieferungskuerzung_bez_hr,
      MAX(CASE
        WHEN spr_id = 90
        THEN 'ZLV0BEST_SHORT, EKPO.LOEKZ = X'
        ELSE NULL
        END) AS lieferungskuerzung_bez_pl,
      MAX(CASE
        WHEN spr_id = 95
        THEN 'ZLV0BEST_SHORT, EKPO.LOEKZ = X'
        ELSE NULL
        END) AS lieferungskuerzung_bez_ro,
      MAX(CASE
        WHEN spr_id = 18
        THEN 'ZLV0BEST_SHORT, EKPO.LOEKZ = X'
        ELSE NULL
        END) AS lieferungskuerzung_bez_bg
     FROM kfl_production_dbp_view.v_spr_2 AS V01
     WHERE spr_id IN (22, 124, 108, 65, 90, 95, 18)
     GROUP BY lieferungskuerzung_fg,
      lieferungskuerzung_bez)
    UNION DISTINCT
    SELECT - 4 AS lieferungskuerzung_fg,
     'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT, EKPO.LOEKZ = X' AS lieferungskuerzung_bez,
     MAX(CASE
       WHEN spr_id = 22
       THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT, EKPO.LOEKZ = X'
       ELSE NULL
       END) AS lieferungskuerzung_bez_de,
     MAX(CASE
       WHEN spr_id = 124
       THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT, EKPO.LOEKZ = X'
       ELSE NULL
       END) AS lieferungskuerzung_bez_cz,
     MAX(CASE
       WHEN spr_id = 108
       THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT, EKPO.LOEKZ = X'
       ELSE NULL
       END) AS lieferungskuerzung_bez_sk,
     MAX(CASE
       WHEN spr_id = 65
       THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT, EKPO.LOEKZ = X'
       ELSE NULL
       END) AS lieferungskuerzung_bez_hr,
     MAX(CASE
       WHEN spr_id = 90
       THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT, EKPO.LOEKZ = X'
       ELSE NULL
       END) AS lieferungskuerzung_bez_pl,
     MAX(CASE
       WHEN spr_id = 95
       THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT, EKPO.LOEKZ = X'
       ELSE NULL
       END) AS lieferungskuerzung_bez_ro,
     MAX(CASE
       WHEN spr_id = 18
       THEN 'ZBLOCKBEST_SHORT + ZLV0BEST_SHORT, EKPO.LOEKZ = X'
       ELSE NULL
       END) AS lieferungskuerzung_bez_bg
    FROM kfl_production_dbp_view.v_spr_2 AS V01
    WHERE spr_id IN (22, 124, 108, 65, 90, 95, 18)
    GROUP BY lieferungskuerzung_fg,
     lieferungskuerzung_bez)
   UNION DISTINCT
   SELECT - 5 AS lieferungskuerzung_fg,
    'Bestellung nicht generiert' AS lieferungskuerzung_bez,
    MAX(CASE
      WHEN spr_id = 22
      THEN 'Bestellung nicht generiert'
      ELSE NULL
      END) AS lieferungskuerzung_bez_de,
    MAX(CASE
      WHEN spr_id = 124
      THEN 'Order not generated'
      ELSE NULL
      END) AS lieferungskuerzung_bez_cz,
    MAX(CASE
      WHEN spr_id = 108
      THEN 'Order not generated'
      ELSE NULL
      END) AS lieferungskuerzung_bez_sk,
    MAX(CASE
      WHEN spr_id = 65
      THEN 'Order not generated'
      ELSE NULL
      END) AS lieferungskuerzung_bez_hr,
    MAX(CASE
      WHEN spr_id = 90
      THEN 'Order not generated'
      ELSE NULL
      END) AS lieferungskuerzung_bez_pl,
    MAX(CASE
      WHEN spr_id = 95
      THEN 'Order not generated'
      ELSE NULL
      END) AS lieferungskuerzung_bez_ro,
    MAX(CASE
      WHEN spr_id = 18
      THEN 'Order not generated'
      ELSE NULL
      END) AS lieferungskuerzung_bez_bg
   FROM kfl_production_dbp_view.v_spr_2 AS V01
   WHERE spr_id IN (22, 124, 108, 65, 90, 95, 18)
   GROUP BY lieferungskuerzung_fg,
    lieferungskuerzung_bez)
  UNION DISTINCT
  SELECT - 6 AS lieferungskuerzung_fg,
   'Bestellung nicht generiert, EKPO.LOEKZ = X (mit Löschkennzeichen)' AS lieferungskuerzung_bez,
   MAX(CASE
     WHEN spr_id = 22
     THEN 'Bestellung nicht generiert, EKPO.LOEKZ = X (mit Löschkennzeichen)'
     ELSE NULL
     END) AS lieferungskuerzung_bez_de,
   MAX(CASE
     WHEN spr_id = 124
     THEN 'Order not generated, EKPO.LOEKZ = X (deletion mark)'
     ELSE NULL
     END) AS lieferungskuerzung_bez_cz,
   MAX(CASE
     WHEN spr_id = 108
     THEN 'Order not generated, EKPO.LOEKZ = X (deletion mark)'
     ELSE NULL
     END) AS lieferungskuerzung_bez_sk,
   MAX(CASE
     WHEN spr_id = 65
     THEN 'Order not generated, EKPO.LOEKZ = X (deletion mark)'
     ELSE NULL
     END) AS lieferungskuerzung_bez_hr,
   MAX(CASE
     WHEN spr_id = 90
     THEN 'Order not generated, EKPO.LOEKZ = X (deletion mark)'
     ELSE NULL
     END) AS lieferungskuerzung_bez_pl,
   MAX(CASE
     WHEN spr_id = 95
     THEN 'Order not generated, EKPO.LOEKZ = X (deletion mark)'
     ELSE NULL
     END) AS lieferungskuerzung_bez_ro,
   MAX(CASE
     WHEN spr_id = 18
     THEN 'Order not generated, EKPO.LOEKZ = X (deletion mark)'
     ELSE NULL
     END) AS lieferungskuerzung_bez_bg
  FROM kfl_production_dbp_view.v_spr_2 AS V01
  WHERE spr_id IN (22, 124, 108, 65, 90, 95, 18)
  GROUP BY lieferungskuerzung_fg,
   lieferungskuerzung_bez)
 UNION DISTINCT
 SELECT - 8 AS lieferungskuerzung_fg,
  'Bestellung generiert, EKPO.LOEKZ = X (mit Löschkennzeichen), Ist-Menge = 0' AS lieferungskuerzung_bez,
  MAX(CASE
    WHEN spr_id = 22
    THEN 'Bestellung generiert, EKPO.LOEKZ = X (mit Löschkennzeichen), Ist-Menge = 0'
    ELSE NULL
    END) AS lieferungskuerzung_bez_de,
  MAX(CASE
    WHEN spr_id = 124
    THEN 'Order generated, EKPO.LOEKZ = X (deletion mark), delivered amount = 0'
    ELSE NULL
    END) AS lieferungskuerzung_bez_cz,
  MAX(CASE
    WHEN spr_id = 108
    THEN 'Order generated, EKPO.LOEKZ = X (deletion mark), delivered amount = 0'
    ELSE NULL
    END) AS lieferungskuerzung_bez_sk,
  MAX(CASE
    WHEN spr_id = 65
    THEN 'Order generated, EKPO.LOEKZ = X (deletion mark), delivered amount = 0'
    ELSE NULL
    END) AS lieferungskuerzung_bez_hr,
  MAX(CASE
    WHEN spr_id = 90
    THEN 'Order generated, EKPO.LOEKZ = X (deletion mark), delivered amount = 0'
    ELSE NULL
    END) AS lieferungskuerzung_bez_pl,
  MAX(CASE
    WHEN spr_id = 95
    THEN 'Order generated, EKPO.LOEKZ = X (deletion mark), delivered amount = 0'
    ELSE NULL
    END) AS lieferungskuerzung_bez_ro,
  MAX(CASE
    WHEN spr_id = 18
    THEN 'Order generated, EKPO.LOEKZ = X (deletion mark), delivered amount = 0'
    ELSE NULL
    END) AS lieferungskuerzung_bez_bg
 FROM kfl_production_dbp_view.v_spr_2 AS V01
 WHERE spr_id IN (22, 124, 108, 65, 90, 95, 18)
 GROUP BY lieferungskuerzung_fg,
  lieferungskuerzung_bez)
UNION DISTINCT
SELECT 8 AS lieferungskuerzung_fg,
 'Bestellung generiert, EKPO.LOEKZ = X (mit Löschkennzeichen), Ist-Menge > 0' AS lieferungskuerzung_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN 'Bestellung generiert, EKPO.LOEKZ = X (mit Löschkennzeichen), Ist-Menge > 0'
   ELSE NULL
   END) AS lieferungskuerzung_bez_de,
 MAX(CASE
   WHEN spr_id = 124
   THEN 'Order generated, EKPO.LOEKZ = X (deletion mark), delivered amount > 0'
   ELSE NULL
   END) AS lieferungskuerzung_bez_cz,
 MAX(CASE
   WHEN spr_id = 108
   THEN 'Order generated, EKPO.LOEKZ = X (deletion mark), delivered amount > 0'
   ELSE NULL
   END) AS lieferungskuerzung_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN 'Order generated, EKPO.LOEKZ = X (deletion mark), delivered amount > 0'
   ELSE NULL
   END) AS lieferungskuerzung_bez_hr,
 MAX(CASE
   WHEN spr_id = 90
   THEN 'Order generated, EKPO.LOEKZ = X (deletion mark), delivered amount > 0'
   ELSE NULL
   END) AS lieferungskuerzung_bez_pl,
 MAX(CASE
   WHEN spr_id = 95
   THEN 'Order generated, EKPO.LOEKZ = X (deletion mark), delivered amount > 0'
   ELSE NULL
   END) AS lieferungskuerzung_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN 'Order generated, EKPO.LOEKZ = X (deletion mark), delivered amount > 0'
   ELSE NULL
   END) AS lieferungskuerzung_bez_bg
FROM kfl_production_dbp_view.v_spr_2 AS V01
WHERE spr_id IN (22, 124, 108, 65, 90, 95, 18)
GROUP BY lieferungskuerzung_fg,
 lieferungskuerzung_bez;