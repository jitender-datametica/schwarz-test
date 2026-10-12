CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_DIM_PRODUCT_AVAILABILITY_LEVEL
AS SELECT
     CASE WHEN AVAIL_LVL_CD = '' THEN '-1' ELSE IFNULL(AVAIL_LVL_CD, '-1') END AS AVAIL_LVL_CD
    ,AVAIL_LVL_DESCR AS AVAIL_LVL_DESCR 
FROM
    lec_share.v_dim_product_availability_level
UNION ALL
    SELECT
         '-1' -- AVAIL_LVL_CD
        ,'Offline' -- AVAIL_LVL_DESCR -- set to offline after discussion with Chris Funk (NULL in fact table always means Offline)
;
