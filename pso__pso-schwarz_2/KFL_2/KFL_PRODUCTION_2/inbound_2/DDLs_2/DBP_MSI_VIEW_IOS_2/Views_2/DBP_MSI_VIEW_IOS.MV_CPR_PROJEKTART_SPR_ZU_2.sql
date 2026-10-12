CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_CPR_PROJEKTART_SPR_ZU_2
(
projektart_id
--,spr_id
,projektart_bez
,projektart_bez_cz
,projektart_bez_sk
,projektart_bez_hr
,projektart_bez_pl
,projektart_bez_ro
,projektart_bez_en
,projektart_bez_bg

)
AS
   SELECT
   projektart_id, MAX(CASE WHEN spr_id =  22 THEN projektart_bez ELSE NULL END) AS projektart_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN projektart_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN projektart_bez ELSE NULL END)) AS projektart_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN projektart_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN projektart_bez ELSE NULL END)) AS projektart_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN projektart_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN projektart_bez ELSE NULL END)) AS projektart_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN projektart_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN projektart_bez ELSE NULL END)) AS projektart_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN projektart_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN projektart_bez ELSE NULL END)) AS projektart_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN projektart_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN projektart_bez ELSE NULL END)) AS projektart_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN projektart_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN projektart_bez ELSE NULL END)) AS projektart_bez_bg    -- BG

   FROM dbp_view.v_cpr_projektart_spr_zu_2
   --WHERE spr_id = 22;

   GROUP BY projektart_id;