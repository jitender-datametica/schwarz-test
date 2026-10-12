CREATE OR REPLACE PROCEDURE DBP_MSI_VIEW_NFMD.SP_IN_NFMD_ART_SECOND_DISCOUNT("P_KJWO_WW" NUMBER(38,0), "P_MANDANT_ID" NUMBER(38,0), "P_AKTION_ID" VARCHAR(255), "P_ART_ID" NUMBER(38,0), "P_USER_ID" VARCHAR(255), "P_MANUAL_VALID_FROM" VARCHAR(255), "P_COMMENT_TEXT" VARCHAR(255), "P_STATIC_MANUAL_VALID_FROM" VARCHAR(255), "P_STATIC_COMMENT_DECISION" VARCHAR(255), "P_VK_AKTION_BRUTTO" FLOAT, "P_WRG_ID" VARCHAR(20), "P_DISCOUNT_TYPE_FG" NUMBER(38,0), "P_DISCOUNT_TYPE_NAME" VARCHAR(50), "P_SECOND_DISCOUNT_PERCENTAGE" FLOAT)
RETURNS VARCHAR(16777216)
LANGUAGE SQL
COMMENT='Insert data into TS_NFMD_ARTICLE_PRICE_2 and TS_NFMD_ARTICLE_PRICE_DATE_2 tables based on the second discount percentage'
EXECUTE AS OWNER
AS '
DECLARE
    var_currentDate_add3Months date;
    var_next_saptransfer_date date;
    var_second_discount float;
    
BEGIN 
    var_second_discount := :P_SECOND_DISCOUNT_PERCENTAGE/100;
    
    INSERT INTO DBP_MSI_VIEW_NFMD.TS_NFMD_ARTICLE_PRICE_2(
        KJWO_WW,
        MANDANT_ID,
        AKTION_ID,
        ART_ID,
        DWH_CREATED_TMSP,
        USER_ID,
        WRG_ID,
        MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL,
        DISCOUNT_TYPE_NAME
    )
    VALUES (
        :P_KJWO_WW,
        :P_MANDANT_ID,
        :P_AKTION_ID,
        :P_ART_ID,
        CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
        :P_USER_ID,
        :P_WRG_ID,
        :P_VK_AKTION_BRUTTO,   -- 1 minus the discount percentage multiplied by the initial price to give the manual discount price
        :P_DISCOUNT_TYPE_NAME
    );

    CASE WHEN (:P_MANUAL_VALID_FROM!= :P_STATIC_MANUAL_VALID_FROM) THEN

        SELECT add_months(current_date,3)  INTO :var_currentDate_add3Months;
        SELECT NEXT_EXPORT_DATE + 1 INTO :var_next_saptransfer_date FROM DBP_MSI_VIEW_NFMD.MV_NFMD_PARAMETERS_2 WHERE MANDANT_ID = :P_MANDANT_ID;
        
        CASE WHEN (:P_MANUAL_VALID_FROM > :var_next_saptransfer_Date 
                AND :P_MANUAL_VALID_FROM <= :var_currentDate_add3Months) THEN
            --Valid From
            INSERT INTO DBP_MSI_VIEW_NFMD.TS_NFMD_ARTICLE_PRICE_DATE_2 (KJWO_WW,
                                                                     MANDANT_ID,
                                                                     AKTION_ID,
                                                                     ART_ID,
                                                                     DWH_CREATED_TMSP,
                                                                     USER_ID,
                                                                     MANUAL_PROMO_PRICE_DT)
            VALUES (:P_KJWO_WW,
                    :P_MANDANT_ID,
                    :P_AKTION_ID,
                    :P_ART_ID,
                    CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
                    :P_USER_ID,
                    :P_MANUAL_VALID_FROM);
        END CASE;
    END CASE;

    COMMIT;
END;
';