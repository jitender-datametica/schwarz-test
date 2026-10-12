CREATE OR REPLACE PROCEDURE DBP_MSI_VIEW_NFMD.SP_IN_NFMD_ARTICLE_CLUSTER_PRICE_DATE_DISCOUNT(
    "P_KJWO_WW" VARCHAR(16777216), 
    "P_MANDANT_ID" FLOAT, 
    "P_ARTICLE_CLUSTER_ID" VARCHAR(16777216), 
    "P_USER_ID" VARCHAR(255), 
    "P_MANUAL_VALID_FROM" VARCHAR(255),
    "P_DISCOUNT_PROZENT" FLOAT,
    "P_FLAG" FLOAT,
    "P_FLAG_RABATTART" FLOAT,
    "P_DISCOUNT_WAEHRUNG" FLOAT)
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS 
$$
DECLARE
    NOT_UPDATED_REC EXCEPTION(-20001,'NOT_UPDATED! Date must be between the next SAP-transferdate and the next 3 months');
    var_currentDate date;
    var_next_saptransfer_date date;
BEGIN 
SELECT add_months(current_date,3)  INTO :var_currentDate;
SELECT NEXT_EXPORT_DATE + 1 INTO :var_next_saptransfer_date FROM DBP_MSI_VIEW_NFMD.MV_NFMD_PARAMETERS_1 WHERE MANDANT_ID = :P_MANDANT_ID;

