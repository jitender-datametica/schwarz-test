CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_RPM_FIN_PLANTYP_SPR_ZU as
   SELECT
   v01.rpm_plantyp_id, MAX(CASE WHEN spr_id =  22 THEN v02.rpm_plantyp_bez ELSE NULL END) AS rpm_plantyp_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN v02.rpm_plantyp_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.rpm_plantyp_bez ELSE NULL END)) AS rpm_plantyp_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN v02.rpm_plantyp_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.rpm_plantyp_bez ELSE NULL END)) AS rpm_plantyp_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN v02.rpm_plantyp_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.rpm_plantyp_bez ELSE NULL END)) AS rpm_plantyp_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN v02.rpm_plantyp_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.rpm_plantyp_bez ELSE NULL END)) AS rpm_plantyp_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN v02.rpm_plantyp_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.rpm_plantyp_bez ELSE NULL END)) AS rpm_plantyp_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN v02.rpm_plantyp_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.rpm_plantyp_bez ELSE NULL END)) AS rpm_plantyp_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN v02.rpm_plantyp_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.rpm_plantyp_bez ELSE NULL END)) AS rpm_plantyp_bez_bg    -- BG

   FROM dbp_view.v_l_rpm_plantyp v01
   LEFT OUTER JOIN dbp_view.v_rpm_plantyp_spr_zu v02
   ON    v01.rpm_plantyp_id = v02.rpm_plantyp_id
   GROUP BY
   v01.rpm_plantyp_id;