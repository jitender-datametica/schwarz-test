CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_ek_infosatz_aktuell_gp_2 (mandant_id, ek_infosatz_id,
max_ek_infosatz_id, art_id, akt_gp_id, einkaufsorganisation_id, dat_erstellung, gp_art_id, dat_von, dat_bis,
konditionsgruppe_id, gp_konditionsgruppe_bez) AS (SELECT ek_info.akt_mandant_id AS mandant_id,
  ek_info.akt_ek_infosatz_id AS ek_infosatz_id,
  ek_info.akt_max_ek_infosatz_id AS max_ek_infosatz_id,
  ek_info.akt_art_id AS art_id,
  ek_info.akt_gp_id,
  ek_info.akt_einkaufsorganisation_id AS einkaufsorganisation_id,
  ek_info.dat_erstellung,
  ek_info.gp_art_id,
  ek_info.akt_dat_von AS dat_von,
  ek_info.akt_dat_bis AS dat_bis,
  ek_info.akt_konditionsgruppe_id AS konditionsgruppe_id,
  v03.gp_konditionsgruppe_bez
 FROM (SELECT V01.mandant_id AS akt_mandant_id,
    V01.ek_infosatz_id AS akt_ek_infosatz_id,
    V01.art_id AS akt_art_id,
    V01.gp_id AS akt_gp_id,
    V01.einkaufsorganisation_id AS akt_einkaufsorganisation_id,
    V01.dat_erstellung,
    V01.gp_art_id,
    V01.dat_von AS akt_dat_von,
    V01.dat_bis AS akt_dat_bis,
     CASE
     WHEN DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN V01.dat_von AND V01.dat_bis
     THEN 'X'
     ELSE ' '
     END AS akt_lieferbar_fg,
     CASE
     WHEN V01.regel_gp_fg = 1
     THEN 'X'
     ELSE ' '
     END AS akt_regel_gp_fg,
     CASE
     WHEN V01.loesch_fg = 1
     THEN 'X'
     ELSE ' '
     END AS akt_loesch_fg,
     CASE
     WHEN v02.max_ek_infosatz_id IS NOT NULL
     THEN 'X'
     ELSE ' '
     END AS akt_max_ek_infosatz_fg,
    v02.max_ek_infosatz_id AS akt_max_ek_infosatz_id,
    COALESCE(V01.gp_teilsortiment_id, '999999') AS akt_gp_teilsortiment_id,
    V01.konditionsgruppe_id AS akt_konditionsgruppe_id,
    V01.apollo_ian AS akt_apollo_ian
   FROM kfl_production_dbp_view.v_ek_infosatz_2 AS V01
    LEFT JOIN (SELECT mandant_id,
      art_id,
      MAX(ek_infosatz_id) AS max_ek_infosatz_id
     FROM kfl_production_dbp_view.v_ek_infosatz_2
     WHERE mandant_id = 1
     GROUP BY mandant_id,
      art_id) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.art_id = v02.art_id AND V01.ek_infosatz_id = v02.max_ek_infosatz_id
      
   WHERE V01.mandant_id = 1
   QUALIFY (RANK() OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.art_id AS STRING), CAST(V01.gp_id AS STRING)
         ORDER BY V01.ek_infosatz_id IS NULL, V01.ek_infosatz_id)) = 1) AS ek_info
  LEFT JOIN (SELECT mandant_id,
    gp_id,
    konditionsgruppe_id,
    spr_id,
    gp_konditionsgruppe_bez
   FROM kfl_production_dbp_view.v_gp_konditionsgruppe_spr_zu_2
   WHERE mandant_id = 1) AS v03 ON ek_info.akt_mandant_id = v03.mandant_id AND ek_info.akt_gp_id = v03.gp_id AND ek_info
    .akt_konditionsgruppe_id = v03.konditionsgruppe_id
 WHERE ek_info.akt_mandant_id = 1
  AND (ek_info.akt_mandant_id, ek_info.akt_art_id, ek_info.akt_gp_id) IN (SELECT (mandant_id, art_id, gp_id)
    FROM kfl_production_dbp_data.art_gp_nm_zu_per_2
    WHERE mandant_id = 1
     AND dat_bis = DATE '9999-12-31')
  AND CURRENT_DATE BETWEEN ek_info.akt_dat_von AND ek_info.akt_dat_bis
  AND (ek_info.akt_mandant_id, ek_info.akt_art_id) IN (SELECT (mandant_id, art_id)
    FROM (SELECT mandant_id,
       art_id,
       COUNT(*) AS dub
      FROM kfl_production_dbp_data.ek_infosatz_2
      WHERE dat_bis = DATE '9999-12-31'
       AND mandant_id = 1
       AND (mandant_id, art_id, gp_id) IN (SELECT (mandant_id, art_id, gp_id)
         FROM kfl_production_dbp_data.art_gp_nm_zu_per_2
         WHERE mandant_id = 1
          AND dat_bis = DATE '9999-12-31')
      GROUP BY mandant_id,
       art_id
      HAVING dub = 1) AS t14)
 UNION DISTINCT
 SELECT ek_info.akt_mandant_id AS mandant_id,
  ek_info.akt_ek_infosatz_id AS ek_infosatz_id,
  ek_info.akt_max_ek_infosatz_id AS max_ek_infosatz_id,
  ek_info.akt_art_id AS art_id,
  ek_info.akt_gp_id,
  ek_info.akt_einkaufsorganisation_id AS einkaufsorganisation_id,
  ek_info.dat_erstellung,
  ek_info.gp_art_id,
  ek_info.akt_dat_von AS dat_von,
  ek_info.akt_dat_bis AS dat_bis,
  ek_info.akt_konditionsgruppe_id AS konditionsgruppe_id,
  v03.gp_konditionsgruppe_bez
 FROM (SELECT V01.mandant_id AS akt_mandant_id,
    V01.ek_infosatz_id AS akt_ek_infosatz_id,
    V01.art_id AS akt_art_id,
    V01.gp_id AS akt_gp_id,
    V01.einkaufsorganisation_id AS akt_einkaufsorganisation_id,
    V01.dat_erstellung,
    V01.gp_art_id,
    V01.dat_von AS akt_dat_von,
    V01.dat_bis AS akt_dat_bis,
     CASE
     WHEN DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN V01.dat_von AND V01.dat_bis
     THEN 'X'
     ELSE ' '
     END AS akt_lieferbar_fg,
     CASE
     WHEN V01.regel_gp_fg = 1
     THEN 'X'
     ELSE ' '
     END AS akt_regel_gp_fg,
     CASE
     WHEN V01.loesch_fg = 1
     THEN 'X'
     ELSE ' '
     END AS akt_loesch_fg,
     CASE
     WHEN v02.max_ek_infosatz_id IS NOT NULL
     THEN 'X'
     ELSE ' '
     END AS akt_max_ek_infosatz_fg,
    v02.max_ek_infosatz_id AS akt_max_ek_infosatz_id,
    COALESCE(V01.gp_teilsortiment_id, '999999') AS akt_gp_teilsortiment_id,
    V01.konditionsgruppe_id AS akt_konditionsgruppe_id,
    V01.apollo_ian AS akt_apollo_ian
   FROM kfl_production_dbp_view.v_ek_infosatz_2 AS V01
    LEFT JOIN (SELECT mandant_id,
      art_id,
      MAX(ek_infosatz_id) AS max_ek_infosatz_id
     FROM kfl_production_dbp_view.v_ek_infosatz_2
     WHERE mandant_id = 1
     GROUP BY mandant_id,
      art_id) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.art_id = v02.art_id AND V01.ek_infosatz_id = v02.max_ek_infosatz_id
      
   WHERE V01.mandant_id = 1
   QUALIFY (RANK() OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.art_id AS STRING), CAST(V01.gp_id AS STRING)
         ORDER BY V01.ek_infosatz_id IS NULL, V01.ek_infosatz_id)) = 1) AS ek_info
  LEFT JOIN (SELECT mandant_id,
    gp_id,
    konditionsgruppe_id,
    spr_id,
    gp_konditionsgruppe_bez
   FROM kfl_production_dbp_view.v_gp_konditionsgruppe_spr_zu_2
   WHERE mandant_id = 1) AS v03 ON ek_info.akt_mandant_id = v03.mandant_id AND ek_info.akt_gp_id = v03.gp_id AND ek_info
    .akt_konditionsgruppe_id = v03.konditionsgruppe_id
 WHERE ek_info.akt_mandant_id = 1
  AND (ek_info.akt_mandant_id, ek_info.akt_art_id, ek_info.akt_gp_id) IN (SELECT (mandant_id, art_id, gp_id)
    FROM kfl_production_dbp_data.art_gp_nm_zu_per_2
    WHERE mandant_id = 1
     AND dat_bis = DATE '9999-12-31')
  AND CURRENT_DATE BETWEEN ek_info.akt_dat_von AND ek_info.akt_dat_bis
  AND ek_info.akt_regel_gp_fg = 'X'
  AND ek_info.akt_loesch_fg <> 'X'
  AND (ek_info.akt_mandant_id, ek_info.akt_art_id) IN (SELECT (mandant_id, art_id)
    FROM (SELECT mandant_id,
       art_id,
       COUNT(*) AS dub
      FROM kfl_production_dbp_data.ek_infosatz_2
      WHERE dat_bis = DATE '9999-12-31'
       AND mandant_id = 1
       AND (mandant_id, art_id, gp_id) IN (SELECT (mandant_id, art_id, gp_id)
         FROM kfl_production_dbp_data.art_gp_nm_zu_per_2
         WHERE mandant_id = 1
          AND dat_bis = DATE '9999-12-31')
      GROUP BY mandant_id,
       art_id
      HAVING dub <> 1) AS t33))
