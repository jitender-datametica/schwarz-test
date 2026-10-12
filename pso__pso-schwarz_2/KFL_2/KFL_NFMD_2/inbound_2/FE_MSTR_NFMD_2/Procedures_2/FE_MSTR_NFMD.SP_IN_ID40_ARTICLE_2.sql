CREATE OR REPLACE PROCEDURE FE_MSTR_NFMD.SP_IN_ID40_ARTICLE("P_COMMENT_DECISION" VARCHAR(230), "P_YEAR_ID" FLOAT, "P_WEEK_ID" FLOAT, "P_MANDANT_ID" FLOAT, "P_AKTION_ID" VARCHAR(255), "P_MANUAL_VALID_FROM" VARCHAR(255), "P_SKU_ID" FLOAT, "P_USER_ID" VARCHAR(255), "P_MANUAL_MARKDOWN_PRICE" FLOAT)
RETURNS BOOLEAN
LANGUAGE JAVASCRIPT
COMMENT='All 3 optional parameters'
EXECUTE AS OWNER
AS $$
	var sql_stmt = `
INSERT INTO CORE.TS_ID40_ART_PRICE_WBS_2
(YEAR_ID, WEEK_ID, MANDANT_ID,  AKTION_ID,SKU_ID, CREATED_AT, USER_ID, MANUAL_MARKDOWN_PRICE)
(SELECT prms.*
    FROM (
VALUES (:1,:2,:3,:4,:5,CURRENT_TIMESTAMP::TIMESTAMP_NTZ,:6,:7)
         ) prms (
                 year_id,
                 week_id,
                 mandant_id,
                 aktion_id,
                 sku_id,
                 created_at,
                 USR_ID,
                 MANUAL_MARKDOWN_PRICE
        )
             LEFT JOIN FE_MSTR_NFMD.MV_ID40_LATEST_ART_PRICE_WB_2 nulc ON prms.year_id = nulc.year_id
        AND prms.week_id = nulc.week_id
        AND prms.mandant_id = nulc.mandant_id
        AND prms.aktion_id = nulc.aktion_id
        AND prms.sku_id = nulc.sku_id
             LEFT JOIN FE_MSTR_NFMD.MV_ID40_LATEST_ART_PRICE_WB_2 lst ON prms.year_id = lst.year_id
        AND prms.week_id = lst.week_id
        AND prms.mandant_id = lst.mandant_id
        AND prms.aktion_id = lst.aktion_id
        AND prms.sku_id = lst.sku_id
        AND prms.MANUAL_MARKDOWN_PRICE = lst.MANUAL_MARKDOWN_PRICE
LEFT JOIN (SELECT  YEAR_ID, MANDANT_ID,  WEEK_ID, AKTION_ID,  SKU_ID, round(AVG(MANUAL_MARKDOWN_PRICE),2) AS AVG_MANUAL_MARKDOWN_PRICE
FROM FE_MSTR_NFMD.MV_FRONTEND_ID40_WB_2
GROUP BY YEAR_ID, MANDANT_ID,  WEEK_ID, AKTION_ID, SKU_ID) mv ON prms.year_id = mv.year_id
        AND prms.week_id = mv.week_id
        AND prms.mandant_id = mv.mandant_id
        AND prms.aktion_id = mv.aktion_id
        AND prms.sku_id = mv.sku_id
        AND AVG_MANUAL_MARKDOWN_PRICE = round(prms.MANUAL_MARKDOWN_PRICE,2)
    WHERE lst.sku_id IS NULL -- check the exact same price does not exist in writeback table
    AND mv.sku_id IS NULL -- check price is not the same as already set
      AND CASE     -- check that a record for the same sku already exists before entering a null price
              WHEN prms.MANUAL_MARKDOWN_PRICE IS NOT NULL
                  OR nulc.MANUAL_MARKDOWN_PRICE IS NOT NULL THEN TRUE   END)
`;
    var stmt = snowflake.createStatement(
        { sqlText : sql_stmt, 
        binds: [P_YEAR_ID, P_WEEK_ID,P_MANDANT_ID,P_AKTION_ID,P_SKU_ID,P_USER_ID,P_MANUAL_MARKDOWN_PRICE ].map(function(x){return x === undefined ? null : x})});
	
    stmt.execute();	
