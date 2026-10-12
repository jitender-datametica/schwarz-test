CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_KPGES_ABSCHRIFTEN_GESAMT_PLAN_MTH_COUNTRY_REGION_2
(
    CLIENT_ID
    ,CY_MONTH
    ,CURRENCY_ISO_CD
    ,DAT_DAYEND
    ,VAL_INDICATOR
    ,GL_REGION_ID
    ,ASPECT_ID
    ,WH_ID
    ,VAL_INDICATOR_GL
) AS
SELECT   
    a11.client_id
    ,a11.cy_month
    ,a11.currency_iso_cd
    ,a11.dat_dayend
    ,a11.val_indicator
    ,a12.gl_region_id 
    ,a13.aspect_id
    ,a14.wh_id
    ,CASE WHEN (a12.gl_region_id >0) THEN 0 ELSE val_indicator END AS val_indicator_gl
    
    FROM p_lew_mart_msi_ac.v_kpges_plan_mth_country_2    a11
    INNER JOIN p_lew_mart_msi_ac.v_ref_gl_region_2    a12
    ON a11.client_id = a12.client_id
    
    INNER JOIN P_LEW_MART_MSI_AC.V_REF_ASPECT_2 a13
    
    INNER JOIN p_lew_mart_msi_ac.V_ORG_WH_MERGE_2 a14
    ON a11.client_id    = a14.client_id
    AND a12.gl_region_id = a14.gl_region_id
    AND a13.aspect_id    = a14.aspect_id
    
    WHERE a11.indicator_id IN (314);