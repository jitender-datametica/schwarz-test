CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_RPM_FIN_GRUPPE_SPR_ZU as
   SELECT
   v01.fin_gruppe_id, v01.fin_kategorie_id, MAX(CASE WHEN spr_id =  22 THEN v03.fin_gruppe_bez ELSE NULL END) AS fin_gruppe_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN v03.fin_gruppe_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v03.fin_gruppe_bez ELSE NULL END)) AS fin_gruppe_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN v03.fin_gruppe_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v03.fin_gruppe_bez ELSE NULL END)) AS fin_gruppe_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN v03.fin_gruppe_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v03.fin_gruppe_bez ELSE NULL END)) AS fin_gruppe_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN v03.fin_gruppe_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v03.fin_gruppe_bez ELSE NULL END)) AS fin_gruppe_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN v03.fin_gruppe_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v03.fin_gruppe_bez ELSE NULL END)) AS fin_gruppe_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN v03.fin_gruppe_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v03.fin_gruppe_bez ELSE NULL END)) AS fin_gruppe_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN v03.fin_gruppe_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v03.fin_gruppe_bez ELSE NULL END)) AS fin_gruppe_bez_bg    -- BG


   FROM dbp_view.v_l_rpm_fin_gruppe v01
   LEFT OUTER JOIN dbp_view.v_rpm_fin_gruppe_spr_zu v03 --left outer aus "normaler" View übernommen

   ON    v01.fin_gruppe_id = v03.fin_gruppe_id
   AND v01.fin_kategorie_id = v03.fin_kategorie_id

   GROUP BY
   v01.fin_gruppe_id
   ,v01.fin_kategorie_id;