var sql_stmt2 = `
-- Comment Insert
INSERT INTO CORE.TS_MSI_COMMENTS_INSERTS_2 (YEAR_ID, WEEK_ID, MANDANT_ID, AKTION_ID, SKU_ID, CREATED_AT, USER_ID, JF_COMMENT ) (
    SELECT prms.*
    FROM (
             VALUES ( :1, :2, :3, :4, :5, CURRENT_TIMESTAMP::TIMESTAMP_NTZ, :6, :8 )
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
             LEFT JOIN FE_MSTR_NFMD.mv_id30_latest_comm_wb_2 nulc ON prms.year_id = nulc.year_id
        AND prms.week_id = nulc.week_id
        AND prms.mandant_id = nulc.mandant_id
        AND prms.aktion_id = nulc.aktion_id
        AND prms.sku_id = nulc.sku_id
             LEFT JOIN FE_MSTR_NFMD.mv_id30_latest_comm_wb_2 lst ON prms.year_id = lst.year_id
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
        { sqlText : sql_stmt2, 
        binds: [P_YEAR_ID, P_WEEK_ID,P_MANDANT_ID,P_AKTION_ID,P_SKU_ID,P_USER_ID,P_MANUAL_MARKDOWN_PRICE,P_COMMENT_DECISION].map(function(x) { return x === undefined ? null: x }) });
    
    stmt2.execute();

    var sql_stmt3 = `
--Valid From
  INSERT INTO CORE.TS_ID40_ART_VALID_FROM_WBS_2 (YEAR_ID,
                                         WEEK_ID,
                                         MANDANT_ID,
                                         AKTION_ID,
                                         SKU_ID,
                                         CREATED_AT,
                                         USER_ID,
                                         MANUAL_MARKDOWN_DATE) (
    SELECT prms.*
    FROM (
             VALUES (:1,:2,:3,:4,:5,CURRENT_TIMESTAMP::TIMESTAMP_NTZ,:6,:7)
         ) prms (
                                 year_id,
                 week_id,
                 mandant_id,
                 aktion_id,
                 sku_id,
                 created_at,
                 USR_ID,
                 MANUAL_MARKDOWN_DATE
        )
             LEFT JOIN FE_MSTR_NFMD.mv_id40_latest_valid_from_wb_2 nulc ON prms.year_id = nulc.year_id
        AND prms.week_id = nulc.week_id
        AND prms.mandant_id = nulc.mandant_id
        AND prms.aktion_id = nulc.aktion_id
        AND prms.sku_id = nulc.sku_id
             LEFT JOIN FE_MSTR_NFMD.mv_id40_latest_valid_from_wb_2 lst ON prms.year_id = lst.year_id
        AND prms.week_id = lst.week_id
        AND prms.mandant_id = lst.mandant_id
        AND prms.aktion_id = lst.aktion_id
        AND prms.sku_id = lst.sku_id
        AND prms.MANUAL_MARKDOWN_DATE = lst.MANUAL_MARKDOWN_DATE
LEFT JOIN (SELECT  YEAR_ID, MANDANT_ID,  WEEK_ID, AKTION_ID,  SKU_ID, MIN(VALID_FROM)AS min_valid_from
FROM FE_MSTR_NFMD.MV_FRONTEND_ID40_WB_2
GROUP BY YEAR_ID, MANDANT_ID,  WEEK_ID, AKTION_ID, SKU_ID) mv ON prms.year_id = mv.year_id
        AND prms.week_id = mv.week_id
        AND prms.mandant_id = mv.mandant_id
        AND prms.aktion_id = mv.aktion_id
        AND prms.sku_id = mv.sku_id
        AND min_valid_from = TO_DATE(COALESCE (prms.MANUAL_MARKDOWN_DATE,'01/01/1900'), 'MM_2/DD/YYYY')
    WHERE lst.sku_id IS NULL -- check the exact same comment does not exist in writeback table
    AND mv.sku_id IS NULL -- check valid from is not the same as already set
      AND CASE     -- check that a record for the same sku already exists before entering a null valid from date
              WHEN prms.MANUAL_MARKDOWN_DATE IS NOT NULL
                  OR nulc.MANUAL_MARKDOWN_DATE IS NOT NULL THEN TRUE   END)
` ;


    var stmt3 = snowflake.createStatement({
      sqlText : sql_stmt3, binds: [P_YEAR_ID, P_WEEK_ID,P_MANDANT_ID,P_AKTION_ID,P_SKU_ID,P_USER_ID,P_MANUAL_VALID_FROM ].map(function(x){return x === undefined ? null : x})});
	stmt3.execute();
      var sql_commit = "COMMIT";
      snowflake.createStatement({
        sqlText: sql_commit
        }).execute();
$$;
