CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ABT_SPR_ZU_1 as
   -- SPRACHE : Abteilung
   -- userabhaengige Bezeichnung
   -- 2010KW07 : arthiertyp_1 2 für 3stellige WG
   -- 2011KW37 : Internationalisierung (feste Sprache)
   -- 2015-07-17 : join ueber abt_1 - Alle kombinatione Land_1/Sprache
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   v01.mandant_id, v01.arthiertyp_id, v01.abt_id, MAX(CASE WHEN spr_id =  22 THEN abt_bez END) AS abt_bez                 -- standard == DE
   , MAX(CASE WHEN spr_id =  22 THEN abt_bez END) AS abt_bez_de                          -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN abt_bez END), abt_bez_de) AS abt_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN abt_bez END), abt_bez_de) AS abt_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN abt_bez END), abt_bez_de) AS abt_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN abt_bez END), abt_bez_de) AS abt_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN abt_bez END), abt_bez_de) AS abt_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN abt_bez END), abt_bez_de) AS abt_bez_bg    -- BG
   FROM dbp_view.v_abt_spr_zu_1  v01

   WHERE v01.arthiertyp_id = 2

   GROUP BY 1,2,3;