
/* FAKT/AGGREGAT VIS Cockpit Personal pro wup_1 (zeitlos)
	BASIS: vis_monat_ums_kunde_pers_wup_1
	Cockpit-Variante: 0 Monat_1 + 1 GJ kum.
	2011KW18 INITIAL
	kkaiser 20150409 NULLIFZERO eingebaut bei expber_fg und stdleist_nat_kvj, stdlohn_nat_kvj
	2025-05-23 ssch0611 : Review (Block cockpit_variante 1 inkl. kum Spalten entfernt) [AP0263159] */
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_cockpit_personal_1 AS
/* cockpit_variante 2 (GJ kum. Werte) komplett entfernt */ SELECT V01.mandant_id,
 V01.nb_id,
 V01.wup_id,
 V01.wrg_id,
 V01.kjmo,
 snowconvert_public.teradata_numeric_date_to_date(V01.kjmo * 100 - 18999999) AS p_dat_von,
  DATE_ADD(snowconvert_public.teradata_numeric_date_to_date(V01.kjmo * 100 - 18999999),INTERVAL 1 MONTH) - 1 AS p_dat_bis,
     '(' || CAST(snowconvert_public.teradata_numeric_date_to_date(V01.kjmo * 100 - 18999999) AS STRING) || ' - ' || CAST(DATE_ADD(snowconvert_public.teradata_numeric_date_to_date(V01.kjmo * 100 - 18999999), INTERVAL 1 MONTH) - 1 AS STRING)
    || ')' AS p_zeit_akt,
     '(' || CAST(DATE_ADD(snowconvert_public.teradata_numeric_date_to_date(V01.kjmo * 100 - 18999999), INTERVAL -12 MONTH) AS STRING)
      || ' - ' || CAST(DATE_ADD(DATE_ADD(snowconvert_public.teradata_numeric_date_to_date(V01.kjmo * 100 - 18999999), INTERVAL 1 MONTH) - 1, INTERVAL -12 MONTH) AS STRING)
    || ')' AS p_zeit_vor,
 v02.expber_fg,
 0 AS cockpit_variante,
  v02.expber_fg * (RANK() OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING), V01.wrg_id
    ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, v02.expber_fg IS NULL, v02.expber_fg
      , (V01.pers_kosten * 100.0000 / CASE
           WHEN V01.ums_netto = 0
           THEN NULL
           ELSE V01.ums_netto
           END * v02.expber_fg - CASE
         WHEN V01.pers_kosten_kvj * 100.0000 / CASE
             WHEN V01.ums_netto_kvj = 0
             THEN NULL
             ELSE V01.ums_netto_kvj
             END * v02.expber_fg = 0
         THEN NULL
         ELSE V01.pers_kosten_kvj * 100.0000 / CASE
            WHEN V01.ums_netto_kvj = 0
            THEN NULL
            ELSE V01.ums_netto_kvj
            END * v02.expber_fg
         END) IS NULL, V01.pers_kosten * 100.0000 / CASE
          WHEN V01.ums_netto = 0
          THEN NULL
          ELSE V01.ums_netto
          END * v02.expber_fg - CASE
        WHEN V01.pers_kosten_kvj * 100.0000 / CASE
            WHEN V01.ums_netto_kvj = 0
            THEN NULL
            ELSE V01.ums_netto_kvj
            END * v02.expber_fg = 0
        THEN NULL
        ELSE V01.pers_kosten_kvj * 100.0000 / CASE
           WHEN V01.ums_netto_kvj = 0
           THEN NULL
           ELSE V01.ums_netto_kvj
           END * v02.expber_fg
        END)) AS pk_rang,
 ROUND(CAST(IFNULL((AVG(V01.pers_kosten * v02.expber_fg * 100.0000) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
          , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id IS NULL
          , V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) / CASE
       WHEN (AVG(V01.ums_netto * v02.expber_fg) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
            , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
            IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 0
       THEN NULL
       ELSE AVG(V01.ums_netto * v02.expber_fg) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
          , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id IS NULL
          , V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
       END - (AVG(V01.pers_kosten_kvj * v02.expber_fg * 100.0000) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
          , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id IS NULL
          , V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) / CASE
       WHEN (AVG(V01.ums_netto_kvj * v02.expber_fg) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
            , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
            IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 0
       THEN NULL
       ELSE AVG(V01.ums_netto_kvj * v02.expber_fg) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
          , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id IS NULL
          , V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
       END, 0) AS NUMERIC), 4) AS pk_nat,
  v02.expber_fg * (RANK() OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING), V01.wrg_id
    ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, v02.expber_fg IS NULL, v02.expber_fg
      , ((V01.ums_netto / CASE
              WHEN V01.pers_std = 0
              THEN NULL
              ELSE V01.pers_std
              END - CASE
             WHEN V01.ums_netto_kvj / CASE
                WHEN V01.pers_std_kvj = 0
                THEN NULL
                ELSE V01.pers_std_kvj
                END = 0
             THEN NULL
             ELSE V01.ums_netto_kvj / CASE
               WHEN V01.pers_std_kvj = 0
               THEN NULL
               ELSE V01.pers_std_kvj
               END
             END) * v02.expber_fg * 100.0000 / CASE
         WHEN V01.ums_netto_kvj / CASE
             WHEN V01.pers_std_kvj = 0
             THEN NULL
             ELSE V01.pers_std_kvj
             END * v02.expber_fg = 0
         THEN NULL
         ELSE V01.ums_netto_kvj / CASE
            WHEN V01.pers_std_kvj = 0
            THEN NULL
            ELSE V01.pers_std_kvj
            END * v02.expber_fg
         END) IS NULL, (V01.ums_netto / CASE
             WHEN V01.pers_std = 0
             THEN NULL
             ELSE V01.pers_std
             END - CASE
            WHEN V01.ums_netto_kvj / CASE
               WHEN V01.pers_std_kvj = 0
               THEN NULL
               ELSE V01.pers_std_kvj
               END = 0
            THEN NULL
            ELSE V01.ums_netto_kvj / CASE
              WHEN V01.pers_std_kvj = 0
              THEN NULL
              ELSE V01.pers_std_kvj
              END
            END) * v02.expber_fg * 100.0000 / CASE
        WHEN V01.ums_netto_kvj / CASE
            WHEN V01.pers_std_kvj = 0
            THEN NULL
            ELSE V01.pers_std_kvj
            END * v02.expber_fg = 0
        THEN NULL
        ELSE V01.ums_netto_kvj / CASE
           WHEN V01.pers_std_kvj = 0
           THEN NULL
           ELSE V01.pers_std_kvj
           END * v02.expber_fg
        END)) AS stdleist_rang,
 ROUND(CAST(IFNULL(((AVG(V01.ums_netto * v02.expber_fg * 1.0000) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
             , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
             IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) / CASE
          WHEN (AVG(V01.pers_std * v02.expber_fg) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
               , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
               IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 0
          THEN NULL
          ELSE AVG(V01.pers_std * v02.expber_fg) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
             , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
             IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
          END - (AVG(V01.ums_netto_kvj * v02.expber_fg * 1.0000) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
             , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
             IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) / CASE
          WHEN (AVG(V01.pers_std_kvj * v02.expber_fg) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
               , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
               IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 0
          THEN NULL
          ELSE AVG(V01.pers_std_kvj * v02.expber_fg) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
             , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
             IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
          END) * 100.0000 / CASE
      WHEN (AVG(V01.ums_netto_kvj * v02.expber_fg * 1.0000) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
            , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
            IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) / CASE
         WHEN (AVG(V01.pers_std_kvj * v02.expber_fg) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
              , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
              IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 0
         THEN NULL
         ELSE AVG(V01.pers_std_kvj * v02.expber_fg) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
            , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
            IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
         END = 0
      THEN NULL
      ELSE (AVG(V01.ums_netto_kvj * v02.expber_fg * 1.0000) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
           , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
           IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) / CASE
        WHEN (AVG(V01.pers_std_kvj * v02.expber_fg) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
             , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
             IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 0
        THEN NULL
        ELSE AVG(V01.pers_std_kvj * v02.expber_fg) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
           , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
           IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        END
      END, 0) AS NUMERIC), 4) AS stdleist_nat,
  v02.expber_fg * (RANK() OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING), V01.wrg_id
    ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, v02.expber_fg IS NULL, v02.expber_fg
      , ((V01.pers_k_ohne / CASE
              WHEN V01.pers_std = 0
              THEN NULL
              ELSE V01.pers_std
              END - CASE
             WHEN V01.pers_k_ohne_kvj / CASE
                WHEN V01.pers_std_kvj = 0
                THEN NULL
                ELSE V01.pers_std_kvj
                END = 0
             THEN NULL
             ELSE V01.pers_k_ohne_kvj / CASE
               WHEN V01.pers_std_kvj = 0
               THEN NULL
               ELSE V01.pers_std_kvj
               END
             END) * v02.expber_fg * - 100.0000 / CASE
         WHEN V01.pers_k_ohne_kvj / CASE
             WHEN V01.pers_std_kvj = 0
             THEN NULL
             ELSE V01.pers_std_kvj
             END * v02.expber_fg = 0
         THEN NULL
         ELSE V01.pers_k_ohne_kvj / CASE
            WHEN V01.pers_std_kvj = 0
            THEN NULL
            ELSE V01.pers_std_kvj
            END * v02.expber_fg
         END) IS NULL, (V01.pers_k_ohne / CASE
             WHEN V01.pers_std = 0
             THEN NULL
             ELSE V01.pers_std
             END - CASE
            WHEN V01.pers_k_ohne_kvj / CASE
               WHEN V01.pers_std_kvj = 0
               THEN NULL
               ELSE V01.pers_std_kvj
               END = 0
            THEN NULL
            ELSE V01.pers_k_ohne_kvj / CASE
              WHEN V01.pers_std_kvj = 0
              THEN NULL
              ELSE V01.pers_std_kvj
              END
            END) * v02.expber_fg * - 100.0000 / CASE
        WHEN V01.pers_k_ohne_kvj / CASE
            WHEN V01.pers_std_kvj = 0
            THEN NULL
            ELSE V01.pers_std_kvj
            END * v02.expber_fg = 0
        THEN NULL
        ELSE V01.pers_k_ohne_kvj / CASE
           WHEN V01.pers_std_kvj = 0
           THEN NULL
           ELSE V01.pers_std_kvj
           END * v02.expber_fg
        END)) AS stdlohn_rang,
 ROUND(CAST(IFNULL(((AVG(V01.pers_k_ohne * v02.expber_fg * 1.0000) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
             , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
             IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) / CASE
          WHEN (AVG(V01.pers_std * v02.expber_fg) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
               , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
               IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 0
          THEN NULL
          ELSE AVG(V01.pers_std * v02.expber_fg) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
             , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
             IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
          END - (AVG(V01.pers_k_ohne_kvj * v02.expber_fg * 1.0000) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
             , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
             IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) / CASE
          WHEN (AVG(V01.pers_std_kvj * v02.expber_fg) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
               , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
               IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 0
          THEN NULL
          ELSE AVG(V01.pers_std_kvj * v02.expber_fg) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
             , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
             IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
          END) * - 100.0000 / CASE
      WHEN (AVG(V01.pers_k_ohne_kvj * v02.expber_fg * 1.0000) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
            , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
            IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) / CASE
         WHEN (AVG(V01.pers_std_kvj * v02.expber_fg) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
              , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
              IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 0
         THEN NULL
         ELSE AVG(V01.pers_std_kvj * v02.expber_fg) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
            , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
            IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
         END = 0
      THEN NULL
      ELSE (AVG(V01.pers_k_ohne_kvj * v02.expber_fg * 1.0000) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
           , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
           IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) / CASE
        WHEN (AVG(V01.pers_std_kvj * v02.expber_fg) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
             , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
             IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 0
        THEN NULL
        ELSE AVG(V01.pers_std_kvj * v02.expber_fg) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
           , V01.wrg_id ORDER BY V01.mandant_id IS NULL, V01.mandant_id, V01.nb_id IS NULL, V01.nb_id, V01.wup_id
           IS NULL, V01.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        END
      END, 0) AS NUMERIC), 4) AS stdlohn_nat,
 V01.ums_netto AS p_ums_ist,
 V01.ums_netto_kvj AS p_ums_kvj,
 V01.pers_kosten AS p_pk_ist,
 V01.pers_kosten_kvj AS p_pk_kvj,
 V01.pers_k_ohne AS p_ohne_ist,
 V01.pers_k_ohne_kvj AS p_ohne_kvj,
 V01.pers_std AS p_std_ist,
 V01.pers_std_kvj AS p_std_kvj
FROM kfl_production_dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_1 AS V01
 INNER JOIN (SELECT mandant_id,
   nb_id,
   wup_id,
   MIN(altersstruktur_tag_id) AS alter_min,
    CASE
    WHEN MIN(altersstruktur_tag_id) < 3
    THEN 1
    ELSE 0
    END AS expber_fg
  FROM kfl_production_dbp_msi_v_view.v_altersstruktur_eis_1
  WHERE nb_id = 0 -- OR wup_id = 0

  GROUP BY mandant_id,
   wup_id,
   nb_id) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.wup_id = v02.wup_id AND V01.nb_id = v02.nb_id
 INNER JOIN (SELECT mandant_id,
   nb_id,
   wup_id
  FROM kfl_production_dbp_view.v_wup_1
  WHERE nb_id = 0) AS v03 ON V01.mandant_id = v03.mandant_id AND V01.wup_id = v03.wup_id AND V01.nb_id = v03.nb_id
 INNER JOIN kfl_production_dbp_view.v_l_buchungsstatus_ker_1 AS V04 ON V01.kjmo = V04.kj_ker_mo_id
WHERE V01.mandant_id = 1 AND V04.akt_fruehinfo1 = 0
 OR V01.mandant_id <> 1 AND V04.akt_fruehinfo2 = 0;
