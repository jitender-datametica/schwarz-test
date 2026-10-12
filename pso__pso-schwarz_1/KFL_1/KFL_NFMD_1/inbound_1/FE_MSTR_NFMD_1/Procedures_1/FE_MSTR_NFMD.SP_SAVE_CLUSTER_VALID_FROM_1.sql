CREATE OR REPLACE PROCEDURE FE_MSTR_NFMD.SP_SAVE_CLUSTER_VALID_FROM(
  "P_YEAR_ID" FLOAT, 
  "P_WEEK_ID" FLOAT, 
  "P_MANDANT_ID" FLOAT, 
  "P_ARTICLE_CLUSTER_ID" FLOAT, 
  "P_USER_ID" VARCHAR(255), 
  "P_MANUAL_VALID_FROM" VARCHAR(255)
)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
COMMENT='Edit Price, Percent, Valid From or Comment through Save button for Article Level'
EXECUTE AS OWNER
AS $$

var sql_stmt = `
-- Price
INSERT INTO CORE.TS_ID40_ART_VALID_FROM_WBS_1(
    YEAR_ID,
    WEEK_ID,
    MANDANT_ID,
    AKTION_ID,
    SKU_ID,
    CREATED_AT,
    USER_ID,
    MANUAL_MARKDOWN_DATE
  )
  SELECT YEAR_ID, WEEK_ID, MANDANT_ID, AKTION_ID, SKU_ID, CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
:5,TO_DATE(:6,'MM_1/DD/YYYY')
FROM FE_MSTR_NFMD.MV_FRONTEND_ID30_WB_1 WHERE YEAR_ID =:1 AND WEEK_ID = :2 AND MANDANT_ID = :3 AND ARTICLE_CLUSTER = :4
  `;
var stmt = snowflake.createStatement(
  { sqlText: sql_stmt,
  binds: [P_YEAR_ID, P_WEEK_ID,P_MANDANT_ID, P_ARTICLE_CLUSTER_ID,P_USER_ID,P_MANUAL_VALID_FROM].map(function(x) { return x === undefined ? null: x }) }
);
stmt.execute();


var sql_commit = "COMMIT";
snowflake.createStatement({ sqlText: sql_commit }).execute();

$$;
