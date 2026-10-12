CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SOK_WG_LU(
    MANDANT_ID,
    SOK_WG_ID,
    SOK_PLATZIERUNGSWG_ID,
    SORT_ID,
    ARTHIERTYP_ID,
    SOK_WG_BEZ_DE,
    SOK_WG_BEZ,
    SOK_WG_BEZ_CZ,
    SOK_WG_BEZ_SK,
    SOK_WG_BEZ_HR,
    SOK_WG_BEZ_PL,
    SOK_WG_BEZ_RO,
    SOK_WG_BEZ_BG
) AS 
/* 
   2024-07-01 muellerpatri : Initiale Erstellung der View, AP0186508
*/
SELECT 
    wg.mandant_id
    , wg.wg_id AS sok_wg_id
    , wg.platzierungswg_id AS sok_platzierungswg_id
    , wg.owg_id * 10000 + wg.wg_id::INTEGER AS sort_id
    , wgs.arthiertyp_id
    , MAX(CASE WHEN spr_id =  22 THEN wg_bez ELSE TRIM(wgs.wg_id) END)     AS sok_wg_bez_de
    , sok_wg_bez_de                                                                    AS sok_wg_bez       -- DE
    , COALESCE(MAX(CASE WHEN spr_id = 124 THEN wg_bez END), sok_wg_bez_de) AS sok_wg_bez_cz    -- CZ
    , COALESCE(MAX(CASE WHEN spr_id = 108 THEN wg_bez END), sok_wg_bez_de) AS sok_wg_bez_sk    -- SK
    , COALESCE(MAX(CASE WHEN spr_id =  65 THEN wg_bez END), sok_wg_bez_de) AS sok_wg_bez_hr    -- HR
    , COALESCE(MAX(CASE WHEN spr_id =  90 THEN wg_bez END), sok_wg_bez_de) AS sok_wg_bez_pl    -- PL
    , COALESCE(MAX(CASE WHEN spr_id =  95 THEN wg_bez END), sok_wg_bez_de) AS sok_wg_bez_ro    -- RO
    , COALESCE(MAX(CASE WHEN spr_id =  18 THEN wg_bez END), sok_wg_bez_de) AS sok_wg_bez_bg    -- BG
FROM dbp_view.v_wg_per wg
JOIN dbp_view.v_wg_spr_zu wgs
ON wg.mandant_id = wgs.mandant_id AND wg.wg_id = wgs.wg_id
WHERE wg.arthiertyp_id = 2 AND wg.dat_bis = '9999-12-31'
GROUP BY 
    wg.mandant_id,
    wg.wg_id,
    wg.platzierungswg_id,
    wg.owg_id * 10000 + wg.wg_id::INTEGER,
    wgs.arthiertyp_id
;