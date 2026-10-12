CREATE OR REPLACE PROCEDURE dbp_msi_view_nfmd.sp_in_nfmd_article_cluster_price_date_second_discount(IN P_KJWO_WW STRING, IN P_MANDANT_ID FLOAT64, IN P_ARTICLE_CLUSTER_ID STRING, IN P_USER_ID STRING, IN P_MANUAL_VALID_FROM STRING, IN P_FLAG FLOAT64, IN P_DISCOUNT_TYPE_NAME STRING, IN P_SECOND_DISCOUNT_PERCENTAGE FLOAT64, OUT out_param STRING)
BEGIN
DECLARE var_currentDate DATE;
DECLARE var_next_saptransfer_date DATE;
BEGIN
BEGIN TRANSACTION;
SET var_currentDate  =  (SELECT IF(CURRENT_DATE("Europe/Berlin") = LAST_DAY(CURRENT_DATE("Europe/Berlin")), LAST_DAY(DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL 3 MONTH)), DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL 3 MONTH)));
SET var_next_saptransfer_date  =  (SELECT DATE_ADD(next_export_date, INTERVAL 1 DAY)
FROM dbp_msi_view_nfmd.mv_nfmd_parameters
WHERE mandant_id = P_MANDANT_ID);
-- FLAG = 0  NUR Gültig ab 
-- FLAG = 1  NUR Rabatt
-- FLAG = 2  Beides !!

CASE P_FLAG 
WHEN 0 THEN

    IF CAST(P_MANUAL_VALID_FROM AS DATE) > var_next_saptransfer_date AND PARSE_DATE('%m/%d/%Y', P_MANUAL_VALID_FROM) < var_currentDate THEN
        BEGIN
        -- KFL_PRODUCTION.DBP_MSI_VIEW_NFMD.TS_NFMD_ARTICLE_ARTICLE_CLUSTER_REL v02
        -- AND v01.aktion_id = v02.aktion_id
        INSERT INTO dbp_msi_view_nfmd.ts_nfmd_article_price_date (mandant_id, aktion_id, art_id, kjwo_ww, manual_promo_price_dt, user_id, dwh_created_tmsp)
(SELECT V01.mandant_id, V01.aktion_id, V01.art_id, V01.kjwo_ww, SUBSTR(CAST(PARSE_DATE('%m/%d/%Y', P_MANUAL_VALID_FROM) AS STRING), 1, 255) AS p_manual_valid_from, P_USER_ID, CAST(CURRENT_TIMESTAMP() AS DATETIME)
    FROM dbp_msi_view_nfmd.ts_nfmd_approved_decision AS V01
        LEFT JOIN dbp_msi_view_nfmd.mv_nfmd_latest_article_article_cluster_rel AS V02 ON V01.mandant_id = V02.mandant_id AND V01.kjwo_ww = V02.kjwo_ww AND V01.art_id = V02.art_id
    WHERE V01.mandant_id = P_MANDANT_ID AND V01.kjwo_ww IN (SELECT CAST(VALUE AS INTEGER) AS value
                FROM (SELECT 1 AS seq) AS t
                    INNER JOIN UNNEST(SPLIT(P_KJWO_WW, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND V01.markdown_decision_id = 0 AND COALESCE(V02.article_cluster_id, 0) IN (SELECT ROUND(CAST(VALUE AS BIGNUMERIC), 0) AS value
                FROM (SELECT 1 AS seq) AS t3
                    INNER JOIN UNNEST(SPLIT(P_ARTICLE_CLUSTER_ID, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE));
        COMMIT TRANSACTION;
        SET out_param  =  'Datum abgespeichert fuer Artikelcluster';
        SELECT out_param;
        RETURN;
        END;
    ELSE
        BEGIN
        RAISE USING MESSAGE = 'NOT_UPDATED_REC';
        SET out_param  =  'Datum NICHT abgespeichert fuer Artikelcluster';
        SELECT out_param;
        RETURN;
        END;
    END IF;

END CASE;

END;
END;

