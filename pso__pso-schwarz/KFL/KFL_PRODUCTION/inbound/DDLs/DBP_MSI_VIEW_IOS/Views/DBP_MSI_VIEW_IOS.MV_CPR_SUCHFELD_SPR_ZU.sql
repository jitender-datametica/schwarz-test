CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_CPR_SUCHFELD_SPR_ZU as
   SELECT

   v01.cpr_suchfeld_id, MAX(CASE WHEN v01.spr_id =  22 THEN v01.suchfeld_bez ELSE NULL END) AS suchfeld_bez                -- standard == DE
   , COALESCE(MAX(CASE WHEN  spr_id = 124 THEN suchfeld_bez END), MAX(CASE WHEN spr_id =  22 THEN suchfeld_bez ELSE NULL END) ) AS suchfeld_bez_cz  -- CZ
   , COALESCE(MAX(CASE WHEN  spr_id = 108 THEN suchfeld_bez END), MAX(CASE WHEN spr_id =  22 THEN suchfeld_bez ELSE NULL END) ) AS suchfeld_bez_sk  -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN suchfeld_bez END), MAX(CASE WHEN spr_id =  22 THEN suchfeld_bez ELSE NULL END) ) AS suchfeld_bez_hr  -- HR
   , COALESCE(MAX(CASE WHEN  spr_id=  90 THEN suchfeld_bez END), MAX(CASE WHEN spr_id =  22 THEN suchfeld_bez ELSE NULL END) ) AS suchfeld_bez_pl  -- PL
   , COALESCE(MAX(CASE WHEN  spr_id =  95 THEN suchfeld_bez END), MAX(CASE WHEN spr_id =  22 THEN suchfeld_bez ELSE NULL END) ) AS suchfeld_bez_ro  -- RO
   , COALESCE(MAX(CASE WHEN  spr_id =  24 THEN suchfeld_bez END), MAX(CASE WHEN spr_id =  22 THEN suchfeld_bez ELSE NULL END) ) AS suchfeld_bez_en  -- EN
   , COALESCE(MAX(CASE WHEN  spr_id =  18 THEN suchfeld_bez END), MAX(CASE WHEN spr_id =  22 THEN suchfeld_bez ELSE NULL END) ) AS suchfeld_bez_bg  -- BG

   FROM dbp_view.v_cpr_suchfeld_spr_zu v01
   GROUP BY
   v01.cpr_suchfeld_id;