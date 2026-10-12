CREATE OR REPLACE PROCEDURE dbp_msi_view_nfmd.sp_in_nfmd_article_cluster_price_date_discount(IN P_KJWO_WW STRING, IN P_MANDANT_ID FLOAT64, IN P_ARTICLE_CLUSTER_ID STRING, IN P_USER_ID STRING, IN P_MANUAL_VALID_FROM STRING, IN P_DISCOUNT_PROZENT FLOAT64, IN P_FLAG FLOAT64, IN P_FLAG_RABATTART FLOAT64, IN P_DISCOUNT_WAEHRUNG FLOAT64, OUT out_param STRING)
BEGIN
DECLARE var_currentDate DATE;
DECLARE var_next_saptransfer_date DATE;
BEGIN
BEGIN TRANSACTION;
SET var_currentDate  =  (SELECT IF(CURRENT_DATE("Europe/Berlin") = LAST_DAY(CURRENT_DATE("Europe/Berlin")), LAST_DAY(DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL 3 MONTH)), DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL 3 MONTH)));

SET var_next_saptransfer_date  =  (SELECT DATE_ADD(next_export_date, INTERVAL 1 DAY)
FROM dbp_msi_view_nfmd.mv_nfmd_parameters_1
WHERE mandant_id = P_MANDANT_ID);

-- FLAG = 0  NUR Gültig ab 
-- FLAG = 1  NUR Rabatt
-- FLAG = 2  Beides !!
-- FLAG = 3 auf empfohlenen VK_1 zurueck setzen 
-- Unterflag Rabattierung (Flag Rabattart)
--      0 = %
--      1 = Währung 
IF P_FLAG = 0 THEN

    IF CAST(P_MANUAL_VALID_FROM AS DATE) > var_next_saptransfer_date AND CAST(P_MANUAL_VALID_FROM AS DATE) < var_currentDate THEN
        BEGIN
        
        INSERT INTO dbp_msi_view_nfmd.ts_nfmd_article_price_date_1 (mandant_id, aktion_id, art_id, kjwo_ww, manual_promo_price_dt, user_id, dwh_created_tmsp)
