CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ABT_SPR_ZU_INT_2 as
   -- SPRACHE : Abteilung International
   -- 20150907 srom: neue View ohne mandant_2 um die Attribute sauber zu trennen ( Es gibt Abteilung mit und ohne mandant_2)
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   v01.abt_id, v01.arthiertyp_id, MAX(CASE WHEN spr_id =  22 THEN abt_bez ELSE NULL END) AS abt_bez                 -- standard == DE
   , MAX(CASE WHEN spr_id =  22 THEN abt_bez ELSE NULL END) AS abt_bez_de                          -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN abt_bez ELSE NULL END), abt_bez_de) AS abt_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN abt_bez ELSE NULL END), abt_bez_de) AS abt_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN abt_bez ELSE NULL END), abt_bez_de) AS abt_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN abt_bez ELSE NULL END), abt_bez_de) AS abt_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN abt_bez ELSE NULL END), abt_bez_de) AS abt_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN abt_bez ELSE NULL END), abt_bez_de) AS abt_bez_bg    -- BG
   FROM dbp_view.v_abt_spr_zu_2 v01

   WHERE v01.arthiertyp_id = 2

   GROUP BY 1, 2;