CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_IN_L_WG_SPR_ZU_1 AS
   SELECT
   v01.mandant_id, v01.in_wg_id, v01.in_wg_struktur_id, MAX(CASE WHEN spr_id =  22 THEN v02.in_wg_bez ELSE NULL END) AS in_wg_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN v02.in_wg_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.in_wg_bez ELSE NULL END))  AS in_wg_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN v02.in_wg_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.in_wg_bez ELSE NULL END)) AS in_wg_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN v02.in_wg_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.in_wg_bez ELSE NULL END)) AS in_wg_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN v02.in_wg_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.in_wg_bez ELSE NULL END)) AS in_wg_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN v02.in_wg_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.in_wg_bez ELSE NULL END)) AS in_wg_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN v02.in_wg_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.in_wg_bez ELSE NULL END)) AS in_wg_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN v02.in_wg_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.in_wg_bez ELSE NULL END)) AS in_wg_bez_bg    -- BG
   , MAX(CASE WHEN spr_id =  22 THEN v02.in_wg_bez_lang ELSE NULL END) AS in_wg_bez_lang                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN v02.in_wg_bez_lang ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.in_wg_bez_lang ELSE NULL END)) AS in_wg_bez_lang_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN v02.in_wg_bez_lang ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.in_wg_bez_lang ELSE NULL END)) AS in_wg_bez_lang_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN v02.in_wg_bez_lang ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.in_wg_bez_lang ELSE NULL END)) AS in_wg_bez_lang_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN v02.in_wg_bez_lang ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.in_wg_bez_lang ELSE NULL END)) AS in_wg_bez_lang_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN v02.in_wg_bez_lang ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.in_wg_bez_lang ELSE NULL END)) AS in_wg_bez_lang_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN v02.in_wg_bez_lang ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.in_wg_bez_lang ELSE NULL END)) AS in_wg_bez_lang_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN v02.in_wg_bez_lang ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v02.in_wg_bez_lang ELSE NULL END)) AS in_wg_bez_lang_bg    -- BG
   FROM dbp_view.v_in_l_wg_1 v01
   JOIN dbp_view.v_in_wg_spr_zu_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.in_wg_id = v02.in_wg_id
   --AND v02.spr_id = 22
   WHERE
   SUBSTR( v01.in_wg_id, 1, 1) = 'W'
   OR v01.in_wg_id = '-1' --keine echte WG, jedoch wir benoetig, dass durch die SPR_ZU nicht die WG mit -1 rausfliegen
   GROUP BY
   v01.mandant_id
   ,v01.in_wg_id
   ,v01.in_wg_struktur_id;