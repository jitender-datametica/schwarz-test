CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_windrichtung_spr_zu_1 AS SELECT windrichtung_schema_id,
 windrichtung_id,
 windrichtung_bez_kurz,
 MAX(CASE
   WHEN spr_id = 22
   THEN windrichtung_bez_lang
   ELSE NULL
   END) AS windrichtung_bez_lang,
 MAX(CASE
   WHEN spr_id = 22
   THEN windrichtung_bez_lang
   ELSE NULL
   END) AS windrichtung_bez_lang_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN windrichtung_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN windrichtung_bez_lang
    ELSE NULL
    END)) AS windrichtung_bez_lang_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN windrichtung_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN windrichtung_bez_lang
    ELSE NULL
    END)) AS windrichtung_bez_lang_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN windrichtung_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN windrichtung_bez_lang
    ELSE NULL
    END)) AS windrichtung_bez_lang_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN windrichtung_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN windrichtung_bez_lang
    ELSE NULL
    END)) AS windrichtung_bez_lang_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN windrichtung_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN windrichtung_bez_lang
    ELSE NULL
    END)) AS windrichtung_bez_lang_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN windrichtung_bez_lang
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN windrichtung_bez_lang
    ELSE NULL
    END)) AS windrichtung_bez_lang_bg
FROM kfl_production_dbp_view.v_windrichtung_spr_zu_1 AS V01
WHERE windrichtung_schema_id = 1
GROUP BY windrichtung_schema_id,
 windrichtung_id,
 windrichtung_bez_kurz;