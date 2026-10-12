CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ALTERSSTRUKTUR_SPR_ZU_2 as
   -- LOOKUP/SPRACHE Alterstruktur
   -- Bezeichnungen nur in Sprache DE vorhanden
   -- 2010KW17 Review
   -- 2011KW37: Internationaliserung (feste Sprache)
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   v01.altersstruktur_id, MAX(CASE WHEN spr_id =  22 THEN altersstruktur_bez END) AS altersstruktur_bez                 -- standard == DE
   , MAX(CASE WHEN spr_id =  22 THEN altersstruktur_bez END) AS altersstruktur_bez_de                          -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN altersstruktur_bez END), altersstruktur_bez_de) AS altersstruktur_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN altersstruktur_bez END), altersstruktur_bez_de) AS altersstruktur_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN altersstruktur_bez END), altersstruktur_bez_de) AS altersstruktur_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN altersstruktur_bez END), altersstruktur_bez_de) AS altersstruktur_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN altersstruktur_bez END), altersstruktur_bez_de) AS altersstruktur_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN altersstruktur_bez END), altersstruktur_bez_de) AS altersstruktur_bez_bg    -- BG
   FROM dbp_view.v_altersstruktur_spr_zu_2  v01

   GROUP BY 1;