CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_BVV_AKTE_SPR_ZU as

   SELECT DISTINCT
   v01.bvv_akte_id, v01.mandant_id, MAX(CASE WHEN v02.spr_id =  22 THEN v02.bvv_akte_bez ELSE NULL END) AS bvv_akte_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN v02.spr_id = 124 THEN v02.bvv_akte_bez ELSE NULL END), MAX(CASE WHEN v02.spr_id =  22 THEN v02.bvv_akte_bez ELSE NULL END)) AS bvv_akte_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN v02.spr_id = 108 THEN v02.bvv_akte_bez ELSE NULL END), MAX(CASE WHEN v02.spr_id =  22 THEN v02.bvv_akte_bez ELSE NULL END)) AS bvv_akte_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN v02.spr_id = 65 THEN v02.bvv_akte_bez ELSE NULL END), MAX(CASE WHEN v02.spr_id =  22 THEN v02.bvv_akte_bez ELSE NULL END)) AS bvv_akte_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN v02.spr_id = 90 THEN v02.bvv_akte_bez ELSE NULL END), MAX(CASE WHEN v02.spr_id =  22 THEN v02.bvv_akte_bez ELSE NULL END)) AS bvv_akte_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN v02.spr_id = 95 THEN v02.bvv_akte_bez ELSE NULL END), MAX(CASE WHEN v02.spr_id =  22 THEN v02.bvv_akte_bez ELSE NULL END)) AS bvv_akte_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN v02.spr_id = 24 THEN v02.bvv_akte_bez ELSE NULL END), MAX(CASE WHEN v02.spr_id =  22 THEN v02.bvv_akte_bez ELSE NULL END)) AS bvv_akte_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN v02.spr_id = 18 THEN v02.bvv_akte_bez ELSE NULL END), MAX(CASE WHEN v02.spr_id =  22 THEN v02.bvv_akte_bez ELSE NULL END)) AS bvv_akte_bez_bg    -- BG

   FROM dbp_view.v_ivs_l_bvv_akte            v01

   JOIN dbp_view.v_ivs_bvv_akte_spr_zu v02
   ON      v01.bvv_akte_id  = v02.bvv_akte_id
   AND    v01.mandant_id  = v02.mandant_id
   GROUP BY
   v01.bvv_akte_id
   , v01.mandant_id;