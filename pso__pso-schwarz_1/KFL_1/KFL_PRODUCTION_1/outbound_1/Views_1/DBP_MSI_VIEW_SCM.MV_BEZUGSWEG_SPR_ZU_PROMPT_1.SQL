CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_bezugsweg_spr_zu_prompt_1 (bezugsweg_id, bezugsweg_bez,
bezugsweg_bez_de, bezugsweg_bez_cz, bezugsweg_bez_sk, bezugsweg_bez_hr, bezugsweg_bez_pl, bezugsweg_bez_ro,
bezugsweg_bez_bg) AS SELECT V01.bezugsweg_id,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN V01.bezugsweg_bez
   ELSE NULL
   END) AS bezugsweg_bez,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN V01.bezugsweg_bez
   ELSE NULL
   END) AS bezugsweg_bez_de,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 124
    THEN V01.bezugsweg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.bezugsweg_bez
    ELSE NULL
    END)) AS bezugsweg_bez_cz,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 108
    THEN V01.bezugsweg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.bezugsweg_bez
    ELSE NULL
    END)) AS bezugsweg_bez_sk,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 65
    THEN V01.bezugsweg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.bezugsweg_bez
    ELSE NULL
    END)) AS bezugsweg_bez_hr,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 90
    THEN V01.bezugsweg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.bezugsweg_bez
    ELSE NULL
    END)) AS bezugsweg_bez_pl,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 95
    THEN V01.bezugsweg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.bezugsweg_bez
    ELSE NULL
    END)) AS bezugsweg_bez_ro,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 18
    THEN V01.bezugsweg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.bezugsweg_bez
    ELSE NULL
    END)) AS bezugsweg_bez_bg
FROM kfl_production_dbp_view.v_bezugsweg_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_spr_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.spr_id = V02.spr_id
   
GROUP BY V01.bezugsweg_id;