CREATE OR REPLACE PROCEDURE DBP_MSI_VIEW_NFMD.SP_IN_NFMD_ARTICLE_CLUSTER_PRICE_DATE(
    "P_KJWO_WW" VARCHAR(16777216), 
    "P_MANDANT_ID" FLOAT, 
    "P_ARTICLE_CLUSTER_ID" FLOAT, 
    "P_USER_ID" VARCHAR(255), 
    "P_MANUAL_VALID_FROM" VARCHAR(255))
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
COMMENT='Edit Price, Percent, Valid From or Comment through Save button for Article Level'
EXECUTE AS OWNER
AS $$


var KJWO_WW_array = P_KJWO_WW.split(",");

KJWO_WW_array.forEach(set_price_date);

function set_price_date(item_1,index) {
 
  var sql_stmt = `
-- Price
INSERT INTO DBP_MSI_VIEW_NFMD.TS_NFMD_ARTICLE_PRICE_DATE_1(
    KJWO_WW,
    MANDANT_ID,
    AKTION_ID,
    ART_ID,
    DWH_CREATED_TMSP,
    USER_ID,
    MANUAL_PROMO_PRICE_DT
  )
  SELECT KJWO_WW, MANDANT_ID, AKTION_ID, ART_ID, CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
:4,TO_DATE(:5,''MM_1/DD/YYYY'')
FROM DBP_MSI_VIEW_NFMD.MV_NFMD_ART_PROMOTION_1 WHERE KJWO_WW = :1 and  MANDANT_ID = :2 and ARTICLE_CLUSTER = :3
  `;
var stmt = snowflake.createStatement(
  { sqlText: sql_stmt,
  binds: [item_1, P_MANDANT_ID, P_ARTICLE_CLUSTER_ID,P_USER_ID,P_MANUAL_VALID_FROM].map(function(x) { return x === undefined ? null: x }) }
);
stmt.execute();
}



var sql_commit = "COMMIT";
snowflake.createStatement({ sqlText: sql_commit }).execute();

$$;