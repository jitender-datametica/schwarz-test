CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_CPR_ANLASS_SPR_ZU as

   SELECT
   v01.projekt_anlass_id, MAX(CASE WHEN spr_id =  22 THEN projekt_anlass_bez ELSE NULL END) AS projekt_anlass_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN projekt_anlass_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN projekt_anlass_bez ELSE NULL END)) AS projekt_anlass_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN projekt_anlass_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN projekt_anlass_bez ELSE NULL END))  AS projekt_anlass_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN projekt_anlass_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN projekt_anlass_bez ELSE NULL END))  AS projekt_anlass_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN projekt_anlass_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN projekt_anlass_bez ELSE NULL END))  AS projekt_anlass_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN projekt_anlass_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN projekt_anlass_bez ELSE NULL END))  AS projekt_anlass_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN projekt_anlass_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN projekt_anlass_bez ELSE NULL END))  AS projekt_anlass_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN projekt_anlass_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN projekt_anlass_bez ELSE NULL END))  AS projekt_anlass_bez_bg    -- BG


   FROM dbp_view.v_cpr_anlass_spr_zu v01

   GROUP BY   1;