CREATE OR REPLACE PROCEDURE FE_MSTR_NFMD.SP_SAVE_ART_LVL(
  "P_YEAR_ID" FLOAT, 
  "P_WEEK_ID" FLOAT, 
  "P_MANDANT_ID" FLOAT, 
  "P_AKTION_ID" VARCHAR(255), 
  "P_SKU_ID" FLOAT, 
  "P_USER_ID" VARCHAR(255), 
  "P_MANUAL_MARKDOWN_PRICE" FLOAT, 
  "P_MANUAL_MARKDOWN_PERCENTAGE" FLOAT, 
  "P_MANUAL_VALID_FROM" VARCHAR(255), 
  "P_COMMENT_DECISION" VARCHAR(255), 
  "P_STATIC_MANUAL_MARKDOWN_PRICE" FLOAT, 
  "P_STATIC_MANUAL_MARKDOWN_PERCENTAGE" FLOAT, 
  "P_STATIC_MANUAL_VALID_FROM" VARCHAR(255), 
  "P_STATIC_COMMENT_DECISION" VARCHAR(255), 
  "P_VK_AKTION_BRUTTO" FLOAT, 
  "P_DISCOUNT_ENDING" FLOAT)
RETURNS BOOLEAN
LANGUAGE JAVASCRIPT
COMMENT='Edit Price, Percent, Valid From or Comment through Save button for Article Level'
EXECUTE AS OWNER
AS $$

if ( P_DISCOUNT_ENDING == 0  ){
var sql_stmt = `
-- Price
INSERT INTO CORE.TS_ID40_ART_PRICE_WBS(
    YEAR_ID,
    WEEK_ID,
    MANDANT_ID,
    AKTION_ID,
    SKU_ID,
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
    CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
    :6,
    :7
  )
  `;
var stmt = snowflake.createStatement(
  { sqlText: sql_stmt,
  binds: [P_YEAR_ID, P_WEEK_ID,P_MANDANT_ID,P_AKTION_ID,P_SKU_ID,P_USER_ID,P_MANUAL_MARKDOWN_PRICE,].map(function(x) { return x === undefined ? null: x }) }
);
stmt.execute();
}
else if(P_DISCOUNT_ENDING == 1 )
{
var sql_stmt = `
-- Price
INSERT INTO CORE.TS_ID40_ART_PRICE_WBS(
    YEAR_ID,
    WEEK_ID,
    MANDANT_ID,
    AKTION_ID,
    SKU_ID,
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
    CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
    :6,
    ((1-:7)*:8)   -- 1 minus the discount percentage multipled BY the inital price to give the manual discount price
  )
  `;
var stmt = snowflake.createStatement(
  { sqlText: sql_stmt,
  binds: [P_YEAR_ID, P_WEEK_ID,P_MANDANT_ID,P_AKTION_ID,P_SKU_ID,P_USER_ID,P_MANUAL_MARKDOWN_PERCENTAGE,P_VK_AKTION_BRUTTO].map(function(x) { return x === undefined ? null: x }) }
);
stmt.execute();

}

if (P_MANUAL_VALID_FROM !== P_STATIC_MANUAL_VALID_FROM)
{
var sql_stmt2 = `
--Valid From
INSERT INTO CORE.TS_ID40_ART_VALID_FROM_WBS (YEAR_ID,
                                             WEEK_ID,
                                             MANDANT_ID,
                                             AKTION_ID,
                                             SKU_ID,
                                             CREATED_AT,
                                             USER_ID,
                                             MANUAL_MARKDOWN_DATE)
VALUES (:1,
        :2,
        :3,
        :4,
        :5,
        CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
        :6,
        :7)
`;
var stmt2 = snowflake.createStatement(
  { sqlText: sql_stmt2,
  binds: [P_YEAR_ID, P_WEEK_ID,P_MANDANT_ID,P_AKTION_ID,P_SKU_ID,P_USER_ID,P_MANUAL_VALID_FROM].map(function(x) { return x === undefined ? null: x }) }
);
stmt2.execute();
}

if (P_COMMENT_DECISION !== P_STATIC_COMMENT_DECISION)
{
var sql_stmt3 = `
--Comment

INSERT INTO CORE.TS_MSI_COMMENTS_INSERTS
(YEAR_ID,
 WEEK_ID,
 MANDANT_ID,
 AKTION_ID,
 SKU_ID,
 CREATED_AT,
 USER_ID,
 JF_COMMENT)
VALUES (:1,
        :2,
        :3,
        :4,
        :5,
        CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
        :6,
        :7)
`;
var stmt3 = snowflake.createStatement(
  { sqlText: sql_stmt3,
  binds: [P_YEAR_ID, P_WEEK_ID,P_MANDANT_ID,P_AKTION_ID,P_SKU_ID,P_USER_ID,P_COMMENT_DECISION].map(function(x) { return x === undefined ? null: x }) }
);
stmt3.execute();
}

var sql_commit = "COMMIT";
snowflake.createStatement({ sqlText: sql_commit }).execute();

$$;
