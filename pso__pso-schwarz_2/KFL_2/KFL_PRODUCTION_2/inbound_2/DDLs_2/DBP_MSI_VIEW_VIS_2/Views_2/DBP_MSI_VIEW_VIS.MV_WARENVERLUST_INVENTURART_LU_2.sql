CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WARENVERLUST_INVENTURART_LU_2(
    INVENTURART_ID,
    INVENTURART_BEZ_DE,
    INVENTURART_BEZ,
    INVENTURART_BEZ_CZ,
    INVENTURART_BEZ_SK,
    INVENTURART_BEZ_HR,
    INVENTURART_BEZ_PL,
    INVENTURART_BEZ_RO,
    INVENTURART_BEZ_BG
) AS  
/*	
    2025-05-06 muellerpatri : Initiale Erstellung der View (AP0263148)
*/
SELECT
    inv.inventurart_id
    , MAX(CASE WHEN spr_id =  22 THEN inventurart_bez ELSE TRIM(inv.inventurart_id) END)      	                AS inventurart_bez_de
    , inventurart_bez_de                                                                                        AS inventurart_bez       -- DE
    , COALESCE(MAX(CASE WHEN spr_id = 124 THEN inventurart_bez END), inventurart_bez_de)                        AS inventurart_bez_cz    -- CZ
    , COALESCE(MAX(CASE WHEN spr_id = 108 THEN inventurart_bez END), inventurart_bez_de)                        AS inventurart_bez_sk    -- SK
    , COALESCE(MAX(CASE WHEN spr_id =  65 THEN inventurart_bez END), inventurart_bez_de)                        AS inventurart_bez_hr    -- HR
    , COALESCE(MAX(CASE WHEN spr_id =  90 THEN inventurart_bez END), inventurart_bez_de)                        AS inventurart_bez_pl    -- PL
    , COALESCE(MAX(CASE WHEN spr_id =  95 THEN inventurart_bez END), inventurart_bez_de)                        AS inventurart_bez_ro    -- RO
    , COALESCE(MAX(CASE WHEN spr_id =  18 THEN inventurart_bez END), inventurart_bez_de)                        AS inventurart_bez_bg    -- BG
FROM 
DBP_VIEW.V_INVENTURART_SPR_ZU_2 inv
GROUP BY ALL
;