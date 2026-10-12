CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_BVV_U_GEWERK_SPR_ZU_1 as
   -- 180613 nfis0811 - Internationalisierung - Einführung spr_zu

   SELECT
   --v01.bvv_leist_id --AS bvv_u_gewerk_sort
   CASE WHEN v01.bvv_leist_id BETWEEN 7 AND 11 THEN 7
   WHEN v01.bvv_leist_id BETWEEN 12 AND 17 THEN 12
   WHEN v01.bvv_leist_id BETWEEN 18 AND 85 THEN 18
   WHEN v01.bvv_leist_id BETWEEN 87 AND 123 THEN 87
   WHEN v01.bvv_leist_id BETWEEN 125 AND 158 THEN 158
   WHEN v01.bvv_leist_id BETWEEN 159 AND 162 THEN 159
   WHEN v01.bvv_leist_id BETWEEN 163 AND 165 THEN 163
   ELSE v01.bvv_leist_id END bvv_u_gewerk_id, MAX(CASE WHEN spr_id =  22 THEN v02.bvv_u_gewerk_bez ELSE NULL END) AS bvv_u_gewerk_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN v02.bvv_u_gewerk_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.bvv_u_gewerk_bez ELSE NULL END)) AS bvv_u_gewerk_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN v02.bvv_u_gewerk_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.bvv_u_gewerk_bez ELSE NULL END)) AS bvv_u_gewerk_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN v02.bvv_u_gewerk_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.bvv_u_gewerk_bez ELSE NULL END)) AS bvv_u_gewerk_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN v02.bvv_u_gewerk_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.bvv_u_gewerk_bez ELSE NULL END)) AS bvv_u_gewerk_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN v02.bvv_u_gewerk_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.bvv_u_gewerk_bez ELSE NULL END)) AS bvv_u_gewerk_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN v02.bvv_u_gewerk_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.bvv_u_gewerk_bez ELSE NULL END)) AS bvv_u_gewerk_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN v02.bvv_u_gewerk_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.bvv_u_gewerk_bez ELSE NULL END)) AS bvv_u_gewerk_bez_bg    -- BG

   FROM dbp_view.v_l_bvv_leistung_1 v01
   JOIN dbp_view.v_bvv_leistung_spr_zu_1 v02
   ON v01.bvv_leist_id = v02.bvv_leist_id
   GROUP BY 1;