CREATE OR REPLACE PROCEDURE `dbp_msi_view_nfmd.sp_in_nfmd_article_cluster_price_date` (
    P_KJWO_WW STRING,
    P_MANDANT_ID FLOAT64,
    P_ARTICLE_CLUSTER_ID FLOAT64,
    P_USER_ID STRING,
    P_MANUAL_VALID_FROM STRING
)
BEGIN

    -- Using a set-based approach (UNNEST) instead of looping through the comma-separated string
    INSERT INTO `dbp_msi_view_nfmd.ts_nfmd_article_price_date` (
        kjwo_ww,
        mandant_id,
        art_id,
        dwh_created_tmsp,
        user_id,
        manual_promo_price_dt
    )
    SELECT 
        kjwo_ww, 
        mandant_id, 
        art_id, 
        CURRENT_DATETIME(),
        P_USER_ID,
        CAST(PARSE_DATE('%m/%d/%Y', P_MANUAL_VALID_FROM) AS STRING)
    FROM `dbp_msi_view_nfmd.mv_nfmd_art_promotion`
    WHERE kjwo_ww IN (
            SELECT CAST(item AS INT64) 
            FROM UNNEST(SPLIT(P_KJWO_WW, ',')) AS item
          )
      AND mandant_id = P_MANDANT_ID 
      AND article_cluster = P_ARTICLE_CLUSTER_ID;

END;
