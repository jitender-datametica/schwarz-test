CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_cpr_cl_punkt_1 (checkliste_punkt_id, cpr_checkliste_id,
projekt_phase_id, dat_ist_termin, dat_start_soll, dat_soll_termin, dat_soll_termin_text, dat_start_termin,
dat_start_vorhersage, dat_ende_vorhersage, dat_termin, dat_termin_gj, termin_fg, text_termin, text2_termin, dauer_termin
, sortier_nummer, ok_fg, nicht_ok_fg, nicht_relevant_fg, obligatorisch_fg, cpr_suchfeld_id, cpr_prozess, terminart,
dat_start_ist, dat_ende_ist, dat_start_max, dat_ende_max, dat_start_plan, dat_ende_plan, dat_start_einschraenkung,
dat_ende_einschraenkung, gesamt_puffer, dauer, cpr_prio, dat_erstellung, cpr_systemstatus1_id, cpr_systemstatus3_id,
cpr_systemstatus2_id, mandant_id, sortier_nr_mhrwrtgkt, dat_realisierung, dat_start_realisierung, dat_soll_monat, akt_gj
) AS SELECT cl_au.checkliste_punkt_id,
 cl_au.cpr_checkliste_id,
 cl_au.projekt_phase_id,
  CASE
  WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
  THEN cl_au.dat_ende_ist
  ELSE DATE(NULL)
  END AS dat_ist_termin,
  CASE
  WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
  THEN cl_au.dat_start_einschraenkung
  ELSE DATE(NULL)
  END AS dat_start_soll,
  CASE
  WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
  THEN cl_au.dat_ende_einschraenkung
  ELSE DATE(NULL)
  END AS dat_soll_termin,
  CASE
  WHEN CASE
    WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END <= DATE_ADD(CURRENT_DATE, INTERVAL 98 DAY)
  THEN FORMAT_DATE('%d.%m.%Y', CASE
    WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END)
  WHEN CASE
    WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END <= IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 6 MONTH)), DATE_ADD(CURRENT_DATE
     ,INTERVAL 6 MONTH))
  THEN FORMAT_DATE('%Y%m%d', CASE
    WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END)
  WHEN CASE
    WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END <= IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 18 MONTH)), DATE_ADD(CURRENT_DATE
     ,INTERVAL 18 MONTH))
  THEN CASE
     WHEN EXTRACT(MONTH FROM CASE
        WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END) BETWEEN 1 AND 3
     THEN 'I'
     WHEN EXTRACT(MONTH FROM CASE
        WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END) BETWEEN 4 AND 6
     THEN 'II'
     WHEN EXTRACT(MONTH FROM CASE
        WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END) BETWEEN 7 AND 9
     THEN 'III'
     WHEN EXTRACT(MONTH FROM CASE
        WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END) BETWEEN 10 AND 12
     THEN 'IV'
     ELSE ''
     END || '/' || CAST(EXTRACT(YEAR FROM CASE
      WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END) AS STRING)
  WHEN CASE
    WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END > IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 18 MONTH)), DATE_ADD(CURRENT_DATE
     ,INTERVAL 18 MONTH))
  THEN FORMAT_DATE('%Y', CASE
    WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END)
  ELSE NULL
  END AS dat_soll_termin_text,
 DATE(COALESCE(CASE
    WHEN cl_au.dat_start_ist = DATE('1900-01-01')
    THEN NULL
    ELSE cl_au.dat_start_ist
    END, CASE
    WHEN CASE
      WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_start_einschraenkung
      ELSE DATE(NULL)
      END >= CURRENT_DATE
    THEN CASE
     WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
     THEN cl_au.dat_start_einschraenkung
     ELSE DATE(NULL)
     END
    ELSE NULL
    END)) AS dat_start_termin,
  CASE
  WHEN cl_au.dat_start_vorhersage IS NOT NULL AND cl_au.dat_start_vorhersage <> DATE('1900-01-01')
  THEN cl_au.dat_start_vorhersage
  ELSE DATE(NULL)
  END AS dat_start_vorhersage,
  CASE
  WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01')
  THEN cl_au.dat_ende_vorhersage
  ELSE DATE(NULL)
  END AS dat_ende_vorhersage,
 DATE(CASE
   WHEN CASE
      WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END <> DATE('1900-01-01') AND CASE
     WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
     THEN cl_au.dat_ende_ist
     ELSE DATE(NULL)
     END IS NOT NULL
   THEN CASE
    WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
    THEN cl_au.dat_ende_ist
    ELSE DATE(NULL)
    END
   WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage
      >= CURRENT_DATE
   THEN cl_au.dat_ende_vorhersage
   WHEN CASE
     WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
     THEN cl_au.dat_ende_einschraenkung
     ELSE DATE(NULL)
     END >= CURRENT_DATE
   THEN CASE
    WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END
   ELSE NULL
   END) AS dat_termin,
 tg.dat_termin_gj,
 CAST(CASE
   WHEN DATE(CASE
      WHEN CASE
         WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
         THEN cl_au.dat_ende_ist
         ELSE DATE(NULL)
         END <> DATE('1900-01-01') AND CASE
        WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END IS NOT NULL
      THEN CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END
      WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
      THEN cl_au.dat_ende_vorhersage
      WHEN CASE
        WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END) <= CURRENT_DATE
   THEN 1
   WHEN DATE(CASE
      WHEN CASE
         WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
         THEN cl_au.dat_ende_ist
         ELSE DATE(NULL)
         END <> DATE('1900-01-01') AND CASE
        WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END IS NOT NULL
      THEN CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END
      WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
      THEN cl_au.dat_ende_vorhersage
      WHEN CASE
        WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END) > CURRENT_DATE
   THEN 0
   ELSE - 1
   END AS BIGNUMERIC) AS termin_fg,
  CASE
  WHEN DATE(CASE
     WHEN CASE
        WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END <> DATE('1900-01-01') AND CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END IS NOT NULL
     THEN CASE
      WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END
     WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage
        >= CURRENT_DATE
     THEN cl_au.dat_ende_vorhersage
     WHEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END >= CURRENT_DATE
     THEN CASE
      WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END
     ELSE NULL
     END) <= DATE_ADD(CURRENT_DATE, INTERVAL 98 DAY)
  THEN FORMAT_DATE('%d.%m.%Y', DATE(CASE
     WHEN CASE
        WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END <> DATE('1900-01-01') AND CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END IS NOT NULL
     THEN CASE
      WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END
     WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage
        >= CURRENT_DATE
     THEN cl_au.dat_ende_vorhersage
     WHEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END >= CURRENT_DATE
     THEN CASE
      WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END
     ELSE NULL
     END))
  WHEN DATE(CASE
     WHEN CASE
        WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END <> DATE('1900-01-01') AND CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END IS NOT NULL
     THEN CASE
      WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END
     WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage
        >= CURRENT_DATE
     THEN cl_au.dat_ende_vorhersage
     WHEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END >= CURRENT_DATE
     THEN CASE
      WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END
     ELSE NULL
     END) <= IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 6 MONTH)), DATE_ADD(CURRENT_DATE
     ,INTERVAL 6 MONTH))
  THEN FORMAT_DATE('%Y%m%d', DATE(CASE
     WHEN CASE
        WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END <> DATE('1900-01-01') AND CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END IS NOT NULL
     THEN CASE
      WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END
     WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage
        >= CURRENT_DATE
     THEN cl_au.dat_ende_vorhersage
     WHEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END >= CURRENT_DATE
     THEN CASE
      WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END
     ELSE NULL
     END))
  WHEN DATE(CASE
     WHEN CASE
        WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END <> DATE('1900-01-01') AND CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END IS NOT NULL
     THEN CASE
      WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END
     WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage
        >= CURRENT_DATE
     THEN cl_au.dat_ende_vorhersage
     WHEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END >= CURRENT_DATE
     THEN CASE
      WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END
     ELSE NULL
     END) <= IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 18 MONTH)), DATE_ADD(CURRENT_DATE
     ,INTERVAL 18 MONTH))
  THEN CASE
     WHEN EXTRACT(MONTH FROM DATE(CASE
         WHEN CASE
            WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
            THEN cl_au.dat_ende_ist
            ELSE DATE(NULL)
            END <> DATE('1900-01-01') AND CASE
           WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END IS NOT NULL
         THEN CASE
          WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END
         WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage
            >= CURRENT_DATE
         THEN cl_au.dat_ende_vorhersage
         WHEN CASE
           WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
           THEN cl_au.dat_ende_einschraenkung
           ELSE DATE(NULL)
           END >= CURRENT_DATE
         THEN CASE
          WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
          THEN cl_au.dat_ende_einschraenkung
          ELSE DATE(NULL)
          END
         ELSE NULL
         END)) BETWEEN 1 AND 3
     THEN 'I'
     WHEN EXTRACT(MONTH FROM DATE(CASE
         WHEN CASE
            WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
            THEN cl_au.dat_ende_ist
            ELSE DATE(NULL)
            END <> DATE('1900-01-01') AND CASE
           WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END IS NOT NULL
         THEN CASE
          WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END
         WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage
            >= CURRENT_DATE
         THEN cl_au.dat_ende_vorhersage
         WHEN CASE
           WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
           THEN cl_au.dat_ende_einschraenkung
           ELSE DATE(NULL)
           END >= CURRENT_DATE
         THEN CASE
          WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
          THEN cl_au.dat_ende_einschraenkung
          ELSE DATE(NULL)
          END
         ELSE NULL
         END)) BETWEEN 4 AND 6
     THEN 'II'
     WHEN EXTRACT(MONTH FROM DATE(CASE
         WHEN CASE
            WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
            THEN cl_au.dat_ende_ist
            ELSE DATE(NULL)
            END <> DATE('1900-01-01') AND CASE
           WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END IS NOT NULL
         THEN CASE
          WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END
         WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage
            >= CURRENT_DATE
         THEN cl_au.dat_ende_vorhersage
         WHEN CASE
           WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
           THEN cl_au.dat_ende_einschraenkung
           ELSE DATE(NULL)
           END >= CURRENT_DATE
         THEN CASE
          WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
          THEN cl_au.dat_ende_einschraenkung
          ELSE DATE(NULL)
          END
         ELSE NULL
         END)) BETWEEN 7 AND 9
     THEN 'III'
     WHEN EXTRACT(MONTH FROM DATE(CASE
         WHEN CASE
            WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
            THEN cl_au.dat_ende_ist
            ELSE DATE(NULL)
            END <> DATE('1900-01-01') AND CASE
           WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END IS NOT NULL
         THEN CASE
          WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END
         WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage
            >= CURRENT_DATE
         THEN cl_au.dat_ende_vorhersage
         WHEN CASE
           WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
           THEN cl_au.dat_ende_einschraenkung
           ELSE DATE(NULL)
           END >= CURRENT_DATE
         THEN CASE
          WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
          THEN cl_au.dat_ende_einschraenkung
          ELSE DATE(NULL)
          END
         ELSE NULL
         END)) BETWEEN 10 AND 12
     THEN 'IV'
     ELSE ''
     END || '/' || CAST(EXTRACT(YEAR FROM DATE(CASE
       WHEN CASE
          WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END <> DATE('1900-01-01') AND CASE
         WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
         THEN cl_au.dat_ende_ist
         ELSE DATE(NULL)
         END IS NOT NULL
       THEN CASE
        WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END
       WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
       THEN cl_au.dat_ende_vorhersage
       WHEN CASE
         WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
         THEN cl_au.dat_ende_einschraenkung
         ELSE DATE(NULL)
         END >= CURRENT_DATE
       THEN CASE
        WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END
       ELSE NULL
       END)) AS STRING)
  WHEN DATE(CASE
     WHEN CASE
        WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END <> DATE('1900-01-01') AND CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END IS NOT NULL
     THEN CASE
      WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END
     WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage
        >= CURRENT_DATE
     THEN cl_au.dat_ende_vorhersage
     WHEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END >= CURRENT_DATE
     THEN CASE
      WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END
     ELSE NULL
     END) > IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 18 MONTH)), DATE_ADD(CURRENT_DATE
     ,INTERVAL 18 MONTH))
  THEN FORMAT_DATE('%Y', DATE(CASE
     WHEN CASE
        WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END <> DATE('1900-01-01') AND CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END IS NOT NULL
     THEN CASE
      WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END
     WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage
        >= CURRENT_DATE
     THEN cl_au.dat_ende_vorhersage
     WHEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END >= CURRENT_DATE
     THEN CASE
      WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END
     ELSE NULL
     END))
  ELSE NULL
  END AS text_termin,
  CASE
  WHEN CASE
    WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
    THEN cl_au.dat_ende_ist
    ELSE DATE(NULL)
    END IS NOT NULL AND CASE
     WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
     THEN cl_au.dat_ende_ist
     ELSE DATE(NULL)
     END <> DATE('1900-01-01')
  THEN FORMAT_DATE('%d.%m.%Y', CASE
    WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
    THEN cl_au.dat_ende_ist
    ELSE DATE(NULL)
    END)
  WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage > CURRENT_DATE
  THEN FORMAT_DATE('%Y%m%d', CURRENT_DATE)
  WHEN CASE
    WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END IS NOT NULL AND CASE
     WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
     THEN cl_au.dat_ende_einschraenkung
     ELSE DATE(NULL)
     END > CURRENT_DATE
  THEN FORMAT_DATE('%Y%m%d', CASE
    WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END)
  ELSE NULL
  END AS text2_termin,
  CASE
  WHEN cl_au.dat_ende_ist <> DATE('1900-01-01') AND cl_au.dat_start_ist <> DATE('1900-01-01') AND cl_au.dat_ende_ist >=
    cl_au.dat_start_ist
  THEN DATE_DIFF(cl_au.dat_ende_ist, cl_au.dat_start_ist, DAY)
  WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01') AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01') AND
    cl_au.dat_ende_einschraenkung >= cl_au.dat_start_einschraenkung
  THEN DATE_DIFF(cl_au.dat_ende_einschraenkung, cl_au.dat_start_einschraenkung, DAY)
  ELSE 0
  END AS dauer_termin,
 cl_au.sortier_nummer,
 cl_au.ok_fg,
 cl_au.nicht_ok_fg,
 cl_au.nicht_relevant_fg,
 cl_au.obligatorisch_fg,
 cl_au.cpr_suchfeld AS cpr_suchfeld_id,
 cl_au.cpr_prozess,
 cl_au.terminart,
  CASE
  WHEN cl_au.dat_start_ist <> DATE('1900-01-01')
  THEN cl_au.dat_start_ist
  ELSE DATE(NULL)
  END AS dat_start_ist,
 cl_au.dat_ende_ist,
 cl_au.dat_start_max,
 cl_au.dat_ende_max,
 cl_au.dat_start_plan,
 cl_au.dat_ende_plan,
 cl_au.dat_start_einschraenkung,
 cl_au.dat_ende_einschraenkung,
 cl_au.gesamt_puffer,
 cl_au.dauer,
 cl_au.cpr_prio,
 cl_au.dat_erstellung,
 cl_au.cpr_systemstatus1_id,
 cl_au.cpr_systemstatus3_id,
 cl_au.cpr_systemstatus2_id,
 PR.mandant_id,
 cl_au.sortier_nr_mhrwrtgkt,
  CASE
  WHEN DATE(CASE
     WHEN CASE
        WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END <> DATE('1900-01-01') AND CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END IS NOT NULL
     THEN CASE
      WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END
     WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage
        >= CURRENT_DATE
     THEN cl_au.dat_ende_vorhersage
     WHEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END >= CURRENT_DATE
     THEN CASE
      WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END
     ELSE NULL
     END) <= DATE_ADD(CURRENT_DATE, INTERVAL 84 DAY)
  THEN FORMAT_DATE('%d.%m.%y', DATE(CASE
     WHEN CASE
        WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END <> DATE('1900-01-01') AND CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END IS NOT NULL
     THEN CASE
      WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END
     WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage
        >= CURRENT_DATE
     THEN cl_au.dat_ende_vorhersage
     WHEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END >= CURRENT_DATE
     THEN CASE
      WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END
     ELSE NULL
     END))
  WHEN DATE(CASE
     WHEN CASE
        WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END <> DATE('1900-01-01') AND CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END IS NOT NULL
     THEN CASE
      WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END
     WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage
        >= CURRENT_DATE
     THEN cl_au.dat_ende_vorhersage
     WHEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END >= CURRENT_DATE
     THEN CASE
      WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END
     ELSE NULL
     END) <= DATE_ADD(CURRENT_DATE, INTERVAL 168 DAY)
  THEN FORMAT_DATE('%Y%m%d', DATE(CASE
     WHEN CASE
        WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END <> DATE('1900-01-01') AND CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END IS NOT NULL
     THEN CASE
      WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END
     WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage
        >= CURRENT_DATE
     THEN cl_au.dat_ende_vorhersage
     WHEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END >= CURRENT_DATE
     THEN CASE
      WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END
     ELSE NULL
     END))
  WHEN DATE(CASE
     WHEN CASE
        WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END <> DATE('1900-01-01') AND CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END IS NOT NULL
     THEN CASE
      WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END
     WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage
        >= CURRENT_DATE
     THEN cl_au.dat_ende_vorhersage
     WHEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END >= CURRENT_DATE
     THEN CASE
      WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END
     ELSE NULL
     END) <= IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 18 MONTH)), DATE_ADD(CURRENT_DATE
     ,INTERVAL 18 MONTH))
  THEN CASE
     WHEN EXTRACT(MONTH FROM DATE(CASE
         WHEN CASE
            WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
            THEN cl_au.dat_ende_ist
            ELSE DATE(NULL)
            END <> DATE('1900-01-01') AND CASE
           WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END IS NOT NULL
         THEN CASE
          WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END
         WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage
            >= CURRENT_DATE
         THEN cl_au.dat_ende_vorhersage
         WHEN CASE
           WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
           THEN cl_au.dat_ende_einschraenkung
           ELSE DATE(NULL)
           END >= CURRENT_DATE
         THEN CASE
          WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
          THEN cl_au.dat_ende_einschraenkung
          ELSE DATE(NULL)
          END
         ELSE NULL
         END)) BETWEEN 1 AND 3
     THEN 'I'
     WHEN EXTRACT(MONTH FROM DATE(CASE
         WHEN CASE
            WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
            THEN cl_au.dat_ende_ist
            ELSE DATE(NULL)
            END <> DATE('1900-01-01') AND CASE
           WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END IS NOT NULL
         THEN CASE
          WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END
         WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage
            >= CURRENT_DATE
         THEN cl_au.dat_ende_vorhersage
         WHEN CASE
           WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
           THEN cl_au.dat_ende_einschraenkung
           ELSE DATE(NULL)
           END >= CURRENT_DATE
         THEN CASE
          WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
          THEN cl_au.dat_ende_einschraenkung
          ELSE DATE(NULL)
          END
         ELSE NULL
         END)) BETWEEN 4 AND 6
     THEN 'II'
     WHEN EXTRACT(MONTH FROM DATE(CASE
         WHEN CASE
            WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
            THEN cl_au.dat_ende_ist
            ELSE DATE(NULL)
            END <> DATE('1900-01-01') AND CASE
           WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END IS NOT NULL
         THEN CASE
          WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END
         WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage
            >= CURRENT_DATE
         THEN cl_au.dat_ende_vorhersage
         WHEN CASE
           WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
           THEN cl_au.dat_ende_einschraenkung
           ELSE DATE(NULL)
           END >= CURRENT_DATE
         THEN CASE
          WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
          THEN cl_au.dat_ende_einschraenkung
          ELSE DATE(NULL)
          END
         ELSE NULL
         END)) BETWEEN 7 AND 9
     THEN 'III'
     WHEN EXTRACT(MONTH FROM DATE(CASE
         WHEN CASE
            WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
            THEN cl_au.dat_ende_ist
            ELSE DATE(NULL)
            END <> DATE('1900-01-01') AND CASE
           WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END IS NOT NULL
         THEN CASE
          WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END
         WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage
            >= CURRENT_DATE
         THEN cl_au.dat_ende_vorhersage
         WHEN CASE
           WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
           THEN cl_au.dat_ende_einschraenkung
           ELSE DATE(NULL)
           END >= CURRENT_DATE
         THEN CASE
          WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
          THEN cl_au.dat_ende_einschraenkung
          ELSE DATE(NULL)
          END
         ELSE NULL
         END)) BETWEEN 10 AND 12
     THEN 'IV'
     ELSE ''
     END || '/' || CAST(EXTRACT(YEAR FROM DATE(CASE
       WHEN CASE
          WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END <> DATE('1900-01-01') AND CASE
         WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
         THEN cl_au.dat_ende_ist
         ELSE DATE(NULL)
         END IS NOT NULL
       THEN CASE
        WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END
       WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
       THEN cl_au.dat_ende_vorhersage
       WHEN CASE
         WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
         THEN cl_au.dat_ende_einschraenkung
         ELSE DATE(NULL)
         END >= CURRENT_DATE
       THEN CASE
        WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END
       ELSE NULL
       END)) AS STRING)
  ELSE NULL
  END AS dat_realisierung,
  CASE
  WHEN DATE(COALESCE(CASE
      WHEN cl_au.dat_start_ist = DATE('1900-01-01')
      THEN NULL
      ELSE cl_au.dat_start_ist
      END, CASE
      WHEN CASE
        WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_start_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_start_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END)) <= DATE_ADD(CURRENT_DATE, INTERVAL 84 DAY)
  THEN FORMAT_DATE('%d.%m.%y', DATE(COALESCE(CASE
      WHEN cl_au.dat_start_ist = DATE('1900-01-01')
      THEN NULL
      ELSE cl_au.dat_start_ist
      END, CASE
      WHEN CASE
        WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_start_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_start_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END)))
  WHEN DATE(COALESCE(CASE
      WHEN cl_au.dat_start_ist = DATE('1900-01-01')
      THEN NULL
      ELSE cl_au.dat_start_ist
      END, CASE
      WHEN CASE
        WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_start_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_start_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END)) <= DATE_ADD(CURRENT_DATE, INTERVAL 168 DAY)
  THEN FORMAT_DATE('%Y%m%d', DATE(COALESCE(CASE
      WHEN cl_au.dat_start_ist = DATE('1900-01-01')
      THEN NULL
      ELSE cl_au.dat_start_ist
      END, CASE
      WHEN CASE
        WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_start_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_start_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END)))
  WHEN DATE(COALESCE(CASE
      WHEN cl_au.dat_start_ist = DATE('1900-01-01')
      THEN NULL
      ELSE cl_au.dat_start_ist
      END, CASE
      WHEN CASE
        WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_start_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_start_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END)) <= IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 18 MONTH)), DATE_ADD(CURRENT_DATE
     ,INTERVAL 18 MONTH))
  THEN CASE
     WHEN EXTRACT(MONTH FROM DATE(COALESCE(CASE
          WHEN cl_au.dat_start_ist = DATE('1900-01-01')
          THEN NULL
          ELSE cl_au.dat_start_ist
          END, CASE
          WHEN CASE
            WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
            THEN cl_au.dat_start_einschraenkung
            ELSE DATE(NULL)
            END >= CURRENT_DATE
          THEN CASE
           WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
           THEN cl_au.dat_start_einschraenkung
           ELSE DATE(NULL)
           END
          ELSE NULL
          END))) BETWEEN 1 AND 3
     THEN 'I'
     WHEN EXTRACT(MONTH FROM DATE(COALESCE(CASE
          WHEN cl_au.dat_start_ist = DATE('1900-01-01')
          THEN NULL
          ELSE cl_au.dat_start_ist
          END, CASE
          WHEN CASE
            WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
            THEN cl_au.dat_start_einschraenkung
            ELSE DATE(NULL)
            END >= CURRENT_DATE
          THEN CASE
           WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
           THEN cl_au.dat_start_einschraenkung
           ELSE DATE(NULL)
           END
          ELSE NULL
          END))) BETWEEN 4 AND 6
     THEN 'II'
     WHEN EXTRACT(MONTH FROM DATE(COALESCE(CASE
          WHEN cl_au.dat_start_ist = DATE('1900-01-01')
          THEN NULL
          ELSE cl_au.dat_start_ist
          END, CASE
          WHEN CASE
            WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
            THEN cl_au.dat_start_einschraenkung
            ELSE DATE(NULL)
            END >= CURRENT_DATE
          THEN CASE
           WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
           THEN cl_au.dat_start_einschraenkung
           ELSE DATE(NULL)
           END
          ELSE NULL
          END))) BETWEEN 7 AND 9
     THEN 'III'
     WHEN EXTRACT(MONTH FROM DATE(COALESCE(CASE
          WHEN cl_au.dat_start_ist = DATE('1900-01-01')
          THEN NULL
          ELSE cl_au.dat_start_ist
          END, CASE
          WHEN CASE
            WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
            THEN cl_au.dat_start_einschraenkung
            ELSE DATE(NULL)
            END >= CURRENT_DATE
          THEN CASE
           WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
           THEN cl_au.dat_start_einschraenkung
           ELSE DATE(NULL)
           END
          ELSE NULL
          END))) BETWEEN 10 AND 12
     THEN 'IV'
     ELSE ''
     END || '/' || CAST(EXTRACT(YEAR FROM DATE(COALESCE(CASE
        WHEN cl_au.dat_start_ist = DATE('1900-01-01')
        THEN NULL
        ELSE cl_au.dat_start_ist
        END, CASE
        WHEN CASE
          WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
          THEN cl_au.dat_start_einschraenkung
          ELSE DATE(NULL)
          END >= CURRENT_DATE
        THEN CASE
         WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
         THEN cl_au.dat_start_einschraenkung
         ELSE DATE(NULL)
         END
        ELSE NULL
        END))) AS STRING)
  ELSE NULL
  END AS dat_start_realisierung,
  CASE
  WHEN CASE
    WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
    THEN cl_au.dat_ende_ist
    ELSE DATE(NULL)
    END IS NULL AND CASE
    WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END IS NOT NULL
  THEN FORMAT_DATE('%Y%m%d', CASE
    WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END)
  WHEN CASE
   WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
   THEN cl_au.dat_ende_ist
   ELSE DATE(NULL)
   END IS NOT NULL
  THEN FORMAT_DATE('%d.%m.%y', CASE
    WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
    THEN cl_au.dat_ende_ist
    ELSE DATE(NULL)
    END)
  ELSE NULL
  END AS dat_soll_monat,
 tg.akt_gj
