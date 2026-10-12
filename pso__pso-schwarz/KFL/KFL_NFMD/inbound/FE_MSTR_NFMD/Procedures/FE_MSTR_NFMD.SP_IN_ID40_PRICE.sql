CREATE OR REPLACE PROCEDURE FE_MSTR_NFMD.SP_IN_ID40_PRICE("P_YEAR_ID" FLOAT, "P_WEEK_ID" FLOAT, "P_MANDANT_ID" FLOAT, "P_AKTION_ID"  VARCHAR(255), "P_MANUAL_VALID_FROM" VARCHAR(255), "P_SKU_ID" FLOAT, "P_WUP_ID" FLOAT, "P_USER_ID" VARCHAR(255), "P_MANUAL_MARKDOWN_PRICE" FLOAT)
RETURNS BOOLEAN
LANGUAGE JAVASCRIPT
COMMENT='Price and Valid From ID40 Save button Article-Branch Level'
EXECUTE AS OWNER
AS $$ 
var sql_stmt = `
-- Price
INSERT INTO CORE.TS_ID40_PRICE_WBS(
    YEAR_ID,
    WEEK_ID,
    MANDANT_ID,
    AKTION_ID,
    SKU_ID,
    WUP_ID,
    CREATED_AT,
    USER_ID,
    MANUAL_MARKDOWN_PRICE
  )
VALUES (
    :1,
    :2,
    :3,
    :4,
    :6,
    :7,
    CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
    :8,
    :9
  )
  `;
var stmt = snowflake.createStatement(
  { sqlText: sql_stmt,
  binds: [P_YEAR_ID, P_WEEK_ID,P_MANDANT_ID,P_AKTION_ID,P_MANUAL_VALID_FROM,P_SKU_ID,P_WUP_ID,P_USER_ID,P_MANUAL_MARKDOWN_PRICE].map(function(x) { return x === undefined ? null: x }) }
);
stmt.execute();
var sql_stmt2 = `
--Valid From
  INSERT INTO CORE.TS_ID40_VALID_FROM_WBS (YEAR_ID,
                                         WEEK_ID,
                                         MANDANT_ID,
                                         AKTION_ID,
                                         SKU_ID,
                                         WUP_ID,
                                         CREATED_AT,
                                         USER_ID,
                                         MANUAL_MARKDOWN_DATE) (
    SELECT prms.*
    FROM (
             VALUES (:1,
                     :2,
                     :3,
                     :4,
                     :6,
                     :7,
                     CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
                     :8,
                     :5)
         ) prms (
                 year_id,
                 week_id,
                 mandant_id,
                 aktion_id,
                 sku_id,
                 wup_id,
                 created_at,
                 USR_ID,
                 MANUAL_MARKDOWN_DATE
        )
             LEFT JOIN FE_MSTR_NFMD.mv_id40_latest_valid_from_wb nulc ON prms.year_id = nulc.year_id
        AND prms.week_id = nulc.week_id
        AND prms.mandant_id = nulc.mandant_id
        AND prms.aktion_id = nulc.aktion_id
        AND prms.sku_id = nulc.sku_id
        AND prms.WUP_ID = nulc.WUP_ID
             LEFT JOIN FE_MSTR_NFMD.mv_id40_latest_valid_from_wb lst ON prms.year_id = lst.year_id
        AND prms.week_id = lst.week_id
        AND prms.mandant_id = lst.mandant_id
        AND prms.aktion_id = lst.aktion_id
        AND prms.sku_id = lst.sku_id
        AND prms.WUP_ID = lst.WUP_ID
        AND prms.MANUAL_MARKDOWN_DATE = lst.MANUAL_MARKDOWN_DATE
    WHERE lst.sku_id IS NULL -- check the exact same comment does not exist
      AND CASE     -- check that a record for the same sku already exists before entering a null valid from date
              WHEN prms.MANUAL_MARKDOWN_DATE IS NOT NULL
                  OR nulc.MANUAL_MARKDOWN_DATE IS NOT NULL THEN TRUE
        END
)
`;
var stmt2 = snowflake.createStatement(
  { sqlText: sql_stmt2,
  binds: [P_YEAR_ID, P_WEEK_ID,P_MANDANT_ID,P_AKTION_ID,P_MANUAL_VALID_FROM,P_SKU_ID,P_WUP_ID,P_USER_ID,P_MANUAL_MARKDOWN_PRICE].map(function(x) { return x === undefined ? null: x }) }
);
stmt2.execute();
var sql_commit = "COMMIT";
snowflake.createStatement({ sqlText: sql_commit }).execute();
$$;
