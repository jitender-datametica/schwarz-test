CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_BEDIENKONZEPT_SPR_ZU_1 as

   SELECT

   v01.rpm_hierarchie_id AS rpm_immobilie_id, v01.bedienkonzept_id, v01.bedienkonzept_auspr_id, MAX(CASE WHEN v03.spr_id =  22 THEN v03.bedienkonzept_auspr_bez ELSE NULL END) AS bedienkonzept_auspr_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN v03.spr_id = 124 THEN v03.bedienkonzept_auspr_bez ELSE NULL END), MAX(CASE WHEN v03.spr_id =  22 THEN v03.bedienkonzept_auspr_bez ELSE NULL END)) AS bedienkonzept_auspr_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN v03.spr_id = 108 THEN v03.bedienkonzept_auspr_bez ELSE NULL END), MAX(CASE WHEN v03.spr_id =  22 THEN v03.bedienkonzept_auspr_bez ELSE NULL END)) AS bedienkonzept_auspr_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN v03.spr_id = 65 THEN v03.bedienkonzept_auspr_bez ELSE NULL END), MAX(CASE WHEN v03.spr_id =  22 THEN v03.bedienkonzept_auspr_bez ELSE NULL END)) AS bedienkonzept_auspr_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN v03.spr_id = 90 THEN v03.bedienkonzept_auspr_bez ELSE NULL END), MAX(CASE WHEN v03.spr_id =  22 THEN v03.bedienkonzept_auspr_bez ELSE NULL END)) AS bedienkonzept_auspr_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN v03.spr_id = 95 THEN v03.bedienkonzept_auspr_bez ELSE NULL END), MAX(CASE WHEN v03.spr_id =  22 THEN v03.bedienkonzept_auspr_bez ELSE NULL END)) AS bedienkonzept_auspr_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN v03.spr_id = 24 THEN v03.bedienkonzept_auspr_bez ELSE NULL END), MAX(CASE WHEN v03.spr_id =  22 THEN v03.bedienkonzept_auspr_bez ELSE NULL END)) AS bedienkonzept_auspr_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN v03.spr_id = 18 THEN v03.bedienkonzept_auspr_bez ELSE NULL END), MAX(CASE WHEN v03.spr_id =  22 THEN v03.bedienkonzept_auspr_bez ELSE NULL END)) AS bedienkonzept_auspr_bez_bg    -- BG

   FROM dbp_view.v_rpm_hier_bed_konzept_zu_per_1 v01
   INNER JOIN dbp_view.v_bedienkonzept_auspr_spr_zu_1 v03
   ON v01.bedienkonzept_id = v03.bedienkonzept_id
   AND v01.bedienkonzept_auspr_id = v03.bedienkonzept_auspr_id


   GROUP BY 1,2,3;