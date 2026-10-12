CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SOK_ABTEILUNG_LU_2(
    MANDANT_ID,
    SOK_ABTEILUNG_ID,
    SOK_FOOD_NONFOOD_KATEGORIE_ID,
    SOK_ABTEILUNG_BEZ_DE,
    SOK_ABTEILUNG_BEZ,
    SOK_ABTEILUNG_BEZ_CZ,
    SOK_ABTEILUNG_BEZ_SK,
    SOK_ABTEILUNG_BEZ_HR,
    SOK_ABTEILUNG_BEZ_PL,
    SOK_ABTEILUNG_BEZ_RO,
    SOK_ABTEILUNG_BEZ_BG
) AS 
/* 
   2024-07-01 muellerpatri : Initiale Erstellung der View, AP0186508
*/
SELECT 
    abt.mandant_id
    , abt.sok_abteilung_id 
    , abt.food_nonfood_kategorie_id AS sok_food_nonfood_kategorie_id
    , MAX(CASE WHEN spr_id =  22 THEN sok_abteilung_bez ELSE TRIM(abts.sok_abteilung_id) END)     AS sok_abteilung_bez_de
    , sok_abteilung_bez_de                                                                    AS sok_abteilung_bez       -- DE
    , COALESCE(MAX(CASE WHEN spr_id = 124 THEN sok_abteilung_bez END), sok_abteilung_bez_de) AS sok_abteilung_bez_cz    -- CZ
    , COALESCE(MAX(CASE WHEN spr_id = 108 THEN sok_abteilung_bez END), sok_abteilung_bez_de) AS sok_abteilung_bez_sk    -- SK
    , COALESCE(MAX(CASE WHEN spr_id =  65 THEN sok_abteilung_bez END), sok_abteilung_bez_de) AS sok_abteilung_bez_hr    -- HR
    , COALESCE(MAX(CASE WHEN spr_id =  90 THEN sok_abteilung_bez END), sok_abteilung_bez_de) AS sok_abteilung_bez_pl    -- PL
    , COALESCE(MAX(CASE WHEN spr_id =  95 THEN sok_abteilung_bez END), sok_abteilung_bez_de) AS sok_abteilung_bez_ro    -- RO
    , COALESCE(MAX(CASE WHEN spr_id =  18 THEN sok_abteilung_bez END), sok_abteilung_bez_de) AS sok_abteilung_bez_bg    -- BG
FROM dbp_view.v_l_sok_abteilung_2 abt_2
JOIN dbp_view.v_sok_abteilung_spr_zu_2 abts
ON abt.mandant_id = abts.mandant_id AND abt.sok_abteilung_id = abts.sok_abteilung_id
GROUP BY 
    abt.mandant_id
    , abt.sok_abteilung_id
    , abt.food_nonfood_kategorie_id
;