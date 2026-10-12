CREATE OR REPLACE PROCEDURE DBP_MSI_VIEW_NFMD.SP_IN_NFMD_ART_WUP_DISCOUNT(
  "P_KJWO_WW" NUMBER,
  "P_MANDANT_ID" NUMBER, 
  "P_AKTION_ID" VARCHAR(255), 
  "P_ART_ID" NUMBER, 
  "P_WUP_ID" NUMBER, 
  "P_USER_ID" VARCHAR(255), 
  "P_MANUAL_MARKDOWN_PRICE" FLOAT, 
  "P_MANUAL_MARKDOWN_PERCENTAGE" FLOAT, 
  "P_MANUAL_VALID_FROM" VARCHAR(255), 
  "P_STATIC_MANUAL_MARKDOWN_PRICE" FLOAT, 
  "P_STATIC_MANUAL_MARKDOWN_PERCENTAGE" FLOAT, 
  "P_STATIC_MANUAL_VALID_FROM" VARCHAR(255), 
  "P_VK_AKTION_BRUTTO" FLOAT, 
  "P_WRG_ID" VARCHAR(20),
  "P_DISCOUNT_TYPE_FG" NUMBER)
RETURNS STRING
LANGUAGE SQL
COMMENT='Edit Price, Percent and Valid From ID40 through Save button for branch level'
EXECUTE AS OWNER
AS $$ 
DECLARE
    var_currentDate_add3Months date;
BEGIN 
CASE :P_DISCOUNT_TYPE_FG 
    WHEN 0 THEN 
        -- Price
        INSERT INTO DBP_MSI_VIEW_NFMD.TS_NFMD_ARTICLE_STORE_PRICE(
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
        VALUES (
            :P_KJWO_WW,
            :P_MANDANT_ID,
            :P_AKTION_ID,
            :P_ART_ID,
            :P_WUP_ID,
            CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
            :P_USER_ID,
            :P_WRG_ID,
            :P_MANUAL_MARKDOWN_PRICE
        );
    WHEN 1 THEN
        -- DISCOUNT
        INSERT INTO DBP_MSI_VIEW_NFMD.TS_NFMD_ARTICLE_STORE_PRICE(
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
        VALUES (
            :P_KJWO_WW,
            :P_MANDANT_ID,
            :P_AKTION_ID,
            :P_ART_ID,
            :P_WUP_ID,
            CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
            :P_USER_ID,
            :P_WRG_ID,
            ((1-:P_MANUAL_MARKDOWN_PERCENTAGE)*:P_VK_AKTION_BRUTTO)   -- 1 minus the discount percentage multipled BY the inital price to give the manual discount price
        );
END;


CASE WHEN (:P_MANUAL_VALID_FROM != :P_STATIC_MANUAL_VALID_FROM) THEN

    SELECT add_months(current_date,3)  INTO :var_currentDate_add3Months;
    CASE WHEN (:P_MANUAL_VALID_FROM <= :var_currentDate_add3Months) THEN
    --Valid From
    INSERT INTO DBP_MSI_VIEW_NFMD.TS_NFMD_ARTICLE_STORE_PRICE_DATE (KJWO_WW,
                                         MANDANT_ID,
                                         AKTION_ID,
                                         ART_ID,
                                         WUP_ID,
                                         DWH_CREATED_TMSP,
                                         USER_ID,
                                         MANUAL_PROMO_PRICE_DT)
             VALUES (:P_KJWO_WW,
                     :P_MANDANT_ID,
                     :P_AKTION_ID,
                     :P_ART_ID,
                     :P_WUP_ID,
                     CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
                     :P_USER_ID,
                     :P_MANUAL_VALID_FROM);
    END;
END;

COMMIT;
RETURN 'Rabatt MAK Level gespeichert';

END;
$$;