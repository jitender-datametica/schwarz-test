CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_CPR_BAU_GV_SPR_ZU as

   -- 2017KW50: NAKU2305 . Umbau der Internationalisierung von Tabellen auf Spalten, Erweiterung für Mehrsprachigkeit
   --20180223 nfis0811: Erweiterung für (Spalten)-Internationalisierung

   SELECT
   v02.mandant_id, v01.projekt_id, v01.bau_gv_dok_id, v01.dat_von, v01.dat_bis, MAX(CASE WHEN spr_id =  22 THEN v01.dokument_bez ELSE NULL END) AS dokument_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN v01.dokument_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v01.dokument_bez ELSE NULL END)) AS dokument_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN v01.dokument_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v01.dokument_bez ELSE NULL END)) AS dokument_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN v01.dokument_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v01.dokument_bez ELSE NULL END)) AS dokument_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN v01.dokument_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v01.dokument_bez ELSE NULL END)) AS dokument_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN v01.dokument_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v01.dokument_bez ELSE NULL END)) AS dokument_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN v01.dokument_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v01.dokument_bez ELSE NULL END)) AS dokument_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN v01.dokument_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v01.dokument_bez ELSE NULL END)) AS dokument_bez_bg    --BG
   , MAX(CASE WHEN spr_id =  22 THEN v01.dokument_bez_lang ELSE NULL END) AS dokument_bez_lang                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN v01.dokument_bez_lang ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v01.dokument_bez_lang ELSE NULL END)) AS dokument_bez_lang_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN v01.dokument_bez_lang ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v01.dokument_bez_lang ELSE NULL END)) AS dokument_bez_lang_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN v01.dokument_bez_lang ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v01.dokument_bez_lang ELSE NULL END)) AS dokument_bez_lang_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN v01.dokument_bez_lang ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v01.dokument_bez_lang ELSE NULL END)) AS dokument_bez_lang_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN v01.dokument_bez_lang ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v01.dokument_bez_lang ELSE NULL END)) AS dokument_bez_lang_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN v01.dokument_bez_lang ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v01.dokument_bez_lang ELSE NULL END)) AS dokument_bez_lang_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN v01.dokument_bez_lang ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v01.dokument_bez_lang ELSE NULL END)) AS dokument_bez_lang_bg    --BGdokument_bez_lang
   FROM dbp_view.v_cpr_bau_gv_spr_zu_per v01
   LEFT JOIN dbp_view.v_cpr_projekt_per  v02
   ON  v01.projekt_id = v02.projekt_id
   AND v02.dat_bis = '9999-12-31'


   WHERE
   v01.dat_bis = '9999-12-31'

   GROUP BY   1,2,3,4,5;