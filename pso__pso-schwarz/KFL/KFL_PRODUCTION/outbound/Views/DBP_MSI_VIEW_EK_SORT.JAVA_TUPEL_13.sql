CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.java_tupel_13 AS SELECT T1.mandant_id,
 T1.kjwo_13,
 T1.matching_id,
 T2.a5_owg_id AS a5,
 T2.a7_wg_id AS a7,
   CASE
   WHEN T2.a7_wg_id < 10
   THEN '00' || CAST(T2.a7_wg_id AS STRING)
   WHEN T2.a7_wg_id < 100
   THEN '0' || CAST(T2.a7_wg_id AS STRING)
   ELSE CAST(T2.a7_wg_id AS STRING)
   END || CASE
   WHEN T2.wug_id < 10
   THEN '00' || CAST(T2.wug_id AS STRING)
   WHEN T2.wug_id < 100
   THEN '0' || CAST(T2.wug_id AS STRING)
   ELSE CAST(T2.wug_id AS STRING)
   END AS a9,
 T2.wug_id,
 CAST(CASE
    WHEN SUM(T1.kassenumsatz_af_kl_absolut_netto) = 0
    THEN NULL
    ELSE SUM(T1.kassenumsatz_af_kl_absolut_netto)
    END / CASE
    WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af) = 0
    THEN NULL
    ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af)
    END AS NUMERIC) AS e284,
 CAST((CASE
        WHEN SUM(T1.kassenumsatz_af_kl_absolut_netto) = 0
        THEN NULL
        ELSE SUM(T1.kassenumsatz_af_kl_absolut_netto)
        END / CASE
        WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af) = 0
        THEN NULL
        ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af)
        END - CASE
       WHEN CASE
          WHEN SUM(T1.kassenumsatz_af_kl_absolut_netto_vj) = 0
          THEN NULL
          ELSE SUM(T1.kassenumsatz_af_kl_absolut_netto_vj)
          END / CASE
          WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0
          THEN NULL
          ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af_vj)
          END = 0
       THEN NULL
       ELSE CASE
         WHEN SUM(T1.kassenumsatz_af_kl_absolut_netto_vj) = 0
         THEN NULL
         ELSE SUM(T1.kassenumsatz_af_kl_absolut_netto_vj)
         END / CASE
         WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0
         THEN NULL
         ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af_vj)
         END
       END) / (CASE
       WHEN SUM(T1.kassenumsatz_af_kl_absolut_netto_vj) = 0
       THEN NULL
       ELSE SUM(T1.kassenumsatz_af_kl_absolut_netto_vj)
       END / CASE
       WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0
       THEN NULL
       ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af_vj)
       END) * 100 AS NUMERIC) AS e288,
 CAST(CASE
    WHEN SUM(T1.absatz_af_kl) = 0
    THEN NULL
    ELSE SUM(T1.absatz_af_kl)
    END / CASE
    WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af) = 0
    THEN NULL
    ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af)
    END AS NUMERIC) AS e250,
 CAST((CASE
        WHEN SUM(T1.absatz_af_kl) = 0
        THEN NULL
        ELSE SUM(T1.absatz_af_kl)
        END / CASE
        WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af) = 0
        THEN NULL
        ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af)
        END - CASE
       WHEN CASE
          WHEN SUM(T1.absatz_af_kl_vj) = 0
          THEN NULL
          ELSE SUM(T1.absatz_af_kl_vj)
          END / CASE
          WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0
          THEN NULL
          ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af_vj)
          END = 0
       THEN NULL
       ELSE CASE
         WHEN SUM(T1.absatz_af_kl_vj) = 0
         THEN NULL
         ELSE SUM(T1.absatz_af_kl_vj)
         END / CASE
         WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0
         THEN NULL
         ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af_vj)
         END
       END) / CASE
     WHEN SUM(T1.absatz_af_kl_vj) / CASE
        WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0
        THEN NULL
        ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af_vj)
        END = 0
     THEN NULL
     ELSE SUM(T1.absatz_af_kl_vj) / CASE
       WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0
       THEN NULL
       ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af_vj)
       END
     END * 100 AS NUMERIC) AS e268,
 ROUND(CAST(SUM(T1.absatz_kl) AS NUMERIC), 0) AS e248,
 ROUND(CAST(SUM(T1.absatz_sst1) AS NUMERIC), 0) AS e196,
 ROUND(CAST(SUM(T1.absatz_sst2) AS NUMERIC), 0) AS e198,
 ROUND(CAST(SUM(T1.absatz_sst3) AS NUMERIC), 0) AS e200,
 ROUND(CAST(SUM(T1.absatz_sst4) AS NUMERIC), 0) AS e202,
 ROUND(CAST(SUM(T1.absatz_sst5) AS NUMERIC), 0) AS e204,
 ROUND(CAST(SUM(T1.absatz_sst6) AS NUMERIC), 0) AS e206,
 ROUND(CAST(SUM(T1.absatz_sst7) AS NUMERIC), 0) AS e208,
 ROUND(CAST(SUM(T1.absatz_ksst1) AS NUMERIC), 0) AS e182,
 ROUND(CAST(SUM(T1.absatz_ksst2) AS NUMERIC), 0) AS e184,
 ROUND(CAST(SUM(T1.absatz_ksst3) AS NUMERIC), 0) AS e186,
 ROUND(CAST(SUM(T1.absatz_ksst4) AS NUMERIC), 0) AS e188,
 ROUND(CAST(SUM(T1.absatz_ksst5) AS NUMERIC), 0) AS e190,
 ROUND(CAST(SUM(T1.absatz_ksst6) AS NUMERIC), 0) AS e192,
 ROUND(CAST(SUM(T1.absatz_ksst7) AS NUMERIC), 0) AS e194,
 ROUND(CAST(SUM(T1.absatz_ost_basis) AS NUMERIC), 0) AS e210,
 ROUND(CAST(SUM(T1.absatz_ost_gross) AS NUMERIC), 0) AS e212,
 ROUND(CAST(SUM(T1.absatz_sued_ost) AS NUMERIC), 0) AS e214,
 ROUND(CAST(SUM(T1.absatz_sued_west) AS NUMERIC), 0) AS e216,
 ROUND(CAST(SUM(T1.absatz_west) AS NUMERIC), 0) AS e218,
 ROUND(CAST(SUM(T1.absatz_nord) AS NUMERIC), 0) AS e220,
 CAST(CASE
    WHEN SUM(T1.absatz_sst1) = 0
    THEN NULL
    ELSE SUM(T1.absatz_sst1)
    END / CASE
    WHEN SUM(T1.markt_wochen_sst1) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_sst1)
    END AS NUMERIC) AS e197,
 CAST(CASE
    WHEN SUM(T1.absatz_sst2) = 0
    THEN NULL
    ELSE SUM(T1.absatz_sst2)
    END / CASE
    WHEN SUM(T1.markt_wochen_sst2) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_sst2)
    END AS NUMERIC) AS e199,
 CAST(CASE
    WHEN SUM(T1.absatz_sst3) = 0
    THEN NULL
    ELSE SUM(T1.absatz_sst3)
    END / CASE
    WHEN SUM(T1.markt_wochen_sst3) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_sst3)
    END AS NUMERIC) AS e201,
 CAST(CASE
    WHEN SUM(T1.absatz_sst4) = 0
    THEN NULL
    ELSE SUM(T1.absatz_sst4)
    END / CASE
    WHEN SUM(T1.markt_wochen_sst4) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_sst4)
    END AS NUMERIC) AS e203,
 CAST(CASE
    WHEN SUM(T1.absatz_sst5) = 0
    THEN NULL
    ELSE SUM(T1.absatz_sst5)
    END / CASE
    WHEN SUM(T1.markt_wochen_sst5) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_sst5)
    END AS NUMERIC) AS e205,
 CAST(CASE
    WHEN SUM(T1.absatz_sst6) = 0
    THEN NULL
    ELSE SUM(T1.absatz_sst6)
    END / CASE
    WHEN SUM(T1.markt_wochen_sst6) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_sst6)
    END AS NUMERIC) AS e207,
 CAST(CASE
    WHEN SUM(T1.absatz_sst7) = 0
    THEN NULL
    ELSE SUM(T1.absatz_sst7)
    END / CASE
    WHEN SUM(T1.markt_wochen_sst7) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_sst7)
    END AS NUMERIC) AS e209,
 CAST(CASE
    WHEN SUM(T1.absatz_ksst1) = 0
    THEN NULL
    ELSE SUM(T1.absatz_ksst1)
    END / CASE
    WHEN SUM(T1.markt_wochen_ksst1) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_ksst1)
    END AS NUMERIC) AS e183,
 CAST(CASE
    WHEN SUM(T1.absatz_ksst2) = 0
    THEN NULL
    ELSE SUM(T1.absatz_ksst2)
    END / CASE
    WHEN SUM(T1.markt_wochen_ksst2) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_ksst2)
    END AS NUMERIC) AS e185,
 CAST(CASE
    WHEN SUM(T1.absatz_ksst3) = 0
    THEN NULL
    ELSE SUM(T1.absatz_ksst3)
    END / CASE
    WHEN SUM(T1.markt_wochen_ksst3) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_ksst3)
    END AS NUMERIC) AS e187,
 CAST(CASE
    WHEN SUM(T1.absatz_ksst4) = 0
    THEN NULL
    ELSE SUM(T1.absatz_ksst4)
    END / CASE
    WHEN SUM(T1.markt_wochen_ksst4) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_ksst4)
    END AS NUMERIC) AS e189,
 CAST(CASE
    WHEN SUM(T1.absatz_ksst5) = 0
    THEN NULL
    ELSE SUM(T1.absatz_ksst5)
    END / CASE
    WHEN SUM(T1.markt_wochen_ksst5) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_ksst5)
    END AS NUMERIC) AS e191,
 CAST(CASE
    WHEN SUM(T1.absatz_ksst6) = 0
    THEN NULL
    ELSE SUM(T1.absatz_ksst6)
    END / CASE
    WHEN SUM(T1.markt_wochen_ksst6) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_ksst6)
    END AS NUMERIC) AS e193,
 CAST(CASE
    WHEN SUM(T1.absatz_ksst7) = 0
    THEN NULL
    ELSE SUM(T1.absatz_ksst7)
    END / CASE
    WHEN SUM(T1.markt_wochen_ksst7) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_ksst7)
    END AS NUMERIC) AS e195,
 CAST(CASE
    WHEN SUM(T1.absatz_ost_basis) = 0
    THEN NULL
    ELSE SUM(T1.absatz_ost_basis)
    END / CASE
    WHEN SUM(T1.markt_wochen_ost_basis) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_ost_basis)
    END AS NUMERIC) AS e211,
 CAST(CASE
    WHEN SUM(T1.absatz_ost_gross) = 0
    THEN NULL
    ELSE SUM(T1.absatz_ost_gross)
    END / CASE
    WHEN SUM(T1.markt_wochen_ost_gross) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_ost_gross)
    END AS NUMERIC) AS e213,
 CAST(CASE
    WHEN SUM(T1.absatz_sued_ost) = 0
    THEN NULL
    ELSE SUM(T1.absatz_sued_ost)
    END / CASE
    WHEN SUM(T1.markt_wochen_sued_ost) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_sued_ost)
    END AS NUMERIC) AS e215,
 CAST(CASE
    WHEN SUM(T1.absatz_sued_west) = 0
    THEN NULL
    ELSE SUM(T1.absatz_sued_west)
    END / CASE
    WHEN SUM(T1.markt_wochen_sued_west) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_sued_west)
    END AS NUMERIC) AS e217,
 CAST(CASE
    WHEN SUM(T1.absatz_west) = 0
    THEN NULL
    ELSE SUM(T1.absatz_west)
    END / CASE
    WHEN SUM(T1.markt_wochen_west) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_west)
    END AS NUMERIC) AS e219,
 CAST(CASE
    WHEN SUM(T1.absatz_nord) = 0
    THEN NULL
    ELSE SUM(T1.absatz_nord)
    END / CASE
    WHEN SUM(T1.markt_wochen_nord) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_nord)
    END AS NUMERIC) AS e221,
 ROUND(CAST(CAST(SUM(T1.anzahl_markt_wochen_kombis_abverkauf_mit_listung) AS NUMERIC) / CASE
      WHEN SUM(T1.anzahl_markt_wochen_kombis_listung) = 0
      THEN NULL
      ELSE SUM(T1.anzahl_markt_wochen_kombis_listung)
      END * 100 AS NUMERIC), 1) AS e363,
 ROUND(CAST(SUM(T1.rohertrag_ekmep_olk_4n) AS NUMERIC), 0) AS e254,
 ROUND(CAST((SUM(T1.kassenumsatz_kl_absolut_netto) - SUM(T1.rohertrag_ekmep_olk_4n)) / CASE
     WHEN SUM(T1.absatz_kl) = 0
     THEN NULL
     ELSE SUM(T1.absatz_kl)
     END AS NUMERIC), 2) AS e260,
 CAST(CASE
    WHEN SUM(T1.absatz_sa_kl) = 0
    THEN NULL
    ELSE SUM(T1.absatz_sa_kl)
    END / CASE
    WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0
    THEN NULL
    ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa)
    END AS NUMERIC) AS e264,
 CAST((CASE
        WHEN SUM(T1.absatz_sa_kl) = 0
        THEN NULL
        ELSE SUM(T1.absatz_sa_kl)
        END / CASE
        WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0
        THEN NULL
        ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa)
        END - CASE
       WHEN CASE
          WHEN SUM(T1.absatz_sa_kl_vj) = 0
          THEN NULL
          ELSE SUM(T1.absatz_sa_kl_vj)
          END / CASE
          WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0
          THEN NULL
          ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj)
          END = 0
       THEN NULL
       ELSE CASE
         WHEN SUM(T1.absatz_sa_kl_vj) = 0
         THEN NULL
         ELSE SUM(T1.absatz_sa_kl_vj)
         END / CASE
         WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0
         THEN NULL
         ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj)
         END
       END) / (CASE
       WHEN SUM(T1.absatz_sa_kl_vj) = 0
       THEN NULL
       ELSE SUM(T1.absatz_sa_kl_vj)
       END / CASE
       WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0
       THEN NULL
       ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj)
       END) * 100 AS NUMERIC) AS e272,
 CAST(CASE
     WHEN SUM(T1.absatz_sa_kl) = 0
     THEN NULL
     ELSE SUM(T1.absatz_sa_kl)
     END / CASE
     WHEN SUM(T1.absatz_kl) = 0
     THEN NULL
     ELSE SUM(T1.absatz_kl)
     END * 100 AS NUMERIC) AS e251,
 NULL AS e351,
 NULL AS e355,
 CAST(CASE
     WHEN SUM(T1.rohertrag_ekmep_olk_4n) - CASE
        WHEN SUM(T1.rohertrag_ekmep_olk_4n_vj) = 0
        THEN NULL
        ELSE SUM(T1.rohertrag_ekmep_olk_4n_vj)
        END = 0
     THEN NULL
     ELSE SUM(T1.rohertrag_ekmep_olk_4n) - CASE
       WHEN SUM(T1.rohertrag_ekmep_olk_4n_vj) = 0
       THEN NULL
       ELSE SUM(T1.rohertrag_ekmep_olk_4n_vj)
       END
     END / CASE
     WHEN SUM(T1.rohertrag_ekmep_olk_4n_vj) = 0
     THEN NULL
     ELSE SUM(T1.rohertrag_ekmep_olk_4n_vj)
     END * 100 AS NUMERIC) AS e255,
 CAST(CASE
    WHEN SUM(T1.rohertrag_ekmep_olk_4n_af) = 0
    THEN NULL
    ELSE SUM(T1.rohertrag_ekmep_olk_4n_af)
    END / CASE
    WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af) = 0
    THEN NULL
    ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af)
    END AS NUMERIC) AS e296,
 CAST(CASE
    WHEN SUM(T1.rohertrag_ekmep_olk_4n_sa) = 0
    THEN NULL
    ELSE SUM(T1.rohertrag_ekmep_olk_4n_sa)
    END / CASE
    WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0
    THEN NULL
    ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa)
    END AS NUMERIC) AS e300,
 CAST((CASE
        WHEN SUM(T1.rohertrag_ekmep_olk_4n_af) = 0
        THEN NULL
        ELSE SUM(T1.rohertrag_ekmep_olk_4n_af)
        END / CASE
        WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af) = 0
        THEN NULL
        ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af)
        END - CASE
       WHEN CASE
          WHEN SUM(T1.rohertrag_ekmep_olk_4n_af_vj) = 0
          THEN NULL
          ELSE SUM(T1.rohertrag_ekmep_olk_4n_af_vj)
          END / CASE
          WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0
          THEN NULL
          ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af_vj)
          END = 0
       THEN NULL
       ELSE CASE
         WHEN SUM(T1.rohertrag_ekmep_olk_4n_af_vj) = 0
         THEN NULL
         ELSE SUM(T1.rohertrag_ekmep_olk_4n_af_vj)
         END / CASE
         WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0
         THEN NULL
         ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af_vj)
         END
       END) / (CASE
       WHEN SUM(T1.rohertrag_ekmep_olk_4n_af_vj) = 0
       THEN NULL
       ELSE SUM(T1.rohertrag_ekmep_olk_4n_af_vj)
       END / CASE
       WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0
       THEN NULL
       ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af_vj)
       END) * 100 AS NUMERIC) AS e304,
 CAST((CASE
        WHEN SUM(T1.rohertrag_ekmep_olk_4n_sa) = 0
        THEN NULL
        ELSE SUM(T1.rohertrag_ekmep_olk_4n_sa)
        END / CASE
        WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0
        THEN NULL
        ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa)
        END - CASE
       WHEN CASE
          WHEN SUM(T1.rohertrag_ekmep_olk_4n_sa_vj) = 0
          THEN NULL
          ELSE SUM(T1.rohertrag_ekmep_olk_4n_sa_vj)
          END / CASE
          WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0
          THEN NULL
          ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj)
          END = 0
       THEN NULL
       ELSE CASE
         WHEN SUM(T1.rohertrag_ekmep_olk_4n_sa_vj) = 0
         THEN NULL
         ELSE SUM(T1.rohertrag_ekmep_olk_4n_sa_vj)
         END / CASE
         WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0
         THEN NULL
         ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj)
         END
       END) / (CASE
       WHEN SUM(T1.rohertrag_ekmep_olk_4n_sa_vj) = 0
       THEN NULL
       ELSE SUM(T1.rohertrag_ekmep_olk_4n_sa_vj)
       END / CASE
       WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0
       THEN NULL
       ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj)
       END) * 100 AS NUMERIC) AS e308,
 CAST(CASE
    WHEN SUM(T1.kassenumsatz_af_kl_absolut_brutto) = 0
    THEN NULL
    ELSE SUM(T1.kassenumsatz_af_kl_absolut_brutto)
    END / CASE
    WHEN SUM(T1.absatz_af_kl) = 0
    THEN NULL
    ELSE SUM(T1.absatz_af_kl)
    END AS NUMERIC) AS e375,
 CAST(CASE
     WHEN SUM(T1.rohertrag_ekmep_olk_4n) = 0
     THEN NULL
     ELSE SUM(T1.rohertrag_ekmep_olk_4n)
     END / CASE
     WHEN SUM(T1.kassenumsatz_kl_absolut_netto) = 0
     THEN NULL
     ELSE SUM(T1.kassenumsatz_kl_absolut_netto)
     END * 100 AS NUMERIC) AS e256,
 CAST(CASE
    WHEN SUM(T1.rohertrag_ekmep_olk_4n_af) = 0
    THEN NULL
    ELSE SUM(T1.rohertrag_ekmep_olk_4n_af)
    END / CASE
    WHEN SUM(T1.kassenumsatz_af_kl_absolut_netto) = 0
    THEN NULL
    ELSE SUM(T1.kassenumsatz_af_kl_absolut_netto)
    END AS NUMERIC) AS e257,
 CAST(CASE
    WHEN SUM(T1.rohertrag_ekmep_olk_4n_sa) = 0
    THEN NULL
    ELSE SUM(T1.rohertrag_ekmep_olk_4n_sa)
    END / CASE
    WHEN SUM(T1.kassenumsatz_sa_kl_absolut_netto) = 0
    THEN NULL
    ELSE SUM(T1.kassenumsatz_sa_kl_absolut_netto)
    END AS NUMERIC) AS e312,
 CAST((CASE
       WHEN SUM(T1.absatz_kl) = 0
       THEN NULL
       ELSE SUM(T1.absatz_kl)
       END - CASE
       WHEN SUM(T1.absatz_kl_vj) = 0
       THEN NULL
       ELSE SUM(T1.absatz_kl_vj)
       END) / CASE
     WHEN SUM(T1.absatz_kl_vj) = 0
     THEN NULL
     ELSE SUM(T1.absatz_kl_vj)
     END * 100 AS NUMERIC) AS e249,
 ROUND(CAST(SUM(T1.kassenumsatz_kl_absolut_netto) AS NUMERIC), 0) AS e252,
 CAST(CASE
    WHEN SUM(T1.kassenumsatz_sa_kl_absolut_netto) = 0
    THEN NULL
    ELSE SUM(T1.kassenumsatz_sa_kl_absolut_netto)
    END / CASE
    WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0
    THEN NULL
    ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa)
    END AS NUMERIC) AS e280,
 CAST((CASE
        WHEN SUM(T1.kassenumsatz_sa_kl_absolut_netto) = 0
        THEN NULL
        ELSE SUM(T1.kassenumsatz_sa_kl_absolut_netto)
        END / CASE
        WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0
        THEN NULL
        ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa)
        END - CASE
       WHEN CASE
          WHEN SUM(T1.kassenumsatz_sa_kl_absolut_netto_vj) = 0
          THEN NULL
          ELSE SUM(T1.kassenumsatz_sa_kl_absolut_netto_vj)
          END / CASE
          WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0
          THEN NULL
          ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj)
          END = 0
       THEN NULL
       ELSE CASE
         WHEN SUM(T1.kassenumsatz_sa_kl_absolut_netto_vj) = 0
         THEN NULL
         ELSE SUM(T1.kassenumsatz_sa_kl_absolut_netto_vj)
         END / CASE
         WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0
         THEN NULL
         ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj)
         END
       END) / (CASE
       WHEN SUM(T1.kassenumsatz_sa_kl_absolut_netto_vj) = 0
       THEN NULL
       ELSE SUM(T1.kassenumsatz_sa_kl_absolut_netto_vj)
       END / CASE
       WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0
       THEN NULL
       ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa_vj)
       END) * 100 AS NUMERIC) AS e292,
 CAST((CASE
       WHEN SUM(T1.kassenumsatz_kl_absolut_netto) = 0
       THEN NULL
       ELSE SUM(T1.kassenumsatz_kl_absolut_netto)
       END - CASE
       WHEN SUM(T1.kassenumsatz_kl_absolut_netto_vj) = 0
       THEN NULL
       ELSE SUM(T1.kassenumsatz_kl_absolut_netto_vj)
       END) / CASE
     WHEN SUM(T1.kassenumsatz_kl_absolut_netto_vj) = 0
     THEN NULL
     ELSE SUM(T1.kassenumsatz_kl_absolut_netto_vj)
     END * 100 AS NUMERIC) AS e253,
 ROUND(CAST(SUM(T1.kassenumsatz_kl_absolut_brutto) AS NUMERIC), 0) AS e276,
 ROUND(CAST(SUM(T1.totalabschriften_wert_netto_absolut) AS NUMERIC), 0) AS e258,
 ROUND(CAST(SUM(T1.preisabschriften_preisanderungen_wert_netto_absolut) AS NUMERIC), 0) AS e316,
 CAST(CASE
     WHEN SUM(T1.preisabschriften_preisanderungen_wert_netto_absolut) = 0
     THEN NULL
     ELSE SUM(T1.preisabschriften_preisanderungen_wert_netto_absolut)
     END / CASE
     WHEN SUM(T1.kassenumsatz_kl_absolut_netto) = 0
     THEN NULL
     ELSE SUM(T1.kassenumsatz_kl_absolut_netto)
     END * 100 AS NUMERIC) AS e320,
 CAST(CASE
     WHEN SUM(T1.totalabschriften_wert_netto_absolut) = 0
     THEN NULL
     ELSE SUM(T1.totalabschriften_wert_netto_absolut)
     END / CASE
     WHEN SUM(T1.kassenumsatz_kl_absolut_netto) = 0
     THEN NULL
     ELSE SUM(T1.kassenumsatz_kl_absolut_netto)
     END * 100 AS NUMERIC) AS e259,
 CAST((CASE
        WHEN SUM(T1.totalabschriften_wert_netto_absolut) = 0
        THEN NULL
        ELSE SUM(T1.totalabschriften_wert_netto_absolut)
        END / CASE
        WHEN SUM(T1.kassenumsatz_kl_absolut_netto) = 0
        THEN NULL
        ELSE SUM(T1.kassenumsatz_kl_absolut_netto)
        END - CASE
       WHEN CASE
          WHEN SUM(T1.totalabschriften_wert_netto_absolut_vj) = 0
          THEN NULL
          ELSE SUM(T1.totalabschriften_wert_netto_absolut_vj)
          END / CASE
          WHEN SUM(T1.kassenumsatz_kl_absolut_netto_vj) = 0
          THEN NULL
          ELSE SUM(T1.kassenumsatz_kl_absolut_netto_vj)
          END = 0
       THEN NULL
       ELSE CASE
         WHEN SUM(T1.totalabschriften_wert_netto_absolut_vj) = 0
         THEN NULL
         ELSE SUM(T1.totalabschriften_wert_netto_absolut_vj)
         END / CASE
         WHEN SUM(T1.kassenumsatz_kl_absolut_netto_vj) = 0
         THEN NULL
         ELSE SUM(T1.kassenumsatz_kl_absolut_netto_vj)
         END
       END) / (CASE
       WHEN SUM(T1.totalabschriften_wert_netto_absolut_vj) = 0
       THEN NULL
       ELSE SUM(T1.totalabschriften_wert_netto_absolut_vj)
       END / CASE
       WHEN SUM(T1.kassenumsatz_kl_absolut_netto_vj) = 0
       THEN NULL
       ELSE SUM(T1.kassenumsatz_kl_absolut_netto_vj)
       END) * 100 AS NUMERIC) AS e328,
 CAST((CASE
        WHEN SUM(T1.preisabschriften_preisanderungen_wert_netto_absolut) = 0
        THEN NULL
        ELSE SUM(T1.preisabschriften_preisanderungen_wert_netto_absolut)
        END / CASE
        WHEN SUM(T1.kassenumsatz_kl_absolut_netto) = 0
        THEN NULL
        ELSE SUM(T1.kassenumsatz_kl_absolut_netto)
        END - CASE
       WHEN CASE
          WHEN SUM(T1.preisabschriften_preisanderungen_wert_netto_absolut_vj) = 0
          THEN NULL
          ELSE SUM(T1.preisabschriften_preisanderungen_wert_netto_absolut_vj)
          END / CASE
          WHEN SUM(T1.kassenumsatz_kl_absolut_netto_vj) = 0
          THEN NULL
          ELSE SUM(T1.kassenumsatz_kl_absolut_netto_vj)
          END = 0
       THEN NULL
       ELSE CASE
         WHEN SUM(T1.preisabschriften_preisanderungen_wert_netto_absolut_vj) = 0
         THEN NULL
         ELSE SUM(T1.preisabschriften_preisanderungen_wert_netto_absolut_vj)
         END / CASE
         WHEN SUM(T1.kassenumsatz_kl_absolut_netto_vj) = 0
         THEN NULL
         ELSE SUM(T1.kassenumsatz_kl_absolut_netto_vj)
         END
       END) / (CASE
       WHEN SUM(T1.preisabschriften_preisanderungen_wert_netto_absolut_vj) = 0
       THEN NULL
       ELSE SUM(T1.preisabschriften_preisanderungen_wert_netto_absolut_vj)
       END / CASE
       WHEN SUM(T1.kassenumsatz_kl_absolut_netto_vj) = 0
       THEN NULL
       ELSE SUM(T1.kassenumsatz_kl_absolut_netto_vj)
       END) * 100 AS NUMERIC) AS e332,
 ROUND(CAST(SUM(T1.totalabschriften_wert_netto_absolut) / CASE
      WHEN SUM(T1.kassenumsatz_kl_absolut_netto) = 0
      THEN NULL
      ELSE SUM(T1.kassenumsatz_kl_absolut_netto)
      END / CASE
     WHEN SUM(T1.totalabschriften_wert_netto_absolut_wg) / CASE
        WHEN SUM(T1.kassenumsatz_kl_absolut_netto_wg) = 0
        THEN NULL
        ELSE SUM(T1.kassenumsatz_kl_absolut_netto_wg)
        END = 0
     THEN NULL
     ELSE SUM(T1.totalabschriften_wert_netto_absolut_wg) / CASE
       WHEN SUM(T1.kassenumsatz_kl_absolut_netto_wg) = 0
       THEN NULL
       ELSE SUM(T1.kassenumsatz_kl_absolut_netto_wg)
       END
     END AS NUMERIC), 2) AS e324
FROM kfl_production_dbp_msi_v_view.v_tupel_13_wochen AS T1
 INNER JOIN kfl_production_dbp_view.v_woche AS X1 ON T1.kjwo_13 = X1.kjwo
 INNER JOIN kfl_production_dbp_view.v_woche AS X2 ON X1.akt_wo + 2 = X2.akt_wo
 INNER JOIN kfl_production_dbp_msi_v_view.v_tupel_mat AS T2 ON T1.mandant_id = T2.mandant_id AND T1.matching_id = T2.matching_id
     AND X2.kjwo = T2.a500_kjwo_update
GROUP BY T1.mandant_id,
 T1.kjwo_13,
 T1.matching_id,
 a5,
 a7,
 a9,
 T2.wug_id;