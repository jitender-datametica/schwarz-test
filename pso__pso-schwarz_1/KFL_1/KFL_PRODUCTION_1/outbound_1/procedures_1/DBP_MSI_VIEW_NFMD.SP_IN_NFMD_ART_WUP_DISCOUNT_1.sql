CREATE OR REPLACE PROCEDURE dbp_msi_view_nfmd.sp_in_nfmd_art_wup_discount(IN P_KJWO_WW INT64, IN P_MANDANT_ID INT64, IN P_AKTION_ID STRING, IN P_ART_ID INT64, IN P_WUP_ID INT64, IN P_USER_ID STRING, IN P_MANUAL_MARKDOWN_PRICE FLOAT64, IN P_MANUAL_MARKDOWN_PERCENTAGE FLOAT64, IN P_MANUAL_VALID_FROM STRING, IN P_STATIC_MANUAL_MARKDOWN_PRICE FLOAT64, IN P_STATIC_MANUAL_MARKDOWN_PERCENTAGE FLOAT64, IN P_STATIC_MANUAL_VALID_FROM STRING, IN P_VK_AKTION_BRUTTO FLOAT64, IN P_WRG_ID STRING, IN P_DISCOUNT_TYPE_FG INT64, OUT out_param STRING)
BEGIN
DECLARE var_currentDate_add3Months DATE;
BEGIN
BEGIN TRANSACTION;
CASE P_DISCOUNT_TYPE_FG 
WHEN 0 THEN
    
    INSERT INTO dbp_msi_view_nfmd.ts_nfmd_article_store_price_1 (mandant_id, aktion_id, art_id, wup_id, kjwo_ww, wrg_id, manual_promo_price_gross_local_val, user_id, dwh_created_tmsp)
(SELECT P_MANDANT_ID AS mandant_id, P_AKTION_ID AS aktion_id, P_ART_ID AS art_id, P_WUP_ID AS wup_id, P_KJWO_WW AS kjwo_ww, P_WRG_ID AS wrg_id, ROUND(CAST(P_MANUAL_MARKDOWN_PRICE AS NUMERIC), 2) AS manual_promo_price_gross_local_val, P_USER_ID AS user_id, CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_created_tmsp);
WHEN 1 THEN
    
    INSERT INTO dbp_msi_view_nfmd.ts_nfmd_article_store_price_1 (mandant_id, aktion_id, art_id, wup_id, kjwo_ww, wrg_id, manual_promo_price_gross_local_val, user_id, dwh_created_tmsp)
(SELECT P_MANDANT_ID AS mandant_id, P_AKTION_ID AS aktion_id, P_ART_ID AS art_id, P_WUP_ID AS wup_id, P_KJWO_WW AS kjwo_ww, P_WRG_ID AS wrg_id, ROUND(CAST((1 - P_MANUAL_MARKDOWN_PERCENTAGE) * P_VK_AKTION_BRUTTO AS NUMERIC), 2) AS manual_promo_price_gross_local_val, P_USER_ID AS user_id, CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_created_tmsp);
END CASE;


IF P_MANUAL_VALID_FROM <> P_STATIC_MANUAL_VALID_FROM THEN
    BEGIN
    SET var_currentDate_add3Months  =  (SELECT IF(CURRENT_DATE("Europe/Berlin") = LAST_DAY(CURRENT_DATE("Europe/Berlin")), LAST_DAY(DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL 3 MONTH)), DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL 3 MONTH)));

    IF CAST(P_MANUAL_VALID_FROM AS DATE) <= var_currentDate_add3Months THEN
        
        INSERT INTO dbp_msi_view_nfmd.ts_nfmd_article_store_price_date_1 (mandant_id, aktion_id, art_id, wup_id, kjwo_ww, manual_promo_price_dt, user_id, dwh_created_tmsp)
(SELECT P_MANDANT_ID AS mandant_id, P_AKTION_ID AS aktion_id, P_ART_ID AS art_id, P_WUP_ID AS wup_id, P_KJWO_WW AS kjwo_ww, CAST(P_MANUAL_VALID_FROM AS DATE) AS manual_promo_price_dt, P_USER_ID AS user_id, CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_created_tmsp);
    END IF;

    END;
END IF;

COMMIT TRANSACTION;
SET out_param  =  'Rabatt MAK Level gespeichert';
SELECT out_param;
RETURN;
END;
END;


