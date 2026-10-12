CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_ABSCHLGRUND_SPR_ZU_2 as
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   v01.abschlussgrund_id, MAX(CASE WHEN spr_id =  22 THEN abschlussgrund_bez END) AS abschlussgrund_bez                -- standard == DE
   , MAX(CASE WHEN spr_id =  22 THEN abschlussgrund_bez END) AS abschlussgrund_bez_de                         -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN abschlussgrund_bez END), abschlussgrund_bez_de) AS abschlussgrund_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN abschlussgrund_bez END), abschlussgrund_bez_de) AS abschlussgrund_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN abschlussgrund_bez END), abschlussgrund_bez_de) AS abschlussgrund_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN abschlussgrund_bez END), abschlussgrund_bez_de) AS abschlussgrund_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN abschlussgrund_bez END), abschlussgrund_bez_de) AS abschlussgrund_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN abschlussgrund_bez END), abschlussgrund_bez_de) AS abschlussgrund_bez_bg    -- BG

   FROM dbp_view.v_geku_abschlussgrund_spr_zu_2  v01

   GROUP BY 1;