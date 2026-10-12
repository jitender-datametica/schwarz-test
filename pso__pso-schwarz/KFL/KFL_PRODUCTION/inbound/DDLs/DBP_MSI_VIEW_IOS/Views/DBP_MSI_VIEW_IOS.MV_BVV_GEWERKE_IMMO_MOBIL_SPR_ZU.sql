CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_BVV_GEWERKE_IMMO_MOBIL_SPR_ZU as
   -- 180613 nfis0811 - Internationalisierung - Einführung spr_zu

   SELECT
   --v01.bvv_leist_id  --AS bvv_immo_mob_sort
   CASE WHEN v01.bvv_leist_id BETWEEN 1 AND 5 THEN 1
   WHEN v01.bvv_leist_id BETWEEN 7 AND 123 THEN 7
   WHEN v01.bvv_leist_id BETWEEN 125 AND 165 THEN 125
   ELSE v01.bvv_leist_id END bvv_immo_mob_id, MAX(CASE WHEN spr_id =  22 THEN v02.bvv_immob_mob_bez ELSE NULL END) AS bvv_immo_mob_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN v02.bvv_immob_mob_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.bvv_immob_mob_bez ELSE NULL END)) AS bvv_immo_mob_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN v02.bvv_immob_mob_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.bvv_immob_mob_bez ELSE NULL END)) AS bvv_immo_mob_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN v02.bvv_immob_mob_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.bvv_immob_mob_bez ELSE NULL END)) AS bvv_immo_mob_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN v02.bvv_immob_mob_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.bvv_immob_mob_bez ELSE NULL END)) AS bvv_immo_mob_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN v02.bvv_immob_mob_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.bvv_immob_mob_bez ELSE NULL END)) AS bvv_immo_mob_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN v02.bvv_immob_mob_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.bvv_immob_mob_bez ELSE NULL END)) AS bvv_immo_mob_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN v02.bvv_immob_mob_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.bvv_immob_mob_bez ELSE NULL END)) AS bvv_immo_mob_bez_bg    -- BG

   FROM dbp_view.v_l_bvv_leistung v01
   JOIN dbp_view.v_bvv_leistung_spr_zu v02
   ON v01.bvv_leist_id = v02.bvv_leist_id
   GROUP BY 1;