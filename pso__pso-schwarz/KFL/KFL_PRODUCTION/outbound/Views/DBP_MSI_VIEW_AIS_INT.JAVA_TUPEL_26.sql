CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.java_tupel_26 (mandant_id, kjwo_26, matching_id, a5, a7, a9,
wug_id, e283, e287, e237, e267, e235, e156, e158, e160, e162, e164, e166, e168, e142, e144, e146, e148, e150, e152, e154
, e170, e172, e174, e176, e178, e180, e157, e159, e161, e163, e165, e167, e169, e143, e145, e147, e149, e151, e153, e155
, e171, e173, e175, e177, e179, e181, e362, e241, e247, e263, e271, e238, e350, e354, e242, e295, e299, e303, e307, e374
, e243, e244, e311, e236, e239, e279, e291, e240, e275, e245, e315, e319, e246, e327, e331, e323) AS SELECT T1.mandant_id
 ,
 T1.kjwo_26,
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
    END AS NUMERIC) AS e283,
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
       END) * 100 AS NUMERIC) AS e287,
 CAST(CASE
    WHEN SUM(T1.absatz_af_kl) = 0
    THEN NULL
    ELSE SUM(T1.absatz_af_kl)
    END / CASE
    WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af) = 0
    THEN NULL
    ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af)
    END AS NUMERIC) AS e237,
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
     END * 100 AS NUMERIC) AS e267,
 ROUND(CAST(SUM(T1.absatz_kl) AS NUMERIC), 0) AS e235,
 ROUND(CAST(SUM(T1.absatz_sst1) AS NUMERIC), 0) AS e156,
 ROUND(CAST(SUM(T1.absatz_sst2) AS NUMERIC), 0) AS e158,
 ROUND(CAST(SUM(T1.absatz_sst3) AS NUMERIC), 0) AS e160,
 ROUND(CAST(SUM(T1.absatz_sst4) AS NUMERIC), 0) AS e162,
 ROUND(CAST(SUM(T1.absatz_sst5) AS NUMERIC), 0) AS e164,
 ROUND(CAST(SUM(T1.absatz_sst6) AS NUMERIC), 0) AS e166,
 ROUND(CAST(SUM(T1.absatz_sst7) AS NUMERIC), 0) AS e168,
 ROUND(CAST(SUM(T1.absatz_ksst1) AS NUMERIC), 0) AS e142,
 ROUND(CAST(SUM(T1.absatz_ksst2) AS NUMERIC), 0) AS e144,
 ROUND(CAST(SUM(T1.absatz_ksst3) AS NUMERIC), 0) AS e146,
 ROUND(CAST(SUM(T1.absatz_ksst4) AS NUMERIC), 0) AS e148,
 ROUND(CAST(SUM(T1.absatz_ksst5) AS NUMERIC), 0) AS e150,
 ROUND(CAST(SUM(T1.absatz_ksst6) AS NUMERIC), 0) AS e152,
 ROUND(CAST(SUM(T1.absatz_ksst7) AS NUMERIC), 0) AS e154,
 ROUND(CAST(SUM(T1.absatz_ost_basis) AS NUMERIC), 0) AS e170,
 ROUND(CAST(SUM(T1.absatz_ost_gross) AS NUMERIC), 0) AS e172,
 ROUND(CAST(SUM(T1.absatz_sued_ost) AS NUMERIC), 0) AS e174,
 ROUND(CAST(SUM(T1.absatz_sued_west) AS NUMERIC), 0) AS e176,
 ROUND(CAST(SUM(T1.absatz_west) AS NUMERIC), 0) AS e178,
 ROUND(CAST(SUM(T1.absatz_nord) AS NUMERIC), 0) AS e180,
 CAST(CASE
    WHEN SUM(T1.absatz_sst1) = 0
    THEN NULL
    ELSE SUM(T1.absatz_sst1)
    END / CASE
    WHEN SUM(T1.markt_wochen_sst1) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_sst1)
    END AS NUMERIC) AS e157,
 CAST(CASE
    WHEN SUM(T1.absatz_sst2) = 0
    THEN NULL
    ELSE SUM(T1.absatz_sst2)
    END / CASE
    WHEN SUM(T1.markt_wochen_sst2) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_sst2)
    END AS NUMERIC) AS e159,
 CAST(CASE
    WHEN SUM(T1.absatz_sst3) = 0
    THEN NULL
    ELSE SUM(T1.absatz_sst3)
    END / CASE
    WHEN SUM(T1.markt_wochen_sst3) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_sst3)
    END AS NUMERIC) AS e161,
 CAST(CASE
    WHEN SUM(T1.absatz_sst4) = 0
    THEN NULL
    ELSE SUM(T1.absatz_sst4)
    END / CASE
    WHEN SUM(T1.markt_wochen_sst4) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_sst4)
    END AS NUMERIC) AS e163,
 CAST(CASE
    WHEN SUM(T1.absatz_sst5) = 0
    THEN NULL
    ELSE SUM(T1.absatz_sst5)
    END / CASE
    WHEN SUM(T1.markt_wochen_sst5) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_sst5)
    END AS NUMERIC) AS e165,
 CAST(CASE
    WHEN SUM(T1.absatz_sst6) = 0
    THEN NULL
    ELSE SUM(T1.absatz_sst6)
    END / CASE
    WHEN SUM(T1.markt_wochen_sst6) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_sst6)
    END AS NUMERIC) AS e167,
 CAST(CASE
    WHEN SUM(T1.absatz_sst7) = 0
    THEN NULL
    ELSE SUM(T1.absatz_sst7)
    END / CASE
    WHEN SUM(T1.markt_wochen_sst7) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_sst7)
    END AS NUMERIC) AS e169,
 CAST(CASE
    WHEN SUM(T1.absatz_ksst1) = 0
    THEN NULL
    ELSE SUM(T1.absatz_ksst1)
    END / CASE
    WHEN SUM(T1.markt_wochen_ksst1) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_ksst1)
    END AS NUMERIC) AS e143,
 CAST(CASE
    WHEN SUM(T1.absatz_ksst2) = 0
    THEN NULL
    ELSE SUM(T1.absatz_ksst2)
    END / CASE
    WHEN SUM(T1.markt_wochen_ksst2) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_ksst2)
    END AS NUMERIC) AS e145,
 CAST(CASE
    WHEN SUM(T1.absatz_ksst3) = 0
    THEN NULL
    ELSE SUM(T1.absatz_ksst3)
    END / CASE
    WHEN SUM(T1.markt_wochen_ksst3) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_ksst3)
    END AS NUMERIC) AS e147,
 CAST(CASE
    WHEN SUM(T1.absatz_ksst4) = 0
    THEN NULL
    ELSE SUM(T1.absatz_ksst4)
    END / CASE
    WHEN SUM(T1.markt_wochen_ksst4) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_ksst4)
    END AS NUMERIC) AS e149,
 CAST(CASE
    WHEN SUM(T1.absatz_ksst5) = 0
    THEN NULL
    ELSE SUM(T1.absatz_ksst5)
    END / CASE
    WHEN SUM(T1.markt_wochen_ksst5) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_ksst5)
    END AS NUMERIC) AS e151,
 CAST(CASE
    WHEN SUM(T1.absatz_ksst6) = 0
    THEN NULL
    ELSE SUM(T1.absatz_ksst6)
    END / CASE
    WHEN SUM(T1.markt_wochen_ksst6) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_ksst6)
    END AS NUMERIC) AS e153,
 CAST(CASE
    WHEN SUM(T1.absatz_ksst7) = 0
    THEN NULL
    ELSE SUM(T1.absatz_ksst7)
    END / CASE
    WHEN SUM(T1.markt_wochen_ksst7) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_ksst7)
    END AS NUMERIC) AS e155,
 CAST(CASE
    WHEN SUM(T1.absatz_ost_basis) = 0
    THEN NULL
    ELSE SUM(T1.absatz_ost_basis)
    END / CASE
    WHEN SUM(T1.markt_wochen_ost_basis) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_ost_basis)
    END AS NUMERIC) AS e171,
 CAST(CASE
    WHEN SUM(T1.absatz_ost_gross) = 0
    THEN NULL
    ELSE SUM(T1.absatz_ost_gross)
    END / CASE
    WHEN SUM(T1.markt_wochen_ost_gross) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_ost_gross)
    END AS NUMERIC) AS e173,
 CAST(CASE
    WHEN SUM(T1.absatz_sued_ost) = 0
    THEN NULL
    ELSE SUM(T1.absatz_sued_ost)
    END / CASE
    WHEN SUM(T1.markt_wochen_sued_ost) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_sued_ost)
    END AS NUMERIC) AS e175,
 CAST(CASE
    WHEN SUM(T1.absatz_sued_west) = 0
    THEN NULL
    ELSE SUM(T1.absatz_sued_west)
    END / CASE
    WHEN SUM(T1.markt_wochen_sued_west) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_sued_west)
    END AS NUMERIC) AS e177,
 CAST(CASE
    WHEN SUM(T1.absatz_west) = 0
    THEN NULL
    ELSE SUM(T1.absatz_west)
    END / CASE
    WHEN SUM(T1.markt_wochen_west) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_west)
    END AS NUMERIC) AS e179,
 CAST(CASE
    WHEN SUM(T1.absatz_nord) = 0
    THEN NULL
    ELSE SUM(T1.absatz_nord)
    END / CASE
    WHEN SUM(T1.markt_wochen_nord) = 0
    THEN NULL
    ELSE SUM(T1.markt_wochen_nord)
    END AS NUMERIC) AS e181,
 ROUND(CAST(CAST(SUM(T1.anzahl_markt_wochen_kombis_abverkauf_mit_listung) AS NUMERIC) / CASE
      WHEN SUM(T1.anzahl_markt_wochen_kombis_listung) = 0
      THEN NULL
      ELSE SUM(T1.anzahl_markt_wochen_kombis_listung)
      END * 100 AS NUMERIC), 1) AS e362,
 ROUND(CAST(SUM(T1.rohertrag_ekmep_olk_4n) AS NUMERIC), 0) AS e241,
 ROUND(CAST((SUM(T1.kassenumsatz_kl_absolut_netto) - SUM(T1.rohertrag_ekmep_olk_4n)) / CASE
     WHEN SUM(T1.absatz_kl) = 0
     THEN NULL
     ELSE SUM(T1.absatz_kl)
     END AS NUMERIC), 2) AS e247,
 CAST(CASE
    WHEN SUM(T1.absatz_sa_kl) = 0
    THEN NULL
    ELSE SUM(T1.absatz_sa_kl)
    END / CASE
    WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0
    THEN NULL
    ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa)
    END AS NUMERIC) AS e263,
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
       END) * 100 AS NUMERIC) AS e271,
 CAST(CASE
     WHEN SUM(T1.absatz_sa_kl) = 0
     THEN NULL
     ELSE SUM(T1.absatz_sa_kl)
     END / CASE
     WHEN SUM(T1.absatz_kl) = 0
     THEN NULL
     ELSE SUM(T1.absatz_kl)
     END * 100 AS NUMERIC) AS e238,
 NULL AS e350,
 NULL AS e354,
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
     END * 100 AS NUMERIC) AS e242,
 CAST(CASE
    WHEN SUM(T1.rohertrag_ekmep_olk_4n_af) = 0
    THEN NULL
    ELSE SUM(T1.rohertrag_ekmep_olk_4n_af)
    END / CASE
    WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af) = 0
    THEN NULL
    ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_af)
    END AS NUMERIC) AS e295,
 CAST(CASE
    WHEN SUM(T1.rohertrag_ekmep_olk_4n_sa) = 0
    THEN NULL
    ELSE SUM(T1.rohertrag_ekmep_olk_4n_sa)
    END / CASE
    WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0
    THEN NULL
    ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa)
    END AS NUMERIC) AS e299,
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
       END) * 100 AS NUMERIC) AS e303,
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
       END) * 100 AS NUMERIC) AS e307,
 CAST(CASE
    WHEN SUM(T1.kassenumsatz_af_kl_absolut_brutto) = 0
    THEN NULL
    ELSE SUM(T1.kassenumsatz_af_kl_absolut_brutto)
    END / CASE
    WHEN SUM(T1.absatz_af_kl) = 0
    THEN NULL
    ELSE SUM(T1.absatz_af_kl)
    END AS NUMERIC) AS e374,
 CAST(CASE
     WHEN SUM(T1.rohertrag_ekmep_olk_4n) = 0
     THEN NULL
     ELSE SUM(T1.rohertrag_ekmep_olk_4n)
     END / CASE
     WHEN SUM(T1.kassenumsatz_kl_absolut_netto) = 0
     THEN NULL
     ELSE SUM(T1.kassenumsatz_kl_absolut_netto)
     END * 100 AS NUMERIC) AS e243,
 CAST(CASE
    WHEN SUM(T1.rohertrag_ekmep_olk_4n_af) = 0
    THEN NULL
    ELSE SUM(T1.rohertrag_ekmep_olk_4n_af)
    END / CASE
    WHEN SUM(T1.kassenumsatz_af_kl_absolut_netto) = 0
    THEN NULL
    ELSE SUM(T1.kassenumsatz_af_kl_absolut_netto)
    END AS NUMERIC) AS e244,
 CAST(CASE
    WHEN SUM(T1.rohertrag_ekmep_olk_4n_sa) = 0
    THEN NULL
    ELSE SUM(T1.rohertrag_ekmep_olk_4n_sa)
    END / CASE
    WHEN SUM(T1.kassenumsatz_sa_kl_absolut_netto) = 0
    THEN NULL
    ELSE SUM(T1.kassenumsatz_sa_kl_absolut_netto)
    END AS NUMERIC) AS e311,
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
     END * 100 AS NUMERIC) AS e236,
 ROUND(CAST(SUM(T1.kassenumsatz_kl_absolut_netto) AS NUMERIC), 0) AS e239,
 CAST(CASE
    WHEN SUM(T1.kassenumsatz_sa_kl_absolut_netto) = 0
    THEN NULL
    ELSE SUM(T1.kassenumsatz_sa_kl_absolut_netto)
    END / CASE
    WHEN SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0
    THEN NULL
    ELSE SUM(T1.anzahl_markt_wochen_kombis_abverkauf_sa)
    END AS NUMERIC) AS e279,
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
       END) * 100 AS NUMERIC) AS e291,
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
     END * 100 AS NUMERIC) AS e240,
 ROUND(CAST(SUM(T1.kassenumsatz_kl_absolut_brutto) AS NUMERIC), 0) AS e275,
 ROUND(CAST(SUM(T1.totalabschriften_wert_netto_absolut) AS NUMERIC), 0) AS e245,
 ROUND(CAST(SUM(T1.preisabschriften_preisanderungen_wert_netto_absolut) AS NUMERIC), 0) AS e315,
 CAST(CASE
     WHEN SUM(T1.preisabschriften_preisanderungen_wert_netto_absolut) = 0
     THEN NULL
     ELSE SUM(T1.preisabschriften_preisanderungen_wert_netto_absolut)
     END / CASE
     WHEN SUM(T1.kassenumsatz_kl_absolut_netto) = 0
     THEN NULL
     ELSE SUM(T1.kassenumsatz_kl_absolut_netto)
     END * 100 AS NUMERIC) AS e319,
 CAST(CASE
     WHEN SUM(T1.totalabschriften_wert_netto_absolut) = 0
     THEN NULL
     ELSE SUM(T1.totalabschriften_wert_netto_absolut)
     END / CASE
     WHEN SUM(T1.kassenumsatz_kl_absolut_netto) = 0
     THEN NULL
     ELSE SUM(T1.kassenumsatz_kl_absolut_netto)
     END * 100 AS NUMERIC) AS e246,
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
       END) * 100 AS NUMERIC) AS e327,
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
       END) * 100 AS NUMERIC) AS e331,
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
     END AS NUMERIC), 2) AS e323
FROM kfl_production_dbp_msi_v_view.v_tupel_26_wochen AS T1
 INNER JOIN kfl_production_dbp_view.v_woche AS X1 ON T1.kjwo_26 = X1.kjwo
 INNER JOIN kfl_production_dbp_view.v_woche AS X2 ON X1.akt_wo + 2 = X2.akt_wo
 INNER JOIN kfl_production_dbp_msi_v_view.v_tupel_mat AS T2 ON T1.mandant_id = T2.mandant_id AND T1.matching_id = T2.matching_id
     AND X2.kjwo = T2.a500_kjwo_update
GROUP BY T1.mandant_id,
 T1.kjwo_26,
 T1.matching_id,
 a5,
 a7,
 a9,
 T2.wug_id;