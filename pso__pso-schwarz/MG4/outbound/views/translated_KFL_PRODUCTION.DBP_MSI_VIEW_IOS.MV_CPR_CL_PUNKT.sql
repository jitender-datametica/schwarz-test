CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_cpr_cl_punkt (checkliste_punkt_id, cpr_checkliste_id,
projekt_phase_id, dat_ist_termin, dat_start_soll, dat_soll_termin, dat_soll_termin_text, dat_start_termin,
dat_start_vorhersage, dat_ende_vorhersage, dat_termin, dat_termin_gj, termin_fg, text_termin, text2_termin, dauer_termin
, sortier_nummer, ok_fg, nicht_ok_fg, nicht_relevant_fg, obligatorisch_fg, cpr_suchfeld_id, cpr_prozess, terminart,
dat_start_ist, dat_ende_ist, dat_start_max, dat_ende_max, dat_start_plan, dat_ende_plan, dat_start_einschraenkung,
dat_ende_einschraenkung, gesamt_puffer, dauer, cpr_prio, dat_erstellung, cpr_systemstatus1_id, cpr_systemstatus3_id,
cpr_systemstatus2_id, mandant_id, sortier_nr_mhrwrtgkt, dat_realisierung, dat_start_realisierung, dat_soll_monat, akt_gj
) AS -- cl_au
 -- 
 /* ** */ -- 
 -- 
 /* ** */ -- 
 SELECT cl_au.checkliste_punkt_id,
 cl_au.cpr_checkliste_id,
 cl_au.projekt_phase_id,
  CASE
  WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
  THEN cl_au.dat_ende_ist
  ELSE DATE(NULL)
  END AS dat_ist_termin,
  CASE
  WHEN cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
  THEN cl_au.dat_start_einschraenkung
  ELSE DATE(NULL)
  END AS dat_start_soll,
  CASE
  WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
  THEN cl_au.dat_ende_einschraenkung
  ELSE DATE(NULL)
  END AS dat_soll_termin,
  CASE
  WHEN CASE
    WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END <= DATE_ADD(CURRENT_DATE, INTERVAL 98 DAY)
  THEN FORMAT_DATE('%d.%m.%Y', CASE
    WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END)
  WHEN CASE
    WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END <= IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 6 MONTH)), DATE_ADD(CURRENT_DATE
     ,INTERVAL 6 MONTH))
  THEN FORMAT_DATE('%m.%d.%Y', CASE
    WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END)
  WHEN CASE
    WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END <= IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 18 MONTH)), DATE_ADD(CURRENT_DATE
     ,INTERVAL 18 MONTH))
  THEN CASE
     WHEN EXTRACT(MONTH FROM CASE
        WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END) BETWEEN 1 AND 3
     THEN 'I'
     WHEN EXTRACT(MONTH FROM CASE
        WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END) BETWEEN 4 AND 6
     THEN 'II'
     WHEN EXTRACT(MONTH FROM CASE
        WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END) BETWEEN 7 AND 9
     THEN 'III'
     WHEN EXTRACT(MONTH FROM CASE
        WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END) BETWEEN 10 AND 12
     THEN 'IV'
     ELSE ''
     END || '/' || CAST(EXTRACT(YEAR FROM CASE
      WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END) AS STRING)
  WHEN CASE
    WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END > IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 18 MONTH)), DATE_ADD(CURRENT_DATE
     ,INTERVAL 18 MONTH))
  THEN FORMAT_DATE('%Y', CASE
    WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
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
      WHEN cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_start_einschraenkung
      ELSE DATE(NULL)
      END >= CURRENT_DATE
    THEN CASE
     WHEN cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
     THEN cl_au.dat_start_einschraenkung
     ELSE DATE(NULL)
     END
    ELSE NULL
    END)) AS dat_start_termin,
  CASE
  WHEN cl_au.dat_start_vorhersage <> DATE('1900-01-01')
  THEN cl_au.dat_start_vorhersage
  ELSE DATE(NULL)
  END AS dat_start_vorhersage,
  CASE
  WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01')
  THEN cl_au.dat_ende_vorhersage
  ELSE DATE(NULL)
  END AS dat_ende_vorhersage,
 DATE(CASE
   WHEN CASE
      WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END <> DATE('1900-01-01') AND CASE
     WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
     THEN cl_au.dat_ende_ist
     ELSE DATE(NULL)
     END IS NOT NULL
   THEN CASE
    WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
    THEN cl_au.dat_ende_ist
    ELSE DATE(NULL)
    END
   WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
   THEN cl_au.dat_ende_vorhersage
   WHEN CASE
     WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
     THEN cl_au.dat_ende_einschraenkung
     ELSE DATE(NULL)
     END >= CURRENT_DATE
   THEN CASE
    WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END
   ELSE NULL
   END) AS dat_termin,
 tg.dat_termin_gj,
 CAST(CASE
   WHEN DATE(CASE
      WHEN CASE
         WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
         THEN cl_au.dat_ende_ist
         ELSE DATE(NULL)
         END <> DATE('1900-01-01') AND CASE
        WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END IS NOT NULL
      THEN CASE
       WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END
      WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
      THEN cl_au.dat_ende_vorhersage
      WHEN CASE
        WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END) <= CURRENT_DATE
   THEN 1
   WHEN DATE(CASE
      WHEN CASE
         WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
         THEN cl_au.dat_ende_ist
         ELSE DATE(NULL)
         END <> DATE('1900-01-01') AND CASE
        WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END IS NOT NULL
      THEN CASE
       WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END
      WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
      THEN cl_au.dat_ende_vorhersage
      WHEN CASE
        WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
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
        WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END <> DATE('1900-01-01') AND CASE
       WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END IS NOT NULL
     THEN CASE
      WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END
     WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
     THEN cl_au.dat_ende_vorhersage
     WHEN CASE
       WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END >= CURRENT_DATE
     THEN CASE
      WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END
     ELSE NULL
     END) <= DATE_ADD(CURRENT_DATE, INTERVAL 98 DAY)
  THEN FORMAT_DATE('%d.%m.%Y', DATE(CASE
     WHEN CASE
        WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END <> DATE('1900-01-01') AND CASE
       WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END IS NOT NULL
     THEN CASE
      WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END
     WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
     THEN cl_au.dat_ende_vorhersage
     WHEN CASE
       WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END >= CURRENT_DATE
     THEN CASE
      WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END
     ELSE NULL
     END))
  WHEN DATE(CASE
     WHEN CASE
        WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END <> DATE('1900-01-01') AND CASE
       WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END IS NOT NULL
     THEN CASE
      WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END
     WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
     THEN cl_au.dat_ende_vorhersage
     WHEN CASE
       WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END >= CURRENT_DATE
     THEN CASE
      WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END
     ELSE NULL
     END) <= IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 6 MONTH)), DATE_ADD(CURRENT_DATE
     ,INTERVAL 6 MONTH))
  THEN FORMAT_DATE('%m.%d.%Y', DATE(CASE
     WHEN CASE
        WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END <> DATE('1900-01-01') AND CASE
       WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END IS NOT NULL
     THEN CASE
      WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END
     WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
     THEN cl_au.dat_ende_vorhersage
     WHEN CASE
       WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END >= CURRENT_DATE
     THEN CASE
      WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END
     ELSE NULL
     END))
  WHEN DATE(CASE
     WHEN CASE
        WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END <> DATE('1900-01-01') AND CASE
       WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END IS NOT NULL
     THEN CASE
      WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END
     WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
     THEN cl_au.dat_ende_vorhersage
     WHEN CASE
       WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END >= CURRENT_DATE
     THEN CASE
      WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END
     ELSE NULL
     END) <= IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 18 MONTH)), DATE_ADD(CURRENT_DATE
     ,INTERVAL 18 MONTH))
  THEN CASE
     WHEN EXTRACT(MONTH FROM DATE(CASE
         WHEN CASE
            WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
            THEN cl_au.dat_ende_ist
            ELSE DATE(NULL)
            END <> DATE('1900-01-01') AND CASE
           WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END IS NOT NULL
         THEN CASE
          WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END
         WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
         THEN cl_au.dat_ende_vorhersage
         WHEN CASE
           WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
           THEN cl_au.dat_ende_einschraenkung
           ELSE DATE(NULL)
           END >= CURRENT_DATE
         THEN CASE
          WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
          THEN cl_au.dat_ende_einschraenkung
          ELSE DATE(NULL)
          END
         ELSE NULL
         END)) BETWEEN 1 AND 3
     THEN 'I'
     WHEN EXTRACT(MONTH FROM DATE(CASE
         WHEN CASE
            WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
            THEN cl_au.dat_ende_ist
            ELSE DATE(NULL)
            END <> DATE('1900-01-01') AND CASE
           WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END IS NOT NULL
         THEN CASE
          WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END
         WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
         THEN cl_au.dat_ende_vorhersage
         WHEN CASE
           WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
           THEN cl_au.dat_ende_einschraenkung
           ELSE DATE(NULL)
           END >= CURRENT_DATE
         THEN CASE
          WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
          THEN cl_au.dat_ende_einschraenkung
          ELSE DATE(NULL)
          END
         ELSE NULL
         END)) BETWEEN 4 AND 6
     THEN 'II'
     WHEN EXTRACT(MONTH FROM DATE(CASE
         WHEN CASE
            WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
            THEN cl_au.dat_ende_ist
            ELSE DATE(NULL)
            END <> DATE('1900-01-01') AND CASE
           WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END IS NOT NULL
         THEN CASE
          WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END
         WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
         THEN cl_au.dat_ende_vorhersage
         WHEN CASE
           WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
           THEN cl_au.dat_ende_einschraenkung
           ELSE DATE(NULL)
           END >= CURRENT_DATE
         THEN CASE
          WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
          THEN cl_au.dat_ende_einschraenkung
          ELSE DATE(NULL)
          END
         ELSE NULL
         END)) BETWEEN 7 AND 9
     THEN 'III'
     WHEN EXTRACT(MONTH FROM DATE(CASE
         WHEN CASE
            WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
            THEN cl_au.dat_ende_ist
            ELSE DATE(NULL)
            END <> DATE('1900-01-01') AND CASE
           WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END IS NOT NULL
         THEN CASE
          WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END
         WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
         THEN cl_au.dat_ende_vorhersage
         WHEN CASE
           WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
           THEN cl_au.dat_ende_einschraenkung
           ELSE DATE(NULL)
           END >= CURRENT_DATE
         THEN CASE
          WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
          THEN cl_au.dat_ende_einschraenkung
          ELSE DATE(NULL)
          END
         ELSE NULL
         END)) BETWEEN 10 AND 12
     THEN 'IV'
     ELSE ''
     END || '/' || CAST(EXTRACT(YEAR FROM DATE(CASE
       WHEN CASE
          WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END <> DATE('1900-01-01') AND CASE
         WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
         THEN cl_au.dat_ende_ist
         ELSE DATE(NULL)
         END IS NOT NULL
       THEN CASE
        WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END
       WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
       THEN cl_au.dat_ende_vorhersage
       WHEN CASE
         WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
         THEN cl_au.dat_ende_einschraenkung
         ELSE DATE(NULL)
         END >= CURRENT_DATE
       THEN CASE
        WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END
       ELSE NULL
       END)) AS STRING)
  WHEN DATE(CASE
     WHEN CASE
        WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END <> DATE('1900-01-01') AND CASE
       WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END IS NOT NULL
     THEN CASE
      WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END
     WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
     THEN cl_au.dat_ende_vorhersage
     WHEN CASE
       WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END >= CURRENT_DATE
     THEN CASE
      WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END
     ELSE NULL
     END) > IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 18 MONTH)), DATE_ADD(CURRENT_DATE
     ,INTERVAL 18 MONTH))
  THEN FORMAT_DATE('%Y', DATE(CASE
     WHEN CASE
        WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END <> DATE('1900-01-01') AND CASE
       WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END IS NOT NULL
     THEN CASE
      WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END
     WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
     THEN cl_au.dat_ende_vorhersage
     WHEN CASE
       WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END >= CURRENT_DATE
     THEN CASE
      WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END
     ELSE NULL
     END))
  ELSE NULL
  END AS text_termin,
  CASE
  WHEN CASE
     WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
     THEN cl_au.dat_ende_ist
     ELSE DATE(NULL)
     END <> DATE('1900-01-01') AND CASE
    WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
    THEN cl_au.dat_ende_ist
    ELSE DATE(NULL)
    END IS NOT NULL
  THEN FORMAT_DATE('%d.%m.%Y', CASE
    WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
    THEN cl_au.dat_ende_ist
    ELSE DATE(NULL)
    END)
  WHEN cl_au.dat_ende_vorhersage > CURRENT_DATE
  THEN FORMAT_DATE('%m.%d.%Y', CURRENT_DATE)
  WHEN CASE
     WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
     THEN cl_au.dat_ende_einschraenkung
     ELSE DATE(NULL)
     END > CURRENT_DATE AND CASE
    WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END IS NOT NULL
  THEN FORMAT_DATE('%m.%d.%Y', CASE
    WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
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
 pr.mandant_id,
 cl_au.sortier_nr_mhrwrtgkt,
  CASE
  WHEN DATE(CASE
     WHEN CASE
        WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END <> DATE('1900-01-01') AND CASE
       WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END IS NOT NULL
     THEN CASE
      WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END
     WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
     THEN cl_au.dat_ende_vorhersage
     WHEN CASE
       WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END >= CURRENT_DATE
     THEN CASE
      WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END
     ELSE NULL
     END) <= DATE_ADD(CURRENT_DATE, INTERVAL 84 DAY)
  THEN FORMAT_DATE('%d.%m.%y', DATE(CASE
     WHEN CASE
        WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END <> DATE('1900-01-01') AND CASE
       WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END IS NOT NULL
     THEN CASE
      WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END
     WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
     THEN cl_au.dat_ende_vorhersage
     WHEN CASE
       WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END >= CURRENT_DATE
     THEN CASE
      WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END
     ELSE NULL
     END))
  WHEN DATE(CASE
     WHEN CASE
        WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END <> DATE('1900-01-01') AND CASE
       WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END IS NOT NULL
     THEN CASE
      WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END
     WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
     THEN cl_au.dat_ende_vorhersage
     WHEN CASE
       WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END >= CURRENT_DATE
     THEN CASE
      WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END
     ELSE NULL
     END) <= DATE_ADD(CURRENT_DATE, INTERVAL 168 DAY)
  THEN FORMAT_DATE('%m.%d.%Y', DATE(CASE
     WHEN CASE
        WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END <> DATE('1900-01-01') AND CASE
       WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END IS NOT NULL
     THEN CASE
      WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END
     WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
     THEN cl_au.dat_ende_vorhersage
     WHEN CASE
       WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END >= CURRENT_DATE
     THEN CASE
      WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END
     ELSE NULL
     END))
  WHEN DATE(CASE
     WHEN CASE
        WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END <> DATE('1900-01-01') AND CASE
       WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END IS NOT NULL
     THEN CASE
      WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END
     WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
     THEN cl_au.dat_ende_vorhersage
     WHEN CASE
       WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END >= CURRENT_DATE
     THEN CASE
      WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END
     ELSE NULL
     END) <= IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 18 MONTH)), DATE_ADD(CURRENT_DATE
     ,INTERVAL 18 MONTH))
  THEN CASE
     WHEN EXTRACT(MONTH FROM DATE(CASE
         WHEN CASE
            WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
            THEN cl_au.dat_ende_ist
            ELSE DATE(NULL)
            END <> DATE('1900-01-01') AND CASE
           WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END IS NOT NULL
         THEN CASE
          WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END
         WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
         THEN cl_au.dat_ende_vorhersage
         WHEN CASE
           WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
           THEN cl_au.dat_ende_einschraenkung
           ELSE DATE(NULL)
           END >= CURRENT_DATE
         THEN CASE
          WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
          THEN cl_au.dat_ende_einschraenkung
          ELSE DATE(NULL)
          END
         ELSE NULL
         END)) BETWEEN 1 AND 3
     THEN 'I'
     WHEN EXTRACT(MONTH FROM DATE(CASE
         WHEN CASE
            WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
            THEN cl_au.dat_ende_ist
            ELSE DATE(NULL)
            END <> DATE('1900-01-01') AND CASE
           WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END IS NOT NULL
         THEN CASE
          WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END
         WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
         THEN cl_au.dat_ende_vorhersage
         WHEN CASE
           WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
           THEN cl_au.dat_ende_einschraenkung
           ELSE DATE(NULL)
           END >= CURRENT_DATE
         THEN CASE
          WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
          THEN cl_au.dat_ende_einschraenkung
          ELSE DATE(NULL)
          END
         ELSE NULL
         END)) BETWEEN 4 AND 6
     THEN 'II'
     WHEN EXTRACT(MONTH FROM DATE(CASE
         WHEN CASE
            WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
            THEN cl_au.dat_ende_ist
            ELSE DATE(NULL)
            END <> DATE('1900-01-01') AND CASE
           WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END IS NOT NULL
         THEN CASE
          WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END
         WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
         THEN cl_au.dat_ende_vorhersage
         WHEN CASE
           WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
           THEN cl_au.dat_ende_einschraenkung
           ELSE DATE(NULL)
           END >= CURRENT_DATE
         THEN CASE
          WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
          THEN cl_au.dat_ende_einschraenkung
          ELSE DATE(NULL)
          END
         ELSE NULL
         END)) BETWEEN 7 AND 9
     THEN 'III'
     WHEN EXTRACT(MONTH FROM DATE(CASE
         WHEN CASE
            WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
            THEN cl_au.dat_ende_ist
            ELSE DATE(NULL)
            END <> DATE('1900-01-01') AND CASE
           WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END IS NOT NULL
         THEN CASE
          WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END
         WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
         THEN cl_au.dat_ende_vorhersage
         WHEN CASE
           WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
           THEN cl_au.dat_ende_einschraenkung
           ELSE DATE(NULL)
           END >= CURRENT_DATE
         THEN CASE
          WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
          THEN cl_au.dat_ende_einschraenkung
          ELSE DATE(NULL)
          END
         ELSE NULL
         END)) BETWEEN 10 AND 12
     THEN 'IV'
     ELSE ''
     END || '/' || CAST(EXTRACT(YEAR FROM DATE(CASE
       WHEN CASE
          WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END <> DATE('1900-01-01') AND CASE
         WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
         THEN cl_au.dat_ende_ist
         ELSE DATE(NULL)
         END IS NOT NULL
       THEN CASE
        WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END
       WHEN cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
       THEN cl_au.dat_ende_vorhersage
       WHEN CASE
         WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
         THEN cl_au.dat_ende_einschraenkung
         ELSE DATE(NULL)
         END >= CURRENT_DATE
       THEN CASE
        WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
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
        WHEN cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_start_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
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
        WHEN cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_start_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
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
        WHEN cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_start_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
       THEN cl_au.dat_start_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END)) <= DATE_ADD(CURRENT_DATE, INTERVAL 168 DAY)
  THEN FORMAT_DATE('%m.%d.%Y', DATE(COALESCE(CASE
      WHEN cl_au.dat_start_ist = DATE('1900-01-01')
      THEN NULL
      ELSE cl_au.dat_start_ist
      END, CASE
      WHEN CASE
        WHEN cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_start_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
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
        WHEN cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
        THEN cl_au.dat_start_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
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
            WHEN cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
            THEN cl_au.dat_start_einschraenkung
            ELSE DATE(NULL)
            END >= CURRENT_DATE
          THEN CASE
           WHEN cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
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
            WHEN cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
            THEN cl_au.dat_start_einschraenkung
            ELSE DATE(NULL)
            END >= CURRENT_DATE
          THEN CASE
           WHEN cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
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
            WHEN cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
            THEN cl_au.dat_start_einschraenkung
            ELSE DATE(NULL)
            END >= CURRENT_DATE
          THEN CASE
           WHEN cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
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
            WHEN cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
            THEN cl_au.dat_start_einschraenkung
            ELSE DATE(NULL)
            END >= CURRENT_DATE
          THEN CASE
           WHEN cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
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
          WHEN cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
          THEN cl_au.dat_start_einschraenkung
          ELSE DATE(NULL)
          END >= CURRENT_DATE
        THEN CASE
         WHEN cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
         THEN cl_au.dat_start_einschraenkung
         ELSE DATE(NULL)
         END
        ELSE NULL
        END))) AS STRING)
  ELSE NULL
  END AS dat_start_realisierung,
  CASE
  WHEN CASE
    WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
    THEN cl_au.dat_ende_ist
    ELSE DATE(NULL)
    END IS NULL AND CASE
    WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END IS NOT NULL
  THEN FORMAT_DATE('%m.%d.%Y', CASE
    WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END)
  WHEN CASE
   WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
   THEN cl_au.dat_ende_ist
   ELSE DATE(NULL)
   END IS NOT NULL
  THEN FORMAT_DATE('%d.%m.%y', CASE
    WHEN cl_au.dat_ende_ist <> DATE('1900-01-01')
    THEN cl_au.dat_ende_ist
    ELSE DATE(NULL)
    END)
  ELSE NULL
  END AS dat_soll_monat,
 tg.akt_gj
