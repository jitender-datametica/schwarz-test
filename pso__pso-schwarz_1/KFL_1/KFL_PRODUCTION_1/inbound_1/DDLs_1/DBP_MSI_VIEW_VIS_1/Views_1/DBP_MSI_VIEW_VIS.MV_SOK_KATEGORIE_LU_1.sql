CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SOK_KATEGORIE_LU_1(
    MANDANT_ID,
    SOK_KATEGORIE_ID,
    SOK_FIMA_BAUSTEIN_ID,
    SOK_KATEGORIE_BEZ_DE,
    SOK_KATEGORIE_BEZ,
    SOK_KATEGORIE_BEZ_CZ,
    SOK_KATEGORIE_BEZ_SK,
    SOK_KATEGORIE_BEZ_HR,
    SOK_KATEGORIE_BEZ_PL,
    SOK_KATEGORIE_BEZ_RO,
    SOK_KATEGORIE_BEZ_BG
) AS 
/* 
   2024-07-01 muellerpatri : Initiale Erstellung der View, AP0186508
*/
SELECT 
    kat.mandant_id
    , kat.sok_kategorie_id AS sok_kategorie_id
    , kat.sok_fima_baustein_id
    , MAX(CASE WHEN spr_id =  22 THEN sok_kategorie_bez ELSE TRIM(kats.sok_kategorie_id) END)     AS sok_kategorie_bez_de
    , sok_kategorie_bez_de                                                                    AS sok_kategorie_bez       -- DE
    , COALESCE(MAX(CASE WHEN spr_id = 124 THEN sok_kategorie_bez END), sok_kategorie_bez_de) AS sok_kategorie_bez_cz    -- CZ
    , COALESCE(MAX(CASE WHEN spr_id = 108 THEN sok_kategorie_bez END), sok_kategorie_bez_de) AS sok_kategorie_bez_sk    -- SK
    , COALESCE(MAX(CASE WHEN spr_id =  65 THEN sok_kategorie_bez END), sok_kategorie_bez_de) AS sok_kategorie_bez_hr    -- HR
    , COALESCE(MAX(CASE WHEN spr_id =  90 THEN sok_kategorie_bez END), sok_kategorie_bez_de) AS sok_kategorie_bez_pl    -- PL
    , COALESCE(MAX(CASE WHEN spr_id =  95 THEN sok_kategorie_bez END), sok_kategorie_bez_de) AS sok_kategorie_bez_ro    -- RO
    , COALESCE(MAX(CASE WHEN spr_id =  18 THEN sok_kategorie_bez END), sok_kategorie_bez_de) AS sok_platzierungswg_bez_bg    -- BG
FROM dbp_view.v_l_sok_kategorie_1 kat 
JOIN dbp_view.v_sok_kategorie_spr_zu_1 kats
ON kat.mandant_id = kats.mandant_id AND kat.sok_kategorie_id = kats.sok_kategorie_id
GROUP BY 
    kat.mandant_id
    , kat.sok_kategorie_id
    , kat.sok_fima_baustein_id
;