FROM ((SELECT CP.checkliste_punkt_id,
     CP.cpr_checkliste_id,
     CL.projekt_phase_id,
     MOD(CAST(CP.sortier_nummer AS BIGNUMERIC), 100) AS sortier_nummer,
     CP.ok_fg,
     CP.nicht_ok_fg,
     CP.nicht_relevant_fg,
     CP.obligatorisch_fg,
     SU.cpr_suchfeld,
     SUBSTR(NULL, 1, 40) AS cpr_prozess,
     SUBSTR(NULL, 1, 20) AS terminart,
     CP.dat_start_ist,
     CP.dat_ende_ist,
     CP.dat_start_max,
     CP.dat_ende_max,
     CP.dat_start_plan,
     CP.dat_ende_plan,
     CP.dat_start_einschraenkung,
     CP.dat_ende_einschraenkung,
     CP.gesamt_puffer,
     CAST(NULL AS NUMERIC) AS dauer,
     CP.cpr_prio,
     CP.dat_erstellung,
     CP.cpr_systemstatus1_id,
     CP.cpr_systemstatus3_id,
     CP.cpr_systemstatus2_id,
     CP.cpr_suchfeld_id,
     CP.sortier_nr_mhrwrtgkt,
      CASE
      WHEN CP.dat_start_vorhersage IS NOT NULL AND CP.dat_start_vorhersage <> DATE('1900-01-01')
      THEN CP.dat_start_vorhersage
      ELSE DATE(NULL)
      END AS dat_start_vorhersage,
      CASE
      WHEN CP.dat_ende_vorhersage IS NOT NULL AND CP.dat_ende_vorhersage <> DATE('1900-01-01')
      THEN CP.dat_ende_vorhersage
      ELSE DATE(NULL)
      END AS dat_ende_vorhersage,
     '' AS dat_realisierung,
     '' AS dat_start_realisierung,
     '' AS dat_soll_monat,
     tg.akt_gj
    FROM kfl_production_dbp_view.v_cpr_cl_punkt_per_1 AS CP
     INNER JOIN kfl_production_dbp_view.v_cpr_checkliste_per_1 AS CL ON CP.cpr_checkliste_id = CL.cpr_checkliste_id
     INNER JOIN kfl_production_dbp_view.v_l_cpr_suchfeld_1 AS SU ON CP.cpr_suchfeld_id = SU.cpr_suchfeld_id
     INNER JOIN (SELECT gj,
       akt_gj,
       MAX(max_dat) AS dat_termin_gj
      FROM kfl_production_dbp_view.v_monat_1 AS TG
      WHERE akt_gj = 0
      GROUP BY gj,
       akt_gj) AS tg ON TRUE
    WHERE CL.dat_bis = DATE '9999-12-31'
     AND CP.dat_bis = DATE '9999-12-31'
    UNION DISTINCT
    SELECT SUBSTR(CAST(AU.cpr_aufgabe_id AS STRING), 1, 32) AS checkliste_punkt_id,
     SUBSTR(NULL, 1, 32) AS cpr_checkliste_id,
     AU.projekt_phase_id,
     AU.sortier_nummer,
      CASE
      WHEN AU.cpr_systemstatus1_id IN (2, 3, 6)
      THEN 1
      ELSE 0
      END AS ok_fg,
      CASE
      WHEN AU.cpr_systemstatus1_id IN (2, 3, 6)
      THEN 0
      ELSE 1
      END AS nicht_ok_fg,
      CASE
      WHEN AU.cpr_systemstatus1_id = 4
      THEN 1
      ELSE 0
      END AS nicht_relevant_fg,
     0 AS obligatorisch_fg,
      CASE
      WHEN SU.cpr_suchfeld = 'CPR_BAURECHTSVERFAHREN'
      THEN 'KBE_BAUANTRAG'
      ELSE SU.cpr_suchfeld
      END AS cpr_suchfeld,
     SUBSTR(NULL, 1, 40) AS cpr_prozess,
     SUBSTR(NULL, 1, 20) AS terminart,
     AU.dat_start_ist,
      CASE
      WHEN SU.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN')
      THEN AU.dat_start_ist
      ELSE AU.dat_ende_ist
      END AS dat_ende_ist,
     AU.dat_start_max,
      CASE
      WHEN SU.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN', 'CPR_REALISIERUNG')
      THEN AU.dat_start_max
      ELSE AU.dat_ende_max
      END AS dat_ende_max,
     AU.dat_start_plan,
      CASE
      WHEN SU.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN', 'CPR_REALISIERUNG')
      THEN AU.dat_start_plan
      ELSE AU.dat_ende_plan
      END AS dat_ende_plan,
     AU.dat_start_einschraenkung,
      CASE
      WHEN SU.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN', 'CPR_REALISIERUNG')
      THEN AU.dat_start_einschraenkung
      ELSE AU.dat_ende_einschraenkung
      END AS dat_ende_einschraenkung,
     AU.gesamt_puffer,
     AU.dauer,
     AU.cpr_prio,
     DATE(NULL) AS dat_erstellung,
     AU.cpr_systemstatus1_id,
     AU.cpr_systemstatus3_id,
     AU.cpr_systemstatus2_id,
     SU.cpr_suchfeld_id,
     1 AS sortier_nr_mhrwrtgkt,
      CASE
      WHEN AU.dat_start_vorhersage IS NOT NULL AND AU.dat_start_vorhersage <> DATE('1900-01-01')
      THEN AU.dat_start_vorhersage
      ELSE DATE(NULL)
      END AS dat_start_vorhersage,
      CASE
      WHEN AU.dat_ende_vorhersage IS NOT NULL AND AU.dat_ende_vorhersage <> DATE('1900-01-01')
      THEN AU.dat_ende_vorhersage
      ELSE DATE(NULL)
      END AS dat_ende_vorhersage,
     '' AS dat_realisierung,
     '' AS dat_start_realisierung,
     '' AS dat_soll_monat,
     0 AS akt_gj
    FROM kfl_production_dbp_view.v_cpr_aufgabe_per_1 AS AU
     INNER JOIN kfl_production_dbp_view.v_l_cpr_suchfeld_1 AS SU ON AU.cpr_suchfeld_id = SU.cpr_suchfeld_id
    WHERE AU.dat_bis = DATE '9999-12-31')
   UNION DISTINCT
   SELECT SUBSTR(CAST(AU.cpr_aufgabe_id AS STRING), 1, 32) AS checkliste_punkt_id,
    SUBSTR(NULL, 1, 32) AS cpr_checkliste_id,
    AU.projekt_phase_id,
    AU.sortier_nummer,
     CASE
     WHEN AU.cpr_systemstatus1_id IN (2, 3, 6)
     THEN 1
     ELSE 0
     END AS ok_fg,
     CASE
     WHEN AU.cpr_systemstatus1_id IN (2, 3, 6)
     THEN 0
     ELSE 1
     END AS nicht_ok_fg,
     CASE
     WHEN AU.cpr_systemstatus1_id = 4
     THEN 1
     ELSE 0
     END AS nicht_relevant_fg,
    0 AS obligatorisch_fg,
    'KBE_BAUGENEHMIGUNG' AS cpr_suchfeld,
    SUBSTR(NULL, 1, 40) AS cpr_prozess,
    SUBSTR(NULL, 1, 20) AS terminart,
    AU.dat_start_ist,
    AU.dat_ende_ist,
    AU.dat_start_max,
    AU.dat_ende_max,
    AU.dat_start_plan,
    AU.dat_ende_plan,
    AU.dat_start_einschraenkung,
    AU.dat_ende_einschraenkung,
    AU.gesamt_puffer,
    AU.dauer,
    AU.cpr_prio,
    DATE(NULL) AS dat_erstellung,
    AU.cpr_systemstatus1_id,
    AU.cpr_systemstatus3_id,
    AU.cpr_systemstatus2_id,
    SU.cpr_suchfeld_id,
    1 AS sortier_nr_mhrwrtgkt,
    AU.dat_start_vorhersage,
    AU.dat_ende_vorhersage,
    '' AS dat_realisierung,
    '' AS dat_start_realisierung,
    '' AS dat_soll_monat,
    0 AS akt_gj
   FROM kfl_production_dbp_view.v_cpr_aufgabe_per_1 AS AU
    INNER JOIN kfl_production_dbp_view.v_l_cpr_suchfeld_1 AS SU ON AU.cpr_suchfeld_id = SU.cpr_suchfeld_id
   WHERE AU.dat_bis = DATE '9999-12-31'
    AND SU.cpr_suchfeld = 'CPR_BAURECHTSVERFAHREN') AS cl_au
 INNER JOIN kfl_production_dbp_view.v_cpr_phase_per_1 AS PH ON cl_au.projekt_phase_id = PH.projekt_phase_id AND PH.dat_bis
    = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_cpr_projekt_per_1 AS PR ON PH.projekt_id = PR.projekt_id AND PR.dat_bis =
   DATE '9999-12-31'
 INNER JOIN (SELECT gj,
   akt_gj,
   MAX(max_dat) AS dat_termin_gj
  FROM kfl_production_dbp_view.v_monat_1 AS TG
  WHERE akt_gj = 0
  GROUP BY gj,
   akt_gj) AS tg ON TRUE;