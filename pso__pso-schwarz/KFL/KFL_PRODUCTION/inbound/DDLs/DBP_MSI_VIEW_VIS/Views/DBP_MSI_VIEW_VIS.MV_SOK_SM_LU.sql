CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SOK_SM_LU(
    MANDANT_ID,
    SOK_SM_ID,
    SOK_SAP_SM_ID,
    SOK_SM_BEZ_DE,
    SOK_SM_BEZ,
    SOK_SM_BEZ_CZ,
    SOK_SM_BEZ_SK,
    SOK_SM_BEZ_HR,
    SOK_SM_BEZ_PL,  
    SOK_SM_BEZ_RO,
    SOK_SM_BEZ_BG
) AS 
/* 
   2024-07-01 muellerpatri : Initiale Erstellung der View, AP0186508
*/
SELECT 
    sm.mandant_id
    , sm.sm_id AS sok_sm_id
    , sm.sap_sm_id AS sok_sap_sm_id
    , MAX(CASE WHEN spr_id =  22 THEN sm_bez ELSE TRIM(sm_id) END)     AS sok_sm_bez_de
    , sok_sm_bez_de                                                                    AS sok_sm_bez       -- DE
    , COALESCE(MAX(CASE WHEN spr_id = 124 THEN sm_bez END), sok_sm_bez_de) AS sok_sm_bez_cz    -- CZ
    , COALESCE(MAX(CASE WHEN spr_id = 108 THEN sm_bez END), sok_sm_bez_de) AS sok_sm_bez_sk    -- SK
    , COALESCE(MAX(CASE WHEN spr_id =  65 THEN sm_bez END), sok_sm_bez_de) AS sok_sm_bez_hr    -- HR
    , COALESCE(MAX(CASE WHEN spr_id =  90 THEN sm_bez END), sok_sm_bez_de) AS sok_sm_bez_pl    -- PL
    , COALESCE(MAX(CASE WHEN spr_id =  95 THEN sm_bez END), sok_sm_bez_de) AS sok_sm_bez_ro    -- RO
    , COALESCE(MAX(CASE WHEN spr_id =  18 THEN sm_bez END), sok_sm_bez_de) AS sok_sm_bez_bg    -- BG
FROM dbp_view.v_sm sm
WHERE sm_id BETWEEN 11 AND 19 AND sap_sm_id = sm_bez
GROUP BY 
    sm.mandant_id
    , sm.sm_id
    , sm.sap_sm_id
;