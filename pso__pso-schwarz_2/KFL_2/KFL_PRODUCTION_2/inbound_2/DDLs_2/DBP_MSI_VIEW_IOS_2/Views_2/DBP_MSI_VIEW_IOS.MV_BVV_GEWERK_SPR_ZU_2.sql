CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_BVV_GEWERK_SPR_ZU_2 as


   SELECT
   --v01.bvv_leist_id --AS bvv_gewerk_sort
   v01.psp_end_nr AS bvv_gewerk_id, MAX(CASE WHEN spr_id =  22 THEN v02.bvv_gewerk_bez ELSE NULL END) AS bvv_gewerk_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN v02.bvv_gewerk_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.bvv_gewerk_bez ELSE NULL END)) AS bvv_gewerk_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN v02.bvv_gewerk_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.bvv_gewerk_bez ELSE NULL END)) AS bvv_gewerk_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN v02.bvv_gewerk_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.bvv_gewerk_bez ELSE NULL END)) AS bvv_gewerk_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN v02.bvv_gewerk_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.bvv_gewerk_bez ELSE NULL END)) AS bvv_gewerk_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN v02.bvv_gewerk_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.bvv_gewerk_bez ELSE NULL END)) AS bvv_gewerk_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN v02.bvv_gewerk_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.bvv_gewerk_bez ELSE NULL END)) AS bvv_gewerk_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN v02.bvv_gewerk_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.bvv_gewerk_bez ELSE NULL END)) AS bvv_gewerk_bez_bg    -- BG

   FROM dbp_view.v_l_bvv_leistung_2 v01
   JOIN dbp_view.v_bvv_leistung_spr_zu_2 v02
   ON v01.bvv_leist_id = v02.bvv_leist_id

   GROUP BY 1;