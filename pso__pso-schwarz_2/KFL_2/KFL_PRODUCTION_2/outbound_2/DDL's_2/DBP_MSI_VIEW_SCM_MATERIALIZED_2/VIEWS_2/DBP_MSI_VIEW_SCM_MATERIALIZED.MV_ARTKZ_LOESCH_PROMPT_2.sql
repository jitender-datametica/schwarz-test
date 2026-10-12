-- CZ
 -- standard == DE
 -- standard == DE
 -- PL
 -- HR
 -- RO
 -- SK
 -- SK
 -- PL
 -- RO
 -- BG
 -- CZ
 -- BG

-- DE
 -- HR
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_artkz_loesch_prompt_2 (loesch_id,
loesch_bez, loesch_bez_de, loesch_bez_cz, loesch_bez_sk, loesch_bez_hr, loesch_bez_pl, loesch_bez_ro, loesch_bez_bg) AS
SELECT V01.loesch_id,
 MAX(CASE
   WHEN V01.spr_id = 22 AND V01.loesch_id <> ' '
   THEN V01.loesch_bez
   WHEN V01.spr_id = 22 AND V01.loesch_id = ' '
   THEN 'leer/empty'
   ELSE NULL
   END) AS loesch_bez,
 MAX(CASE
   WHEN V01.spr_id = 22 AND V01.loesch_id <> ' '
   THEN V01.loesch_bez
   WHEN V01.spr_id = 22 AND V01.loesch_id = ' '
   THEN 'leer/empty'
   ELSE NULL
   END) AS loesch_bez_de,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 124 AND V01.loesch_id <> ' '
    THEN V01.loesch_bez
    WHEN V01.spr_id = 124 AND V01.loesch_id = ' '
    THEN 'leer/empty'
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22 AND V01.loesch_id <> ' '
    THEN V01.loesch_bez
    WHEN V01.spr_id = 22 AND V01.loesch_id = ' '
    THEN 'leer/empty'
    ELSE NULL
    END)) AS loesch_bez_cz,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 108 AND V01.loesch_id <> ' '
    THEN V01.loesch_bez
    WHEN V01.spr_id = 108 AND V01.loesch_id = ' '
    THEN 'leer/empty'
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22 AND V01.loesch_id <> ' '
    THEN V01.loesch_bez
    WHEN V01.spr_id = 22 AND V01.loesch_id = ' '
    THEN 'leer/empty'
    ELSE NULL
    END)) AS loesch_bez_sk,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 65 AND V01.loesch_id <> ' '
    THEN V01.loesch_bez
    WHEN V01.spr_id = 65 AND V01.loesch_id = ' '
    THEN 'leer/empty'
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22 AND V01.loesch_id <> ' '
    THEN V01.loesch_bez
    WHEN V01.spr_id = 22 AND V01.loesch_id = ' '
    THEN 'leer/empty'
    ELSE NULL
    END)) AS loesch_bez_hr,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 90 AND V01.loesch_id <> ' '
    THEN V01.loesch_bez
    WHEN V01.spr_id = 90 AND V01.loesch_id = ' '
    THEN 'leer/empty'
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22 AND V01.loesch_id <> ' '
    THEN V01.loesch_bez
    WHEN V01.spr_id = 22 AND V01.loesch_id = ' '
    THEN 'leer/empty'
    ELSE NULL
    END)) AS loesch_bez_pl,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 95 AND V01.loesch_id <> ' '
    THEN V01.loesch_bez
    WHEN V01.spr_id = 95 AND V01.loesch_id = ' '
    THEN 'leer/empty'
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22 AND V01.loesch_id <> ' '
    THEN V01.loesch_bez
    WHEN V01.spr_id = 22 AND V01.loesch_id = ' '
    THEN 'leer/empty'
    ELSE NULL
    END)) AS loesch_bez_ro,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 18 AND V01.loesch_id <> ' '
    THEN V01.loesch_bez
    WHEN V01.spr_id = 18 AND V01.loesch_id = ' '
    THEN 'leer/empty'
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22 AND V01.loesch_id <> ' '
    THEN V01.loesch_bez
    WHEN V01.spr_id = 22 AND V01.loesch_id = ' '
    THEN 'leer/empty'
    ELSE NULL
    END)) AS loesch_bez_bg
FROM kfl_production_dbp_view.v_artkz_loesch_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_spr_zu_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.spr_id = V02.spr_id
   
GROUP BY V01.loesch_id
UNION ALL
SELECT ' ' AS loesch_id,
 'leer/empty' AS loesch_bez,
 'leer/empty' AS loesch_bez_de,
 'leer/empty' AS loesch_bez_cz,
 'leer/empty' AS loesch_bez_sk,
 'leer/empty' AS loesch_bez_hr,
 'leer/empty' AS loesch_bez_pl,
 'leer/empty' AS loesch_bez_ro,
 'leer/empty' AS loesch_bez_bg
FROM kfl_production_dbp_view.v_mandant_2 AS V02
GROUP BY loesch_id;