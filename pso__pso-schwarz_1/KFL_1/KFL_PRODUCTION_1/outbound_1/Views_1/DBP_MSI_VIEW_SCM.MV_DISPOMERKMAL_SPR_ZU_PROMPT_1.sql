CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_dispomerkmal_spr_zu_prompt_1 AS SELECT V01.dispomerkmal,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN V01.dispomerkmal_bez
   ELSE NULL
   END) AS dispomerkmal_bez,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN V01.dispomerkmal_bez
   ELSE NULL
   END) AS dispomerkmal_bez_de,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 124
    THEN V01.dispomerkmal_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.dispomerkmal_bez
    ELSE NULL
    END)) AS dispomerkmal_bez_cz,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 108
    THEN V01.dispomerkmal_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.dispomerkmal_bez
    ELSE NULL
    END)) AS dispomerkmal_bez_sk,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 65
    THEN V01.dispomerkmal_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.dispomerkmal_bez
    ELSE NULL
    END)) AS dispomerkmal_bez_hr,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 90
    THEN V01.dispomerkmal_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.dispomerkmal_bez
    ELSE NULL
    END)) AS dispomerkmal_bez_pl,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 95
    THEN V01.dispomerkmal_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.dispomerkmal_bez
    ELSE NULL
    END)) AS dispomerkmal_bez_ro,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 18
    THEN V01.dispomerkmal_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.dispomerkmal_bez
    ELSE NULL
    END)) AS dispomerkmal_bez_bg
FROM kfl_production_dbp_view.v_dispomerkmal_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_spr_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.spr_id = V02.spr_id
   
GROUP BY V01.dispomerkmal;