UNION DISTINCT
SELECT ek_info.akt_mandant_id AS mandant_id,
 ek_info.akt_ek_infosatz_id AS ek_infosatz_id,
 ek_info.akt_max_ek_infosatz_id AS max_ek_infosatz_id,
 ek_info.akt_art_id AS art_id,
 ek_info.akt_gp_id,
 ek_info.akt_einkaufsorganisation_id AS einkaufsorganisation_id,
 ek_info.dat_erstellung,
 ek_info.gp_art_id,
 ek_info.akt_dat_von AS dat_von,
 ek_info.akt_dat_bis AS dat_bis,
 ek_info.akt_konditionsgruppe_id AS konditionsgruppe_id,
 v03.gp_konditionsgruppe_bez
FROM (SELECT V01.mandant_id AS akt_mandant_id,
   V01.ek_infosatz_id AS akt_ek_infosatz_id,
   V01.art_id AS akt_art_id,
   V01.gp_id AS akt_gp_id,
   V01.einkaufsorganisation_id AS akt_einkaufsorganisation_id,
   V01.dat_erstellung,
   V01.gp_art_id,
   V01.dat_von AS akt_dat_von,
   V01.dat_bis AS akt_dat_bis,
    CASE
    WHEN DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN V01.dat_von AND V01.dat_bis
    THEN 'X'
    ELSE ' '
    END AS akt_lieferbar_fg,
    CASE
    WHEN V01.regel_gp_fg = 1
    THEN 'X'
    ELSE ' '
    END AS akt_regel_gp_fg,
    CASE
    WHEN V01.loesch_fg = 1
    THEN 'X'
    ELSE ' '
    END AS akt_loesch_fg,
    CASE
    WHEN v02.max_ek_infosatz_id IS NOT NULL
    THEN 'X'
    ELSE ' '
    END AS akt_max_ek_infosatz_fg,
   v02.max_ek_infosatz_id AS akt_max_ek_infosatz_id,
   COALESCE(V01.gp_teilsortiment_id, '999999') AS akt_gp_teilsortiment_id,
   V01.konditionsgruppe_id AS akt_konditionsgruppe_id,
   V01.apollo_ian AS akt_apollo_ian
  FROM kfl_production_dbp_view.v_ek_infosatz_2 AS V01
   LEFT JOIN (SELECT mandant_id,
     art_id,
     MAX(ek_infosatz_id) AS max_ek_infosatz_id
    FROM kfl_production_dbp_view.v_ek_infosatz_2
    WHERE mandant_id = 1
    GROUP BY mandant_id,
     art_id) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.art_id = v02.art_id AND V01.ek_infosatz_id = v02.max_ek_infosatz_id
     
  WHERE V01.mandant_id = 1
  QUALIFY (RANK() OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.art_id AS STRING), CAST(V01.gp_id AS STRING)
        ORDER BY V01.ek_infosatz_id IS NULL, V01.ek_infosatz_id)) = 1) AS ek_info
 LEFT JOIN (SELECT mandant_id,
   gp_id,
   konditionsgruppe_id,
   spr_id,
   gp_konditionsgruppe_bez
  FROM kfl_production_dbp_view.v_gp_konditionsgruppe_spr_zu_2
  WHERE mandant_id = 1) AS v03 ON ek_info.akt_mandant_id = v03.mandant_id AND ek_info.akt_gp_id = v03.gp_id AND ek_info
   .akt_konditionsgruppe_id = v03.konditionsgruppe_id
