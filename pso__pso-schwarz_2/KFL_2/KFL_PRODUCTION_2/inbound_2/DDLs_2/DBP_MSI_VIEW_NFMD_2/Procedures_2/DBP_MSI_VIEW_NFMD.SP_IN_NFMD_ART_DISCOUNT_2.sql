CREATE OR REPLACE PROCEDURE DBP_MSI_VIEW_NFMD.SP_IN_NFMD_ART_DISCOUNT(
  "P_KJWO_WW" NUMBER,  
  "P_MANDANT_ID" NUMBER, 
  "P_AKTION_ID" VARCHAR(255), 
  "P_ART_ID" NUMBER, 
  "P_USER_ID" VARCHAR(255), 
  "P_MANUAL_MARKDOWN_PRICE" FLOAT, 
  "P_MANUAL_MARKDOWN_PERCENTAGE" FLOAT, 
  "P_MANUAL_VALID_FROM" VARCHAR(255), 
  "P_COMMENT_TEXT" VARCHAR(255), 
  "P_STATIC_MANUAL_MARKDOWN_PRICE" FLOAT, 
  "P_STATIC_MANUAL_MARKDOWN_PERCENTAGE" FLOAT, 
  "P_STATIC_MANUAL_VALID_FROM" VARCHAR(255), 
  "P_STATIC_COMMENT_DECISION" VARCHAR(255), 
  "P_VK_AKTION_BRUTTO" FLOAT, 
  "P_WRG_ID" VARCHAR(20),
  "P_DISCOUNT_TYPE_FG" NUMBER)
RETURNS STRING
LANGUAGE SQL
COMMENT='Edit Price, Percent, Valid From or Comment through Save button for Article Level'
EXECUTE AS OWNER
AS $$
DECLARE
    var_currentDate_add3Months date;
    var_next_saptransfer_date date;
BEGIN 
CASE :P_DISCOUNT_TYPE_FG 
    WHEN 0 THEN 
        -- Price
        INSERT INTO DBP_MSI_VIEW_NFMD.TS_NFMD_ARTICLE_PRICE_2(
            KJWO_WW,
            MANDANT_ID,
            AKTION_ID,
            ART_ID,
            DWH_CREATED_TMSP,
            USER_ID,
            WRG_ID,
            MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL
          )
        VALUES (
            :P_KJWO_WW,
            :P_MANDANT_ID,
            :P_AKTION_ID,
            :P_ART_ID,
            CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
            :P_USER_ID,
            :P_WRG_ID,
            :P_MANUAL_MARKDOWN_PRICE
          );
    WHEN 1 THEN
        -- DISCOUNT
        INSERT INTO DBP_MSI_VIEW_NFMD.TS_NFMD_ARTICLE_PRICE_2(
            KJWO_WW,
            MANDANT_ID,
            AKTION_ID,
            ART_ID,
            DWH_CREATED_TMSP,
            USER_ID,
            WRG_ID,
            MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL
          )
        VALUES (
            :P_KJWO_WW,
            :P_MANDANT_ID,
            :P_AKTION_ID,
            :P_ART_ID,
            CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
            :P_USER_ID,
            :P_WRG_ID,
            ((1-:P_MANUAL_MARKDOWN_PERCENTAGE)*:P_VK_AKTION_BRUTTO)   -- 1 minus the discount percentage multipled BY the inital price to give the manual discount price
          );
END;

CASE WHEN (:P_MANUAL_VALID_FROM != :P_STATIC_MANUAL_VALID_FROM) THEN

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
     END;
END;
COMMIT;
RETURN 'Rabatt MAK Level gespeichert';
END;
$$;