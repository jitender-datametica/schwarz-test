CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_projekt_bauabschnitt_spr_zu AS SELECT V02.projekt_id,
  CASE
  WHEN V03.cpr_suchfeld_id = 161 AND V02.teil_massn_kz > 1
  THEN V02.projekt_id || V02.projekt_phase_id
  ELSE V02.projekt_id || '0000'
  END AS bauabschnitt_id,
 COALESCE(CASE
   WHEN V03.cpr_suchfeld_id = 161 AND V02.teil_massn_kz > 1
   THEN V05.cpr_phase_bez
   ELSE V04.cpr_projekt_bez
   END, ' ') AS bauabschnitt_bez,
 COALESCE(CASE
   WHEN V03.cpr_suchfeld_id = 161 AND V02.teil_massn_kz > 1
   THEN MAX(CASE
     WHEN V05.spr_id = 22
     THEN V05.cpr_phase_langtext
     ELSE NULL
     END)
   ELSE MAX(CASE
     WHEN V04.spr_id = 22
     THEN V04.cpr_projekt_langtext
     ELSE NULL
     END)
   END, ' ') AS bauabschnitt_langtext,
 COALESCE(CASE
   WHEN V03.cpr_suchfeld_id = 161 AND V02.teil_massn_kz > 1
   THEN MAX(CASE
     WHEN V05.spr_id = 124
     THEN V05.cpr_phase_langtext
     ELSE NULL
     END)
   ELSE MAX(CASE
     WHEN V04.spr_id = 124
     THEN V04.cpr_projekt_langtext
     ELSE NULL
     END)
   END, COALESCE(CASE
    WHEN V03.cpr_suchfeld_id = 161 AND V02.teil_massn_kz > 1
    THEN MAX(CASE
      WHEN V05.spr_id = 22
      THEN V05.cpr_phase_langtext
      ELSE NULL
      END)
    ELSE MAX(CASE
      WHEN V04.spr_id = 22
      THEN V04.cpr_projekt_langtext
      ELSE NULL
      END)
    END, ' ')) AS bauabschnitt_langtext_cz,
 COALESCE(CASE
   WHEN V03.cpr_suchfeld_id = 161 AND V02.teil_massn_kz > 1
   THEN MAX(CASE
     WHEN V05.spr_id = 108
     THEN V05.cpr_phase_langtext
     ELSE NULL
     END)
   ELSE MAX(CASE
     WHEN V04.spr_id = 108
     THEN V04.cpr_projekt_langtext
     ELSE NULL
     END)
   END, COALESCE(CASE
    WHEN V03.cpr_suchfeld_id = 161 AND V02.teil_massn_kz > 1
    THEN MAX(CASE
      WHEN V05.spr_id = 22
      THEN V05.cpr_phase_langtext
      ELSE NULL
      END)
    ELSE MAX(CASE
      WHEN V04.spr_id = 22
      THEN V04.cpr_projekt_langtext
      ELSE NULL
      END)
    END, ' ')) AS bauabschnitt_langtext_sk,
 COALESCE(CASE
   WHEN V03.cpr_suchfeld_id = 161 AND V02.teil_massn_kz > 1
   THEN MAX(CASE
     WHEN V05.spr_id = 65
     THEN V05.cpr_phase_langtext
     ELSE NULL
     END)
   ELSE MAX(CASE
     WHEN V04.spr_id = 65
     THEN V04.cpr_projekt_langtext
     ELSE NULL
     END)
   END, COALESCE(CASE
    WHEN V03.cpr_suchfeld_id = 161 AND V02.teil_massn_kz > 1
    THEN MAX(CASE
      WHEN V05.spr_id = 22
      THEN V05.cpr_phase_langtext
      ELSE NULL
      END)
    ELSE MAX(CASE
      WHEN V04.spr_id = 22
      THEN V04.cpr_projekt_langtext
      ELSE NULL
      END)
    END, ' ')) AS bauabschnitt_langtext_hr,
 COALESCE(CASE
   WHEN V03.cpr_suchfeld_id = 161 AND V02.teil_massn_kz > 1
   THEN MAX(CASE
     WHEN V05.spr_id = 90
     THEN V05.cpr_phase_langtext
     ELSE NULL
     END)
   ELSE MAX(CASE
     WHEN V04.spr_id = 90
     THEN V04.cpr_projekt_langtext
     ELSE NULL
     END)
   END, COALESCE(CASE
    WHEN V03.cpr_suchfeld_id = 161 AND V02.teil_massn_kz > 1
    THEN MAX(CASE
      WHEN V05.spr_id = 22
      THEN V05.cpr_phase_langtext
      ELSE NULL
      END)
    ELSE MAX(CASE
      WHEN V04.spr_id = 22
      THEN V04.cpr_projekt_langtext
      ELSE NULL
      END)
    END, ' ')) AS bauabschnitt_langtext_pl,
 COALESCE(CASE
   WHEN V03.cpr_suchfeld_id = 161 AND V02.teil_massn_kz > 1
   THEN MAX(CASE
     WHEN V05.spr_id = 95
     THEN V05.cpr_phase_langtext
     ELSE NULL
     END)
   ELSE MAX(CASE
     WHEN V04.spr_id = 95
     THEN V04.cpr_projekt_langtext
     ELSE NULL
     END)
   END, COALESCE(CASE
    WHEN V03.cpr_suchfeld_id = 161 AND V02.teil_massn_kz > 1
    THEN MAX(CASE
      WHEN V05.spr_id = 22
      THEN V05.cpr_phase_langtext
      ELSE NULL
      END)
    ELSE MAX(CASE
      WHEN V04.spr_id = 22
      THEN V04.cpr_projekt_langtext
      ELSE NULL
      END)
    END, ' ')) AS bauabschnitt_langtext_ro,
 COALESCE(CASE
   WHEN V03.cpr_suchfeld_id = 161 AND V02.teil_massn_kz > 1
   THEN MAX(CASE
     WHEN V05.spr_id = 24
     THEN V05.cpr_phase_langtext
     ELSE NULL
     END)
   ELSE MAX(CASE
     WHEN V04.spr_id = 24
     THEN V04.cpr_projekt_langtext
     ELSE NULL
     END)
   END, COALESCE(CASE
    WHEN V03.cpr_suchfeld_id = 161 AND V02.teil_massn_kz > 1
    THEN MAX(CASE
      WHEN V05.spr_id = 22
      THEN V05.cpr_phase_langtext
      ELSE NULL
      END)
    ELSE MAX(CASE
      WHEN V04.spr_id = 22
      THEN V04.cpr_projekt_langtext
      ELSE NULL
      END)
    END, ' ')) AS bauabschnitt_langtext_en,
 COALESCE(CASE
   WHEN V03.cpr_suchfeld_id = 161 AND V02.teil_massn_kz > 1
   THEN MAX(CASE
     WHEN V05.spr_id = 18
     THEN V05.cpr_phase_langtext
     ELSE NULL
     END)
   ELSE MAX(CASE
     WHEN V04.spr_id = 18
     THEN V04.cpr_projekt_langtext
     ELSE NULL
     END)
   END, COALESCE(CASE
    WHEN V03.cpr_suchfeld_id = 161 AND V02.teil_massn_kz > 1
    THEN MAX(CASE
      WHEN V05.spr_id = 22
      THEN V05.cpr_phase_langtext
      ELSE NULL
      END)
    ELSE MAX(CASE
      WHEN V04.spr_id = 22
      THEN V04.cpr_projekt_langtext
      ELSE NULL
      END)
    END, ' ')) AS bauabschnitt_langtext_bg,
 MAX(CASE
   WHEN V04.spr_id = 22
   THEN V04.cpr_projekt_bez
   ELSE NULL
   END) AS cpr_projekt_bez_sort,
 COALESCE(MAX(CASE
    WHEN V04.spr_id = 124
    THEN V04.cpr_projekt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V04.spr_id = 22
    THEN V04.cpr_projekt_bez
    ELSE NULL
    END)) AS cpr_projekt_bez_sort_cz,
 COALESCE(MAX(CASE
    WHEN V04.spr_id = 108
    THEN V04.cpr_projekt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V04.spr_id = 22
    THEN V04.cpr_projekt_bez
    ELSE NULL
    END)) AS cpr_projekt_bez_sort_sk,
 COALESCE(MAX(CASE
    WHEN V04.spr_id = 65
    THEN V04.cpr_projekt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V04.spr_id = 22
    THEN V04.cpr_projekt_bez
    ELSE NULL
    END)) AS cpr_projekt_bez_sort_hr,
 COALESCE(MAX(CASE
    WHEN V04.spr_id = 90
    THEN V04.cpr_projekt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V04.spr_id = 22
    THEN V04.cpr_projekt_bez
    ELSE NULL
    END)) AS cpr_projekt_bez_sort_pl,
 COALESCE(MAX(CASE
    WHEN V04.spr_id = 95
    THEN V04.cpr_projekt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V04.spr_id = 22
    THEN V04.cpr_projekt_bez
    ELSE NULL
    END)) AS cpr_projekt_bez_sort_ro,
 COALESCE(MAX(CASE
    WHEN V04.spr_id = 24
    THEN V04.cpr_projekt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V04.spr_id = 22
    THEN V04.cpr_projekt_bez
    ELSE NULL
    END)) AS cpr_projekt_bez_sort_en,
 COALESCE(MAX(CASE
    WHEN V04.spr_id = 18
    THEN V04.cpr_projekt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V04.spr_id = 22
    THEN V04.cpr_projekt_bez
    ELSE NULL
    END)) AS cpr_projekt_bez_sort_bg
FROM kfl_production_dbp_view.v_cpr_phase_per AS V02
 LEFT JOIN kfl_production_dbp_view.v_cpr_aufgabe_per AS V03 ON V02.projekt_phase_id = V03.projekt_phase_id AND V03.dat_bis
    = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_cpr_projekt_spr_zu_per AS V04 ON V02.projekt_id = V04.projekt_id AND V04.dat_bis =
   DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_cpr_phase_spr_zu_per AS V05 ON V02.projekt_phase_id = V05.projekt_phase_id AND V05
   .dat_bis = DATE '9999-12-31'
WHERE V02.dat_bis = DATE '9999-12-31'
GROUP BY V02.projekt_id,
 bauabschnitt_id,
 bauabschnitt_bez,
 V03.cpr_suchfeld_id,
 V02.teil_massn_kz;