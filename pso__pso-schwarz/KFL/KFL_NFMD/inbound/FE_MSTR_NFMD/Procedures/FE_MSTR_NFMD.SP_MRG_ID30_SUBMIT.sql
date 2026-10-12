CREATE OR REPLACE PROCEDURE FE_MSTR_NFMD.SP_MRG_ID30_SUBMIT(P_YEAR_ID FLOAT, P_WEEK_ID FLOAT, P_MANDANT_ID FLOAT, P_USER_ID VARCHAR(255))
RETURNS BOOLEAN
LANGUAGE JAVASCRIPT
COMMENT='Submits markdown decision'
EXECUTE AS OWNER
AS $$ 
var sql_stmt = `
MERGE INTO CORE.TS_ID30_MSI_FINAL_SUBMIT f USING (
    SELECT mv.YEAR_ID,
        mv.WEEK_ID,
        mv.MANDANT_ID,
        mv.AKTION_ID,
        mv.SKU_ID,
        mv.MARKDOWN_DECISION
    FROM MV_FRONTEND_ID30_WB mv
        LEFT JOIN CORE.TS_ID30_MSI_FINAL_SUBMIT ff ON (
            ff.YEAR_ID = mv.YEAR_ID
            AND ff.WEEK_ID = mv.WEEK_ID
            AND ff.AKTION_ID = mv.AKTION_ID
            AND ff.MANDANT_ID = mv.MANDANT_ID
            AND ff.SKU_ID = mv.SKU_ID
            AND ff.markdown_decision = mv.markdown_decision
        )
    WHERE mv.YEAR_ID = :1
        AND mv.WEEK_ID = :2
        AND mv.MANDANT_ID = :3
        AND ff.sku_id IS NULL
) wb ON (
    f.YEAR_ID = wb.YEAR_ID
    AND f.WEEK_ID = wb.WEEK_ID
    AND f.AKTION_ID = wb.AKTION_ID
    AND f.MANDANT_ID = wb.MANDANT_ID
    AND f.SKU_ID = wb.SKU_ID
)
WHEN MATCHED THEN
UPDATE
    SET f.CREATED_AT = CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
    f.USER_ID = :4,
    f.MARKDOWN_DECISION = COALESCE (wb.MARKDOWN_DECISION, '0')
WHEN NOT MATCHED THEN
INSERT (YEAR_ID, WEEK_ID, MANDANT_ID, AKTION_ID, SKU_ID, CREATED_AT, USER_ID, MARKDOWN_DECISION )
VALUES (YEAR_ID,
        WEEK_ID,
        MANDANT_ID,
        AKTION_ID,
        SKU_ID,
        CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
        :4,
        COALESCE(MARKDOWN_DECISION, '0'))`;
var stmt = snowflake.createStatement(
        { sqlText: sql_stmt,
        binds: [P_YEAR_ID, P_WEEK_ID,P_MANDANT_ID,P_USER_ID] }
    );
stmt.execute();
var sql_stmt2 = "INSERT INTO CORE.TS_ID30_SUBMIT_LOG (YEAR_ID, WEEK_ID, MANDANT_ID, DAT_CREATED, USER_ID) VALUES (:1, :2, :3, CURRENT_TIMESTAMP::TIMESTAMP_NTZ, :4)"; 
var stmt2 = snowflake.createStatement(
    { sqlText: sql_stmt2,
    binds: [P_YEAR_ID, P_WEEK_ID,P_MANDANT_ID,P_USER_ID] }
);
stmt2.execute();
var sql_commit = "COMMIT";
snowflake.createStatement({ sqlText: sql_commit }).execute();
$$;