WHERE ek_info.akt_mandant_id = 1
 AND (ek_info.akt_mandant_id, ek_info.akt_art_id, ek_info.akt_gp_id) IN (SELECT (mandant_id, art_id, gp_id)
   FROM kfl_production_dbp_data.art_gp_nm_zu_per_2
   WHERE mandant_id = 1
    AND dat_bis = DATE '9999-12-31')
 AND CURRENT_DATE BETWEEN ek_info.akt_dat_von AND ek_info.akt_dat_bis
 AND ek_info.akt_regel_gp_fg <> 'X'
 AND ek_info.akt_max_ek_infosatz_fg = 'X'
 AND ek_info.akt_loesch_fg <> 'X'
 AND (ek_info.akt_mandant_id, ek_info.akt_art_id) IN (SELECT (mandant_id, art_id)
   FROM (SELECT mandant_id,
      art_id,
      COUNT(*) AS dub
     FROM kfl_production_dbp_data.ek_infosatz_2
     WHERE dat_bis = DATE '9999-12-31'
      AND mandant_id = 1
      AND (mandant_id, art_id, gp_id) IN (SELECT (mandant_id, art_id, gp_id)
        FROM kfl_production_dbp_data.art_gp_nm_zu_per_2
        WHERE mandant_id = 1
         AND dat_bis = DATE '9999-12-31')
     GROUP BY mandant_id,
      art_id
     HAVING dub <> 1) AS t52)
 AND (ek_info.akt_mandant_id, ek_info.akt_art_id) NOT IN (SELECT (mandant_id, art_id)
   FROM kfl_production_dbp_data.ek_infosatz_2
   WHERE mandant_id = 1
    AND regel_gp_fg = 1
    AND CURRENT_DATE BETWEEN dat_von AND dat_bis
    AND (mandant_id, art_id, gp_id) IN (SELECT (mandant_id, art_id, gp_id)
      FROM kfl_production_dbp_data.art_gp_nm_zu_per_2
      WHERE mandant_id = 1
       AND dat_bis = DATE '9999-12-31'));