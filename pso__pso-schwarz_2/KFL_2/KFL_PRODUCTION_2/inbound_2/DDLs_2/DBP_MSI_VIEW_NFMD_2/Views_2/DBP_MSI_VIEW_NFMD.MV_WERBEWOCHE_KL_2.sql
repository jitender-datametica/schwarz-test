CREATE OR REPLACE VIEW DBP_MSI_VIEW_NFMD.MV_WERBEWOCHE_KL_2 AS 
SELECT DISTINCT v01.MANDANT_ID,
        v01.AKT_KJWO_WW,
        -- ueber diese Flag wird gesteuert welche WW relevant sind
        CASE WHEN v01.AKT_KJWO_WW BETWEEN -1 - (v02.promo_lifecycle_weeks_cnt) AND -1 THEN 1 ELSE 0 END AS akt_kjwo_ww_relvant_flag,
        --Änderung in Zeile 5 von -2 zu -1 : NSR4777997
        v01.AKT_KJWO_WW_KOMPLETT,
        v01.KJWO_WW,
        MIN(v01.DAT) OVER (PARTITION BY v01.mandant_id, v01.kjwo_ww) AS ww_dat_von,
        MAX(v01.DAT) OVER (PARTITION BY v01.mandant_id, v01.kjwo_ww) AS ww_dat_bis
FROM DBP_VIEW.V_WERBEWOCHE_KL_2 v01
LEFT JOIN DBP_VIEW.V_NFMD_PARAMETER_2 v02
ON v01.mandant_id = v02.mandant_id
;