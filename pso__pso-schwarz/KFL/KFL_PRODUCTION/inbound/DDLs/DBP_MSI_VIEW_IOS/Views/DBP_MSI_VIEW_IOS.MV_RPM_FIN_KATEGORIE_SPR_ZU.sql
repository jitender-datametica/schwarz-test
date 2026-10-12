CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_RPM_FIN_KATEGORIE_SPR_ZU as
   SELECT
   fin_kategorie_id, MAX(CASE WHEN spr_id =  22 THEN fin_kategorie_bez ELSE NULL END) AS fin_kategorie_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN fin_kategorie_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN fin_kategorie_bez ELSE NULL END)) AS fin_kategorie_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN fin_kategorie_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN fin_kategorie_bez ELSE NULL END)) AS fin_kategorie_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN fin_kategorie_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN fin_kategorie_bez ELSE NULL END)) AS fin_kategorie_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN fin_kategorie_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN fin_kategorie_bez ELSE NULL END)) AS fin_kategorie_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN fin_kategorie_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN fin_kategorie_bez ELSE NULL END)) AS fin_kategorie_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN fin_kategorie_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN fin_kategorie_bez ELSE NULL END)) AS fin_kategorie_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN fin_kategorie_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN fin_kategorie_bez ELSE NULL END)) AS fin_kategorie_bez_bg    -- BG

   FROM dbp_view.v_rpm_fin_kategorie_spr_zu v03
   GROUP BY
   fin_kategorie_id;