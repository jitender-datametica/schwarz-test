
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_stueckliste_1 AS 
WITH STEUCKLISTE_KOMPLETT AS (SELECT S.mandant_id
    ,
    S.stueckliste_id,
    T.dat,
    T.kjwo_kl,
    S.dat_von AS komponente_dat_von,
    S.dat_bis AS komponente_dat_bis,
    S.art_id AS display_art_id,
    S.art_id,
    0 AS komponentenmenge,
    '-' AS komponentenmenge_einh_id,
    0 AS gp_id,
    1 AS display_flag
   FROM kfl_production_dbp_data.stueckliste_1 AS S
    INNER JOIN kfl_production_dbp_data.tag_1 AS T ON T.dat BETWEEN S.dat_von AND S.dat_bis
   WHERE T.akt_gj <= 2
   UNION ALL
   SELECT A.mandant_id,
    A.stueckliste_id,
    T.dat,
    T.kjwo_kl,
    A.dat_von AS komponente_dat_von,
    A.dat_bis AS komponente_dat_bis,
    B.art_id AS display_art_id,
    A.art_id,
    A.komponentenmenge,
    A.komponentenmenge_einh_id,
    0 AS gp_id,
    0 AS display_flag
   FROM kfl_production_dbp_data.stueckliste_det_1 AS A
    INNER JOIN kfl_production_dbp_data.stueckliste_1 AS B ON A.mandant_id = B.mandant_id AND A.stueckliste_id = B.stueckliste_id
      
    INNER JOIN kfl_production_dbp_data.tag_1 AS T ON T.dat BETWEEN A.dat_von AND A.dat_bis
   WHERE T.akt_gj <= 2)
    (SELECT *
  FROM (SELECT v1.mandant_id,
      v1.stueckliste_id,
      v1.dat,
      v1.kjwo_kl,
      v1.komponente_dat_von,
      v1.komponente_dat_bis,
      v1.display_art_id,
      v1.art_id,
      v1.komponentenmenge,
      v1.komponentenmenge_einh_id,
      v3.gp_id,
      v1.display_flag,
       CASE
       WHEN v1.display_flag = 0
       THEN CONCAT(CAST(v1.komponentenmenge / v2.total_amount_display * 100 AS BIGNUMERIC), '%')
       ELSE NULL
       END AS stueckliste_anteil,
       CASE
       WHEN v1.display_flag = 1
       THEN v2.total_amount_display
       ELSE 0
       END AS anzahl_komponentenmenge_gesamt
     FROM STEUCKLISTE_KOMPLETT AS v1
      INNER JOIN (SELECT A0.mandant_id,
        A0.stueckliste_id,
        T0.dat,
        SUM(A0.komponentenmenge) AS total_amount_display
       FROM kfl_production_dbp_data.stueckliste_det_1 AS A0
        INNER JOIN kfl_production_dbp_data.tag_1 AS T0 ON T0.dat BETWEEN A0.dat_von AND A0.dat_bis
       WHERE T0.akt_gj <= 2
       GROUP BY A0.mandant_id,
        A0.stueckliste_id,
        T0.dat) AS v2 ON v1.mandant_id = v2.mandant_id AND v1.stueckliste_id = v2.stueckliste_id AND v1.dat = v2.dat
      INNER JOIN (SELECT mandant_id,
        gp_id,
        art_id
       FROM kfl_production_dbp_data.art_gp_nm_zu_per_1
       GROUP BY mandant_id,
        art_id,
        gp_id) AS v3 ON v1.mandant_id = v3.mandant_id AND v1.display_art_id = v3.art_id
     WHERE (v1.mandant_id, v1.display_art_id, v3.gp_id, v1.dat) IN (SELECT (mandant_id, art_id, gp_id, dat_buch)
        FROM (SELECT mandant_id,
            art_id,
            gp_id,
            dat_buch
           FROM (SELECT A.mandant_id,
              A.art_id,
              A.gp_id,
              A.dat_buch,
              SUM(IFNULL(A.menge_basis, 0)) AS we_menge_inkl_ret
             FROM kfl_production_dbp_msi_view_ais_int.mv_wewa_1 AS A
              INNER JOIN kfl_production_dbp_data.tag_1 AS T ON A.dat_buch = T.dat
             WHERE T.akt_gj <= 2
             GROUP BY A.mandant_id,
              A.art_id,
              A.gp_id,
              A.dat_buch
             HAVING we_menge_inkl_ret <> 0) AS a
           UNION DISTINCT
           SELECT t16.mandant_id,
            t16.art_id,
            t16.gp_id,
            t16.dat
           FROM (SELECT A.mandant_id,
              A.dat,
              A.gp_id,
              A.art_id,
              SUM(A.menge) AS absatz
             FROM kfl_production_dbp_data.artbew_1 AS A
              INNER JOIN kfl_production_dbp_data.tag_1 AS T ON A.dat = T.dat
             WHERE T.akt_gj <= 2
             GROUP BY A.mandant_id,
              A.dat,
              A.gp_id,
              A.art_id
             HAVING absatz <> 0) AS t16) AS t18)
     UNION ALL
     SELECT mandant_id,
      stueckliste_id,
      dat,
      kjwo_kl,
      CAST(NULL AS DATE),
      CAST(NULL AS DATE),
      CAST(NULL AS BIGNUMERIC) AS display_art_id,
      display_art_id AS art_id,
      CAST(NULL AS NUMERIC) AS komponentenmenge,
      CAST(NULL AS STRING) AS komponentenmenge_ein_id,
      CAST(komponentenmenge_ein_id AS BIGNUMERIC) AS gp_id,
      gp_id AS display_fg,
      CAST(NULL AS STRING) AS stueckliste_anteil,
      CAST(NULL AS BIGNUMERIC) AS anzahl_komponentenmenge_gesamt
     FROM (SELECT mandant_id,
        - 1 AS stueckliste_id,
        dat,
        kjwo_kl,
        NULL,
        - 2 AS display_art_id,
        art_id,
        NULL AS komponentenmenge,
        NULL AS komponentenmenge_ein_id,
        gp_id,
        0 AS display_fg,
        NULL AS stueckliste_anteil,
        NULL AS anzahl_komponentenmenge_gesamt
       FROM (SELECT *
         FROM (SELECT *
           FROM kfl_production_dbp_data.art_gp_nm_zu_per_1 AS A
           WHERE (mandant_id, art_id, gp_id) NOT IN (SELECT (mandant_id, art_id, gp_id)
              FROM (SELECT A.mandant_id,
                  A.art_id,
                  b.gp_id
                 FROM kfl_production_dbp_data.stueckliste_1 AS A
                  INNER JOIN (SELECT mandant_id,
                    gp_id,
                    art_id
                   FROM kfl_production_dbp_data.art_gp_nm_zu_per_1
                   GROUP BY mandant_id,
                    art_id,
                    gp_id) AS b ON TRUE
                 GROUP BY A.mandant_id,
                  A.art_id,
                  b.gp_id
                 UNION ALL
                 SELECT A.mandant_id,
                  A.art_id,
                  b.gp_id
                 FROM kfl_production_dbp_data.stueckliste_det_1 AS A
                  INNER JOIN (SELECT mandant_id,
                    gp_id,
                    art_id
                   FROM kfl_production_dbp_data.art_gp_nm_zu_per_1
                   GROUP BY mandant_id,
                    art_id,
                    gp_id) AS b ON TRUE
                 GROUP BY A.art_id,
                  A.mandant_id,
                  b.gp_id) AS t29)) AS t31
          INNER JOIN kfl_production_dbp_data.tag_1 AS B ON B.dat BETWEEN t31.dat_von AND t31.dat_bis
         WHERE B.akt_gj <= 2) AS t32
       WHERE (t32.mandant_id, t32.art_id, t32.gp_id, t32.dat) IN (SELECT (mandant_id, art_id, gp_id, dat_buch)
          FROM (SELECT mandant_id,
              art_id,
              gp_id,
              dat_buch
             FROM (SELECT A.mandant_id,
                A.art_id,
                A.gp_id,
                A.dat_buch,
                SUM(IFNULL(A.menge_basis, 0)) AS we_menge_inkl_ret
               FROM kfl_production_dbp_msi_view_ais_int.mv_wewa_1 AS A
                INNER JOIN kfl_production_dbp_data.tag_1 AS T ON A.dat_buch = T.dat
               WHERE T.akt_gj <= 2
               GROUP BY A.mandant_id,
                A.art_id,
                A.gp_id,
                A.dat_buch
               HAVING we_menge_inkl_ret <> 0) AS a
             UNION DISTINCT
             SELECT t40.mandant_id,
              t40.art_id,
              t40.gp_id,
              t40.dat
             FROM (SELECT A.mandant_id,
                A.dat,
                A.gp_id,
                A.art_id,
                SUM(A.menge) AS absatz
               FROM kfl_production_dbp_data.artbew_1 AS A
                INNER JOIN kfl_production_dbp_data.tag_1 AS T ON A.dat = T.dat
               WHERE T.akt_gj <= 2
               GROUP BY A.mandant_id,
                A.dat,
                A.gp_id,
                A.art_id
               HAVING absatz <> 0) AS t40) AS t42)) AS t45
     GROUP BY mandant_id,
      stueckliste_id,
      dat,
      kjwo_kl,
      display_art_id,
      art_id,
      komponentenmenge,
      komponentenmenge_ein_id,
      gp_id,
      display_fg,
      stueckliste_anteil,
      anzahl_komponentenmenge_gesamt));

