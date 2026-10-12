CREATE OR REPLACE PROCEDURE dbp_msi_view_nfmd.sp_in_nfmd_art_second_discount(IN P_KJWO_WW INT64, IN P_MANDANT_ID INT64, IN P_AKTION_ID STRING, IN P_ART_ID INT64, IN P_USER_ID STRING, IN P_MANUAL_VALID_FROM STRING, IN P_COMMENT_TEXT STRING, IN P_STATIC_MANUAL_VALID_FROM STRING, IN P_STATIC_COMMENT_DECISION STRING, IN P_VK_AKTION_BRUTTO FLOAT64, IN P_WRG_ID STRING, IN P_DISCOUNT_TYPE_FG INT64, IN P_DISCOUNT_TYPE_NAME STRING, IN P_SECOND_DISCOUNT_PERCENTAGE FLOAT64)
BEGIN
DECLARE var_currentDate_add3Months DATE;
DECLARE var_next_saptransfer_date DATE;
DECLARE var_second_discount FLOAT64;
BEGIN TRANSACTION;
BEGIN
SET var_second_discount  =  P_SECOND_DISCOUNT_PERCENTAGE / 100;

INSERT INTO dbp_msi_view_nfmd.ts_nfmd_article_price_2 (mandant_id, aktion_id, art_id, discount_type_name, kjwo_ww, wrg_id, manual_promo_price_gross_local_val, user_id, dwh_created_tmsp)
(SELECT P_MANDANT_ID AS mandant_id, P_AKTION_ID AS aktion_id, P_ART_ID AS art_id, P_DISCOUNT_TYPE_NAME AS discount_type_name, P_KJWO_WW AS kjwo_ww, P_WRG_ID AS wrg_id, ROUND(CAST(P_VK_AKTION_BRUTTO AS NUMERIC), 2) AS manual_promo_price_gross_local_val, P_USER_ID AS user_id, CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_created_tmsp);

CASE WHEN P_MANUAL_VALID_FROM <> P_STATIC_MANUAL_VALID_FROM 
THEN
SELECT IF(CURRENT_DATE("Europe/Berlin") = LAST_DAY(CURRENT_DATE("Europe/Berlin")), LAST_DAY(DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL 3 MONTH)), DATE_ADD(CURRENT_DATE("Europe/Berlin")
   ,INTERVAL 3 MONTH)) = var_currentDate_add3Months;
SELECT NEXT_EXPORT_DATE +1 = var_next_saptransfer_date
FROM  dbp_msi_view_nfmd.mv_nfmd_parameters_2 
WHERE MANDATE_ID = P_MANDANT_ID;

CASE WHEN (P_MANUAL_VALID_FROM > var_next_saptransfer_Date AND P_MANUAL_VALID_FROM <= var_currentDate_add3Months) THEN
INSERT INTO dbp_msi_view_nfmd.ts_nfmd_article_price_date_2 (mandant_id, aktion_id, art_id, kjwo_ww, manual_promo_price_dt, user_id, dwh_created_tmsp)
(SELECT P_MANDANT_ID AS mandant_id, P_AKTION_ID AS aktion_id, P_ART_ID AS art_id, P_KJWO_WW AS kjwo_ww, P_MANUAL_VALID_FROM AS manual_promo_price_dt, P_USER_ID AS user_id, CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_created_tmsp);
        END CASE;
    END CASE;
    COMMIT;     
END;
END;