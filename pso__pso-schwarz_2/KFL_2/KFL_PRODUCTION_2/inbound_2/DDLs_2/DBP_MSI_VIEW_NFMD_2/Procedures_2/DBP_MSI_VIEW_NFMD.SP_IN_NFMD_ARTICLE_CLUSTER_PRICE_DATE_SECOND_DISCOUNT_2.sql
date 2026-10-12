CREATE OR REPLACE PROCEDURE DBP_MSI_VIEW_NFMD.SP_IN_NFMD_ARTICLE_CLUSTER_PRICE_DATE_SECOND_DISCOUNT("P_KJWO_WW" VARCHAR(16777216), "P_MANDANT_ID" FLOAT, "P_ARTICLE_CLUSTER_ID" VARCHAR(16777216), "P_USER_ID" VARCHAR(255), "P_MANUAL_VALID_FROM" VARCHAR(255), "P_FLAG" FLOAT, "P_DISCOUNT_TYPE_NAME" VARCHAR(50), "P_SECOND_DISCOUNT_PERCENTAGE" FLOAT)
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    NOT_UPDATED_REC EXCEPTION(-20001,''NOT_UPDATED! Date must be between the next SAP-transferdate and the next 3 months'');
    var_currentDate date;
    var_next_saptransfer_date date;
BEGIN 
    SELECT add_months(current_date,3)  INTO :var_currentDate;
    SELECT NEXT_EXPORT_DATE + 1 INTO :var_next_saptransfer_date FROM DBP_MSI_VIEW_NFMD.MV_NFMD_PARAMETERS_2 WHERE MANDANT_ID = :P_MANDANT_ID;

    -- FLAG = 0  NUR Gültig ab 
    -- FLAG = 1  NUR Rabatt
    -- FLAG = 2  Beides !!

    CASE :P_FLAG 
        WHEN 0  THEN 
            

            IF ( :P_MANUAL_VALID_FROM > :var_next_saptransfer_Date 
                AND TO_DATE(:P_MANUAL_VALID_FROM,''MM_2/DD/YYYY'') < :var_currentDate) THEN
            INSERT INTO DBP_MSI_VIEW_NFMD.TS_NFMD_ARTICLE_PRICE_DATE_2(
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
                TO_DATE(:P_MANUAL_VALID_FROM,''MM_2/DD/YYYY'')
            FROM DBP_MSI_VIEW_NFMD.TS_NFMD_APPROVED_DECISION_2 v01
            LEFT JOIN DBP_MSI_VIEW_NFMD.MV_NFMD_LATEST_ARTICLE_ARTICLE_CLUSTER_REL_2 v02 -- DBP_MSI_VIEW_NFMD.TS_NFMD_ARTICLE_ARTICLE_CLUSTER_REL_2 v02
            ON v01.mandant_id = v02.mandant_id
            AND v01.kjwo_ww = v02.kjwo_ww
            AND v01.art_id = v02.art_id
            -- AND v01.aktion_id = v02.aktion_id

            WHERE v01.mandant_id = :P_MANDANT_ID
            AND v01.kjwo_ww IN ( SELECT table1.value FROM TABLE(split_to_table(:P_KJWO_WW, '','')) AS table1 )
            AND v01.markdown_decision_id = 0 
            AND COALESCE(v02.article_cluster_id,0) IN ( SELECT table1.value FROM TABLE(split_to_table(:P_ARTICLE_CLUSTER_ID, '','')) AS table1 )
            ;

            COMMIT;
            RETURN ''Datum abgespeichert fuer Artikelcluster'';
            ELSE 
            RAISE NOT_UPDATED_REC;
            RETURN ''Datum NICHT abgespeichert fuer Artikelcluster'';

            END IF;   
    END CASE;
    END;
';