-- FLAG = 0  NUR Gültig ab 
-- FLAG = 1  NUR Rabatt
-- FLAG = 2  Beides !!
-- FLAG = 3 auf empfohlenen VK_1 zurueck setzen 
-- Unterflag Rabattierung (Flag Rabattart)
--      0 = %
--      1 = Währung 
CASE :P_FLAG 
    WHEN 0  THEN 
        

        IF ( :P_MANUAL_VALID_FROM > :var_next_saptransfer_Date 
            AND :P_MANUAL_VALID_FROM < :var_currentDate) THEN
        INSERT INTO DBP_MSI_VIEW_NFMD.TS_NFMD_ARTICLE_PRICE_DATE_1(
            KJWO_WW,
            MANDANT_ID,
            AKTION_ID,
            ART_ID,
            DWH_CREATED_TMSP,
            USER_ID,
            MANUAL_PROMO_PRICE_DT
          )
        SELECT 
            v01.kjwo_ww,
            v01.mandant_id, 
            v01.aktion_id,
            v01.art_id,
            CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
            :P_USER_ID,
            TO_DATE(:P_MANUAL_VALID_FROM,'MM_1/DD/YYYY')
        FROM DBP_MSI_VIEW_NFMD.TS_NFMD_APPROVED_DECISION_1 v01
        LEFT JOIN DBP_MSI_VIEW_NFMD.MV_NFMD_LATEST_ARTICLE_ARTICLE_CLUSTER_REL_1 v02 -- DBP_MSI_VIEW_NFMD.TS_NFMD_ARTICLE_ARTICLE_CLUSTER_REL_1 v02
        ON v01.mandant_id = v02.mandant_id
        AND v01.kjwo_ww = v02.kjwo_ww
        AND v01.art_id = v02.art_id
        --AND v01.aktion_id = v02.aktion_id

        WHERE v01.mandant_id = :P_MANDANT_ID
        AND v01.kjwo_ww IN ( SELECT table1.value FROM TABLE(split_to_table(:P_KJWO_WW, ',')) AS table1 )
        AND v01.markdown_decision_id = 0 
        AND COALESCE(v02.article_cluster_id,0) IN ( SELECT table1.value FROM TABLE(split_to_table(:P_ARTICLE_CLUSTER_ID, ',')) AS table1 )
        ;

        COMMIT;
        RETURN 'Datum abgespeichert fuer Artikelcluster';
        ELSE 
        RAISE NOT_UPDATED_REC;
        RETURN 'Datum NICHT abgespeichert fuer Artikelcluster';

        END IF;
    WHEN 1 THEN 
        INSERT INTO DBP_MSI_VIEW_NFMD.TS_NFMD_ARTICLE_STORE_PRICE_1(
            KJWO_WW,
            MANDANT_ID,
            AKTION_ID,
            ART_ID,
            WUP_ID,
            DWH_CREATED_TMSP,
            USER_ID,
            WRG_ID,
            MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL
          )
        SELECT v01.KJWO_WW,
            v01.mandant_id,
            v03.aktion_id,
            v01.art_id,
            v03.wup_id,
            CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
            :P_USER_ID, 
            v03.wrg_id,
            CASE WHEN :P_FLAG_RABATTART = 0 
                THEN v03.selling_price_gross_local_val * (1-(:P_DISCOUNT_PROZENT/100))
            WHEN :P_FLAG_RABATTART = 1 
                THEN :P_DISCOUNT_WAEHRUNG END AS MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL
        FROM DBP_MSI_VIEW_NFMD.TS_NFMD_APPROVED_DECISION_1 v01
        INNER JOIN DBP_MSI_VIEW_NFMD.MV_NFMD_ARTICLE_STORE_SCORECARD_1 v03
        ON v01.mandant_id = v03.mandant_id
        AND v01.kjwo_ww = v03.kjwo_ww
        AND v01.art_id = v03.art_id
        --AND v01.aktion_id = v03.aktion_id
        AND (v03.previous_submitted_price is null 
            or v03.previous_submitted_price > (CASE WHEN :P_FLAG_RABATTART = 0 THEN v03.selling_price_gross_local_val * (1-(:P_DISCOUNT_PROZENT/100))  
                                                    WHEN :P_FLAG_RABATTART = 1 THEN :P_DISCOUNT_WAEHRUNG END)
            )
        AND v01.markdown_decision_id = 0 
       
        
        LEFT JOIN DBP_MSI_VIEW_NFMD.MV_NFMD_LATEST_ARTICLE_ARTICLE_CLUSTER_REL_1 v02 -- letzte Änderung 
        ON v01.mandant_id = v02.mandant_id
        AND v01.kjwo_ww = v02.kjwo_ww
        AND v01.art_id = v02.art_id
        --AND v01.aktion_id = v02.aktion_id
        
        WHERE v01.mandant_id = :P_MANDANT_ID
        AND v01.kjwo_ww IN ( SELECT table1.value FROM TABLE(split_to_table(:P_KJWO_WW, ',')) AS table1 )
        AND v01.markdown_decision_id = 0 
        AND COALESCE(v02.article_cluster_id,0) IN ( SELECT table1.value FROM TABLE(split_to_table(:P_ARTICLE_CLUSTER_ID, ',')) AS table1 );
        
        COMMIT;
        RETURN 'Rabatt fuer Artikelcluster gesetzt';
        
    WHEN 2 THEN 
         IF ( :P_MANUAL_VALID_FROM > :var_next_saptransfer_Date 
            AND :P_MANUAL_VALID_FROM < :var_currentDate) THEN
        INSERT INTO DBP_MSI_VIEW_NFMD.TS_NFMD_ARTICLE_PRICE_DATE_1(
            KJWO_WW,
            MANDANT_ID,
            AKTION_ID,
            ART_ID,
            DWH_CREATED_TMSP,
            USER_ID,
            MANUAL_PROMO_PRICE_DT
          )
        SELECT 
            v01.kjwo_ww,
            v01.mandant_id, 
            v01.aktion_id,
            v01.art_id,
            CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
            :P_USER_ID,
            TO_DATE(:P_MANUAL_VALID_FROM,'MM_1/DD/YYYY')
        FROM DBP_MSI_VIEW_NFMD.TS_NFMD_APPROVED_DECISION_1 v01
        LEFT JOIN DBP_MSI_VIEW_NFMD.MV_NFMD_LATEST_ARTICLE_ARTICLE_CLUSTER_REL_1 v02-- DBP_MSI_VIEW_NFMD.TS_NFMD_ARTICLE_ARTICLE_CLUSTER_REL_1 v02
        ON v01.mandant_id = v02.mandant_id
        AND v01.kjwo_ww = v02.kjwo_ww
        AND v01.art_id = v02.art_id
        --AND v01.aktion_id = v02.aktion_id

        WHERE v01.mandant_id = :P_MANDANT_ID
        AND v01.kjwo_ww IN ( SELECT table1.value FROM TABLE(split_to_table(:P_KJWO_WW, ',')) AS table1 )
        AND v01.markdown_decision_id = 0 
        AND COALESCE(v02.article_cluster_id,0) IN ( SELECT table1.value FROM TABLE(split_to_table(:P_ARTICLE_CLUSTER_ID, ',')) AS table1 )
        ;
        
        INSERT INTO DBP_MSI_VIEW_NFMD.TS_NFMD_ARTICLE_STORE_PRICE_1(
            KJWO_WW,
            MANDANT_ID,
            AKTION_ID,
            ART_ID,
            WUP_ID,
            DWH_CREATED_TMSP,
            USER_ID,
            WRG_ID,
            MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL
          )
        SELECT v01.KJWO_WW,
            v01.mandant_id,
            v03.aktion_id,
            v01.art_id,
            v03.wup_id,
            CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
            :P_USER_ID, 
            v03.wrg_id,
            CASE WHEN :P_FLAG_RABATTART = 0 
                THEN v03.selling_price_gross_local_val * (1-(:P_DISCOUNT_PROZENT/100))
            WHEN :P_FLAG_RABATTART = 1 
                THEN :P_DISCOUNT_WAEHRUNG END AS MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL
        FROM DBP_MSI_VIEW_NFMD.TS_NFMD_APPROVED_DECISION_1 v01
        INNER JOIN DBP_MSI_VIEW_NFMD.MV_NFMD_ARTICLE_STORE_SCORECARD_1 v03
        ON v01.mandant_id = v03.mandant_id
        AND v01.kjwo_ww = v03.kjwo_ww
        AND v01.art_id = v03.art_id
        --AND v01.aktion_id = v03.aktion_id
        AND (v03.previous_submitted_price is null 
            or v03.previous_submitted_price > (CASE WHEN :P_FLAG_RABATTART = 0 THEN v03.selling_price_gross_local_val * (1-(:P_DISCOUNT_PROZENT/100))  
                                                    WHEN :P_FLAG_RABATTART = 1 THEN :P_DISCOUNT_WAEHRUNG END)
            )
        AND v01.markdown_decision_id = 0 
       
        
        LEFT JOIN DBP_MSI_VIEW_NFMD.MV_NFMD_LATEST_ARTICLE_ARTICLE_CLUSTER_REL_1 v02 -- letzte Änderung 
        ON v01.mandant_id = v02.mandant_id
        AND v01.kjwo_ww = v02.kjwo_ww
        AND v01.art_id = v02.art_id
        --AND v01.aktion_id = v02.aktion_id
        
        WHERE v01.mandant_id = :P_MANDANT_ID
        AND v01.kjwo_ww IN ( SELECT table1.value FROM TABLE(split_to_table(:P_KJWO_WW, ',')) AS table1 )
        AND v01.markdown_decision_id = 0 
        AND COALESCE(v02.article_cluster_id,0) IN ( SELECT table1.value FROM TABLE(split_to_table(:P_ARTICLE_CLUSTER_ID, ',')) AS table1 );

        COMMIT;
        RETURN 'Datum abgespeichert fuer Artikelcluster';
        ELSE 
        RAISE NOT_UPDATED_REC;
        RETURN 'Datum NICHT abgespeichert fuer Artikelcluster';

        END IF;
    WHEN 3 THEN 
        INSERT INTO DBP_MSI_VIEW_NFMD.TS_NFMD_ARTICLE_STORE_PRICE_1(
            KJWO_WW,
            MANDANT_ID,
            AKTION_ID,
            ART_ID,
            WUP_ID,
            DWH_CREATED_TMSP,
            USER_ID,
            WRG_ID,
            MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL
          )
        SELECT v01.KJWO_WW,
            v01.mandant_id,
            v03.aktion_id,
            v01.art_id,
            v03.wup_id,
            CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
            :P_USER_ID, 
            v03.wrg_id,
            NULL
        FROM DBP_MSI_VIEW_NFMD.TS_NFMD_APPROVED_DECISION_1 v01
        INNER JOIN DBP_MSI_VIEW_NFMD.MV_NFMD_ARTICLE_STORE_SCORECARD_1 v03
        ON v01.mandant_id = v03.mandant_id
        AND v01.kjwo_ww = v03.kjwo_ww
        AND v01.art_id = v03.art_id
        --AND v01.aktion_id = v03.aktion_id
        AND v01.markdown_decision_id = 0 
       
        LEFT JOIN DBP_MSI_VIEW_NFMD.MV_NFMD_LATEST_ARTICLE_ARTICLE_CLUSTER_REL_1 v02 -- letzte Änderung 
        ON v01.mandant_id = v02.mandant_id
        AND v01.kjwo_ww = v02.kjwo_ww
        AND v01.art_id = v02.art_id
        --AND v01.aktion_id = v02.aktion_id
        
        WHERE v01.mandant_id = :P_MANDANT_ID
        AND v01.kjwo_ww IN ( SELECT table1.value FROM TABLE(split_to_table(:P_KJWO_WW, ',')) AS table1 )
        AND v01.markdown_decision_id = 0 
        AND COALESCE(v02.article_cluster_id,0) IN ( SELECT table1.value FROM TABLE(split_to_table(:P_ARTICLE_CLUSTER_ID, ',')) AS table1 );
        
        COMMIT;
        RETURN 'Rabatt fuer Artikelcluster gesetzt';
    
    END;   
END;
$$;