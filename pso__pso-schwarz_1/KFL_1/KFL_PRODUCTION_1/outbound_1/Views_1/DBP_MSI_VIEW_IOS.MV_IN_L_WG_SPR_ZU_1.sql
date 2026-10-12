CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_in_l_wg_spr_zu_1 AS SELECT V01.mandant_id,
 V01.in_wg_id,
 V01.in_wg_struktur_id,
 MAX(CASE
   WHEN V02.spr_id = 22
   THEN V02.in_wg_bez
   ELSE NULL
   END) AS in_wg_bez,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.in_wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.in_wg_bez
    ELSE NULL
    END)) AS in_wg_bez_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.in_wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.in_wg_bez
    ELSE NULL
    END)) AS in_wg_bez_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.in_wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.in_wg_bez
    ELSE NULL
    END)) AS in_wg_bez_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.in_wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.in_wg_bez
    ELSE NULL
    END)) AS in_wg_bez_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.in_wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.in_wg_bez
    ELSE NULL
    END)) AS in_wg_bez_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 24
    THEN V02.in_wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.in_wg_bez
    ELSE NULL
    END)) AS in_wg_bez_en,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.in_wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.in_wg_bez
    ELSE NULL
    END)) AS in_wg_bez_bg,
 MAX(CASE
   WHEN V02.spr_id = 22
   THEN V02.in_wg_bez_lang
   ELSE NULL
   END) AS in_wg_bez_lang,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.in_wg_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.in_wg_bez_lang
    ELSE NULL
    END)) AS in_wg_bez_lang_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.in_wg_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.in_wg_bez_lang
    ELSE NULL
    END)) AS in_wg_bez_lang_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.in_wg_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.in_wg_bez_lang
    ELSE NULL
    END)) AS in_wg_bez_lang_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.in_wg_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.in_wg_bez_lang
    ELSE NULL
    END)) AS in_wg_bez_lang_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.in_wg_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.in_wg_bez_lang
    ELSE NULL
    END)) AS in_wg_bez_lang_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 24
    THEN V02.in_wg_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.in_wg_bez_lang
    ELSE NULL
    END)) AS in_wg_bez_lang_en,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.in_wg_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.in_wg_bez_lang
    ELSE NULL
    END)) AS in_wg_bez_lang_bg
FROM kfl_production_dbp_view.v_in_l_wg_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_in_wg_spr_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.in_wg_id = V02.in_wg_id
   
WHERE SUBSTR(V01.in_wg_id, 1, 1) = 'W'
 OR V01.in_wg_id = '-1'
GROUP BY V01.mandant_id,
 V01.in_wg_id,
 V01.in_wg_struktur_id;