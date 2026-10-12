CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SOK_MGG_ABTEILUNG_LU_1(
    MANDANT_ID,
    SOK_MGG_ABTEILUNG_ID,
    SOK_FOOD_NONFOOD_KATEGORIE_ID,
    SOK_MGG_ABTEILUNG_BEZ_DE,
    SOK_MGG_ABTEILUNG_BEZ,
    SOK_MGG_ABTEILUNG_BEZ_CZ,
    SOK_MGG_ABTEILUNG_BEZ_SK,
    SOK_MGG_ABTEILUNG_BEZ_HR,
    SOK_MGG_ABTEILUNG_BEZ_PL,
    SOK_MGG_ABTEILUNG_BEZ_RO,
    SOK_MGG_ABTEILUNG_BEZ_BG
) AS 
/* 
   2024-07-01 muellerpatri : Initiale Erstellung der View, AP0186508
*/
SELECT 
    abt.mandant_id
    , abt.mgg_abteilung_id AS sok_mgg_abteilung_id
    , abt.food_nonfood_kategorie_id AS sok_food_nonfood_kategorie_id
    , MAX(CASE WHEN spr_id =  22 THEN mgg_abteilung_bez ELSE TRIM(abts.mgg_abteilung_id) END)     AS sok_mgg_abteilung_bez_de
    , sok_mgg_abteilung_bez_de                                                                    AS sok_mgg_abteilung_bez       -- DE
    , COALESCE(MAX(CASE WHEN spr_id = 124 THEN mgg_abteilung_bez END), sok_mgg_abteilung_bez_de) AS sok_mgg_abteilung_bez_cz    -- CZ
    , COALESCE(MAX(CASE WHEN spr_id = 108 THEN mgg_abteilung_bez END), sok_mgg_abteilung_bez_de) AS sok_mgg_abteilung_bez_sk    -- SK
    , COALESCE(MAX(CASE WHEN spr_id =  65 THEN mgg_abteilung_bez END), sok_mgg_abteilung_bez_de) AS sok_mgg_abteilung_bez_hr    -- HR
    , COALESCE(MAX(CASE WHEN spr_id =  90 THEN mgg_abteilung_bez END), sok_mgg_abteilung_bez_de) AS sok_mgg_abteilung_bez_pl    -- PL
    , COALESCE(MAX(CASE WHEN spr_id =  95 THEN mgg_abteilung_bez END), sok_mgg_abteilung_bez_de) AS sok_mgg_abteilung_bez_ro    -- RO
    , COALESCE(MAX(CASE WHEN spr_id =  18 THEN mgg_abteilung_bez END), sok_mgg_abteilung_bez_de) AS sok_mgg_abteilung_bez_bg    -- BG
FROM dbp_view.v_l_mgg_abteilung_1 abt_1
JOIN dbp_view.v_mgg_abteilung_spr_zu_1 abts
ON abt.mandant_id = abts.mandant_id AND abt.mgg_abteilung_id = abts.mgg_abteilung_id
GROUP BY 
    abt.mandant_id
    , abt.mgg_abteilung_id
    , abt.food_nonfood_kategorie_id 
;