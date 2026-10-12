CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ART_SPR_ZU_1 as
     -- 2011KW37: Internationaliserung (feste Sprache)
   -- 2015KW46: Erweiterung um alle Abschriftarten, für Mehrsprachigkeit im CUBE
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten
   -- 20200622 ssch0611 : new columns (multi-language bez + nr)

   SELECT
   v01.mandant_id
   , v01.art_id
   , TO_VARCHAR((CASE WHEN mandant_id=1 
                  THEN v01.art_id / 100 
                ELSE v01.art_id / 10 
             END), 'FM00000000')                                 AS kl_art_nr
   , MAX(CASE WHEN spr_id =  22 THEN art_bez END) AS art_bez                 -- standard == DE
   , MAX(CASE WHEN spr_id =  22 THEN art_bez END) AS art_bez_de                          -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN art_bez END), art_bez_de) AS art_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN art_bez END), art_bez_de) AS art_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN art_bez END), art_bez_de) AS art_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN art_bez END), art_bez_de) AS art_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN art_bez END), art_bez_de) AS art_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN art_bez END), art_bez_de) AS art_bez_bg    -- BG
   , (art_bez_de || ' (' || kl_art_nr ||  ')' )                          AS art_nr_bez       -- standard (de)
   , (art_bez_de || ' (' || kl_art_nr ||  ')' )                          AS art_nr_bez_de    -- DE
   , (art_bez_cz || ' (' || kl_art_nr ||  ')' )                          AS art_nr_bez_cz    -- CZ
   , (art_bez_sk || ' (' || kl_art_nr ||  ')' )                          AS art_nr_bez_sk    -- SK
   , (art_bez_hr || ' (' || kl_art_nr ||  ')' )                          AS art_nr_bez_hr    -- HR
   , (art_bez_pl || ' (' || kl_art_nr ||  ')' )                          AS art_nr_bez_pl    -- PL
   , (art_bez_ro || ' (' || kl_art_nr ||  ')' )                          AS art_nr_bez_ro    -- RO
   , (art_bez_bg || ' (' || kl_art_nr ||  ')' )                          AS art_nr_bez_bg    -- BG

   FROM dbp_view.v_art_spr_zu_1 v01

   GROUP BY 1,2,3
   ;
      