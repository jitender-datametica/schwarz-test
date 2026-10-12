CREATE OR REPLACE PROCEDURE dbp_msi_view_nfmd.sp_in_nfmd_art_second_discount_checkbox(IN P_KJWO_WW INT64, IN P_MANDANT_ID INT64, IN P_AKTION_ID STRING, IN P_ART_ID INT64, IN P_USER_ID STRING, IN P_WRG_ID STRING, IN P_DISCOUNT_TYPE_NAME STRING, IN P_CHECKBOX_HELPER INT64, OUT out_param STRING)
BEGIN
DECLARE var_currentDate_add3Months DATE;
DECLARE var_next_saptransfer_date DATE;
BEGIN TRANSACTION;
BEGIN

CASE P_CHECKBOX_HELPER 
WHEN 1 THEN
   
    INSERT INTO dbp_msi_view_nfmd.ts_nfmd_article_store_price (mandant_id, aktion_id, art_id, wup_id, discount_type_name, kjwo_ww, wrg_id, manual_promo_price_gross_local_val, user_id, dwh_created_tmsp)
(SELECT P_MANDANT_ID, P_AKTION_ID, P_ART_ID, wup_id, P_DISCOUNT_TYPE_NAME, P_KJWO_WW, P_WRG_ID, model_price_gross_local_val, P_USER_ID, CAST(CURRENT_TIMESTAMP() AS DATETIME)
    FROM dbp_data.nfmd_article_store_scorecard
    WHERE discount_type_name = P_DISCOUNT_TYPE_NAME AND mandant_id = P_MANDANT_ID AND kjwo_ww = P_KJWO_WW AND art_id = P_ART_ID);
WHEN 0 THEN
   
    DELETE FROM dbp_msi_view_nfmd.ts_nfmd_article_store_price
WHERE mandant_id = P_MANDANT_ID AND kjwo_ww = P_KJWO_WW AND dwh_created_tmsp < CAST(DATETIME_ADD(CURRENT_TIMESTAMP(), INTERVAL - 30 MINUTE) AS DATETIME) AND art_id = P_ART_ID AND art_id NOT IN (SELECT art_id
            FROM dbp_msi_view_nfmd.ts_nfmd_manual_price_release
            WHERE discount_type_name = P_DISCOUNT_TYPE_NAME AND art_id = P_ART_ID AND mandant_id = P_MANDANT_ID AND kjwo_ww = P_KJWO_WW);
END CASE;

COMMIT TRANSACTION;
SET out_param  =  'Anpassung ZR erfolgreich';
SELECT out_param;
RETURN;
END;
END;

