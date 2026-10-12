CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SOK_FIMA_BAUSTEIN_LU(
    MANDANT_ID,
    SOK_FIMA_BAUSTEIN_ID,
    SOK_ABTEILUNG_ID,
    SOK_FIMA_BAUSTEIN_BEZ_DE,
    SOK_FIMA_BAUSTEIN_BEZ,
    SOK_FIMA_BAUSTEIN_BEZ_CZ,
    SOK_FIMA_BAUSTEIN_BEZ_SK,
    SOK_FIMA_BAUSTEIN_BEZ_HR,
    SOK_FIMA_BAUSTEIN_BEZ_PL,
    SOK_FIMA_BAUSTEIN_BEZ_RO,
    SOK_FIMA_BAUSTEIN_BEZ_BG
) AS 
/* 
   2024-07-01 muellerpatri : Initiale Erstellung der View, AP0186508
*/
SELECT 
    fima.mandant_id
    , fima.sok_fima_baustein_id
    , fima.sok_abteilung_id
    , MAX(CASE WHEN spr_id =  22 THEN sok_fima_baustein_bez ELSE TRIM(fimas.sok_fima_baustein_id) END)     AS sok_fima_baustein_bez_de
    , sok_fima_baustein_bez_de                                                                       AS sok_fima_baustein_bez       -- DE
    , COALESCE(MAX(CASE WHEN spr_id = 124 THEN sok_fima_baustein_bez END), sok_fima_baustein_bez_de) AS sok_fima_baustein_bez_cz    -- CZ
    , COALESCE(MAX(CASE WHEN spr_id = 108 THEN sok_fima_baustein_bez END), sok_fima_baustein_bez_de) AS sok_fima_baustein_bez_sk    -- SK
    , COALESCE(MAX(CASE WHEN spr_id =  65 THEN sok_fima_baustein_bez END), sok_fima_baustein_bez_de) AS sok_fima_baustein_bez_hr    -- HR
    , COALESCE(MAX(CASE WHEN spr_id =  90 THEN sok_fima_baustein_bez END), sok_fima_baustein_bez_de) AS sok_fima_baustein_bez_pl    -- PL
    , COALESCE(MAX(CASE WHEN spr_id =  95 THEN sok_fima_baustein_bez END), sok_fima_baustein_bez_de) AS sok_fima_baustein_bez_ro    -- RO
    , COALESCE(MAX(CASE WHEN spr_id =  18 THEN sok_fima_baustein_bez END), sok_fima_baustein_bez_de) AS sok_fima_baustein_bez_bg    -- BG
FROM dbp_view.v_l_sok_fima_baustein fima
JOIN dbp_view.v_sok_fima_baustein_spr_zu fimas
ON fima.mandant_id = fimas.mandant_id AND fima.sok_fima_baustein_id = fimas.sok_fima_baustein_id
GROUP BY 
    fima.mandant_id
    , fima.sok_fima_baustein_id
    , fima.sok_abteilung_id
;