CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SOK_VERKAUFSMOEBEL_LU_2(
    MANDANT_ID,
    SOK_VERKAUFSMOEBEL_ID,
    SOK_VERKAUFSMOEBEL_BEZ_DE,
    SOK_VERKAUFSMOEBEL_BEZ,
    SOK_VERKAUFSMOEBEL_BEZ_CZ,
    SOK_VERKAUFSMOEBEL_BEZ_SK,
    SOK_VERKAUFSMOEBEL_BEZ_HR,
    SOK_VERKAUFSMOEBEL_BEZ_PL,  
    SOK_VERKAUFSMOEBEL_BEZ_RO,
    SOK_VERKAUFSMOEBEL_BEZ_BG
) AS 
/* 
   2024-07-01 muellerpatri : Initiale Erstellung der View, AP0186508
*/
SELECT 
    vm.mandant_id
    , vm.verkaufsmoebel_id AS sok_verkaufsmoebel_id
    , MAX(CASE WHEN spr_id =  22 THEN verkaufsmoebel_bez ELSE TRIM(verkaufsmoebel_id) END)     AS sok_verkaufsmoebel_bez_de
    , sok_verkaufsmoebel_bez_de                                                                    AS sok_verkaufsmoebel_bez       -- DE
    , COALESCE(MAX(CASE WHEN spr_id = 124 THEN verkaufsmoebel_bez END), sok_verkaufsmoebel_bez_de) AS sok_verkaufsmoebel_bez_cz    -- CZ
    , COALESCE(MAX(CASE WHEN spr_id = 108 THEN verkaufsmoebel_bez END), sok_verkaufsmoebel_bez_de) AS sok_verkaufsmoebel_bez_sk    -- SK
    , COALESCE(MAX(CASE WHEN spr_id =  65 THEN verkaufsmoebel_bez END), sok_verkaufsmoebel_bez_de) AS sok_verkaufsmoebel_bez_hr    -- HR
    , COALESCE(MAX(CASE WHEN spr_id =  90 THEN verkaufsmoebel_bez END), sok_verkaufsmoebel_bez_de) AS sok_verkaufsmoebel_bez_pl    -- PL
    , COALESCE(MAX(CASE WHEN spr_id =  95 THEN verkaufsmoebel_bez END), sok_verkaufsmoebel_bez_de) AS sok_verkaufsmoebel_bez_ro    -- RO
    , COALESCE(MAX(CASE WHEN spr_id =  18 THEN verkaufsmoebel_bez END), sok_verkaufsmoebel_bez_de) AS sok_verkaufsmoebel_bez_bg    -- BG
FROM dbp_view.v_verkaufsmoebel_spr_zu_2 vm
GROUP BY 
    vm.mandant_id
    , vm.verkaufsmoebel_id
;