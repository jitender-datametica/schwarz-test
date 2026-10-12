CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.java_tupel_13_akt (mandant_id, kjwo_13, matching_id, a489,
a497, a499, a495, a502, a506, a504, a505, a498, a501, a492, a494, a490, a503, a496, a491, a493) AS SELECT mandant_id,
 kjwo_13,
 matching_id,
 ROUND(CAST(SUM(absatz_kl) AS NUMERIC), 0) AS a489,
 CAST(CASE
    WHEN SUM(rohertrag_ekmep_olk_4n_af) = 0
    THEN NULL
    ELSE SUM(rohertrag_ekmep_olk_4n_af)
    END / CASE
    WHEN SUM(anzahl_markt_wochen_kombis_abverkauf_af) = 0
    THEN NULL
    ELSE SUM(anzahl_markt_wochen_kombis_abverkauf_af)
    END AS NUMERIC) AS a497,
 CAST(CASE
    WHEN SUM(rohertrag_ekmep_olk_4n_sa) = 0
    THEN NULL
    ELSE SUM(rohertrag_ekmep_olk_4n_sa)
    END / CASE
    WHEN SUM(anzahl_markt_wochen_kombis_abverkauf_sa) = 0
    THEN NULL
    ELSE SUM(anzahl_markt_wochen_kombis_abverkauf_sa)
    END AS NUMERIC) AS a499,
 ROUND(CAST(SUM(kassenumsatz_kl_absolut_netto) AS NUMERIC), 0) AS a495,
 ROUND(CAST(SUM(rohertrag_ekmep_olk_4n) AS NUMERIC), 0) AS a502,
 CAST(CASE
     WHEN SUM(rohertrag_ekmep_olk_4n) = 0
     THEN NULL
     ELSE SUM(rohertrag_ekmep_olk_4n)
     END / CASE
     WHEN SUM(kassenumsatz_kl_absolut_netto) = 0
     THEN NULL
     ELSE SUM(kassenumsatz_kl_absolut_netto)
     END * 100 AS NUMERIC) AS a506,
 CAST(CASE
    WHEN SUM(rohertrag_ekmep_olk_4n_af) = 0
    THEN NULL
    ELSE SUM(rohertrag_ekmep_olk_4n_af)
    END / CASE
    WHEN SUM(kassenumsatz_af_kl_absolut_netto) = 0
    THEN NULL
    ELSE SUM(kassenumsatz_af_kl_absolut_netto)
    END AS NUMERIC) AS a504,
 CAST(CASE
    WHEN SUM(rohertrag_ekmep_olk_4n_sa) = 0
    THEN NULL
    ELSE SUM(rohertrag_ekmep_olk_4n_sa)
    END / CASE
    WHEN SUM(kassenumsatz_sa_kl_absolut_netto) = 0
    THEN NULL
    ELSE SUM(kassenumsatz_sa_kl_absolut_netto)
    END AS NUMERIC) AS a505,
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
       END) * 100 AS NUMERIC) AS a498,
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
       END) * 100 AS NUMERIC) AS a501,
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
       END) * 100 AS NUMERIC) AS a492,
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
       END) * 100 AS NUMERIC) AS a494,
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
     END * 100 AS NUMERIC) AS a490,
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
     END * 100 AS NUMERIC) AS a503,
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
     END * 100 AS NUMERIC) AS a496,
 CAST(CASE
    WHEN SUM(kassenumsatz_af_kl_absolut_netto) = 0
    THEN NULL
    ELSE SUM(kassenumsatz_af_kl_absolut_netto)
    END / CASE
    WHEN SUM(anzahl_markt_wochen_kombis_abverkauf_af) = 0
    THEN NULL
    ELSE SUM(anzahl_markt_wochen_kombis_abverkauf_af)
    END AS NUMERIC) AS a491,
 CAST(CASE
    WHEN SUM(kassenumsatz_sa_kl_absolut_netto) = 0
    THEN NULL
    ELSE SUM(kassenumsatz_sa_kl_absolut_netto)
    END / CASE
    WHEN SUM(anzahl_markt_wochen_kombis_abverkauf_sa) = 0
    THEN NULL
    ELSE SUM(anzahl_markt_wochen_kombis_abverkauf_sa)
    END AS NUMERIC) AS a493
FROM kfl_production_dbp_msi_v_view.v_tupel_13_wochen AS T1
GROUP BY mandant_id,
 kjwo_13,
 matching_id;