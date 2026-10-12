CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_cpr_cl_punkt_hist_monat_1 AS SELECT cl_au.checkliste_punkt_id,
 cl_au.cpr_checkliste_id,
 cl_au.projekt_phase_id,
  CASE
  WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
  THEN cl_au.dat_ende_ist
  ELSE DATE(NULL)
  END AS dat_ist_termin,
  CASE
  WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_start_einschraenkung) <> 2001
  THEN cl_au.dat_start_einschraenkung
  ELSE DATE(NULL)
  END AS dat_start_soll,
  CASE
  WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
  THEN cl_au.dat_ende_einschraenkung
  ELSE DATE(NULL)
  END AS dat_soll_termin,
 DATE(COALESCE(CASE
    WHEN EXTRACT(YEAR FROM cl_au.dat_start_ist) = 2001
    THEN NULL
    ELSE cl_au.dat_start_ist
    END, CASE
    WHEN CASE
      WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_start_einschraenkung) <> 2001
      THEN cl_au.dat_start_einschraenkung
      ELSE DATE(NULL)
      END >= CURRENT_DATE
    THEN CASE
     WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_start_einschraenkung) <> 2001
     THEN cl_au.dat_start_einschraenkung
     ELSE DATE(NULL)
     END
    ELSE NULL
    END)) AS dat_start_termin,
 DATE(COALESCE(CASE
    WHEN EXTRACT(YEAR FROM CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END) = 2001
    THEN NULL
    ELSE CASE
     WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
     THEN cl_au.dat_ende_ist
     ELSE DATE(NULL)
     END
    END, CASE
    WHEN CASE
      WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END >= CURRENT_DATE
    THEN CASE
     WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
     THEN cl_au.dat_ende_einschraenkung
     ELSE DATE(NULL)
     END
    ELSE NULL
    END)) AS dat_termin,
 CAST(CASE
   WHEN DATE(COALESCE(CASE
       WHEN EXTRACT(YEAR FROM CASE
          WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END) = 2001
       THEN NULL
       ELSE CASE
        WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END
       END, CASE
       WHEN CASE
         WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
         THEN cl_au.dat_ende_einschraenkung
         ELSE DATE(NULL)
         END >= CURRENT_DATE
       THEN CASE
        WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END
       ELSE NULL
       END)) <= CURRENT_DATE
   THEN 1
   WHEN DATE(COALESCE(CASE
       WHEN EXTRACT(YEAR FROM CASE
          WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END) = 2001
       THEN NULL
       ELSE CASE
        WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END
       END, CASE
       WHEN CASE
         WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
         THEN cl_au.dat_ende_einschraenkung
         ELSE DATE(NULL)
         END >= CURRENT_DATE
       THEN CASE
        WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END
       ELSE NULL
       END)) > CURRENT_DATE
   THEN 0
   ELSE - 1
   END AS BIGNUMERIC) AS termin_fg,
  CASE
  WHEN DATE(COALESCE(CASE
      WHEN EXTRACT(YEAR FROM CASE
         WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
         THEN cl_au.dat_ende_ist
         ELSE DATE(NULL)
         END) = 2001
      THEN NULL
      ELSE CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END
      END, CASE
      WHEN CASE
        WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END)) <= DATE_ADD(CURRENT_DATE, INTERVAL 98 DAY)
  THEN CAST(DATE(COALESCE(CASE
      WHEN EXTRACT(YEAR FROM CASE
         WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
         THEN cl_au.dat_ende_ist
         ELSE DATE(NULL)
         END) = 2001
      THEN NULL
      ELSE CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END
      END, CASE
      WHEN CASE
        WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END)) AS STRING)
  WHEN DATE(COALESCE(CASE
      WHEN EXTRACT(YEAR FROM CASE
         WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
         THEN cl_au.dat_ende_ist
         ELSE DATE(NULL)
         END) = 2001
      THEN NULL
      ELSE CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END
      END, CASE
      WHEN CASE
        WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END)) <= IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 6 MONTH)), DATE_ADD(CURRENT_DATE
     ,INTERVAL 6 MONTH))
  THEN CAST(DATE(COALESCE(CASE
      WHEN EXTRACT(YEAR FROM CASE
         WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
         THEN cl_au.dat_ende_ist
         ELSE DATE(NULL)
         END) = 2001
      THEN NULL
      ELSE CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END
      END, CASE
      WHEN CASE
        WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END)) AS STRING)
  WHEN DATE(COALESCE(CASE
      WHEN EXTRACT(YEAR FROM CASE
         WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
         THEN cl_au.dat_ende_ist
         ELSE DATE(NULL)
         END) = 2001
      THEN NULL
      ELSE CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END
      END, CASE
      WHEN CASE
        WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END)) <= IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 18 MONTH)), DATE_ADD(CURRENT_DATE
     ,INTERVAL 18 MONTH))
  THEN CASE
     WHEN EXTRACT(MONTH FROM DATE(COALESCE(CASE
          WHEN EXTRACT(YEAR FROM CASE
             WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
             THEN cl_au.dat_ende_ist
             ELSE DATE(NULL)
             END) = 2001
          THEN NULL
          ELSE CASE
           WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END
          END, CASE
          WHEN CASE
            WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
            THEN cl_au.dat_ende_einschraenkung
            ELSE DATE(NULL)
            END >= CURRENT_DATE
          THEN CASE
           WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
           THEN cl_au.dat_ende_einschraenkung
           ELSE DATE(NULL)
           END
          ELSE NULL
          END))) BETWEEN 1 AND 3
     THEN 'I'
     WHEN EXTRACT(MONTH FROM DATE(COALESCE(CASE
          WHEN EXTRACT(YEAR FROM CASE
             WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
             THEN cl_au.dat_ende_ist
             ELSE DATE(NULL)
             END) = 2001
          THEN NULL
          ELSE CASE
           WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END
          END, CASE
          WHEN CASE
            WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
            THEN cl_au.dat_ende_einschraenkung
            ELSE DATE(NULL)
            END >= CURRENT_DATE
          THEN CASE
           WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
           THEN cl_au.dat_ende_einschraenkung
           ELSE DATE(NULL)
           END
          ELSE NULL
          END))) BETWEEN 4 AND 6
     THEN 'II'
     WHEN EXTRACT(MONTH FROM DATE(COALESCE(CASE
          WHEN EXTRACT(YEAR FROM CASE
             WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
             THEN cl_au.dat_ende_ist
             ELSE DATE(NULL)
             END) = 2001
          THEN NULL
          ELSE CASE
           WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END
          END, CASE
          WHEN CASE
            WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
            THEN cl_au.dat_ende_einschraenkung
            ELSE DATE(NULL)
            END >= CURRENT_DATE
          THEN CASE
           WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
           THEN cl_au.dat_ende_einschraenkung
           ELSE DATE(NULL)
           END
          ELSE NULL
          END))) BETWEEN 7 AND 9
     THEN 'III'
     WHEN EXTRACT(MONTH FROM DATE(COALESCE(CASE
          WHEN EXTRACT(YEAR FROM CASE
             WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
             THEN cl_au.dat_ende_ist
             ELSE DATE(NULL)
             END) = 2001
          THEN NULL
          ELSE CASE
           WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END
          END, CASE
          WHEN CASE
            WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
            THEN cl_au.dat_ende_einschraenkung
            ELSE DATE(NULL)
            END >= CURRENT_DATE
          THEN CASE
           WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
           THEN cl_au.dat_ende_einschraenkung
           ELSE DATE(NULL)
           END
          ELSE NULL
          END))) BETWEEN 10 AND 12
     THEN 'IV'
     ELSE ''
     END || '/' || CAST(DATE(COALESCE(CASE
       WHEN EXTRACT(YEAR FROM CASE
          WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END) = 2001
       THEN NULL
       ELSE CASE
        WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END
       END, CASE
       WHEN CASE
         WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
         THEN cl_au.dat_ende_einschraenkung
         ELSE DATE(NULL)
         END >= CURRENT_DATE
       THEN CASE
        WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END
       ELSE NULL
       END)) AS STRING)
  WHEN DATE(COALESCE(CASE
      WHEN EXTRACT(YEAR FROM CASE
         WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
         THEN cl_au.dat_ende_ist
         ELSE DATE(NULL)
         END) = 2001
      THEN NULL
      ELSE CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END
      END, CASE
      WHEN CASE
        WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END)) > IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 18 MONTH)), DATE_ADD(CURRENT_DATE
     ,INTERVAL 18 MONTH))
  THEN CAST(DATE(COALESCE(CASE
      WHEN EXTRACT(YEAR FROM CASE
         WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
         THEN cl_au.dat_ende_ist
         ELSE DATE(NULL)
         END) = 2001
      THEN NULL
      ELSE CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END
      END, CASE
      WHEN CASE
        WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END)) AS STRING)
  ELSE NULL
  END AS text_termin,
  CASE
  WHEN CASE
    WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END IS NOT NULL AND CASE
    WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
    THEN cl_au.dat_ende_ist
    ELSE DATE(NULL)
    END IS NULL
  THEN CAST(CASE
    WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END AS STRING)
  ELSE CAST(CASE
    WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
    THEN cl_au.dat_ende_ist
    ELSE DATE(NULL)
    END AS STRING)
  END AS text2_termin,
  CASE
  WHEN EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001 AND EXTRACT(YEAR FROM cl_au.dat_start_ist) <> 2001 AND cl_au.dat_ende_ist
     >= cl_au.dat_start_ist
  THEN DATE_DIFF(cl_au.dat_ende_ist, cl_au.dat_start_ist, DAY)
  WHEN EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001 AND EXTRACT(YEAR FROM cl_au.dat_start_einschraenkung) <>
     2001 AND cl_au.dat_ende_einschraenkung >= cl_au.dat_start_einschraenkung
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
 cl_au.dat_start_ist,
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
 cl_au.cpr_systemstatus1_id,
 cl_au.cpr_systemstatus3_id,
 cl_au.cpr_systemstatus2_id,
 PR.mandant_id,
 CURRENT_DATE AS dat_vorhersage_start,
 CURRENT_DATE AS dat_vorhersage_ende,
  CASE
  WHEN DATE(COALESCE(CASE
      WHEN EXTRACT(YEAR FROM CASE
         WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
         THEN cl_au.dat_ende_ist
         ELSE DATE(NULL)
         END) = 2001
      THEN NULL
      ELSE CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END
      END, CASE
      WHEN CASE
        WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END)) <= DATE_ADD(CURRENT_DATE, INTERVAL 84 DAY)
  THEN CAST(DATE(COALESCE(CASE
      WHEN EXTRACT(YEAR FROM CASE
         WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
         THEN cl_au.dat_ende_ist
         ELSE DATE(NULL)
         END) = 2001
      THEN NULL
      ELSE CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END
      END, CASE
      WHEN CASE
        WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END)) AS STRING)
  WHEN DATE(COALESCE(CASE
      WHEN EXTRACT(YEAR FROM CASE
         WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
         THEN cl_au.dat_ende_ist
         ELSE DATE(NULL)
         END) = 2001
      THEN NULL
      ELSE CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END
      END, CASE
      WHEN CASE
        WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END)) <= DATE_ADD(CURRENT_DATE, INTERVAL 168 DAY)
  THEN CAST(DATE(COALESCE(CASE
      WHEN EXTRACT(YEAR FROM CASE
         WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
         THEN cl_au.dat_ende_ist
         ELSE DATE(NULL)
         END) = 2001
      THEN NULL
      ELSE CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END
      END, CASE
      WHEN CASE
        WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END)) AS STRING)
  WHEN DATE(COALESCE(CASE
      WHEN EXTRACT(YEAR FROM CASE
         WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
         THEN cl_au.dat_ende_ist
         ELSE DATE(NULL)
         END) = 2001
      THEN NULL
      ELSE CASE
       WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
       THEN cl_au.dat_ende_ist
       ELSE DATE(NULL)
       END
      END, CASE
      WHEN CASE
        WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
       THEN cl_au.dat_ende_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END)) <= IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 18 MONTH)), DATE_ADD(CURRENT_DATE
     ,INTERVAL 18 MONTH))
  THEN CASE
     WHEN EXTRACT(MONTH FROM DATE(COALESCE(CASE
          WHEN EXTRACT(YEAR FROM CASE
             WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
             THEN cl_au.dat_ende_ist
             ELSE DATE(NULL)
             END) = 2001
          THEN NULL
          ELSE CASE
           WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END
          END, CASE
          WHEN CASE
            WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
            THEN cl_au.dat_ende_einschraenkung
            ELSE DATE(NULL)
            END >= CURRENT_DATE
          THEN CASE
           WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
           THEN cl_au.dat_ende_einschraenkung
           ELSE DATE(NULL)
           END
          ELSE NULL
          END))) BETWEEN 1 AND 3
     THEN 'I'
     WHEN EXTRACT(MONTH FROM DATE(COALESCE(CASE
          WHEN EXTRACT(YEAR FROM CASE
             WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
             THEN cl_au.dat_ende_ist
             ELSE DATE(NULL)
             END) = 2001
          THEN NULL
          ELSE CASE
           WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END
          END, CASE
          WHEN CASE
            WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
            THEN cl_au.dat_ende_einschraenkung
            ELSE DATE(NULL)
            END >= CURRENT_DATE
          THEN CASE
           WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
           THEN cl_au.dat_ende_einschraenkung
           ELSE DATE(NULL)
           END
          ELSE NULL
          END))) BETWEEN 4 AND 6
     THEN 'II'
     WHEN EXTRACT(MONTH FROM DATE(COALESCE(CASE
          WHEN EXTRACT(YEAR FROM CASE
             WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
             THEN cl_au.dat_ende_ist
             ELSE DATE(NULL)
             END) = 2001
          THEN NULL
          ELSE CASE
           WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END
          END, CASE
          WHEN CASE
            WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
            THEN cl_au.dat_ende_einschraenkung
            ELSE DATE(NULL)
            END >= CURRENT_DATE
          THEN CASE
           WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
           THEN cl_au.dat_ende_einschraenkung
           ELSE DATE(NULL)
           END
          ELSE NULL
          END))) BETWEEN 7 AND 9
     THEN 'III'
     WHEN EXTRACT(MONTH FROM DATE(COALESCE(CASE
          WHEN EXTRACT(YEAR FROM CASE
             WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
             THEN cl_au.dat_ende_ist
             ELSE DATE(NULL)
             END) = 2001
          THEN NULL
          ELSE CASE
           WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END
          END, CASE
          WHEN CASE
            WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
            THEN cl_au.dat_ende_einschraenkung
            ELSE DATE(NULL)
            END >= CURRENT_DATE
          THEN CASE
           WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
           THEN cl_au.dat_ende_einschraenkung
           ELSE DATE(NULL)
           END
          ELSE NULL
          END))) BETWEEN 10 AND 12
     THEN 'IV'
     ELSE ''
     END || '/' || CAST(DATE(COALESCE(CASE
       WHEN EXTRACT(YEAR FROM CASE
          WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END) = 2001
       THEN NULL
       ELSE CASE
        WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
        THEN cl_au.dat_ende_ist
        ELSE DATE(NULL)
        END
       END, CASE
       WHEN CASE
         WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
         THEN cl_au.dat_ende_einschraenkung
         ELSE DATE(NULL)
         END >= CURRENT_DATE
       THEN CASE
        WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
        THEN cl_au.dat_ende_einschraenkung
        ELSE DATE(NULL)
        END
       ELSE NULL
       END)) AS STRING)
  ELSE NULL
  END AS dat_realisierung,
  CASE
  WHEN DATE(COALESCE(CASE
      WHEN EXTRACT(YEAR FROM cl_au.dat_start_ist) = 2001
      THEN NULL
      ELSE cl_au.dat_start_ist
      END, CASE
      WHEN CASE
        WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_start_einschraenkung) <> 2001
        THEN cl_au.dat_start_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_start_einschraenkung) <> 2001
       THEN cl_au.dat_start_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END)) <= DATE_ADD(CURRENT_DATE, INTERVAL 84 DAY)
  THEN CAST(DATE(COALESCE(CASE
      WHEN EXTRACT(YEAR FROM cl_au.dat_start_ist) = 2001
      THEN NULL
      ELSE cl_au.dat_start_ist
      END, CASE
      WHEN CASE
        WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_start_einschraenkung) <> 2001
        THEN cl_au.dat_start_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_start_einschraenkung) <> 2001
       THEN cl_au.dat_start_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END)) AS STRING)
  WHEN DATE(COALESCE(CASE
      WHEN EXTRACT(YEAR FROM cl_au.dat_start_ist) = 2001
      THEN NULL
      ELSE cl_au.dat_start_ist
      END, CASE
      WHEN CASE
        WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_start_einschraenkung) <> 2001
        THEN cl_au.dat_start_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_start_einschraenkung) <> 2001
       THEN cl_au.dat_start_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END)) <= DATE_ADD(CURRENT_DATE, INTERVAL 168 DAY)
  THEN CAST(DATE(COALESCE(CASE
      WHEN EXTRACT(YEAR FROM cl_au.dat_start_ist) = 2001
      THEN NULL
      ELSE cl_au.dat_start_ist
      END, CASE
      WHEN CASE
        WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_start_einschraenkung) <> 2001
        THEN cl_au.dat_start_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_start_einschraenkung) <> 2001
       THEN cl_au.dat_start_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END)) AS STRING)
  WHEN DATE(COALESCE(CASE
      WHEN EXTRACT(YEAR FROM cl_au.dat_start_ist) = 2001
      THEN NULL
      ELSE cl_au.dat_start_ist
      END, CASE
      WHEN CASE
        WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_start_einschraenkung) <> 2001
        THEN cl_au.dat_start_einschraenkung
        ELSE DATE(NULL)
        END >= CURRENT_DATE
      THEN CASE
       WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_start_einschraenkung) <> 2001
       THEN cl_au.dat_start_einschraenkung
       ELSE DATE(NULL)
       END
      ELSE NULL
      END)) <= IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 18 MONTH)), DATE_ADD(CURRENT_DATE
     ,INTERVAL 18 MONTH))
  THEN CASE
     WHEN EXTRACT(MONTH FROM DATE(COALESCE(CASE
          WHEN EXTRACT(YEAR FROM cl_au.dat_start_ist) = 2001
          THEN NULL
          ELSE cl_au.dat_start_ist
          END, CASE
          WHEN CASE
            WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_start_einschraenkung) <>
              2001
            THEN cl_au.dat_start_einschraenkung
            ELSE DATE(NULL)
            END >= CURRENT_DATE
          THEN CASE
           WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_start_einschraenkung) <> 2001
             
           THEN cl_au.dat_start_einschraenkung
           ELSE DATE(NULL)
           END
          ELSE NULL
          END))) BETWEEN 1 AND 3
     THEN 'I'
     WHEN EXTRACT(MONTH FROM DATE(COALESCE(CASE
          WHEN EXTRACT(YEAR FROM cl_au.dat_start_ist) = 2001
          THEN NULL
          ELSE cl_au.dat_start_ist
          END, CASE
          WHEN CASE
            WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_start_einschraenkung) <>
              2001
            THEN cl_au.dat_start_einschraenkung
            ELSE DATE(NULL)
            END >= CURRENT_DATE
          THEN CASE
           WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_start_einschraenkung) <> 2001
             
           THEN cl_au.dat_start_einschraenkung
           ELSE DATE(NULL)
           END
          ELSE NULL
          END))) BETWEEN 4 AND 6
     THEN 'II'
     WHEN EXTRACT(MONTH FROM DATE(COALESCE(CASE
          WHEN EXTRACT(YEAR FROM cl_au.dat_start_ist) = 2001
          THEN NULL
          ELSE cl_au.dat_start_ist
          END, CASE
          WHEN CASE
            WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_start_einschraenkung) <>
              2001
            THEN cl_au.dat_start_einschraenkung
            ELSE DATE(NULL)
            END >= CURRENT_DATE
          THEN CASE
           WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_start_einschraenkung) <> 2001
             
           THEN cl_au.dat_start_einschraenkung
           ELSE DATE(NULL)
           END
          ELSE NULL
          END))) BETWEEN 7 AND 9
     THEN 'III'
     WHEN EXTRACT(MONTH FROM DATE(COALESCE(CASE
          WHEN EXTRACT(YEAR FROM cl_au.dat_start_ist) = 2001
          THEN NULL
          ELSE cl_au.dat_start_ist
          END, CASE
          WHEN CASE
            WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_start_einschraenkung) <>
              2001
            THEN cl_au.dat_start_einschraenkung
            ELSE DATE(NULL)
            END >= CURRENT_DATE
          THEN CASE
           WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_start_einschraenkung) <> 2001
             
           THEN cl_au.dat_start_einschraenkung
           ELSE DATE(NULL)
           END
          ELSE NULL
          END))) BETWEEN 10 AND 12
     THEN 'IV'
     ELSE ''
     END || '/' || CAST(DATE(COALESCE(CASE
       WHEN EXTRACT(YEAR FROM cl_au.dat_start_ist) = 2001
       THEN NULL
       ELSE cl_au.dat_start_ist
       END, CASE
       WHEN CASE
         WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_start_einschraenkung) <> 2001
         THEN cl_au.dat_start_einschraenkung
         ELSE DATE(NULL)
         END >= CURRENT_DATE
       THEN CASE
        WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_start_einschraenkung) <> 2001
        THEN cl_au.dat_start_einschraenkung
        ELSE DATE(NULL)
        END
       ELSE NULL
       END)) AS STRING)
  ELSE NULL
  END AS dat_start_realisierung,
  CASE
  WHEN CASE
    WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
    THEN cl_au.dat_ende_ist
    ELSE DATE(NULL)
    END IS NULL AND CASE
    WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END IS NOT NULL
  THEN CAST(CASE
    WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_einschraenkung) <> 2001
    THEN cl_au.dat_ende_einschraenkung
    ELSE DATE(NULL)
    END AS STRING)
  WHEN CASE
   WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
   THEN cl_au.dat_ende_ist
   ELSE DATE(NULL)
   END IS NOT NULL
  THEN CAST(CASE
    WHEN cl_au.dat_ende_ist IS NOT NULL AND EXTRACT(YEAR FROM cl_au.dat_ende_ist) <> 2001
    THEN cl_au.dat_ende_ist
    ELSE DATE(NULL)
    END AS STRING)
  ELSE NULL
  END AS dat_soll_monat,
 cl_au.ref_monat
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
     CP.cpr_systemstatus1_id,
     CP.cpr_systemstatus3_id,
     CP.cpr_systemstatus2_id,
     CP.cpr_suchfeld_id,
     CURRENT_DATE AS dat_vorhersage_start,
     CURRENT_DATE AS dat_vorhersage_ende,
     '' AS dat_realisierung,
     '' AS dat_start_realisierung,
     '' AS dat_soll_monat,
     T.ref_monat
    FROM kfl_production_dbp_view.v_cpr_cl_punkt_per_1 AS CP
     LEFT JOIN kfl_production_dbp_msi_view_ios.mv_ref_monat_1 AS T ON T.ref_monat <= CURRENT_DATE
     INNER JOIN kfl_production_dbp_view.v_cpr_checkliste_per_1 AS CL ON CP.cpr_checkliste_id = CL.cpr_checkliste_id AND T
       .ref_monat BETWEEN CL.dat_von AND CL.dat_bis
     INNER JOIN kfl_production_dbp_view.v_l_cpr_suchfeld_1 AS SU ON CP.cpr_suchfeld_id = SU.cpr_suchfeld_id
    WHERE T.ref_monat BETWEEN CP.dat_von AND CP.dat_bis
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
      WHEN SU.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN', 'CPR_REALISIERUNG')
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
     AU.cpr_systemstatus1_id,
     AU.cpr_systemstatus3_id,
     AU.cpr_systemstatus2_id,
     SU.cpr_suchfeld_id,
     CURRENT_DATE AS dat_vorhersage_start,
     CURRENT_DATE AS dat_vorhersage_ende,
     '' AS dat_realisierung,
     '' AS dat_start_realisierung,
     '' AS dat_soll_monat,
     T.ref_monat
    FROM kfl_production_dbp_view.v_cpr_aufgabe_per_1 AS AU
     LEFT JOIN kfl_production_dbp_msi_view_ios.mv_ref_monat_1 AS T ON T.ref_monat <= CURRENT_DATE
     INNER JOIN kfl_production_dbp_view.v_l_cpr_suchfeld_1 AS SU ON AU.cpr_suchfeld_id = SU.cpr_suchfeld_id
    WHERE T.ref_monat BETWEEN AU.dat_von AND AU.dat_bis)
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
    AU.cpr_systemstatus1_id,
    AU.cpr_systemstatus3_id,
    AU.cpr_systemstatus2_id,
    SU.cpr_suchfeld_id,
    CURRENT_DATE AS dat_vorhersage_start,
    CURRENT_DATE AS dat_vorhersage_ende,
    '' AS dat_realisierung,
    '' AS dat_start_realisierung,
    '' AS dat_soll_monat,
    T.ref_monat
   FROM kfl_production_dbp_view.v_cpr_aufgabe_per_1 AS AU
    INNER JOIN kfl_production_dbp_view.v_l_cpr_suchfeld_1 AS SU ON AU.cpr_suchfeld_id = SU.cpr_suchfeld_id
    LEFT JOIN kfl_production_dbp_msi_view_ios.mv_ref_monat_1 AS T ON T.ref_monat <= CURRENT_DATE
   WHERE T.ref_monat BETWEEN AU.dat_von AND AU.dat_bis
    AND SU.cpr_suchfeld = 'CPR_BAURECHTSVERFAHREN') AS cl_au
 INNER JOIN kfl_production_dbp_view.v_cpr_phase_per_1 AS PH ON cl_au.projekt_phase_id = PH.projekt_phase_id AND cl_au.ref_monat
   BETWEEN PH.dat_von AND PH.dat_bis
 INNER JOIN kfl_production_dbp_view.v_cpr_projekt_per_1 AS PR ON PH.projekt_id = PR.projekt_id AND cl_au.ref_monat BETWEEN
   PR.dat_von AND PR.dat_bis;