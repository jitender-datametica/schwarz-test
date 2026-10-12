CREATE OR REPLACE PROCEDURE FE_MSTR_NFMD.SP_IN_ARTCLE_CLUSTER("P_YEAR_ID" FLOAT, "P_WEEK_ID" FLOAT, "P_MANDANT_ID" FLOAT, "P_AKTION_ID" VARCHAR(255), "P_SKU_ID" FLOAT, "P_USER_ID" VARCHAR(255))
RETURNS BOOLEAN
LANGUAGE JAVASCRIPT
COMMENT='ID30 Save button, inserts from a row on grid'
EXECUTE AS OWNER
AS $$ 
var sql_stmt = `
--Decision Insert
INSERT INTO CORE.TS_ARTICE_CLUSTER_WBS_2 (YEAR_ID, WEEK_ID, MANDANT_ID, AKTION_ID, SKU_ID, CREATED_AT, USER_ID,ARTICLE_CLUSTER_ID)
SELECT :1, :2, :3, :4, :5, CURRENT_TIMESTAMP::TIMESTAMP_NTZ, :6, ARTICLE_CLUSTER_ID
FROM FE_MSTR_NFMD.MV_ACTIVE_CLUSTER_2 WHERE MV_ACTIVE_CLUSTER.MANDANT_ID = :3
`;
var stmt = snowflake.createStatement(
  { sqlText: sql_stmt,
  binds: [P_YEAR_ID, P_WEEK_ID,P_MANDANT_ID,P_AKTION_ID,P_SKU_ID,P_USER_ID].map(function(x){return x === undefined ? null : x})
  });
stmt.execute();
var sql_commit = "COMMIT";
snowflake.createStatement({ sqlText: sql_commit }).execute();
$$;
