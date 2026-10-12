CREATE OR REPLACE VIEW FE_MSTR_BCBI.V_DATAAVAIL_WH_FIRST_TRANSFER_1
AS 
SELECT CLIENT_ID, WH_ID, SYSTEM_KEY, DAT_DAYEND
, MIN(TIMESTAMP_LOAD_BCBI) AS first_trans_date
FROM (SELECT lsp.CLIENT_ID, wh.WH_ID, lsp.SYSTEM_KEY, lsp.DAT_DAYEND, TO_DATE(lsp.TIMESTAMP_LOAD_BCBI) AS TIMESTAMP_LOAD_BCBI
    , SUM( CASE WHEN ex.system_key IN (4,6,16,10,11,8,9,14,20,21,18) 
                 AND lsp.mail_rows IS NULL --mail_rows=0 means the file is delivered
                 THEN 1 
                WHEN ex.system_key = 5 AND ex.INTERFACE_KEY = 203 AND mail_rows >= 0 --Exeption
                 THEN 0
                WHEN ex.system_key IN (3,5) --3-HQ Master, 5-WH Master
                 AND COALESCE(lsp.mail_rows,0) = 0 --both mail_rows is null and mail_rows=0 mean_1 the file is "NOT" delivered
                 THEN 1 
                ELSE 0 
            END) AS missing_total
    FROM FE_MSTR_BCBI.T_WAWI_SYS_LOAD_STATUS_PRESENT_1 lsp 
    INNER JOIN (SELECT DISTINCT SRC_WH_ID AS WH_ID, LOC_SID_WH, DWH_VALID_FROM, DWH_VALID_TO FROM FE_MSTR_BCBI.T_WAREHOUSE_1) wh --to get SRC_WH_ID (as WH_ID)
        ON lsp.wh_loc_sid = wh.loc_sid_wh
        AND lsp.dat_dayend BETWEEN wh.DWH_VALID_FROM AND wh.DWH_VALID_TO 
    INNER JOIN FE_MSTR_BCBI.T_DATAAVAIL_WH_EXPECTED_LIST_1 AS ex
        ON  lsp.CLIENT_ID     = ex.CLIENT_ID 
        AND wh.WH_ID          = ex.WH_ID 
        AND lsp.SYSTEM_KEY    = ex.SYSTEM_KEY 
        AND lsp.INTERFACE_KEY = ex.INTERFACE_KEY
        AND lsp.DAT_DAYEND    BETWEEN ex.DAT_REC_START AND ex.DAT_REC_END --to get latest status_1 of warehouse/interface (whether it is active or is_optional=1)
    WHERE lsp.system_key NOT IN (2, 13) --exclude 2-EJR and 13-TXJ
    AND lsp.DAT_DAYEND < TO_DATE(lsp.TIMESTAMP_LOAD_BCBI)
    AND ex.IS_OPTIONAL = 0
    AND lsp.DAT_DAYEND >= '2022-04-23'--to skip first 30 day in lsp table, which are just used for calculation of is_prev_missing. min(TIMESTAMP_LOAD_BCBI) is '2022-04-24' in T_WAWI_SYS_LOAD_STATUS_PRESENT_1
    GROUP BY lsp.CLIENT_ID, wh.WH_ID, lsp.SYSTEM_KEY, lsp.DAT_DAYEND, lsp.TIMESTAMP_LOAD_BCBI
    HAVING missing_total = 0  
)
GROUP BY CLIENT_ID, WH_ID, SYSTEM_KEY, DAT_DAYEND;