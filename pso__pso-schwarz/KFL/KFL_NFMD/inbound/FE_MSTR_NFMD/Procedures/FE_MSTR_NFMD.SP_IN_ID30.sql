CREATE OR REPLACE PROCEDURE FE_MSTR_NFMD.SP_IN_ID30("P_YEAR_ID" FLOAT, "P_WEEK_ID" FLOAT, "P_MANDANT_ID" FLOAT, "P_AKTION_ID" VARCHAR(255), "P_SKU_ID" FLOAT, "P_USER_ID" VARCHAR(255), "P_MARKDOWN_DECISION" VARCHAR(255), "P_COMMENT_DECISION" VARCHAR(230))
RETURNS BOOLEAN
LANGUAGE JAVASCRIPT
COMMENT='ID30 Save button, inserts from a row on grid'
EXECUTE AS OWNER
AS $$ 
var sql_stmt = `
--Decision Insert
INSERT INTO CORE.TS_ID30_MSI_INSERTS (YEAR_ID, WEEK_ID, MANDANT_ID, AKTION_ID, SKU_ID, CREATED_AT, USER_ID,
                                    MARKDOWN_DECISION)
VALUES (:1, :2, :3, :4, :5, CURRENT_TIMESTAMP::TIMESTAMP_NTZ, :6, :7)
`;
var stmt = snowflake.createStatement(
  { sqlText: sql_stmt,
  binds: [P_YEAR_ID, P_WEEK_ID,P_MANDANT_ID,P_AKTION_ID,P_SKU_ID,P_USER_ID,P_MARKDOWN_DECISION,P_COMMENT_DECISION].map(function(x){return x === undefined ? null : x})
  });
stmt.execute();
var sql_stmt2 = `
-- Comment Insert
INSERT INTO CORE.TS_MSI_COMMENTS_INSERTS (YEAR_ID, WEEK_ID, MANDANT_ID,AKTION_ID, SKU_ID, CREATED_AT, USER_ID, JF_COMMENT) (
    SELECT prms.*
    FROM (
             VALUES (:1, :2, :3, :4, :5, CURRENT_TIMESTAMP::TIMESTAMP, :6, :8)
         ) prms (
                 year_id,
                 week_id,
                 mandant_id,
                 aktion_id,
                 sku_id,
                 created_at,
                 USR_ID,
                 jf_comment
        )
             LEFT JOIN FE_MSTR_NFMD.mv_id30_latest_comm_wb nulc ON prms.year_id = nulc.year_id
        AND prms.week_id = nulc.week_id
        AND prms.mandant_id = nulc.mandant_id
        AND prms.aktion_id = nulc.aktion_id
        AND prms.sku_id = nulc.sku_id
             LEFT JOIN FE_MSTR_NFMD.mv_id30_latest_comm_wb lst ON prms.year_id = lst.year_id
        AND prms.week_id = lst.week_id
        AND prms.mandant_id = lst.mandant_id
        AND prms.aktion_id = lst.aktion_id
        AND prms.sku_id = lst.sku_id
        AND prms.jf_comment = lst.jf_comment
    WHERE lst.sku_id IS NULL -- check the exact same comment does not exist
      AND CASE -- check that a record for the same sku already exists before entering a null comment
              WHEN prms.jf_comment IS NOT NULL
                  OR nulc.jf_comment IS NOT NULL THEN TRUE
        END
)
    `;
var stmt2 = snowflake.createStatement(
  { sqlText: sql_stmt2,
  binds: [P_YEAR_ID, P_WEEK_ID,P_MANDANT_ID,P_AKTION_ID,P_SKU_ID,P_USER_ID,P_MARKDOWN_DECISION,P_COMMENT_DECISION].map(function(x){return x === undefined ? null : x})
  });
stmt2.execute();
var sql_commit = "COMMIT";
snowflake.createStatement({ sqlText: sql_commit }).execute();
$$;
