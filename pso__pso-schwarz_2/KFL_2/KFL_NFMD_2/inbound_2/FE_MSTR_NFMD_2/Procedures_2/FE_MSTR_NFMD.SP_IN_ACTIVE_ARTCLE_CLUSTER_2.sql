CREATE OR REPLACE PROCEDURE FE_MSTR_NFMD.SP_IN_ACTIVE_ARTCLE_CLUSTER("P_MANDANT_ID" FLOAT, "P_ARTICLE_CLUSTER_ID" FLOAT, "P_USER_ID" VARCHAR(255))
RETURNS BOOLEAN
LANGUAGE JAVASCRIPT
COMMENT='ID30 Save button, inserts from a row on grid'
EXECUTE AS OWNER
AS $$ 
var sql_stmt = `
--Decision Insert
INSERT INTO CORE.TS_ACTIVE_ARTICE_CLUSTER_WBS_2
(CREATED_AT, USER_ID, ARTICLE_CLUSTER_ID,MANDANT_ID )
VALUES(CURRENT_TIMESTAMP::TIMESTAMP_NTZ, :1, :2, :3);
`;
var stmt = snowflake.createStatement(
  { sqlText: sql_stmt,
  binds: [P_USER_ID,P_ARTICLE_CLUSTER_ID,P_MANDANT_ID].map(function(x){return x === undefined ? null : x})
  });
stmt.execute();
var sql_commit = "COMMIT";
snowflake.createStatement({ sqlText: sql_commit }).execute();
$$;
