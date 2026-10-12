CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_DIM_CUSTOMER_SEGMENTATION_BASE
AS SELECT
     IFNULL(DIM_CSB.CUST_SID, '-1') AS CUST_SID
    ,CASE WHEN DIM_CSB.CUST_TYPE_CD = '' THEN '-1' ELSE IFNULL(DIM_CSB.CUST_TYPE_CD, '-1') END AS CUST_TYPE_CD
    ,CASE WHEN DIM_CSB.CUST_GENDER_CD = '' THEN '-1' ELSE IFNULL(DIM_CSB.CUST_GENDER_CD, '-1') END AS CUST_GENDER_CD
    ,DIM_CSB.CUST_BIRTH_CY AS CUST_BIRTH_CY
    ,CASE WHEN DIM_CSB.ZIP_SHORT_CD = '' THEN '-1' ELSE IFNULL(DIM_CSB.ZIP_SHORT_CD, '-1') END AS ZIP_SHORT_CD
    ,DIM_CSB.CITY_NAME AS CITY_NAME
    ,DIM_CSB.COUNTRY_NAME AS COUNTRY_NAME
    ,IFNULL(DIM_CAS.CUST_AGE_SEGM_CD, '-1') AS CUST_AGE_SEGM_CD
FROM
    lec_share.v_dim_customer_segmentation_base DIM_CSB
LEFT JOIN
    lec_share.v_dim_customer_age_segment DIM_CAS
    ON
        (YEAR(CURRENT_DATE()) - DIM_CSB.CUST_BIRTH_CY)
        BETWEEN
            DIM_CAS.CUST_AGE_SEGM_START_YEAR
            AND
            IFF(DIM_CAS.CUST_AGE_SEGM_END_YEAR = -1, 118, DIM_CAS.CUST_AGE_SEGM_END_YEAR) -- age segment end year of "über 80" is -1. replace it with 118 (oldest person currently alive)
        AND DIM_CAS.CUST_AGE_SEGM_TYPE_CD='MSTR' -- there can be multiple segmentation types in this table, we want only MSTR here
WHERE
    DIM_CSB.DWH_VALID_FG = TRUE
UNION ALL
    SELECT
         '-1' -- CUST_SID
        ,'-1' -- CUST_TYPE_CD
        ,'-1' -- CUST_GENDER_CD
        ,'0' -- CUST_BIRTH_CY
        ,'-1' -- ZIP_SHORT_CD
        ,'' -- CITY_NAME
        ,'' -- COUNTRY_NAME
        ,'-1' -- CUST_AGE_SEGM_CD
;
