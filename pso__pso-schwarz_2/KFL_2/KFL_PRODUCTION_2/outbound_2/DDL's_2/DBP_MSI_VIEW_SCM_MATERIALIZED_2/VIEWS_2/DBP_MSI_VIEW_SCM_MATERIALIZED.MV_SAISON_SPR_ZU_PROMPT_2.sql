-- 2023-02-13,dknop, AP0162072, initial

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_saison_spr_zu_prompt_2 (saison_id, saison_bez,
saison_bez_de, saison_bez_cz, saison_bez_sk, saison_bez_hr, saison_bez_pl, saison_bez_ro, saison_bez_bg) AS SELECT V01.saison_id
 ,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN V01.saison_bez
   ELSE NULL
   END) AS saison_bez,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN V01.saison_bez
   ELSE NULL
   END) AS saison_bez_de,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 124
    THEN V01.saison_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.saison_bez
    ELSE NULL
    END)) AS saison_bez_cz,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 108
    THEN V01.saison_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.saison_bez
    ELSE NULL
    END)) AS saison_bez_sk,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 65
    THEN V01.saison_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.saison_bez
    ELSE NULL
    END)) AS saison_bez_hr,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 90
    THEN V01.saison_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.saison_bez
    ELSE NULL
    END)) AS saison_bez_pl,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 95
    THEN V01.saison_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.saison_bez
    ELSE NULL
    END)) AS saison_bez_ro,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 18
    THEN V01.saison_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.saison_bez
    ELSE NULL
    END)) AS saison_bez_bg
FROM kfl_production_dbp_view.v_saison_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_spr_zu_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.spr_id = V02.spr_id
   
GROUP BY V01.saison_id;