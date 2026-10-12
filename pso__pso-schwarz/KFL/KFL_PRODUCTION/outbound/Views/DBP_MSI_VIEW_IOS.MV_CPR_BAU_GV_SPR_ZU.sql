CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_cpr_bau_gv_spr_zu AS SELECT V02.mandant_id,
 V01.projekt_id,
 V01.bau_gv_dok_id,
 V01.dat_von,
 V01.dat_bis,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN V01.dokument_bez
   ELSE NULL
   END) AS dokument_bez,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 124
    THEN V01.dokument_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.dokument_bez
    ELSE NULL
    END)) AS dokument_bez_cz,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 108
    THEN V01.dokument_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.dokument_bez
    ELSE NULL
    END)) AS dokument_bez_sk,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 65
    THEN V01.dokument_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.dokument_bez
    ELSE NULL
    END)) AS dokument_bez_hr,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 90
    THEN V01.dokument_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.dokument_bez
    ELSE NULL
    END)) AS dokument_bez_pl,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 95
    THEN V01.dokument_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.dokument_bez
    ELSE NULL
    END)) AS dokument_bez_ro,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 24
    THEN V01.dokument_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.dokument_bez
    ELSE NULL
    END)) AS dokument_bez_en,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 18
    THEN V01.dokument_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.dokument_bez
    ELSE NULL
    END)) AS dokument_bez_bg,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN V01.dokument_bez_lang
   ELSE NULL
   END) AS dokument_bez_lang,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 124
    THEN V01.dokument_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.dokument_bez_lang
    ELSE NULL
    END)) AS dokument_bez_lang_cz,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 108
    THEN V01.dokument_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.dokument_bez_lang
    ELSE NULL
    END)) AS dokument_bez_lang_sk,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 65
    THEN V01.dokument_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.dokument_bez_lang
    ELSE NULL
    END)) AS dokument_bez_lang_hr,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 90
    THEN V01.dokument_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.dokument_bez_lang
    ELSE NULL
    END)) AS dokument_bez_lang_pl,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 95
    THEN V01.dokument_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.dokument_bez_lang
    ELSE NULL
    END)) AS dokument_bez_lang_ro,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 24
    THEN V01.dokument_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.dokument_bez_lang
    ELSE NULL
    END)) AS dokument_bez_lang_en,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 18
    THEN V01.dokument_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.dokument_bez_lang
    ELSE NULL
    END)) AS dokument_bez_lang_bg
FROM kfl_production_dbp_view.v_cpr_bau_gv_spr_zu_per AS V01
 LEFT JOIN kfl_production_dbp_view.v_cpr_projekt_per AS V02 ON V01.projekt_id = V02.projekt_id AND V02.dat_bis =
   DATE '9999-12-31'
WHERE V01.dat_bis = DATE '9999-12-31'
GROUP BY V02.mandant_id,
 V01.projekt_id,
 V01.bau_gv_dok_id,
 V01.dat_von,
 V01.dat_bis;