CREATE OR REPLACE PROCEDURE FE_MSTR_NFMD.SP_SAVE_MAK_LVL(
  "P_YEAR_ID" FLOAT, 
  "P_WEEK_ID" FLOAT, 
  "P_MANDANT_ID" FLOAT, 
  "P_AKTION_ID" VARCHAR(255), 
  "P_SKU_ID" FLOAT, 
  "P_WUP_ID" FLOAT, 
  "P_USER_ID" VARCHAR(255), 
  "P_MANUAL_MARKDOWN_PRICE" FLOAT, 
  "P_MANUAL_MARKDOWN_PERCENTAGE" FLOAT, 
  "P_MANUAL_VALID_FROM" VARCHAR(255), 
  "P_STATIC_MANUAL_MARKDOWN_PRICE" FLOAT, 
  "P_STATIC_MANUAL_MARKDOWN_PERCENTAGE" FLOAT, 
  "P_STATIC_MANUAL_VALID_FROM" VARCHAR(255), 
  "P_VK_AKTION_BRUTTO" FLOAT, 
  "P_DISCOUNT_ENDING" FLOAT)
RETURNS BOOLEAN
LANGUAGE JAVASCRIPT
COMMENT='Edit Price, Percent and Valid From ID40 through Save button for branch level'
EXECUTE AS OWNER
AS $$ 

if ( P_DISCOUNT_ENDING == 0 ){
var sql_stmt = `
-- Price
INSERT INTO CORE.TS_ID40_PRICE_WBS_2(
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
    :5,
    :6,
    CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
    :7,
    :8
  )
  `;
var stmt = snowflake.createStatement(
  { sqlText: sql_stmt,
  binds: [P_YEAR_ID, P_WEEK_ID,P_MANDANT_ID,P_AKTION_ID,P_SKU_ID,P_WUP_ID,P_USER_ID,P_MANUAL_MARKDOWN_PRICE].map(function(x) { return x === undefined ? null: x }) }
);
stmt.execute();
}
else if(P_DISCOUNT_ENDING == 1)
{
var sql_stmt = `
-- Price
INSERT INTO CORE.TS_ID40_PRICE_WBS_2(
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
    :5,
    :6,
    CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
    :7,
    ((1-:8)*:9)   -- 1 minus the discount percentage multipled BY the inital price to give the manual discount price
  )
  `;
var stmt = snowflake.createStatement(
  { sqlText: sql_stmt,
  binds: [P_YEAR_ID, P_WEEK_ID,P_MANDANT_ID,P_AKTION_ID,P_SKU_ID,P_WUP_ID,P_USER_ID,P_MANUAL_MARKDOWN_PERCENTAGE,P_VK_AKTION_BRUTTO].map(function(x) { return x === undefined ? null: x }) }
);
stmt.execute();

}

if (P_MANUAL_VALID_FROM !== P_STATIC_MANUAL_VALID_FROM)
{
var sql_stmt2 = `
--Valid From
  INSERT INTO CORE.TS_ID40_VALID_FROM_WBS_2 (YEAR_ID,
                                         WEEK_ID,
                                         MANDANT_ID,
                                         AKTION_ID,
                                         SKU_ID,
                                         WUP_ID,
                                         CREATED_AT,
                                         USER_ID,
                                         MANUAL_MARKDOWN_DATE)
             VALUES (:1,
                     :2,
                     :3,
                     :4,
                     :5,
                     :6,
                     CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
                     :7,
                     :8)
`;
var stmt2 = snowflake.createStatement(
  { sqlText: sql_stmt2,
  binds: [P_YEAR_ID, P_WEEK_ID,P_MANDANT_ID,P_AKTION_ID,P_SKU_ID,P_WUP_ID,P_USER_ID,P_MANUAL_VALID_FROM].map(function(x) { return x === undefined ? null: x }) }
);
stmt2.execute();
}
var sql_commit = "COMMIT";
snowflake.createStatement({ sqlText: sql_commit }).execute();

$$;
