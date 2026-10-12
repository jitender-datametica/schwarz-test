CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WINDRICHTUNG_SPR_ZU_2 as
   SELECT
   v01.windrichtung_schema_id, v01.windrichtung_id, v01.windrichtung_bez_kurz, MAX(CASE WHEN v01.spr_id =  22 THEN v01.windrichtung_bez_lang END) AS windrichtung_bez_lang   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id =  22 THEN v01.windrichtung_bez_lang END) AS windrichtung_bez_lang_de      --DE
   , COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN v01.windrichtung_bez_lang END), windrichtung_bez_lang_de) AS windrichtung_bez_lang_cz    -- CZ
   , COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN v01.windrichtung_bez_lang END), windrichtung_bez_lang_de) AS windrichtung_bez_lang_sk    -- SK
   , COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN v01.windrichtung_bez_lang END), windrichtung_bez_lang_de) AS windrichtung_bez_lang_hr    -- HR
   , COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN v01.windrichtung_bez_lang END), windrichtung_bez_lang_de) AS windrichtung_bez_lang_pl    -- PL
   , COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN v01.windrichtung_bez_lang END), windrichtung_bez_lang_de) AS windrichtung_bez_lang_ro    -- RO
   , COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN v01.windrichtung_bez_lang END), windrichtung_bez_lang_de) AS windrichtung_bez_lang_bg    -- BG
   FROM dbp_view.v_windrichtung_spr_zu_2 v01
   WHERE v01.windrichtung_schema_id=1
   GROUP BY
   v01.windrichtung_schema_id
   , v01.windrichtung_id
   , v01.windrichtung_bez_kurz;