CREATE OR REPLACE VIEW DBP_MSI_VIEW_NFMD.MV_WTAG_SPR_ZU AS
SELECT  
    v01.wtag_id
    ,MAX(CASE WHEN v01.SPR_ID =  22 THEN v01.wtag_bez END) AS wtag_bez                -- standard == DE
    ,MAX(CASE WHEN v01.SPR_ID =  22 THEN v01.wtag_bez END) AS wtag_bez_de                                --DE
    ,COALESCE(MAX(CASE WHEN v01.SPR_ID =  24 THEN v01.wtag_bez END), wtag_bez_de) AS wtag_bez_en    -- EN
    ,COALESCE(MAX(CASE WHEN v01.SPR_ID = 124 THEN v01.wtag_bez END), wtag_bez_de) AS wtag_bez_cz    -- CZ
    ,COALESCE(MAX(CASE WHEN v01.SPR_ID = 108 THEN v01.wtag_bez END), wtag_bez_de) AS wtag_bez_sk    -- SK
    ,COALESCE(MAX(CASE WHEN v01.SPR_ID =  65 THEN v01.wtag_bez END), wtag_bez_de) AS wtag_bez_hr    -- HR
    ,COALESCE(MAX(CASE WHEN v01.SPR_ID =  90 THEN v01.wtag_bez END), wtag_bez_de) AS wtag_bez_pl    -- PL
    ,COALESCE(MAX(CASE WHEN v01.SPR_ID =  95 THEN v01.wtag_bez END), wtag_bez_de) AS wtag_bez_ro    -- RO
    ,COALESCE(MAX(CASE WHEN v01.SPR_ID =  18 THEN v01.wtag_bez END), wtag_bez_de) AS wtag_bez_bg    -- BG
FROM dbp_view.v_wtag_spr_zu  v01
GROUP BY  v01.wtag_id; 