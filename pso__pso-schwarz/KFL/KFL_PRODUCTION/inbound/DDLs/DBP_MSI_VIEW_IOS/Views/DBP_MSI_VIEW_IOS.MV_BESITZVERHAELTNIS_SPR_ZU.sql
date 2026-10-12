CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_BESITZVERHAELTNIS_SPR_ZU AS
   -- Faktview : Besitzverhaeltnis gemäß: AP0004980
   -- 20161202 kkai0912 : initial
   --20180313 nfis0811: Erweiterung für (Spalten)-Internationalisierung

   SELECT
   v01.besitzverhaeltnis_id, MAX(CASE WHEN spr_id =  22 THEN v02.besitzverhaeltnis_bez ELSE NULL END) AS besitzverhaeltnis_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN v02.besitzverhaeltnis_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.besitzverhaeltnis_bez ELSE NULL END)) AS besitzverhaeltnis_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN v02.besitzverhaeltnis_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.besitzverhaeltnis_bez ELSE NULL END)) AS besitzverhaeltnis_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN v02.besitzverhaeltnis_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.besitzverhaeltnis_bez ELSE NULL END)) AS besitzverhaeltnis_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN v02.besitzverhaeltnis_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.besitzverhaeltnis_bez ELSE NULL END)) AS besitzverhaeltnis_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN v02.besitzverhaeltnis_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.besitzverhaeltnis_bez ELSE NULL END)) AS besitzverhaeltnis_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN v02.besitzverhaeltnis_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.besitzverhaeltnis_bez ELSE NULL END)) AS besitzverhaeltnis_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN v02.besitzverhaeltnis_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.besitzverhaeltnis_bez ELSE NULL END)) AS besitzverhaeltnis_bez_bg    -- BG


   FROM dbp_view.v_l_besitzverhaeltnis v01
   JOIN dbp_view.v_besitzverhaeltnis_spr_zu v02
   ON v01.besitzverhaeltnis_id = v02.besitzverhaeltnis_id
   --AND v02.spr_id = 22
   GROUP BY
   v01.besitzverhaeltnis_id

   UNION ALL
-- Dummywert
   SELECT

   ' -1' AS besitzverhaeltnis_id, ' ' AS besitzverhaeltnis_bez, ' ', ' ', ' ', ' ', ' ', ' ', ' '
;