CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ART_FEHLGRUND_SPR_ZU as

   --2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   v01.mandant_id, v01.art_fehlgrund_id, MAX(CASE WHEN spr_id =  22 THEN art_fehlgrund_bez END) AS art_fehlgrund_bez                 -- standard == DE
   , MAX(CASE WHEN spr_id =  22 THEN art_fehlgrund_bez END) AS art_fehlgrund_bez_de                          -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN art_fehlgrund_bez END), art_fehlgrund_bez_de) AS art_fehlgrund_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN art_fehlgrund_bez END), art_fehlgrund_bez_de) AS art_fehlgrund_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN art_fehlgrund_bez END), art_fehlgrund_bez_de) AS art_fehlgrund_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN art_fehlgrund_bez END), art_fehlgrund_bez_de) AS art_fehlgrund_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN art_fehlgrund_bez END), art_fehlgrund_bez_de) AS art_fehlgrund_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN art_fehlgrund_bez END), art_fehlgrund_bez_de) AS art_fehlgrund_bez_bg    -- BG

   FROM dbp_view.v_art_fehlgrund_spr_zu  v01

   GROUP BY 1,2;