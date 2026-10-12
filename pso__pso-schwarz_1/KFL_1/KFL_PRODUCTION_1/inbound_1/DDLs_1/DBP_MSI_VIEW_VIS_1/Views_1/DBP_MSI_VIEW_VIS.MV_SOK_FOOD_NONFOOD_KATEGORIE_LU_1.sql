CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SOK_FOOD_NONFOOD_KATEGORIE_LU_1(
    MANDANT_ID,
    SOK_FOOD_NONFOOD_KATEGORIE_ID,
    SOK_FOOD_NONFOOD_KATEGORIE_BEZ_DE,
    SOK_FOOD_NONFOOD_KATEGORIE_BEZ,
    SOK_FOOD_NONFOOD_KATEGORIE_BEZ_CZ,
    SOK_FOOD_NONFOOD_KATEGORIE_BEZ_SK,
    SOK_FOOD_NONFOOD_KATEGORIE_BEZ_HR,
    SOK_FOOD_NONFOOD_KATEGORIE_BEZ_PL,
    SOK_FOOD_NONFOOD_KATEGORIE_BEZ_RO,
    SOK_FOOD_NONFOOD_KATEGORIE_BEZ_BG
) AS 
/* 
   2024-07-01 muellerpatri : Initiale Erstellung der View, AP0186508
*/
SELECT 
    fnf.mandant_id
    , fnf.food_nonfood_kategorie_id AS sok_food_nonfood_kategorie_id
    , MAX(CASE WHEN spr_id =  22 THEN food_nonfood_kategorie_bez ELSE TRIM(food_nonfood_kategorie_id) END)     AS sok_food_nonfood_kategorie_bez_de
    , sok_food_nonfood_kategorie_bez_de                                                                    AS sok_food_nonfood_kategorie_bez       -- DE
    , COALESCE(MAX(CASE WHEN spr_id = 124 THEN food_nonfood_kategorie_bez END), sok_food_nonfood_kategorie_bez_de) AS sok_food_nonfood_kategorie_bez_cz    -- CZ
    , COALESCE(MAX(CASE WHEN spr_id = 108 THEN food_nonfood_kategorie_bez END), sok_food_nonfood_kategorie_bez_de) AS sok_food_nonfood_kategorie_bez_sk    -- SK
    , COALESCE(MAX(CASE WHEN spr_id =  65 THEN food_nonfood_kategorie_bez END), sok_food_nonfood_kategorie_bez_de) AS sok_food_nonfood_kategorie_bez_hr    -- HR
    , COALESCE(MAX(CASE WHEN spr_id =  90 THEN food_nonfood_kategorie_bez END), sok_food_nonfood_kategorie_bez_de) AS sok_food_nonfood_kategorie_bez_pl    -- PL
    , COALESCE(MAX(CASE WHEN spr_id =  95 THEN food_nonfood_kategorie_bez END), sok_food_nonfood_kategorie_bez_de) AS sok_food_nonfood_kategorie_bez_ro    -- RO
    , COALESCE(MAX(CASE WHEN spr_id =  18 THEN food_nonfood_kategorie_bez END), sok_food_nonfood_kategorie_bez_de) AS sok_food_nonfood_kategorie_bez_bg    -- BG
FROM dbp_view.v_food_nonfood_kategorie_spr_zu_1 fnf
GROUP BY 
    fnf.mandant_id
    , fnf.food_nonfood_kategorie_id
;