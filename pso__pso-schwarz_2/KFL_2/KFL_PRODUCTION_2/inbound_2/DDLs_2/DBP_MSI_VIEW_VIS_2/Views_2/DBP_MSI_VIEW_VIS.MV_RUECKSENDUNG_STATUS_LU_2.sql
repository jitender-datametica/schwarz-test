CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_RUECKSENDUNG_STATUS_LU_2(
    --MANDANT_ID,
    RUECKSENDUNG_STATUS_ID,
    RUECKSENDUNG_STATUS_BEZ_DE,
    RUECKSENDUNG_STATUS_BEZ,
    RUECKSENDUNG_STATUS_BEZ_CZ,
    RUECKSENDUNG_STATUS_BEZ_SK,
    RUECKSENDUNG_STATUS_BEZ_HR,
    RUECKSENDUNG_STATUS_BEZ_PL,
    RUECKSENDUNG_STATUS_BEZ_RO,
    RUECKSENDUNG_STATUS_BEZ_BG
) AS  
/*	
    2025-05-06 muellerpatri : Initiale Erstellung der View (AP0263148)
*/
SELECT
    --rs.mandant_id
    rs.ruecksendung_status_id
    , MAX(CASE WHEN spr_id =  22 THEN ruecksendung_status_bez ELSE TRIM(rss.ruecksendung_status_id) END)    AS ruecksendung_status_bez_de
    , ruecksendung_status_bez_de                                                                            AS ruecksendung_status_bez       -- DE
    , COALESCE(MAX(CASE WHEN spr_id = 124 THEN ruecksendung_status_bez END), ruecksendung_status_bez_de)    AS ruecksendung_status_bez_cz    -- CZ
    , COALESCE(MAX(CASE WHEN spr_id = 108 THEN ruecksendung_status_bez END), ruecksendung_status_bez_de)    AS ruecksendung_status_bez_sk    -- SK
    , COALESCE(MAX(CASE WHEN spr_id =  65 THEN ruecksendung_status_bez END), ruecksendung_status_bez_de)    AS ruecksendung_status_bez_hr    -- HR
    , COALESCE(MAX(CASE WHEN spr_id =  90 THEN ruecksendung_status_bez END), ruecksendung_status_bez_de)    AS ruecksendung_status_bez_pl    -- PL
    , COALESCE(MAX(CASE WHEN spr_id =  95 THEN ruecksendung_status_bez END), ruecksendung_status_bez_de)    AS ruecksendung_status_bez_ro    -- RO
    , COALESCE(MAX(CASE WHEN spr_id =  18 THEN ruecksendung_status_bez END), ruecksendung_status_bez_de)    AS ruecksendung_status_bez_bg    -- BG
FROM dbp_view.V_L_RUECKSENDUNG_STATUS_2 rs_2
JOIN DBP_VIEW.V_RUECKSENDUNG_STATUS_SPR_ZU_2 rss
ON rs.mandant_id = rss.mandant_id AND rs.ruecksendung_status_id = rss.ruecksendung_status_id
GROUP BY ALL
;