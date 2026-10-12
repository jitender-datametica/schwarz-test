CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_in_wg_spr_zu_2 (mandant_id, in_wg_id, in_wg_bez, in_wg_bez_de,
in_wg_bez_cz, in_wg_bez_sk, in_wg_bez_hr, in_wg_bez_pl, in_wg_bez_ro, in_wg_bez_bg, in_wg_bez_lang, in_wg_bez_lang_de,
in_wg_bez_lang_cz, in_wg_bez_lang_sk, in_wg_bez_lang_hr, in_wg_bez_lang_pl, in_wg_bez_lang_ro, in_wg_bez_lang_bg) AS
SELECT mandant_id,
 in_wg_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN in_wg_bez
   ELSE NULL
   END) AS in_wg_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN in_wg_bez
   ELSE NULL
   END) AS in_wg_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN in_wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN in_wg_bez
    ELSE NULL
    END)) AS in_wg_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN in_wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN in_wg_bez
    ELSE NULL
    END)) AS in_wg_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN in_wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN in_wg_bez
    ELSE NULL
    END)) AS in_wg_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN in_wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN in_wg_bez
    ELSE NULL
    END)) AS in_wg_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN in_wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN in_wg_bez
    ELSE NULL
    END)) AS in_wg_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN in_wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN in_wg_bez
    ELSE NULL
    END)) AS in_wg_bez_bg,
 MAX(CASE
   WHEN spr_id = 22
   THEN in_wg_bez_lang
   ELSE NULL
   END) AS in_wg_bez_lang,
 MAX(CASE
   WHEN spr_id = 22
   THEN in_wg_bez_lang
   ELSE NULL
   END) AS in_wg_bez_lang_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN in_wg_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN in_wg_bez_lang
    ELSE NULL
    END)) AS in_wg_bez_lang_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN in_wg_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN in_wg_bez_lang
    ELSE NULL
    END)) AS in_wg_bez_lang_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN in_wg_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN in_wg_bez_lang
    ELSE NULL
    END)) AS in_wg_bez_lang_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN in_wg_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN in_wg_bez_lang
    ELSE NULL
    END)) AS in_wg_bez_lang_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN in_wg_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN in_wg_bez_lang
    ELSE NULL
    END)) AS in_wg_bez_lang_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN in_wg_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN in_wg_bez_lang
    ELSE NULL
    END)) AS in_wg_bez_lang_bg
FROM kfl_production_dbp_view.v_in_wg_spr_zu_2 AS V01
GROUP BY mandant_id,
 in_wg_id;