FROM ((SELECT cp.checkliste_punkt_id,
     cp.cpr_checkliste_id,
     cl.projekt_phase_id,
     MOD(cp.sortier_nummer, 100) AS sortier_nummer,
     cp.ok_fg,
     cp.nicht_ok_fg,
     cp.nicht_relevant_fg,
     cp.obligatorisch_fg,
     su.cpr_suchfeld,
     SUBSTR(NULL, 1, 40) AS cpr_prozess,
     SUBSTR(NULL, 1, 20) AS terminart,
     cp.dat_start_ist,
     cp.dat_ende_ist,
     cp.dat_start_max,
     cp.dat_ende_max,
     cp.dat_start_plan,
     cp.dat_ende_plan,
     cp.dat_start_einschraenkung,
     cp.dat_ende_einschraenkung,
     cp.gesamt_puffer,
     CAST(NULL AS NUMERIC) AS dauer,
     cp.cpr_prio,
     cp.dat_erstellung,
     cp.cpr_systemstatus1_id,
     cp.cpr_systemstatus3_id,
     cp.cpr_systemstatus2_id,
     cp.cpr_suchfeld_id,
     cp.sortier_nr_mhrwrtgkt,
      CASE
      WHEN cp.dat_start_vorhersage <> DATE('1900-01-01')
      THEN cp.dat_start_vorhersage
      ELSE DATE(NULL)
      END AS dat_start_vorhersage,
      CASE
      WHEN cp.dat_ende_vorhersage <> DATE('1900-01-01')
      THEN cp.dat_ende_vorhersage
      ELSE DATE(NULL)
      END AS dat_ende_vorhersage,
     ' AS dat_realisierung, ' AS dat_start_realisierung,
     '' AS dat_soll_monat,
     tg.akt_gj
    FROM kfl_production_dbp_view.v_cpr_cl_punkt_per AS cp
     INNER JOIN kfl_production_dbp_view.v_cpr_checkliste_per AS cl ON cp.cpr_checkliste_id = cl.cpr_checkliste_id
     INNER JOIN kfl_production_dbp_view.v_l_cpr_suchfeld AS su ON cp.cpr_suchfeld_id = su.cpr_suchfeld_id
     INNER JOIN (SELECT gj,
       akt_gj,
       MAX(max_dat) AS dat_termin_gj
      FROM kfl_production_dbp_view.v_monat AS tg
      WHERE akt_gj = 0
      GROUP BY gj,
       akt_gj) AS tg ON TRUE
    WHERE cl.dat_bis = DATE '9999-12-31'
     AND cp.dat_bis = DATE '9999-12-31'
    UNION DISTINCT
    SELECT SUBSTR(CAST(au.cpr_aufgabe_id AS STRING), 1, 32) AS checkliste_punkt_id,
     SUBSTR(NULL, 1, 32) AS cpr_checkliste_id,
     au.projekt_phase_id,
     au.sortier_nummer,
      CASE
      WHEN au.cpr_systemstatus1_id IN (2, 3, 6)
      THEN 1
      ELSE 0
      END AS ok_fg,
      CASE
      WHEN au.cpr_systemstatus1_id IN (2, 3, 6)
      THEN 0
      ELSE 1
      END AS nicht_ok_fg,
      CASE
      WHEN au.cpr_systemstatus1_id = 4
      THEN 1
      ELSE 0
      END AS nicht_relevant_fg,
     0 AS obligatorisch_fg,
      CASE
      WHEN su.cpr_suchfeld = 'CPR_BAURECHTSVERFAHREN'
      THEN 'KBE_BAUANTRAG' -- WHEN su.cpr_suchfeld = 'CPR_REALISIERUNG' THEN 'BAUBEGINN'

      ELSE su.cpr_suchfeld
      END AS cpr_suchfeld,
     SUBSTR(NULL, 1, 40) AS cpr_prozess,
     SUBSTR(NULL, 1, 20) AS terminart,
     au.dat_start_ist,
      CASE
      WHEN su.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN')
      THEN au.dat_start_ist
      ELSE au.dat_ende_ist
      END AS dat_ende_ist,
     au.dat_start_max,
      CASE
      WHEN su.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN', 'CPR_REALISIERUNG')
      THEN au.dat_start_max
      ELSE au.dat_ende_max
      END AS dat_ende_max,
     au.dat_start_plan,
      CASE
      WHEN su.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN', 'CPR_REALISIERUNG')
      THEN au.dat_start_plan
      ELSE au.dat_ende_plan
      END AS dat_ende_plan,
     au.dat_start_einschraenkung,
      CASE
      WHEN su.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN', 'CPR_REALISIERUNG')
      THEN au.dat_start_einschraenkung
      ELSE au.dat_ende_einschraenkung
      END AS dat_ende_einschraenkung,
     au.gesamt_puffer,
     au.dauer,
     au.cpr_prio,
     DATE(NULL) AS dat_erstellung,
     au.cpr_systemstatus1_id,
     au.cpr_systemstatus3_id,
     au.cpr_systemstatus2_id,
     su.cpr_suchfeld_id,
     1 AS sortier_nr_mhrwrtgkt,
      CASE
      WHEN au.dat_start_vorhersage <> DATE('1900-01-01')
      THEN au.dat_start_vorhersage
      ELSE DATE(NULL)
      END AS dat_start_vorhersage,
      CASE
      WHEN au.dat_ende_vorhersage <> DATE('1900-01-01')
      THEN au.dat_ende_vorhersage
      ELSE DATE(NULL)
      END AS dat_ende_vorhersage,
     ' AS dat_realisierung, ' AS dat_start_realisierung,
     '' AS dat_soll_monat,
     0 AS akt_gj
    FROM kfl_production_dbp_view.v_cpr_aufgabe_per AS au
     INNER JOIN kfl_production_dbp_view.v_l_cpr_suchfeld AS su ON au.cpr_suchfeld_id = su.cpr_suchfeld_id
    WHERE au.dat_bis = DATE '9999-12-31')
   UNION DISTINCT
   SELECT SUBSTR(CAST(au.cpr_aufgabe_id AS STRING), 1, 32) AS checkliste_punkt_id,
    SUBSTR(NULL, 1, 32) AS cpr_checkliste_id,
    au.projekt_phase_id,
    au.sortier_nummer,
     CASE
     WHEN au.cpr_systemstatus1_id IN (2, 3, 6)
     THEN 1
     ELSE 0
     END AS ok_fg,
     CASE
     WHEN au.cpr_systemstatus1_id IN (2, 3, 6)
     THEN 0
     ELSE 1
     END AS nicht_ok_fg,
     CASE
     WHEN au.cpr_systemstatus1_id = 4
     THEN 1
     ELSE 0
     END AS nicht_relevant_fg,
    0 AS obligatorisch_fg,
    'KBE_BAUGENEHMIGUNG' AS cpr_suchfeld,
    SUBSTR(NULL, 1, 40) AS cpr_prozess,
    SUBSTR(NULL, 1, 20) AS terminart,
    au.dat_start_ist,
    au.dat_ende_ist,
    au.dat_start_max,
    au.dat_ende_max,
    au.dat_start_plan,
    au.dat_ende_plan,
    au.dat_start_einschraenkung,
    au.dat_ende_einschraenkung,
    au.gesamt_puffer,
    au.dauer,
    au.cpr_prio,
    DATE(NULL) AS dat_erstellung,
    au.cpr_systemstatus1_id,
    au.cpr_systemstatus3_id,
    au.cpr_systemstatus2_id,
    su.cpr_suchfeld_id,
    1 AS sortier_nr_mhrwrtgkt,
    au.dat_start_vorhersage,
    au.dat_ende_vorhersage,
    ' AS dat_realisierung, ' AS dat_start_realisierung,
    '' AS dat_soll_monat,
    0 AS akt_gj
   FROM kfl_production_dbp_view.v_cpr_aufgabe_per AS au
    INNER JOIN kfl_production_dbp_view.v_l_cpr_suchfeld AS su ON au.cpr_suchfeld_id = su.cpr_suchfeld_id
   WHERE au.dat_bis = DATE '9999-12-31'
    AND su.cpr_suchfeld = 'CPR_BAURECHTSVERFAHREN') AS cl_au
 INNER JOIN kfl_production_dbp_view.v_cpr_phase_per AS ph ON cl_au.projekt_phase_id = ph.projekt_phase_id AND ph.dat_bis
    = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_cpr_projekt_per AS pr ON ph.projekt_id = pr.projekt_id AND pr.dat_bis =
   DATE '9999-12-31'
 INNER JOIN (SELECT gj,
   akt_gj,
   MAX(max_dat) AS dat_termin_gj
  FROM kfl_production_dbp_view.v_monat AS tg
  WHERE akt_gj = 0
  GROUP BY gj,
   akt_gj) AS tg ON TRUE;