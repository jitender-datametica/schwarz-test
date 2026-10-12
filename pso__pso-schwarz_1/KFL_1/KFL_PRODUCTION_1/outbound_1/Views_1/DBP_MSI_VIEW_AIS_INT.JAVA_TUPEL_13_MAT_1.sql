CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.java_tupel_13_mat_1 (mandant_id, kjwo_13, matching_id, a472,
a480, a482, a478, a484, a488, a486, a487, a481, a483, a475, a477, a473, a485, a479, a474, a476) AS SELECT mandant_id,
 kjwo_13,
 matching_id,
 ROUND(CAST(SUM(absatz_kl) AS NUMERIC), 0) AS a472,
 CAST(CASE
    WHEN SUM(rohertrag_ekmep_olk_4n_af) = 0
    THEN NULL
    ELSE SUM(rohertrag_ekmep_olk_4n_af)
    END / CASE
    WHEN SUM(anzahl_markt_wochen_kombis_abverkauf_af) = 0
    THEN NULL
    ELSE SUM(anzahl_markt_wochen_kombis_abverkauf_af)
    END AS NUMERIC) AS a480,
 CAST(CASE
    WHEN SUM(rohertrag_ekmep_olk_4n_sa) = 0
    THEN NULL
    ELSE SUM(rohertrag_ekmep_olk_4n_sa)
    END / CASE
    WHEN SUM(anzahl_markt_wochen_kombis_abverkauf_sa) = 0
    THEN NULL
    ELSE SUM(anzahl_markt_wochen_kombis_abverkauf_sa)
    END AS NUMERIC) AS a482,
 ROUND(CAST(SUM(kassenumsatz_kl_absolut_netto) AS NUMERIC), 0) AS a478,
 ROUND(CAST(SUM(rohertrag_ekmep_olk_4n) AS NUMERIC), 0) AS a484,
 CAST(CASE
     WHEN SUM(rohertrag_ekmep_olk_4n) = 0
     THEN NULL
     ELSE SUM(rohertrag_ekmep_olk_4n)
     END / CASE
     WHEN SUM(kassenumsatz_kl_absolut_netto) = 0
     THEN NULL
     ELSE SUM(kassenumsatz_kl_absolut_netto)
     END * 100 AS NUMERIC) AS a488,
 CAST(CASE
    WHEN SUM(rohertrag_ekmep_olk_4n_af) = 0
    THEN NULL
    ELSE SUM(rohertrag_ekmep_olk_4n_af)
    END / CASE
    WHEN SUM(kassenumsatz_af_kl_absolut_netto) = 0
    THEN NULL
    ELSE SUM(kassenumsatz_af_kl_absolut_netto)
    END AS NUMERIC) AS a486,
 CAST(CASE
    WHEN SUM(rohertrag_ekmep_olk_4n_sa) = 0
    THEN NULL
    ELSE SUM(rohertrag_ekmep_olk_4n_sa)
    END / CASE
    WHEN SUM(kassenumsatz_sa_kl_absolut_netto) = 0
    THEN NULL
    ELSE SUM(kassenumsatz_sa_kl_absolut_netto)
    END AS NUMERIC) AS a487,
 CAST((CASE
        WHEN SUM(rohertrag_ekmep_olk_4n_af) = 0
        THEN NULL
        ELSE SUM(rohertrag_ekmep_olk_4n_af)
        END / CASE
        WHEN SUM(anzahl_markt_wochen_kombis_abverkauf_af) = 0
        THEN NULL
        ELSE SUM(anzahl_markt_wochen_kombis_abverkauf_af)
        END - CASE
       WHEN CASE
          WHEN SUM(rohertrag_ekmep_olk_4n_af_vj) = 0
          THEN NULL
          ELSE SUM(rohertrag_ekmep_olk_4n_af_vj)
          END / CASE
          WHEN SUM(anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0
          THEN NULL
          ELSE SUM(anzahl_markt_wochen_kombis_abverkauf_af_vj)
          END = 0
       THEN NULL
       ELSE CASE
         WHEN SUM(rohertrag_ekmep_olk_4n_af_vj) = 0
         THEN NULL
         ELSE SUM(rohertrag_ekmep_olk_4n_af_vj)
         END / CASE
         WHEN SUM(anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0
         THEN NULL
         ELSE SUM(anzahl_markt_wochen_kombis_abverkauf_af_vj)
         END
       END) / (CASE
       WHEN SUM(rohertrag_ekmep_olk_4n_af_vj) = 0
       THEN NULL
       ELSE SUM(rohertrag_ekmep_olk_4n_af_vj)
       END / CASE
       WHEN SUM(anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0
       THEN NULL
       ELSE SUM(anzahl_markt_wochen_kombis_abverkauf_af_vj)
       END) * 100 AS NUMERIC) AS a481,
 CAST((CASE
        WHEN SUM(rohertrag_ekmep_olk_4n_sa) = 0
        THEN NULL
        ELSE SUM(rohertrag_ekmep_olk_4n_sa)
        END / CASE
        WHEN SUM(anzahl_markt_wochen_kombis_abverkauf_sa) = 0
        THEN NULL
        ELSE SUM(anzahl_markt_wochen_kombis_abverkauf_sa)
        END - CASE
       WHEN CASE
          WHEN SUM(rohertrag_ekmep_olk_4n_sa_vj) = 0
          THEN NULL
          ELSE SUM(rohertrag_ekmep_olk_4n_sa_vj)
          END / CASE
          WHEN SUM(anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0
          THEN NULL
          ELSE SUM(anzahl_markt_wochen_kombis_abverkauf_sa_vj)
          END = 0
       THEN NULL
       ELSE CASE
         WHEN SUM(rohertrag_ekmep_olk_4n_sa_vj) = 0
         THEN NULL
         ELSE SUM(rohertrag_ekmep_olk_4n_sa_vj)
         END / CASE
         WHEN SUM(anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0
         THEN NULL
         ELSE SUM(anzahl_markt_wochen_kombis_abverkauf_sa_vj)
         END
       END) / (CASE
       WHEN SUM(rohertrag_ekmep_olk_4n_sa_vj) = 0
       THEN NULL
       ELSE SUM(rohertrag_ekmep_olk_4n_sa_vj)
       END / CASE
       WHEN SUM(anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0
       THEN NULL
       ELSE SUM(anzahl_markt_wochen_kombis_abverkauf_sa_vj)
       END) * 100 AS NUMERIC) AS a483,
 CAST((CASE
        WHEN SUM(kassenumsatz_af_kl_absolut_netto) = 0
        THEN NULL
        ELSE SUM(kassenumsatz_af_kl_absolut_netto)
        END / CASE
        WHEN SUM(anzahl_markt_wochen_kombis_abverkauf_af) = 0
        THEN NULL
        ELSE SUM(anzahl_markt_wochen_kombis_abverkauf_af)
        END - CASE
       WHEN CASE
          WHEN SUM(kassenumsatz_af_kl_absolut_netto_vj) = 0
          THEN NULL
          ELSE SUM(kassenumsatz_af_kl_absolut_netto_vj)
          END / CASE
          WHEN SUM(anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0
          THEN NULL
          ELSE SUM(anzahl_markt_wochen_kombis_abverkauf_af_vj)
          END = 0
       THEN NULL
       ELSE CASE
         WHEN SUM(kassenumsatz_af_kl_absolut_netto_vj) = 0
         THEN NULL
         ELSE SUM(kassenumsatz_af_kl_absolut_netto_vj)
         END / CASE
         WHEN SUM(anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0
         THEN NULL
         ELSE SUM(anzahl_markt_wochen_kombis_abverkauf_af_vj)
         END
       END) / (CASE
       WHEN SUM(kassenumsatz_af_kl_absolut_netto_vj) = 0
       THEN NULL
       ELSE SUM(kassenumsatz_af_kl_absolut_netto_vj)
       END / CASE
       WHEN SUM(anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0
       THEN NULL
       ELSE SUM(anzahl_markt_wochen_kombis_abverkauf_af_vj)
       END) * 100 AS NUMERIC) AS a475,
 CAST((CASE
        WHEN SUM(kassenumsatz_sa_kl_absolut_netto) = 0
        THEN NULL
        ELSE SUM(kassenumsatz_sa_kl_absolut_netto)
        END / CASE
        WHEN SUM(anzahl_markt_wochen_kombis_abverkauf_sa) = 0
        THEN NULL
        ELSE SUM(anzahl_markt_wochen_kombis_abverkauf_sa)
        END - CASE
       WHEN CASE
          WHEN SUM(kassenumsatz_sa_kl_absolut_netto_vj) = 0
          THEN NULL
          ELSE SUM(kassenumsatz_sa_kl_absolut_netto_vj)
          END / CASE
          WHEN SUM(anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0
          THEN NULL
          ELSE SUM(anzahl_markt_wochen_kombis_abverkauf_sa_vj)
          END = 0
       THEN NULL
       ELSE CASE
         WHEN SUM(kassenumsatz_sa_kl_absolut_netto_vj) = 0
         THEN NULL
         ELSE SUM(kassenumsatz_sa_kl_absolut_netto_vj)
         END / CASE
         WHEN SUM(anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0
         THEN NULL
         ELSE SUM(anzahl_markt_wochen_kombis_abverkauf_sa_vj)
         END
       END) / (CASE
       WHEN SUM(kassenumsatz_sa_kl_absolut_netto_vj) = 0
       THEN NULL
       ELSE SUM(kassenumsatz_sa_kl_absolut_netto_vj)
       END / CASE
       WHEN SUM(anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0
       THEN NULL
       ELSE SUM(anzahl_markt_wochen_kombis_abverkauf_sa_vj)
       END) * 100 AS NUMERIC) AS a477,
 CAST((CASE
       WHEN SUM(absatz_kl) = 0
       THEN NULL
       ELSE SUM(absatz_kl)
       END - CASE
       WHEN SUM(absatz_kl_vj) = 0
       THEN NULL
       ELSE SUM(absatz_kl_vj)
       END) / CASE
     WHEN SUM(absatz_kl_vj) = 0
     THEN NULL
     ELSE SUM(absatz_kl_vj)
     END * 100 AS NUMERIC) AS a473,
 CAST(CASE
     WHEN SUM(rohertrag_ekmep_olk_4n) - CASE
        WHEN SUM(rohertrag_ekmep_olk_4n_vj) = 0
        THEN NULL
        ELSE SUM(rohertrag_ekmep_olk_4n_vj)
        END = 0
     THEN NULL
     ELSE SUM(rohertrag_ekmep_olk_4n) - CASE
       WHEN SUM(rohertrag_ekmep_olk_4n_vj) = 0
       THEN NULL
       ELSE SUM(rohertrag_ekmep_olk_4n_vj)
       END
     END / CASE
     WHEN SUM(rohertrag_ekmep_olk_4n_vj) = 0
     THEN NULL
     ELSE SUM(rohertrag_ekmep_olk_4n_vj)
     END * 100 AS NUMERIC) AS a485,
 CAST((CASE
       WHEN SUM(kassenumsatz_kl_absolut_netto) = 0
       THEN NULL
       ELSE SUM(kassenumsatz_kl_absolut_netto)
       END - CASE
       WHEN SUM(kassenumsatz_kl_absolut_netto_vj) = 0
       THEN NULL
       ELSE SUM(kassenumsatz_kl_absolut_netto_vj)
       END) / CASE
     WHEN SUM(kassenumsatz_kl_absolut_netto_vj) = 0
     THEN NULL
     ELSE SUM(kassenumsatz_kl_absolut_netto_vj)
     END * 100 AS NUMERIC) AS a479,
 CAST(CASE
    WHEN SUM(kassenumsatz_af_kl_absolut_netto) = 0
    THEN NULL
    ELSE SUM(kassenumsatz_af_kl_absolut_netto)
    END / CASE
    WHEN SUM(anzahl_markt_wochen_kombis_abverkauf_af) = 0
    THEN NULL
    ELSE SUM(anzahl_markt_wochen_kombis_abverkauf_af)
    END AS NUMERIC) AS a474,
 CAST(CASE
    WHEN SUM(kassenumsatz_sa_kl_absolut_netto) = 0
    THEN NULL
    ELSE SUM(kassenumsatz_sa_kl_absolut_netto)
    END / CASE
    WHEN SUM(anzahl_markt_wochen_kombis_abverkauf_sa) = 0
    THEN NULL
    ELSE SUM(anzahl_markt_wochen_kombis_abverkauf_sa)
    END AS NUMERIC) AS a476
FROM kfl_production_dbp_msi_v_view.v_tupel_13_wochen_1 AS T1_1
GROUP BY mandant_id,
 kjwo_13,
 matching_id;