CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_BEDIENKONZEPT_AUSPR_SPR_ZU as
   -- AL 12.10.2011 neu erstellt
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten


   SELECT
   v01.bedienkonzept_id, v01.bedienkonzept_auspr_id, MAX(CASE WHEN spr_id =  22 THEN bedienkonzept_auspr_bez END) AS bedienkonzept_auspr_bez                 -- standard == DE
   , MAX(CASE WHEN spr_id =  22 THEN bedienkonzept_auspr_bez END) AS bedienkonzept_auspr_bez_de                          -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN bedienkonzept_auspr_bez END), bedienkonzept_auspr_bez_de) AS bedienkonzept_auspr_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN bedienkonzept_auspr_bez END), bedienkonzept_auspr_bez_de) AS bedienkonzept_auspr_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN bedienkonzept_auspr_bez END), bedienkonzept_auspr_bez_de) AS bedienkonzept_auspr_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN bedienkonzept_auspr_bez END), bedienkonzept_auspr_bez_de) AS bedienkonzept_auspr_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN bedienkonzept_auspr_bez END), bedienkonzept_auspr_bez_de) AS bedienkonzept_auspr_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN bedienkonzept_auspr_bez END), bedienkonzept_auspr_bez_de) AS bedienkonzept_auspr_bez_bg    -- BG

   FROM dbp_view.v_bedienkonzept_auspr_spr_zu  v01

   GROUP BY 1,2;