(SELECT V01.mandant_id, V01.aktion_id, V01.art_id, V01.kjwo_ww, SUBSTR(CAST(PARSE_DATE('%m/%d/%Y', P_MANUAL_VALID_FROM) AS STRING), 1, 255) AS p_manual_valid_from, P_USER_ID, CAST(CURRENT_TIMESTAMP() AS DATETIME)
    FROM dbp_msi_view_nfmd.ts_nfmd_approved_decision_1 AS V01
        LEFT JOIN dbp_msi_view_nfmd.mv_nfmd_latest_article_article_cluster_rel_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.kjwo_ww = V02.kjwo_ww AND V01.art_id = V02.art_id -- AND v01.aktion_id = v02.aktion_id

    WHERE V01.mandant_id = P_MANDANT_ID AND V01.kjwo_ww IN (SELECT CAST(VALUE AS INTEGER) AS value
                FROM (SELECT 1 AS seq) AS t
                    INNER JOIN UNNEST(SPLIT(P_KJWO_WW, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND V01.markdown_decision_id = 0 AND COALESCE(V02.article_cluster_id, 0) IN (SELECT CAST(VALUE AS INTEGER) AS value
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

ELSEIF P_FLAG = 1 THEN
    BEGIN
    
    INSERT INTO dbp_msi_view_nfmd.ts_nfmd_article_store_price_1 (mandant_id, aktion_id, art_id, wup_id, kjwo_ww, wrg_id, manual_promo_price_gross_local_val, user_id, dwh_created_tmsp)
(SELECT V01.mandant_id, V03.aktion_id, V01.art_id, V03.wup_id, V01.kjwo_ww, V03.wrg_id, CASE WHEN P_FLAG_RABATTART = 0 THEN CAST(V03.selling_price_gross_local_val * (1 - P_DISCOUNT_PROZENT / 100) AS NUMERIC) WHEN P_FLAG_RABATTART = 1 THEN CAST(P_DISCOUNT_WAEHRUNG AS NUMERIC) ELSE NULL END AS manual_promo_price_gross_local_val, P_USER_ID, CAST(CURRENT_TIMESTAMP() AS DATETIME)
    FROM dbp_msi_view_nfmd.ts_nfmd_approved_decision_1 AS V01
        INNER JOIN dbp_msi_view_nfmd.mv_nfmd_article_store_scorecard_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.kjwo_ww = V03.kjwo_ww AND V01.art_id = V03.art_id -- AND v01.aktion_id = v03.aktion_id
 AND (V03.previous_submitted_price IS NULL OR V03.previous_submitted_price > CASE WHEN P_FLAG_RABATTART = 0 THEN CAST(V03.selling_price_gross_local_val * (1 - P_DISCOUNT_PROZENT / 100) AS NUMERIC) WHEN P_FLAG_RABATTART = 1 THEN CAST(P_DISCOUNT_WAEHRUNG AS NUMERIC) ELSE NULL END) AND V01.markdown_decision_id = 0
        LEFT JOIN dbp_msi_view_nfmd.mv_nfmd_latest_article_article_cluster_rel_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.kjwo_ww = V02.kjwo_ww AND V01.art_id = V02.art_id
    WHERE V01.mandant_id = P_MANDANT_ID AND V01.kjwo_ww IN (SELECT CAST(VALUE AS INTEGER) AS value
                FROM (SELECT 1 AS seq) AS t
                    INNER JOIN UNNEST(SPLIT(P_KJWO_WW, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND V01.markdown_decision_id = 0 AND COALESCE(V02.article_cluster_id, 0) IN (SELECT CAST(VALUE AS INTEGER) AS value
                FROM (SELECT 1 AS seq) AS t3
                    INNER JOIN UNNEST(SPLIT(P_ARTICLE_CLUSTER_ID, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE));
    COMMIT TRANSACTION;
    SET out_param  =  'Rabatt fuer Artikelcluster gesetzt';
    SELECT out_param;
    RETURN;
    END;
ELSEIF P_FLAG = 2 THEN

    IF CAST(P_MANUAL_VALID_FROM AS DATE) > var_next_saptransfer_date AND CAST(P_MANUAL_VALID_FROM AS DATE) < var_currentDate THEN
        BEGIN
        
        INSERT INTO dbp_msi_view_nfmd.ts_nfmd_article_price_date_1 (mandant_id, aktion_id, art_id, kjwo_ww, manual_promo_price_dt, user_id, dwh_created_tmsp)
(SELECT V01.mandant_id, V01.aktion_id, V01.art_id, V01.kjwo_ww, SUBSTR(CAST(PARSE_DATE('%m/%d/%Y', P_MANUAL_VALID_FROM) AS STRING), 1, 255) AS p_manual_valid_from, P_USER_ID, CAST(CURRENT_TIMESTAMP() AS DATETIME)
    FROM dbp_msi_view_nfmd.ts_nfmd_approved_decision_1 AS V01
        LEFT JOIN dbp_msi_view_nfmd.mv_nfmd_latest_article_article_cluster_rel_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.kjwo_ww = V02.kjwo_ww AND V01.art_id = V02.art_id -- AND v01.aktion_id = v02.aktion_id

    WHERE V01.mandant_id = P_MANDANT_ID AND V01.kjwo_ww IN (SELECT CAST(VALUE AS INTEGER) AS value
                FROM (SELECT 1 AS seq) AS t
                    INNER JOIN UNNEST(SPLIT(P_KJWO_WW, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND V01.markdown_decision_id = 0 AND COALESCE(V02.article_cluster_id, 0) IN (SELECT CAST(VALUE AS INTEGER) AS value
                FROM (SELECT 1 AS seq) AS t3
                    INNER JOIN UNNEST(SPLIT(P_ARTICLE_CLUSTER_ID, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE));
        
        INSERT INTO dbp_msi_view_nfmd.ts_nfmd_article_store_price_1 (mandant_id, aktion_id, art_id, wup_id, kjwo_ww, wrg_id, manual_promo_price_gross_local_val, user_id, dwh_created_tmsp)
(SELECT V01.mandant_id, V03.aktion_id, V01.art_id, V03.wup_id, V01.kjwo_ww, V03.wrg_id, CASE WHEN P_FLAG_RABATTART = 0 THEN CAST(V03.selling_price_gross_local_val * (1 - P_DISCOUNT_PROZENT / 100) AS NUMERIC) WHEN P_FLAG_RABATTART = 1 THEN CAST(P_DISCOUNT_WAEHRUNG AS NUMERIC) ELSE NULL END AS manual_promo_price_gross_local_val, P_USER_ID, CAST(CURRENT_TIMESTAMP() AS DATETIME)
    FROM dbp_msi_view_nfmd.ts_nfmd_approved_decision_1 AS V01
        INNER JOIN dbp_msi_view_nfmd.mv_nfmd_article_store_scorecard_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.kjwo_ww = V03.kjwo_ww AND V01.art_id = V03.art_id -- AND v01.aktion_id = v03.aktion_id
 AND (V03.previous_submitted_price IS NULL OR V03.previous_submitted_price > CASE WHEN P_FLAG_RABATTART = 0 THEN CAST(V03.selling_price_gross_local_val * (1 - P_DISCOUNT_PROZENT / 100) AS NUMERIC) WHEN P_FLAG_RABATTART = 1 THEN CAST(P_DISCOUNT_WAEHRUNG AS NUMERIC) ELSE NULL END) AND V01.markdown_decision_id = 0
        LEFT JOIN dbp_msi_view_nfmd.mv_nfmd_latest_article_article_cluster_rel_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.kjwo_ww = V02.kjwo_ww AND V01.art_id = V02.art_id
    WHERE V01.mandant_id = P_MANDANT_ID AND V01.kjwo_ww IN (SELECT CAST(VALUE AS INTEGER) AS value
                FROM (SELECT 1 AS seq) AS t
                    INNER JOIN UNNEST(SPLIT(P_KJWO_WW, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND V01.markdown_decision_id = 0 AND COALESCE(V02.article_cluster_id, 0) IN (SELECT CAST(VALUE AS INTEGER) AS value
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

ELSEIF P_FLAG = 3 THEN
    
    INSERT INTO dbp_msi_view_nfmd.ts_nfmd_article_store_price_1 (mandant_id, aktion_id, art_id, wup_id, kjwo_ww, wrg_id, manual_promo_price_gross_local_val, user_id, dwh_created_tmsp)
(SELECT V01.mandant_id, V03.aktion_id, V01.art_id, V03.wup_id, V01.kjwo_ww, V03.wrg_id, NULL, P_USER_ID, CAST(CURRENT_TIMESTAMP() AS DATETIME)
    FROM dbp_msi_view_nfmd.ts_nfmd_approved_decision_1 AS V01
        INNER JOIN dbp_msi_view_nfmd.mv_nfmd_article_store_scorecard_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.kjwo_ww = V03.kjwo_ww AND V01.art_id = V03.art_id -- AND v01.aktion_id = v03.aktion_id
 AND V01.markdown_decision_id = 0
        LEFT JOIN dbp_msi_view_nfmd.mv_nfmd_latest_article_article_cluster_rel_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.kjwo_ww = V02.kjwo_ww AND V01.art_id = V02.art_id
        --AND v01.aktion_id = v02.aktion_id
    WHERE V01.mandant_id = P_MANDANT_ID AND V01.kjwo_ww IN (SELECT CAST(VALUE AS INTEGER) AS value
                FROM (SELECT 1 AS seq) AS t
                    INNER JOIN UNNEST(SPLIT(P_KJWO_WW, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND V01.markdown_decision_id = 0 AND COALESCE(V02.article_cluster_id, 0) IN (SELECT CAST(VALUE AS INTEGER) AS value
                FROM (SELECT 1 AS seq) AS t3
                    INNER JOIN UNNEST(SPLIT(P_ARTICLE_CLUSTER_ID, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE));
END IF;

COMMIT TRANSACTION;
SET out_param  =  'Rabatt fuer Artikelcluster gesetzt';
SELECT out_param;
RETURN;
END;
END;
